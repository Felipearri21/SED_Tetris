library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity board_memory is
    generic (
        BOARD_WIDTH  : integer := 10;
        BOARD_HEIGHT : integer := 20
    );
    port (
        clk    : in  std_logic;
        reset  : in  std_logic;

        -- Datos de la pieza a fijar
        x         : in integer;
        y         : in integer;
        shape_16b : in std_logic_vector(15 downto 0);

        -- Control
        lock_request  : in std_logic;
        do_line_clear : in std_logic;

        -- Salidas
        board_flat      : out std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT-1 downto 0);
        rows_cleared    : out std_logic_vector(BOARD_HEIGHT-1 downto 0);
        any_row_cleared : out std_logic
    );
end entity;


architecture RTL of board_memory is

    -------------------------------------------------------------------------
    -- Representación del tablero como RAM: array de FILAS
    -------------------------------------------------------------------------
    type row_t  is array (0 to BOARD_WIDTH-1) of std_logic;
    type ram_t  is array (0 to BOARD_HEIGHT-1) of row_t;

    signal board : ram_t := (others => (others => '0'));

    -- Sugerencia explícita a Vivado: usar Block RAM
    attribute ram_style : string;
    attribute ram_style of board : signal is "block";

    -------------------------------------------------------------------------
    -- Señales para detección de filas completas
    -------------------------------------------------------------------------
    signal rows_full : std_logic_vector(BOARD_HEIGHT-1 downto 0);

    -------------------------------------------------------------------------
    -- FSM interna para fijar pieza y borrar líneas
    -------------------------------------------------------------------------
    type fsm_state_t is (
        S_IDLE,
        S_LOCK_WRITE,       -- escribir los 16 bits de la pieza (4x4)
        S_CLEAR_SCAN,       -- compactar filas de abajo a arriba
        S_CLEAR_ZERO        -- poner a cero las filas sobrantes superiores
    );

    signal state : fsm_state_t := S_IDLE;

    -- Registros para la operación de lock
    signal x_reg, y_reg : integer;
    signal shape_reg    : std_logic_vector(15 downto 0);
    signal lock_idx     : integer range 0 to 15 := 0;  -- índice 0..15 en shape_16b

    -- Registros para la operación de borrado/compactado
    signal scan_row    : integer range 0 to BOARD_HEIGHT-1 := 0; -- fila origen (de abajo arriba)
    signal wr_ptr      : integer range 0 to BOARD_HEIGHT-1 := 0; -- siguiente fila destino
    signal clear_idx   : integer range 0 to BOARD_HEIGHT-1 := 0; -- índice para rellenar con ceros
    signal clear_limit : integer range 0 to BOARD_HEIGHT-1 := 0; -- última fila que se pone a cero

