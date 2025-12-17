library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_current_piece_ctrl is
end entity;

architecture TB of tb_current_piece_ctrl is

    -- Parámetros del tablero
    constant BW : integer := 10;
    constant BH : integer := 20;

    -- Señales del DUT
    signal clk   : std_logic := '0';
    signal reset : std_logic := '1';

    signal left_pulse  : std_logic := '0';
    signal right_pulse : std_logic := '0';
    signal rot_pulse   : std_logic := '0';
    signal drop_pulse  : std_logic := '0';

    signal tick_game : std_logic := '0';
    signal tick_drop : std_logic := '0';

    signal can_left  : std_logic := '1';
    signal can_right : std_logic := '1';
    signal can_rot   : std_logic := '1';
    signal can_down  : std_logic := '1';

    signal spawn_new : std_logic := '0';

    signal random_id : integer := 3;   -- pieza T, por ejemplo

    signal piece_id  : integer;
    signal rotation  : integer;
    signal x         : integer;
    signal y         : integer;

    signal lock_req : std_logic;

begin

    -------------------------------------------------------------------
    -- DUT: Instancia correcta del módulo
    -------------------------------------------------------------------
    DUT : entity work.current_piece_ctrl
        generic map (
            BOARD_WIDTH  => BW,
            BOARD_HEIGHT => BH
        )
        port map (
            clk   => clk,
            reset => reset,

            left_pulse  => left_pulse,
            right_pulse => right_pulse,
            rot_pulse   => rot_pulse,
            drop_pulse  => drop_pulse,

            tick_game => tick_game,
            tick_drop => tick_drop,

            can_move_left  => can_left,
            can_move_right => can_right,
            can_rotate     => can_rot,
            can_move_down  => can_down,

            spawn_new_piece => spawn_new,
            random_id       => random_id,

            piece_id => piece_id,
            rotation => rotation,
            x        => x,
            y        => y,

            lock_request => lock_req
        );

    -------------------------------------------------------------------
    -- Reloj
    -------------------------------------------------------------------
    clk <= not clk after 5 ns;

    -------------------------------------------------------------------
    -- Estímulos
    -------------------------------------------------------------------
    process
    begin
        ---------------------------------------------------------------
        -- Reset inicial
        ---------------------------------------------------------------
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 20 ns;

        ---------------------------------------------------------------
        -- Crear nueva pieza
        ---------------------------------------------------------------
        spawn_new <= '1';
        wait for 10 ns;
        spawn_new <= '0';

        wait for 40 ns;

        ---------------------------------------------------------------
        -- Pulsar mover izquierda
        ---------------------------------------------------------------
        left_pulse <= '1';
        tick_game  <= '1';
        wait for 10 ns;
        left_pulse <= '0';
        tick_game  <= '0';

        wait for 30 ns;

        ---------------------------------------------------------------
        -- Pulsar rotación
        ---------------------------------------------------------------
        rot_pulse <= '1';
        tick_game <= '1';
        wait for 10 ns;
        rot_pulse <= '0';
        tick_game <= '0';

        wait for 30 ns;

        ---------------------------------------------------------------
        -- Caída automática
        ---------------------------------------------------------------
        tick_drop <= '1';
        wait for 10 ns;
        tick_drop <= '0';

        wait for 30 ns;

        ---------------------------------------------------------------
        -- Caída manual
        ---------------------------------------------------------------
        drop_pulse <= '1';
        wait for 10 ns;
        drop_pulse <= '0';

        wait for 30 ns;

        ---------------------------------------------------------------
        -- Fin de la simulación
        ---------------------------------------------------------------
        wait;
    end process;

end architecture TB;
