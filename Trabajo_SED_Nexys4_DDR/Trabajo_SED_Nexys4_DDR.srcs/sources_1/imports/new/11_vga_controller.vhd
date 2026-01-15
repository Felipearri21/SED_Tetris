library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_controller is
    port (
        ---------------------------------------------------------------------
        -- Pixel clock (25 MHz desde Clock Wizard / MMCM)
        ---------------------------------------------------------------------
        pixel_clk    : in  std_logic;
        reset        : in  std_logic;

        ---------------------------------------------------------------------
        -- Señales VGA
        ---------------------------------------------------------------------
        hsync        : out std_logic;
        vsync        : out std_logic;
        video_active : out std_logic;

        ---------------------------------------------------------------------
        -- Coordenadas del píxel actual
        ---------------------------------------------------------------------
        pixel_x      : out integer range 0 to 639;
        pixel_y      : out integer range 0 to 479
    );
end entity;

architecture RTL of vga_controller is

    -------------------------------------------------------------------------
    -- PARÁMETROS VGA 640x480 @ 60 Hz (VESA)
    -------------------------------------------------------------------------
    constant H_VISIBLE  : integer := 640;
    constant H_FRONT    : integer := 16;
    constant H_SYNC     : integer := 96;
    constant H_BACK     : integer := 48;
    constant H_TOTAL    : integer := H_VISIBLE + H_FRONT + H_SYNC + H_BACK; -- 800

    constant V_VISIBLE  : integer := 480;
    constant V_FRONT    : integer := 10;
    constant V_SYNC     : integer := 2;
    constant V_BACK     : integer := 33;
    constant V_TOTAL    : integer := V_VISIBLE + V_FRONT + V_SYNC + V_BACK; -- 525

    -------------------------------------------------------------------------
    -- CONTADORES
    -------------------------------------------------------------------------
    signal h_count : integer range 0 to H_TOTAL-1 := 0;
    signal v_count : integer range 0 to V_TOTAL-1 := 0;

begin

    -------------------------------------------------------------------------
    -- CONTADORES HORIZONTAL Y VERTICAL
    -- Clockeados ÚNICAMENTE por pixel_clk
    -------------------------------------------------------------------------
    process(pixel_clk)
    begin
        if rising_edge(pixel_clk) then
            if reset = '1' then
                h_count <= 0;
                v_count <= 0;
            else
                if h_count = H_TOTAL - 1 then
                    h_count <= 0;
                    if v_count = V_TOTAL - 1 then
                        v_count <= 0;
                    else
                        v_count <= v_count + 1;
                    end if;
                else
                    h_count <= h_count + 1;
                end if;
            end if;
        end if;
    end process;

    -------------------------------------------------------------------------
    -- HSYNC (activo en bajo)
    -------------------------------------------------------------------------
    hsync <= '0' when (h_count >= H_VISIBLE + H_FRONT and
                       h_count <  H_VISIBLE + H_FRONT + H_SYNC)
             else '1';

    -------------------------------------------------------------------------
    -- VSYNC (activo en bajo)
    -------------------------------------------------------------------------
    vsync <= '0' when (v_count >= V_VISIBLE + V_FRONT and
                       v_count <  V_VISIBLE + V_FRONT + V_SYNC)
             else '1';

    -------------------------------------------------------------------------
    -- VIDEO ACTIVO (zona visible)
    -------------------------------------------------------------------------
    video_active <= '1' when (h_count < H_VISIBLE and
                              v_count < V_VISIBLE)
                    else '0';

    -------------------------------------------------------------------------
    -- COORDENADAS DEL PÍXEL VISIBLE
    -------------------------------------------------------------------------
    pixel_x <= h_count when h_count < H_VISIBLE else 0;
    pixel_y <= v_count when v_count < V_VISIBLE else 0;

end architecture RTL;
