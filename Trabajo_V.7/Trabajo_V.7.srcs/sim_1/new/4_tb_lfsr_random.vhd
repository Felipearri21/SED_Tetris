library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_lfsr_random is
end entity;

architecture TB of tb_lfsr_random is

    -- Señales internas
    signal clk        : std_logic := '0';
    signal reset      : std_logic := '0';
    signal random_out : integer;

begin

    --------------------------------------------------------------------
    -- DUT: Device Under Test
    --------------------------------------------------------------------
    DUT: entity work.lfsr_random
        port map (
            clk        => clk,
            reset      => reset,
            random_out => random_out
        );

    --------------------------------------------------------------------
    -- Generador de reloj (10 ns → 100 MHz ficticio)
    --------------------------------------------------------------------
    clk_process : process
    begin
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
    end process;

    --------------------------------------------------------------------
    -- Proceso de estímulos
    --------------------------------------------------------------------
    stim_process : process
    begin
        ----------------------------------------------------------
        -- Reset inicial
        ----------------------------------------------------------
        report ">> RESET";
        reset <= '1';
        wait for 50 ns;
        reset <= '0';
        wait for 50 ns;

        ----------------------------------------------------------
        -- Caso 1: LFSR avanzando libremente
        ----------------------------------------------------------
        report ">> TEST 1: LFSR avanzando normal (sin enable)";
        for i in 1 to 5 loop
            wait for 20 ns;
            report "  rnd_out = " & integer'image(random_out);
        end loop;

        ----------------------------------------------------------
        -- Caso 2: Observación continua
        ----------------------------------------------------------
        report ">> TEST 2: Comportamiento en 10 ciclos";
        for i in 1 to 10 loop
            wait for 20 ns;
            report "  rnd_next = " & integer'image(random_out);
        end loop;

        ----------------------------------------------------------
        -- Caso 3: “Enable pulsante simulado”
        ----------------------------------------------------------
        report ">> TEST 3: Modulación de reloj simulando enable";
        for i in 0 to 7 loop
            -- "Enable" simulado → dejamos correr un ciclo
            wait for 20 ns;
            report "  rnd_pulse = " & integer'image(random_out);

            -- “Disable” simulado → paramos 1 ciclo
            wait for 20 ns;
            report "  rnd_hold  = " & integer'image(random_out);
        end loop;

        ----------------------------------------------------------
        -- Final de la simulación
        ----------------------------------------------------------
        report ">> FIN DE LA SIMULACION";
        assert false report "FIN TB" severity failure;
        wait;

    end process;

end architecture TB;
