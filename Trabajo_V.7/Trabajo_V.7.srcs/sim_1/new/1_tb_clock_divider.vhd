library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_clk_divider is
end entity;

architecture TB of tb_clk_divider is

    --------------------------------------------------------------------
    -- CONSTANTES
    --------------------------------------------------------------------
    constant GAME_SPEED_TB : integer := 20;   -- MUCHÍSIMO MÁS PEQUEÑO para TB
    constant DROP_SPEED_TB : integer := 50;   -- idem
    -- (en hardware real valen millones; aquí usamos valores muy bajos
    --  para que la simulación sea rápida)

    --------------------------------------------------------------------
    -- SEÑALES
    --------------------------------------------------------------------
    signal clk       : std_logic := '0';
    signal reset     : std_logic := '0';

    signal tick_game : std_logic;
    signal tick_drop : std_logic;

begin

    --------------------------------------------------------------------
    -- INSTANCIA DEL DUT
    --------------------------------------------------------------------
    DUT: entity work.clk_divider
        generic map (
            GAME_SPEED => GAME_SPEED_TB,
            DROP_SPEED => DROP_SPEED_TB
        )
        port map (
            clk       => clk,
            reset     => reset,
            tick_game => tick_game,
            tick_drop => tick_drop
        );


    --------------------------------------------------------------------
    -- GENERADOR DE RELOJ (100 MHz → periodo 10 ns)
    --------------------------------------------------------------------
    clock_gen : process
    begin
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
    end process;


    --------------------------------------------------------------------
    -- PROCESO PRINCIPAL DE ESTÍMULOS
    --------------------------------------------------------------------
    stim_proc : process
        variable cycle : integer := 0;
    begin

        ----------------------------------------------------------------
        -- 1) RESET
        ----------------------------------------------------------------
        report "==== RESET ====";
        reset <= '1';
        wait for 40 ns;
        reset <= '0';
        report "==== RESET LIBERADO ====";

        ----------------------------------------------------------------
        -- 2) ESPERAR CICLOS Y DETECTAR TICKS
        ----------------------------------------------------------------
        for i in 0 to 200 loop
            wait until rising_edge(clk);
            cycle := cycle + 1;

            if tick_game = '1' then
                report "Tick GAME en ciclo: " & integer'image(cycle);
            end if;

            if tick_drop = '1' then
                report "Tick DROP en ciclo: " & integer'image(cycle);
            end if;
        end loop;


        ----------------------------------------------------------------
        -- 3) FIN DE SIMULACIÓN
        ----------------------------------------------------------------
        report "==== FIN TB clk_divider ====";
        assert false report "END TB" severity failure;

        wait;

    end process;

end architecture TB;