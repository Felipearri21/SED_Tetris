library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_board_memory is
end entity;

architecture TB of tb_board_memory is

    -------------------------------------------------------------------------
    -- Parámetros
    -------------------------------------------------------------------------
    constant BOARD_WIDTH  : integer := 10;
    constant BOARD_HEIGHT : integer := 20;

    -------------------------------------------------------------------------
    -- Señales del DUT
    -------------------------------------------------------------------------
    signal clk   : std_logic := '0';
    signal reset : std_logic := '0';

    signal lock_piece   : std_logic := '0';
    signal clear_enable : std_logic := '0';

    signal piece_x     : integer := 0;
    signal piece_y     : integer := 0;
    signal piece_mask  : std_logic_vector(15 downto 0) := (others => '0');
    signal piece_color : std_logic_vector(2 downto 0)  := "001";

    signal any_row_full  : std_logic;
    signal lines_cleared : integer range 0 to 4;

    signal board_filled_flat : std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT-1 downto 0);
    signal board_color_flat  : std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT*3-1 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    -------------------------------------------------------------------------
    -- Clock
    -------------------------------------------------------------------------
    clk <= not clk after CLK_PERIOD/2;

    -------------------------------------------------------------------------
    -- DUT
    -------------------------------------------------------------------------
    dut : entity work.board_memory
        generic map (
            BOARD_WIDTH  => BOARD_WIDTH,
            BOARD_HEIGHT => BOARD_HEIGHT
        )
        port map (
            clk   => clk,
            reset => reset,

            lock_piece   => lock_piece,
            clear_enable => clear_enable,

            piece_x     => piece_x,
            piece_y     => piece_y,
            piece_mask  => piece_mask,
            piece_color => piece_color,

            any_row_full  => any_row_full,
            lines_cleared => lines_cleared,

            board_filled_flat => board_filled_flat,
            board_color_flat  => board_color_flat
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
        -- 2) Fijar una pieza horizontal (fila completa)
        --    Simulamos una fila llena manualmente
        ---------------------------------------------------------------------
        piece_y <= BOARD_HEIGHT-1;

        -- Rellenamos la fila inferior usando 3 piezas de 4 bloques
        piece_mask <= "0000111100000000"; -- pieza I horizontal

        piece_x <= 0;
        lock_piece <= '1';
        wait for CLK_PERIOD;

        piece_x <= 4;
        wait for CLK_PERIOD;

        piece_x <= 6;
        wait for CLK_PERIOD;

        lock_piece <= '0';
        wait for CLK_PERIOD;

        ---------------------------------------------------------------------
        -- 3) Comprobar detección de fila completa
        ---------------------------------------------------------------------
        wait for CLK_PERIOD;

        ---------------------------------------------------------------------
        -- 4) Borrar la fila
        ---------------------------------------------------------------------
        clear_enable <= '1';
        wait for CLK_PERIOD;
        clear_enable <= '0';

        ---------------------------------------------------------------------
        -- 5) Esperar y observar compactación
        ---------------------------------------------------------------------
        wait for 5*CLK_PERIOD;

        ---------------------------------------------------------------------
        -- FIN
        ---------------------------------------------------------------------
        wait;
    end process;

end architecture;
