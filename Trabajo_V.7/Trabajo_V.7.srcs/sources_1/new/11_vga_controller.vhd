library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_controller is
    port (
        clk_100MHz   : in  std_logic;     -- reloj de 100 MHz de la placa
        reset        : in  std_logic;

        -- Salida del reloj de píxel (25 MHz)
        pixel_clk    : out std_logic;

        -- Señales VGA
        hsync        : out std_logic;
        vsync        : out std_logic;

        video_active : out std_logic;

        pixel_x      : out integer;
        pixel_y      : out integer
    );
end entity;

architecture RTL of vga_controller is

    -------------------------------------------------------------------------
    -- GENERACIÓN DE PIXEL CLOCK = 25 MHz
    -- (100 MHz / 4)
    -------------------------------------------------------------------------
    signal div_cnt   : unsigned(1 downto 0) := (others => '0');
    signal pix_clk_i : std_logic := '0';

    -------------------------------------------------------------------------
    -- TIEMPOS HORIZONTALES Y VERTICALES
    -------------------------------------------------------------------------
    constant H_VISIBLE  : integer := 640;
    constant H_FRONT    : integer := 16;
    constant H_SYNC     : integer := 96;
    constant H_BACK     : integer := 48;
    constant H_TOTAL    : integer := H_VISIBLE + H_FRONT + H_SYNC + H_BACK;  -- 800

    constant V_VISIBLE  : integer := 480;
    constant V_FRONT    : integer := 10;
    constant V_SYNC     : integer := 2;
    constant V_BACK     : integer := 33;
    constant V_TOTAL    : integer := V_VISIBLE + V_FRONT + V_SYNC + V_BACK;  -- 525

    -------------------------------------------------------------------------
    -- CONTADORES
    -------------------------------------------------------------------------
    signal h_count : integer range 0 to H_TOTAL-1 := 0;
    signal v_count : integer range 0 to V_TOTAL-1 := 0;

begin

    -------------------------------------------------------------------------
    -- DIVISOR DE FRECUENCIA: 100 MHz → 25 MHz
    -------------------------------------------------------------------------
    process(clk_100MHz)
    begin
        if rising_edge(clk_100MHz) then
            div_cnt <= div_cnt + 1;
            pix_clk_i <= div_cnt(1);   -- divide por 4
        end if;
    end process;

    pixel_clk <= pix_clk_i;


    -------------------------------------------------------------------------
    -- CONTADORES HORIZONTAL Y VERTICAL
    -------------------------------------------------------------------------
    process(pix_clk_i, reset)
    begin
        if reset = '1' then
            h_count <= 0;
            v_count <= 0;

        elsif rising_edge(pix_clk_i) then

            -- Contador horizontal
            if h_count = H_TOTAL-1 then
                h_count <= 0;

                -- Al finalizar una línea, incrementamos el vertical
                if v_count = V_TOTAL-1 then
                    v_count <= 0;
                else
                    v_count <= v_count + 1;
                end if;

            else
                h_count <= h_count + 1;
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
    -- VIDEO ACTIVE: SOLO zona visible
    -------------------------------------------------------------------------
    video_active <= '1' when (h_count < H_VISIBLE and v_count < V_VISIBLE) else '0';

    -------------------------------------------------------------------------
    -- COORDENADAS DEL PÍXEL VISIBLE
    -------------------------------------------------------------------------
    pixel_x <= h_count;
    pixel_y <= v_count;

end architecture RTL;
