library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_input_controller is
end entity;

architecture TB of tb_input_controller is

    --------------------------------------------------------------------
    -- Señales internas
    --------------------------------------------------------------------
    signal clk   : std_logic := '0';
    signal reset : std_logic := '0';

    -- Entradas crudas
    signal btn_left_raw  : std_logic := '0';
    signal btn_right_raw : std_logic := '0';
    signal btn_rot_raw   : std_logic := '0';
    signal btn_drop_raw  : std_logic := '0';

    -- Salidas limpias del DUT
    signal left_pulse  : std_logic;
    signal right_pulse : std_logic;
    signal rot_pulse   : std_logic;
    signal drop_pulse  : std_logic;

begin

    --------------------------------------------------------------------
    -- INSTANCIA DEL DUT
    --------------------------------------------------------------------
    DUT: entity work.input_controller
        port map (
            clk       => clk,
            reset     => reset,
            btn_left  => btn_left_raw,
            btn_right => btn_right_raw,
            btn_rot   => btn_rot_raw,
            btn_drop  => btn_drop_raw,
            p_left    => left_pulse,
            p_right   => right_pulse,
            p_rot     => rot_pulse,
            p_drop    => drop_pulse
        );

    --------------------------------------------------------------------
    -- GENERADOR DE RELOJ
    --------------------------------------------------------------------
    clk_process : process
    begin
        clk <= '0'; 
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    --------------------------------------------------------------------
    -- PROCESO DE ESTÍMULOS
    --------------------------------------------------------------------
    stim_process : process
    begin
        ----------------------------------------------------------------
        -- RESET INICIAL
        ----------------------------------------------------------------
        reset <= '1';
        wait for 40 ns;
        reset <= '0';

        ----------------------------------------------------------------
        -- 1) Pulsación limpia izquierda
        ----------------------------------------------------------------
        report "TEST: PULSACION LIMPIA izquierda";
        btn_left_raw <= '1';
        wait for 50 ns;
        btn_left_raw <= '0';
        wait for 100 ns;

        ----------------------------------------------------------------
        -- 2) Rebote derecha
        ----------------------------------------------------------------
        report "TEST: REBOTE en boton DERECHA";
        btn_right_raw <= '1';
        wait for 10 ns;
        btn_right_raw <= '0';
        wait for 10 ns;
        btn_right_raw <= '1';
        wait for 50 ns;
        btn_right_raw <= '0';
        wait for 100 ns;

        ----------------------------------------------------------------
        -- 3) Pulsación demasiado corta
        ----------------------------------------------------------------
        report "TEST: PULSACION CORTA rotar";
        btn_rot_raw <= '1';
        wait for 5 ns;
        btn_rot_raw <= '0';
        wait for 100 ns;

        ----------------------------------------------------------------
        -- 4) Pulsación larga drop
        ----------------------------------------------------------------
        report "TEST: PULSACION LARGA drop";
        btn_drop_raw <= '1';
        wait for 100 ns;
        btn_drop_raw <= '0';
        wait for 100 ns;

        ----------------------------------------------------------------
        -- FIN
        ----------------------------------------------------------------
        assert false report "FIN DE SIMULACION" severity failure;

    end process;

end architecture TB;
