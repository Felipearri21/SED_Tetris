library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity current_piece_ctrl is
    generic (
        BOARD_WIDTH  : integer := 10;
        BOARD_HEIGHT : integer := 20
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- Pulsos del usuario
        left_pulse  : in std_logic;
        right_pulse : in std_logic;
        rot_pulse   : in std_logic;
        drop_pulse  : in std_logic;

        -- Tiempos
        tick_game : in std_logic;
        tick_drop : in std_logic;

        -- Colisiones
        can_move_left  : in std_logic;
        can_move_right : in std_logic;
        can_rotate     : in std_logic;
        can_move_down  : in std_logic;

        -- Control del game controller
        spawn_new_piece : in std_logic;

        -- Aleatorio desde el LFSR
        random_id : in integer;

        -- Estado actual de la pieza
        piece_id : out integer;
        rotation : out integer;
        x        : out integer;
        y        : out integer;

        -- Petición de fijado
        lock_request : out std_logic
    );
end entity current_piece_ctrl;


architecture RTL of current_piece_ctrl is

    -- Registros internos
    signal x_reg, y_reg : integer := 0;
    signal rot_reg      : integer := 0;
    signal piece_id_reg : integer := 0;

    signal lock_req_reg : std_logic := '0';

    constant SPAWN_X : integer := BOARD_WIDTH/2 - 2;
    constant SPAWN_Y : integer := 0;

begin

    -------------------------------------------------------------------------
    -- Proceso principal
    -------------------------------------------------------------------------
    process(clk, reset)
    begin
        if reset = '1' then

            x_reg        <= SPAWN_X;
            y_reg        <= SPAWN_Y;
            rot_reg      <= 0;
            piece_id_reg <= 0;
            lock_req_reg <= '0';

        elsif rising_edge(clk) then

            -- Por defecto no pedimos fijado en este ciclo
            lock_req_reg <= '0';

            -----------------------------------------------------------------
            -- 1. Nueva pieza
            -----------------------------------------------------------------
            if spawn_new_piece = '1' then

                piece_id_reg <= random_id;   -- Latch aleatorio
                x_reg        <= SPAWN_X;
                y_reg        <= SPAWN_Y;
                rot_reg      <= 0;

            else

                -----------------------------------------------------------------
                -- 2. Movimientos con tick_game
                -----------------------------------------------------------------
                if tick_game = '1' then

                    if left_pulse = '1' and can_move_left = '1' then
                        x_reg <= x_reg - 1;
                    end if;

                    if right_pulse = '1' and can_move_right = '1' then
                        x_reg <= x_reg + 1;
                    end if;

                    if rot_pulse = '1' and can_rotate = '1' then
                        rot_reg <= (rot_reg + 1) mod 4;
                    end if;

                end if;

                -----------------------------------------------------------------
                -- 3. Caída automática
                -----------------------------------------------------------------
                if tick_drop = '1' then
                    if can_move_down = '1' then
                        y_reg <= y_reg + 1;
                    else
                        lock_req_reg <= '1';
                    end if;
                end if;

                -----------------------------------------------------------------
                -- 4. Caída manual
                -----------------------------------------------------------------
                if drop_pulse = '1' then
                    if can_move_down = '1' then
                        y_reg <= y_reg + 1;
                    else
                        lock_req_reg <= '1';
                    end if;
                end if;

            end if; -- spawn_new_piece

        end if;
    end process;

    -------------------------------------------------------------------------
    -- Salidas
    -------------------------------------------------------------------------
    x            <= x_reg;
    y            <= y_reg;
    rotation     <= rot_reg;
    piece_id     <= piece_id_reg;
    lock_request <= lock_req_reg;

end architecture RTL;
