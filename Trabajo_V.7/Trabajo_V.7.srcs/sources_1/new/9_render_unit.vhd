library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity render_unit is
    generic (
        BOARD_WIDTH  : integer := 10;
        BOARD_HEIGHT : integer := 20
    );
    port (
        board_flat   : in std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT-1 downto 0);
        x            : in integer;
        y            : in integer;
        shape_16b    : in std_logic_vector(15 downto 0);
        rotation     : in integer;

        pixel_x      : in integer;
        pixel_y      : in integer;
        video_active : in std_logic;

        rgb          : out std_logic_vector(11 downto 0)
    );
end entity;

architecture COMB of render_unit is

    constant SCREEN_W : integer := 640;
    constant SCREEN_H : integer := 480;

    constant CELL_W : integer := 32;
    constant CELL_H : integer := 24;

    constant BOARD_PIX_W : integer := BOARD_WIDTH * CELL_W;
    constant BOARD_PIX_H : integer := BOARD_HEIGHT * CELL_H;

    constant BOARD_X0 : integer := (SCREEN_W - BOARD_PIX_W) / 2;
    constant BOARD_Y0 : integer := 0;

    constant COLOR_EMPTY : std_logic_vector(11 downto 0) := (others => '0');
    constant COLOR_FULL  : std_logic_vector(11 downto 0) := (others => '1');

begin

    process(board_flat, x, y, shape_16b, rotation, pixel_x, pixel_y, video_active)
        variable color      : std_logic_vector(11 downto 0);
        variable cell_row   : integer;
        variable cell_col   : integer;
        variable board_idx  : integer;
        variable board_bit  : std_logic;
        variable piece_bit  : std_logic;

        variable local_x    : integer;
        variable local_y    : integer;
        variable piece_idx  : integer;

    begin
        color := COLOR_EMPTY;  -- default

        if video_active = '1' then

            if (pixel_x >= BOARD_X0) and (pixel_x < BOARD_X0 + BOARD_PIX_W) and
               (pixel_y >= BOARD_Y0) and (pixel_y < BOARD_Y0 + BOARD_PIX_H) then

                -- Compute board cell
                cell_col := (pixel_x - BOARD_X0) / CELL_W;
                cell_row := (pixel_y - BOARD_Y0) / CELL_H;

                if (cell_col >= 0) and (cell_col < BOARD_WIDTH) and
                   (cell_row >= 0) and (cell_row < BOARD_HEIGHT) then

                    board_idx := cell_row * BOARD_WIDTH + cell_col;
                    board_bit := board_flat(board_idx);

                    piece_bit := '0';

                    -- piece local coordinates
                    local_x := cell_col - x;
                    local_y := cell_row - y;

                    if (local_x >= 0) and (local_x < 4) and
                       (local_y >= 0) and (local_y < 4) then

                        piece_idx := local_y * 4 + local_x;

                        if shape_16b(15 - piece_idx) = '1' then
                            piece_bit := '1';
                        end if;

                    end if;

                    if (board_bit = '1') or (piece_bit = '1') then
                        color := COLOR_FULL;
                    else
                        color := COLOR_EMPTY;
                    end if;

                end if; -- valid board cell

            end if; -- inside board pixels

        end if; -- video_active

        rgb <= color;
    end process;

end architecture;
