library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_vga_controller is
end entity;

architecture TB of tb_vga_controller is

    -- Señales DUT
    signal clk_100MHz   : std_logic := '0';
    signal reset        : std_logic := '1';

    signal pixel_clk    : std_logic;
    signal hsync        : std_logic;
    signal vsync        : std_logic;
    signal video_active : std_logic;
    signal pixel_x      : integer;
    signal pixel_y      : integer;

    -- Período del reloj de 100 MHz
    constant CLK100_PERIOD : time := 10 ns;  -- 100 MHz

begin

    -------------------------------------------------------------------------
    -- Instancia del DUT
    -------------------------------------------------------------------------
    DUT : entity work.vga_controller
        port map(
            clk_100MHz   => clk_100MHz,
            reset        => reset,
            pixel_clk    => pixel_clk,
            hsync        => hsync,
            vsync        => vsync,
            video_active => video_active,
            pixel_x      => pixel_x,
            pixel_y      => pixel_y
        );

    -------------------------------------------------------------------------
    -- Generador del reloj 100 MHz
    -------------------------------------------------------------------------
    clk_process : process
    begin
        clk_100MHz <= '0';
        wait for CLK100_PERIOD/2;
        clk_100MHz <= '1';
        wait for CLK100_PERIOD/2;
    end process;

    -------------------------------------------------------------------------
    -- Proceso de estímulos
    -------------------------------------------------------------------------
    stim_proc : process
    begin
        -- Reset inicial
        reset <= '1';
        wait for 200 ns;
        reset <= '0';
        report "RESET desactivado, comienza la simulación" severity note;

        ---------------------------------------------------------------------
        -- Observamos algunos ciclos del pixel clock
        ---------------------------------------------------------------------
        report "Observando señales durante algunos ciclos..." severity note;

        wait for 2000 ns;

        report "Pixel clock actual = " & std_logic'image(pixel_clk);
        report "pixel_x=" & integer'image(pixel_x) &
               " pixel_y=" & integer'image(pixel_y);
        report "video_active = " & std_logic'image(video_active);
        report "hsync = " & std_logic'image(hsync) &
               " vsync=" & std_logic'image(vsync);

        ---------------------------------------------------------------------
        -- Esperamos hasta que haya un frame completo (525 líneas)
        ---------------------------------------------------------------------
        report "Esperando varios frames VGA..." severity note;

        wait for 20 ms;  -- sobradamente más de 1 frame a 60 Hz

        ---------------------------------------------------------------------
        -- Extra: mostrar cuando comienza la zona visible
        ---------------------------------------------------------------------
        if video_active = '1' then
            report "VIDEO ACTIVO detectado correctamente" severity note;
        else
            report "Advertencia: video_active no está activo en este instante" severity warning;
        end if;

        report "Coordenada visible actual: X=" & integer'image(pixel_x) &
               " Y=" & integer'image(pixel_y);

        ---------------------------------------------------------------------
        -- Fin de simulación
        ---------------------------------------------------------------------
        report "FIN DEL TESTBENCH" severity note;
        wait;
    end process;

end architecture TB;
