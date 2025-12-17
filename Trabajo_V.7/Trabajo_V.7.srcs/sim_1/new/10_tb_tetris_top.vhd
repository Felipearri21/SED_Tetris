library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_tetris_top is
end entity;

architecture TB of tb_tetris_top is

    -- Top signals
    signal clk_100MHz : std_logic := '0';
    signal reset_btn  : std_logic := '1';

    signal btn_left  : std_logic := '0';
    signal btn_right : std_logic := '0';
    signal btn_rot   : std_logic := '0';
    signal btn_drop  : std_logic := '0';

    signal vga_hsync : std_logic;
    signal vga_vsync : std_logic;
    signal vga_r     : std_logic_vector(3 downto 0);
    signal vga_g     : std_logic_vector(3 downto 0);
    signal vga_b     : std_logic_vector(3 downto 0);

    constant CLK_PERIOD : time := 10 ns; -- 100 MHz

begin

    -------------------------------------------------------------------------
    -- DUT instantiation
    -------------------------------------------------------------------------
    DUT : entity work.tetris_top
        port map (
            clk_100MHz => clk_100MHz,
            reset_btn  => reset_btn,

            btn_left   => btn_left,
            btn_right  => btn_right,
            btn_rot    => btn_rot,
            btn_drop   => btn_drop,

            vga_hsync  => vga_hsync,
            vga_vsync  => vga_vsync,
            vga_r      => vga_r,
            vga_g      => vga_g,
            vga_b      => vga_b
        );


    -------------------------------------------------------------------------
    -- Clock generator (100 MHz)
    -------------------------------------------------------------------------
    clk_process : process
    begin
        clk_100MHz <= '0';
        wait for CLK_PERIOD/2;
        clk_100MHz <= '1';
        wait for CLK_PERIOD/2;
    end process;


    -------------------------------------------------------------------------
    -- Stimulus process
    -------------------------------------------------------------------------
    stim_proc : process
    begin
        
        ---------------------------------------------------------------------
        -- Reset
        ---------------------------------------------------------------------
        reset_btn <= '1';
        wait for 500 ns;
        reset_btn <= '0';
        report "Reset released";

        ---------------------------------------------------------------------
        -- Wait some time for system initialization
        ---------------------------------------------------------------------
        wait for 2 ms;

        report "Initial VGA sample:";
        report "HSYNC=" & std_logic'image(vga_hsync)
            & " VSYNC=" & std_logic'image(vga_vsync);

        report "RGB="
            & integer'image(to_integer(unsigned(vga_r))) & " "
            & integer'image(to_integer(unsigned(vga_g))) & " "
            & integer'image(to_integer(unsigned(vga_b)));

        ---------------------------------------------------------------------
        -- Basic button tests
        ---------------------------------------------------------------------
        report "Testing left button";
        btn_left <= '1'; wait for 200 ns; btn_left <= '0';
        wait for 2 ms;

        report "Testing rotate button";
        btn_rot <= '1'; wait for 200 ns; btn_rot <= '0';
        wait for 2 ms;

        report "Testing right button";
        btn_right <= '1'; wait for 200 ns; btn_right <= '0';
        wait for 2 ms;

        report "Testing drop button";
        btn_drop <= '1'; wait for 300 ns; btn_drop <= '0';
        wait for 3 ms;

        ---------------------------------------------------------------------
        -- Final VGA sample
        ---------------------------------------------------------------------
        report "Final VGA RGB sample:";
        report "RGB="
            & integer'image(to_integer(unsigned(vga_r))) & " "
            & integer'image(to_integer(unsigned(vga_g))) & " "
            & integer'image(to_integer(unsigned(vga_b)));

        report "End of TB";
        wait;
    end process;

end architecture;
