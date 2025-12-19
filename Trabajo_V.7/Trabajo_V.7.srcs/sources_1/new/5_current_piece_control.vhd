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

        left_pulse  : in std_logic;
        right_pulse : in std_logic;
        rot_pulse   : in std_logic;
        drop_pulse  : in std_logic;

        tick_game : in std_logic;
        tick_drop : in std_logic;

        can_move_left  : in std_logic;
        can_move_right : in std_logic;
        can_rotate     : in std_logic;
        can_move_down  : in std_logic;

        spawn_new_piece : in std_logic;
        random_id       : in integer;

        piece_id    : out integer;
        rotation    : out integer;
        x           : out integer;
        y           : out integer;
        piece_color : out std_logic_vector(2 downto 0);

        lock_request : out std_logic
    );
end entity;

architecture RTL of current_piece_ctrl is

    signal x_reg, y_reg : integer := 0;
    signal rot_reg      : integer := 0;
    signal piece_id_reg : integer := 0;
    signal color_reg    : std_logic_vector(2 downto 0) := "000";

    signal lock_req_reg : std_logic := '0';
    signal frozen_reg   : std_logic := '0';  -- ✅ NUEVO: pieza congelada tras tocar suelo

    constant SPAWN_X : integer := BOARD_WIDTH/2 - 2;
    constant SPAWN_Y : integer := 0;

begin

    process(clk, reset)
    begin
        if reset = '1' then
            x_reg        <= SPAWN_X;
            y_reg        <= SPAWN_Y;
            rot_reg      <= 0;
            piece_id_reg <= 0;
            color_reg    <= "000";
            lock_req_reg <= '0';
            frozen_reg   <= '0';

        elsif rising_edge(clk) then
            -- por defecto no pedimos lock (pulso de 1 ciclo)
            lock_req_reg <= '0';

            -----------------------------------------------------------------
            -- 1) Si estamos congelados, NO movemos nada.
            --    Solo esperamos a que el game_controller pida spawn_new_piece.
            -----------------------------------------------------------------
            if frozen_reg = '1' then
                if spawn_new_piece = '1' then
                    piece_id_reg <= random_id;
                    color_reg    <= std_logic_vector(to_unsigned(random_id mod 8, 3));
                    x_reg        <= SPAWN_X;
                    y_reg        <= SPAWN_Y;
                    rot_reg      <= 0;
                    frozen_reg   <= '0';
                end if;

            else
                -----------------------------------------------------------------
                -- 2) Si el game_controller pide spawn, generamos nueva pieza
                -----------------------------------------------------------------
                if spawn_new_piece = '1' then
                    piece_id_reg <= random_id;
                    color_reg    <= std_logic_vector(to_unsigned(random_id mod 8, 3));
                    x_reg        <= SPAWN_X;
                    y_reg        <= SPAWN_Y;
                    rot_reg      <= 0;

                else
                    -----------------------------------------------------------------
                    -- 3) MOVIMIENTOS
                    -----------------------------------------------------------------
                    if left_pulse = '1' and can_move_left = '1' then
                        x_reg <= x_reg - 1;
                    end if;

                    if right_pulse = '1' and can_move_right = '1' then
                        x_reg <= x_reg + 1;
                    end if;

                    if rot_pulse = '1' and can_rotate = '1' then
                        rot_reg <= (rot_reg + 1) mod 4;
                    end if;

                    -----------------------------------------------------------------
                    -- 4) CAÍDA (auto o manual)
                    -----------------------------------------------------------------
                    if (tick_drop = '1') or (drop_pulse = '1') then
                        if can_move_down = '1' then
                            y_reg <= y_reg + 1;
                        else
                            -- ✅ toca suelo: pedimos lock y nos congelamos
                            lock_req_reg <= '1';
                            frozen_reg   <= '1';
                        end if;
                    end if;

                end if; -- spawn_new_piece
            end if; -- frozen_reg
        end if;
    end process;

    x            <= x_reg;
    y            <= y_reg;
    rotation     <= rot_reg;
    piece_id     <= piece_id_reg;
    piece_color  <= color_reg;
    lock_request <= lock_req_reg;

end architecture RTL;
