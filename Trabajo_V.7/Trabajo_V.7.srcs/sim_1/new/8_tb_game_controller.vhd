library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_game_controller is
end entity;

architecture TB of tb_game_controller is

    -------------------------------------------------------------------
    -- Señales internas
    -------------------------------------------------------------------
    signal clk   : std_logic := '0';
    signal reset : std_logic := '0';

    signal lock_request    : std_logic := '0';
    signal any_row_cleared : std_logic := '0';

    signal spawn_new_piece : std_logic;
    signal do_line_clear   : std_logic;
    signal game_state      : std_logic_vector(2 downto 0);

begin

    -------------------------------------------------------------------
    -- Instancia del DUT (Device Under Test)
    -------------------------------------------------------------------
    DUT: entity work.game_controller
        port map (
            clk   => clk,
            reset => reset,
            lock_request    => lock_request,
            any_row_cleared => any_row_cleared,
            spawn_new_piece => spawn_new_piece,
            do_line_clear   => do_line_clear,
            game_state      => game_state
        );

    -------------------------------------------------------------------
    -- Generador del reloj (10 ns → 100 MHz ficticio)
    -------------------------------------------------------------------
    clk_process : process
    begin
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
    end process;


    -------------------------------------------------------------------
    -- PROCESO PRINCIPAL DE ESTÍMULOS
    -------------------------------------------------------------------
    stim_process : process
    begin
        ------------------------------------------------------------------
        -- 1) Reset inicial
        ------------------------------------------------------------------
        report "---- RESET ----";
        reset <= '1';
        wait for 40 ns;
        reset <= '0';
        wait for 40 ns;


        ------------------------------------------------------------------
        -- 2) Arranque: el controlador debe entrar en SPAWN
        ------------------------------------------------------------------
        report "Estado tras reset (esperado SPAWN)";
        wait for 40 ns;

        ------------------------------------------------------------------
        -- 3) SPAWN → PLAYING
        ------------------------------------------------------------------
        report "Comprobando transición SPAWN -> PLAYING";
        wait for 100 ns;


        ------------------------------------------------------------------
        -- 4) PLAYING → LOCK (cuando lock_request = 1)
        ------------------------------------------------------------------
        report "Simulando que la pieza ya no puede bajar: LOCK";
        lock_request <= '1';
        wait for 20 ns;
        lock_request <= '0';
        wait for 100 ns;


        ------------------------------------------------------------------
        -- 5) LOCK → LINE_CHECK
        ------------------------------------------------------------------
        report "Ahora debe estar en LINE_CHECK";
        wait for 60 ns;


        ------------------------------------------------------------------
        -- 6) Caso A: NO hay filas completas (any_row_cleared = 0)
        --           Vuelve a SPAWN
        ------------------------------------------------------------------
        report "Simulando que NO hay filas completas";
        any_row_cleared <= '0';
        wait for 120 ns;


        ------------------------------------------------------------------
        -- 7) Nuevo SPAWN → PLAYING de nuevo
        ------------------------------------------------------------------
        report "Comprobando nuevo SPAWN";
        wait for 100 ns;

        ------------------------------------------------------------------
        -- 8) PLAYING → LOCK otra vez
        ------------------------------------------------------------------
        report "Generando otro LOCK";
        lock_request <= '1';
        wait for 20 ns;
        lock_request <= '0';
        wait for 60 ns;  -- ahora estamos en LINE_CHECK


        ------------------------------------------------------------------
        -- 9) Caso B: SÍ hay filas completas (any_row_cleared = 1)
        ------------------------------------------------------------------
        report "Simulando fila completa: debe pasar a LINE_CLEAR";
        any_row_cleared <= '1';
        wait for 40 ns;


        ------------------------------------------------------------------
        -- 10) LINE_CLEAR → SPAWN
        ------------------------------------------------------------------
        wait for 100 ns;
        report "Tras LINE_CLEAR debe volver a SPAWN";


        ------------------------------------------------------------------
        -- 11) Fin de simulación
        ------------------------------------------------------------------
        report "---- FIN SIMULACION ----";
        assert false report "END TB" severity failure;

        wait;
    end process;

end architecture TB;