begin

    -------------------------------------------------------------------------
    -- 1) Aplanado del tablero: board (2D) -> board_flat (1D)
    -------------------------------------------------------------------------
    flatten_proc : process(board)
        variable flat : std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT-1 downto 0);
        variable idx  : integer;
    begin
        idx := 0;
        for r in 0 to BOARD_HEIGHT-1 loop
            for c in 0 to BOARD_WIDTH-1 loop
                idx := r*BOARD_WIDTH + c;
                flat(idx) := board(r)(c);
            end loop;
        end loop;
        board_flat <= flat;
    end process;


    -------------------------------------------------------------------------
    -- 2) Detección de filas completas (combinacional, poco coste)
    -------------------------------------------------------------------------
    detect_full_rows : process(board)
        variable full : std_logic;
    begin
        for r in 0 to BOARD_HEIGHT-1 loop
            full := '1';
            for c in 0 to BOARD_WIDTH-1 loop
                if board(r)(c) = '0' then
                    full := '0';
                end if;
            end loop;
            rows_full(r) <= full;
        end loop;
    end process;

    rows_cleared <= rows_full;

    any_row_proc : process(rows_full)
        variable any : std_logic;
    begin
        any := '0';
        for r in 0 to BOARD_HEIGHT-1 loop
            if rows_full(r) = '1' then
                any := '1';
            end if;
        end loop;
        any_row_cleared <= any;
    end process;


    -------------------------------------------------------------------------
    -- 3) FSM principal: fijar pieza y borrar/compactar filas
    --    NOTA: todas las operaciones sobre 'board' son SECUECIALES
    --          (máx. 1 escritura de fila por ciclo) → apto para BRAM.
    -------------------------------------------------------------------------
    main_proc : process(clk, reset)
        -- variables locales para cálculo de posición de los bloques
        variable bit_row, bit_col : integer;
        variable gx, gy           : integer;
        variable idx_bit          : integer;
    begin
        if reset = '1' then
            -- Reset sincrono de la RAM y FSM
            board       <= (others => (others => '0'));
            state       <= S_IDLE;
            lock_idx    <= 0;
            scan_row    <= 0;
            wr_ptr      <= 0;
            clear_idx   <= 0;
            clear_limit <= 0;

        elsif rising_edge(clk) then

            case state is

                -----------------------------------------------------------------
                -- ESTADO IDLE:
                --   - Espera a que llegue lock_request o do_line_clear.
                -----------------------------------------------------------------
                when S_IDLE =>
                    -- No modificamos 'board' si no hay peticiones.

                    -- Prioridad a bloquear pieza frente a limpiar líneas.
                    if lock_request = '1' then
                        shape_reg <= shape_16b;
                        x_reg     <= x;
                        y_reg     <= y;
                        lock_idx  <= 0;
                        state     <= S_LOCK_WRITE;

                    elsif do_line_clear = '1' then
                        -- Preparamos el barrido de filas de abajo hacia arriba
                        scan_row    <= BOARD_HEIGHT - 1;
                        wr_ptr      <= BOARD_HEIGHT - 1;
                        clear_idx   <= 0;
                        clear_limit <= 0;
                        state       <= S_CLEAR_SCAN;
                    end if;


                -----------------------------------------------------------------
                -- S_LOCK_WRITE:
                --   Escribe, en hasta 16 ciclos, los bits '1' del shape_16b
                --   en el tablero, respetando los límites.
                -----------------------------------------------------------------
                when S_LOCK_WRITE =>

                    idx_bit := 15 - lock_idx;  -- mismo orden que tu código

                    if shape_reg(idx_bit) = '1' then
                        -- Coordenadas dentro del 4x4
                        bit_row := lock_idx / 4;
                        bit_col := lock_idx mod 4;

                        -- Coordenadas globales
                        gx := x_reg + bit_col;
                        gy := y_reg + bit_row;

                        if (gx >= 0) and (gx < BOARD_WIDTH) and
                           (gy >= 0) and (gy < BOARD_HEIGHT) then
                            -- Escritura de UNA celda por ciclo
                            board(gy)(gx) <= '1';
                        end if;
                    end if;

                    -- Avanzamos al siguiente bit de la pieza
                    if lock_idx = 15 then
                        state <= S_IDLE;
                    else
                        lock_idx <= lock_idx + 1;
                    end if;


                -----------------------------------------------------------------
                -- S_CLEAR_SCAN:
                --   Recorre de abajo a arriba.
                --   - Si la fila 'scan_row' NO está llena, se copia a 'wr_ptr'.
                --   - Las filas llenas se "saltan" (serán sustituidas por ceros).
                -----------------------------------------------------------------
                when S_CLEAR_SCAN =>

                    if rows_full(scan_row) = '0' then
                        -- Copiamos esta fila a la posición de escritura actual.
                        board(wr_ptr) <= board(scan_row);

                        -- Solo decrementamos si aún hay espacio por encima.
                        if wr_ptr > 0 then
                            wr_ptr <= wr_ptr - 1;
                        end if;
                    end if;

                    -- ¿Hemos terminado el barrido?
                    if scan_row = 0 then
                        -- Las filas 0..wr_ptr son las que quedan "huecas"
                        clear_limit <= wr_ptr;
                        clear_idx   <= 0;
                        state       <= S_CLEAR_ZERO;
                    else
                        scan_row <= scan_row - 1;
                    end if;


                -----------------------------------------------------------------
                -- S_CLEAR_ZERO:
                --   Pone a cero las filas 0..clear_limit (si hay huecos).
                -----------------------------------------------------------------
                when S_CLEAR_ZERO =>

                    if clear_idx <= clear_limit then
                        board(clear_idx) <= (others => '0');

                        if clear_idx = clear_limit then
                            state <= S_IDLE;
                        else
                            clear_idx <= clear_idx + 1;
                        end if;
                    else
                        -- Por seguridad, volvemos a IDLE.
                        state <= S_IDLE;
                    end if;

            end case;
        end if;
    end process;

end architecture RTL;
