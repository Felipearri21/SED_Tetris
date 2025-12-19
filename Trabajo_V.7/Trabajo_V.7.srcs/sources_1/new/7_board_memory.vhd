library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity board_memory is
    generic (
        BOARD_WIDTH  : integer := 10;
        BOARD_HEIGHT : integer := 20
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        lock_piece   : in std_logic;
        clear_enable : in std_logic;

        piece_x     : in integer;
        piece_y     : in integer;
        piece_mask  : in std_logic_vector(15 downto 0);
        piece_color : in std_logic_vector(2 downto 0);

        any_row_full  : out std_logic;
        lines_cleared : out integer range 0 to 4;

        board_filled_flat : out std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT-1 downto 0);
        board_color_flat  : out std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT*3-1 downto 0)
    );
end entity;

architecture RTL of board_memory is

    type cell_t is record
        filled : std_logic;
        color  : std_logic_vector(2 downto 0);
    end record;

    type board_t is array (0 to BOARD_HEIGHT-1, 0 to BOARD_WIDTH-1) of cell_t;
    signal board : board_t := (others => (others => ('0',"000")));

    -- 🔒 REGISTRO de líneas borradas
    signal lines_cleared_reg : integer range 0 to 4 := 0;

begin

    -------------------------------------------------------------------------
    -- Aplanado
    -------------------------------------------------------------------------
    flatten : process(board)
        variable idx : integer := 0;
    begin
        idx := 0;
        for y in 0 to BOARD_HEIGHT-1 loop
            for x in 0 to BOARD_WIDTH-1 loop
                board_filled_flat(idx) <= board(y,x).filled;
                board_color_flat(3*idx+2 downto 3*idx) <= board(y,x).color;
                idx := idx + 1;
            end loop;
        end loop;
    end process;

    -------------------------------------------------------------------------
    -- Lógica principal
    -------------------------------------------------------------------------
    process(clk)
        variable temp_board : board_t;
        variable new_board  : board_t;

        variable row_full   : std_logic_vector(0 to BOARD_HEIGHT-1);
        variable full       : std_logic;
        variable any_full   : std_logic;
        variable count_full : integer range 0 to 4;

        variable write_row  : integer;
        variable px, py     : integer;
        variable bit_row, bit_col : integer;
    begin
        if rising_edge(clk) then
            if reset = '1' then
                board              <= (others => (others => ('0',"000")));
                any_row_full       <= '0';
                lines_cleared_reg  <= 0;

            else
                temp_board := board;
                any_full   := '0';
                count_full := 0;

                -----------------------------------------------------------------
                -- 1) Fijar pieza
                -----------------------------------------------------------------
                if lock_piece = '1' then
                    for i in 0 to 15 loop
                        if piece_mask(15 - i) = '1' then
                            bit_row := i / 4;
                            bit_col := i mod 4;
                            px := piece_x + bit_col;
                            py := piece_y + bit_row;

                            if (px >= 0 and px < BOARD_WIDTH and
                                py >= 0 and py < BOARD_HEIGHT) then
                                temp_board(py,px).filled := '1';
                                temp_board(py,px).color  := piece_color;
                            end if;
                        end if;
                    end loop;
                end if;

                -----------------------------------------------------------------
                -- 2) Detectar filas completas
                -----------------------------------------------------------------
                for y in 0 to BOARD_HEIGHT-1 loop
                    full := '1';
                    for x in 0 to BOARD_WIDTH-1 loop
                        full := full and temp_board(y,x).filled;
                    end loop;

                    row_full(y) := full;
                    if full = '1' then
                        any_full   := '1';
                        count_full := count_full + 1;
                    end if;
                end loop;

                any_row_full <= any_full;

                -----------------------------------------------------------------
                -- 3) Borrado de líneas
                -----------------------------------------------------------------
                if (clear_enable = '1') and (any_full = '1') then

                    -- 🔒 GUARDAMOS el número de líneas borradas
                    lines_cleared_reg <= count_full;

                    for y in 0 to BOARD_HEIGHT-1 loop
                        for x in 0 to BOARD_WIDTH-1 loop
                            new_board(y,x).filled := '0';
                            new_board(y,x).color  := "000";
                        end loop;
                    end loop;

                    write_row := BOARD_HEIGHT - 1;
                    for y in BOARD_HEIGHT-1 downto 0 loop
                        if row_full(y) = '0' then
                            for x in 0 to BOARD_WIDTH-1 loop
                                new_board(write_row,x) := temp_board(y,x);
                            end loop;
                            write_row := write_row - 1;
                        end if;
                    end loop;

                    temp_board := new_board;
                end if;

                board <= temp_board;
            end if;
        end if;
    end process;

    lines_cleared <= lines_cleared_reg;

end architecture RTL;
