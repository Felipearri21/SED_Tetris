library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity board_memory is
    generic (
        BOARD_WIDTH  : integer := 10;
        BOARD_HEIGHT : integer := 20
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- Control
        lock_piece   : in std_logic;
        clear_enable : in std_logic;

        -- Pieza actual
        piece_x    : in integer range 0 to BOARD_WIDTH-1;
        piece_y    : in integer range 0 to BOARD_HEIGHT-1;
        piece_mask : in std_logic_vector(15 downto 0);

        -- Info real para la FSM
        any_row_full : out std_logic;

        -- Salida para render
        board_out : out std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT-1 downto 0)
    );
end entity;

architecture RTL of board_memory is

    type board_t is array (0 to BOARD_HEIGHT-1, 0 to BOARD_WIDTH-1) of std_logic;
    signal board : board_t := (others => (others => '0'));

begin

    -------------------------------------------------------------------------
    -- Aplanado del tablero
    -------------------------------------------------------------------------
    flatten : process(board)
        variable idx : integer := 0;
    begin
        idx := 0;
        for y in 0 to BOARD_HEIGHT-1 loop
            for x in 0 to BOARD_WIDTH-1 loop
                board_out(idx) <= board(y,x);
                idx := idx + 1;
            end loop;
        end loop;
    end process;

    -------------------------------------------------------------------------
    -- Proceso principal
    -------------------------------------------------------------------------
    main : process(clk)
        variable temp_board : board_t;
        variable new_board  : board_t;

        variable row_full   : std_logic_vector(0 to BOARD_HEIGHT-1);
        variable any_full   : std_logic;

        variable write_row  : integer;

        variable px, py     : integer;
        variable bit_row    : integer;
        variable bit_col    : integer;

        variable full       : std_logic;
    begin
        if rising_edge(clk) then
            if reset = '1' then
                board        <= (others => (others => '0'));
                any_row_full <= '0';

            else
                -----------------------------------------------------------------
                -- 0) Partimos del tablero actual
                -----------------------------------------------------------------
                temp_board := board;

                -----------------------------------------------------------------
                -- 1) LOCK: fijar pieza (MISMO MAPEADO que collision_detector)
                --    bit 15 = (row0,col0), bit 0 = (row3,col3)
                -----------------------------------------------------------------
                if lock_piece = '1' then
                    for i in 0 to 15 loop
                        if piece_mask(15 - i) = '1' then
                            bit_row := i / 4;
                            bit_col := i mod 4;

                            px := piece_x + bit_col;
                            py := piece_y + bit_row;

                            if (px >= 0 and px < BOARD_WIDTH and
                                py >= 0 and py < BOARD_HEIGHT) then
                                temp_board(py, px) := '1';
                            end if;
                        end if;
                    end loop;
                end if;

                -----------------------------------------------------------------
                -- 2) Detectar filas completas sobre temp_board
                -----------------------------------------------------------------
                any_full := '0';
                for y in 0 to BOARD_HEIGHT-1 loop
                    full := '1';
                    for x in 0 to BOARD_WIDTH-1 loop
                        full := full and temp_board(y, x);
                    end loop;

                    row_full(y) := full;
                    if full = '1' then
                        any_full := '1';
                    end if;
                end loop;

                any_row_full <= any_full;

                -----------------------------------------------------------------
                -- 3) Borrar líneas (solo si hay alguna)
                -----------------------------------------------------------------
                if (clear_enable = '1') and (any_full = '1') then

                    for y in 0 to BOARD_HEIGHT-1 loop
                        for x in 0 to BOARD_WIDTH-1 loop
                            new_board(y, x) := '0';
                        end loop;
                    end loop;

                    write_row := BOARD_HEIGHT - 1;

                    for y in BOARD_HEIGHT-1 downto 0 loop
                        if row_full(y) = '0' then
                            for x in 0 to BOARD_WIDTH-1 loop
                                new_board(write_row, x) := temp_board(y, x);
                            end loop;
                            write_row := write_row - 1;
                        end if;
                    end loop;

                    temp_board := new_board;
                end if;

                -----------------------------------------------------------------
                -- 4) Única escritura final
                -----------------------------------------------------------------
                board <= temp_board;

            end if;
        end if;
    end process;

end architecture RTL;
