library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_input_controller is
end entity;

architecture TB of tb_input_controller is

    -------------------------------------------------------------------------
    -- Señales del DUT
    -------------------------------------------------------------------------
    signal clk   : std_logic := '0';
    signal reset : std_logic := '0';

    signal btn_left  : std_logic := '0';
    signal btn_right : std_logic := '0';
    signal btn_rot   : std_logic := '0';
    signal btn_drop  : std_logic := '0';

    signal p_left  : std_logic;
    signal p_right : std_logic;
    signal p_rot   : std_logic;
    signal p_drop  : std_logic;

    -------------------------------------------------------------------------
    -- Parámetros de simulación
    -------------------------------------------------------------------------
    constant CLK_PERIOD : time := 10 ns;

begin

    -------------------------------------------------------------------------
    -- Generación de reloj
    -------------------------------------------------------------------------
    clk <= not clk after CLK_PERIOD/2;

    -------------------------------------------------------------------------
    -- Instancia del DUT
    -------------------------------------------------------------------------
    dut : entity work.input_controller
        generic map (
            CLK_FREQ_HZ => 1_000_000, -- reducido para simulación
            DEBOUNCE_MS => 1           -- debounce muy corto
        )
        port map (
            clk       => clk,
            reset     => reset,
            btn_left  => btn_left,
            btn_right => btn_right,
            btn_rot   => btn_rot,
            btn_drop  => btn_drop,
            p_left    => p_left,
            p_right   => p_right,
            p_rot     => p_rot,
            p_drop    => p_drop
        );

    -------------------------------------------------------------------------
    -- Proceso de estímulos
    -------------------------------------------------------------------------
    stim_proc : process
    begin
        ---------------------------------------------------------------------
        -- Reset inicial
        ---------------------------------------------------------------------
        reset <= '1';
        wait for 50 ns;
        reset <= '0';

        ---------------------------------------------------------------------
        -- Simulación de rebote en btn_left
        ---------------------------------------------------------------------
        btn_left <= '1'; wait for 20 ns;
        btn_left <= '0'; wait for 20 ns;
        btn_left <= '1'; wait for 20 ns;
        btn_left <= '0'; wait for 20 ns;
        btn_left <= '1';                -- pulsación estable
        wait for 200 ns;
        btn_left <= '0';

        wait for 200 ns;

        ---------------------------------------------------------------------
        -- Pulsación limpia btn_rot
        ---------------------------------------------------------------------
        btn_rot <= '1';
        wait for 200 ns;
        btn_rot <= '0';

        wait for 200 ns;

        ---------------------------------------------------------------------
        -- Mantener btn_drop pulsado (solo un pulso)
        ---------------------------------------------------------------------
        btn_drop <= '1';
        wait for 400 ns;
        btn_drop <= '0';

        wait for 200 ns;

        ---------------------------------------------------------------------
        -- Fin de simulación
        ---------------------------------------------------------------------
        wait;
    end process;

end architecture;
