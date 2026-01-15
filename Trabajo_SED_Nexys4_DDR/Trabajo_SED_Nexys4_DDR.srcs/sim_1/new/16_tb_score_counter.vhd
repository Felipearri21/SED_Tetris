library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_score_counter is
end entity;

architecture TB of tb_score_counter is

    -------------------------------------------------------------------------
    -- Señales del DUT
    -------------------------------------------------------------------------
    signal clk           : std_logic := '0';
    signal reset         : std_logic := '0';
    signal score_pulse   : std_logic := '0';
    signal lines_cleared : integer range 0 to 4 := 0;
    signal score         : integer range 0 to 9999;

    constant CLK_PERIOD : time := 10 ns;

begin

    -------------------------------------------------------------------------
    -- Clock
    -------------------------------------------------------------------------
    clk <= not clk after CLK_PERIOD/2;

    -------------------------------------------------------------------------
    -- DUT
    -------------------------------------------------------------------------
    dut : entity work.score_counter
        port map (
            clk           => clk,
            reset         => reset,
            score_pulse   => score_pulse,
            lines_cleared => lines_cleared,
            score         => score
        );

    -------------------------------------------------------------------------
    -- Estímulos
    -------------------------------------------------------------------------
    stim_proc : process
    begin
        ---------------------------------------------------------------------
        -- 1) RESET
        ---------------------------------------------------------------------
        reset <= '1';
        wait for 2*CLK_PERIOD;
        reset <= '0';
        wait for CLK_PERIOD;

        ---------------------------------------------------------------------
        -- 2) Borrar 1 línea → +100
        ---------------------------------------------------------------------
        lines_cleared <= 1;
        score_pulse   <= '1';
        wait for CLK_PERIOD;
        score_pulse   <= '0';
        wait for 2*CLK_PERIOD;

        ---------------------------------------------------------------------
        -- 3) Borrar 2 líneas → +300
        ---------------------------------------------------------------------
        lines_cleared <= 2;
        score_pulse   <= '1';
        wait for CLK_PERIOD;
        score_pulse   <= '0';
        wait for 2*CLK_PERIOD;

        ---------------------------------------------------------------------
        -- 4) Borrar 4 líneas → +800
        ---------------------------------------------------------------------
        lines_cleared <= 4;
        score_pulse   <= '1';
        wait for CLK_PERIOD;
        score_pulse   <= '0';
        wait for 2*CLK_PERIOD;

        ---------------------------------------------------------------------
        -- 5) score_pulse = 0 → NO cambia la puntuación
        ---------------------------------------------------------------------
        lines_cleared <= 3;
        wait for 3*CLK_PERIOD;

        ---------------------------------------------------------------------
        -- FIN
        ---------------------------------------------------------------------
        wait;
    end process;

end architecture;
