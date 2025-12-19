library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity render_unit is
    generic (
        BOARD_WIDTH  : integer := 10;
        BOARD_HEIGHT : integer := 20
    );
    port (
        -- Tablero
        board_filled_flat : in std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT-1 downto 0);
        board_color_flat  : in std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT*3-1 downto 0);

        -- Pieza activa
        x            : in integer;
        y            : in integer;
        shape_16b    : in std_logic_vector(15 downto 0);
        piece_color  : in std_logic_vector(2 downto 0);

        -- VGA
        pixel_x      : in integer;
        pixel_y      : in integer;
        video_active : in std_logic;

        rgb          : out std_logic_vector(11 downto 0)
    );
end entity;

architecture COMB of render_unit is

    -------------------------------------------------------------------------
    -- Parámetros de pantalla y tablero
    -------------------------------------------------------------------------
    constant SCREEN_W : integer := 640;
    constant SCREEN_H : integer := 480;

    constant CELL_W : integer := 32;
    constant CELL_H : integer := 24;

    constant BOARD_PIX_W : integer := BOARD_WIDTH * CELL_W;
    constant BOARD_PIX_H : integer := BOARD_HEIGHT * CELL_H;

    constant BOARD_X0 : integer := (SCREEN_W - BOARD_PIX_W) / 2;
    constant BOARD_Y0 : integer := 0;

    constant FLAT_SIZE : integer := BOARD_WIDTH * BOARD_HEIGHT;

    -------------------------------------------------------------------------
    -- Colores
    -------------------------------------------------------------------------
    constant COLOR_EMPTY : std_logic_vector(11 downto 0) := (others => '0');

    function color_to_rgb(c : std_logic_vector(2 downto 0))
        return std_logic_vector is
    begin
        case c is
            when "000" => return "111100000000"; -- rojo
            when "001" => return "000011110000"; -- verde
            when "010" => return "000000001111"; -- azul
            when "011" => return "111111110000"; -- amarillo
            when "100" => return "111100001111"; -- magenta
            when "101" => return "000011111111"; -- cian
            when "110" => return "111110100000"; -- naranja
            when others=> return "111111111111"; -- blanco
        end case;
    end function;

begin

    -------------------------------------------------------------------------
    -- RENDER COMBINACIONAL POR PIXEL
    -------------------------------------------------------------------------
    process(board_filled_flat, board_color_flat,
            x, y, shape_16b, piece_color,
            pixel_x, pixel_y, video_active)

        variable color      : std_logic_vector(11 downto 0);
        variable cell_row   : integer;
        variable cell_col   : integer;
        variable board_idx  : integer;

        variable board_bit  : std_logic;
        variable board_col  : std_logic_vector(2 downto 0);

        variable piece_bit  : std_logic;
        variable local_x    : integer;
        variable local_y    : integer;
        variable piece_idx  : integer;

    begin
        color := COLOR_EMPTY;

        if video_active = '1' then
            if (pixel_x >= BOARD_X0) and (pixel_x < BOARD_X0 + BOARD_PIX_W) and
               (pixel_y >= BOARD_Y0) and (pixel_y < BOARD_Y0 + BOARD_PIX_H) then

                -----------------------------------------------------------------
                -- Coordenadas de celda
                -----------------------------------------------------------------
                cell_col := (pixel_x - BOARD_X0) / CELL_W;
                cell_row := (pixel_y - BOARD_Y0) / CELL_H;

                if (cell_col >= 0) and (cell_col < BOARD_WIDTH) and
                   (cell_row >= 0) and (cell_row < BOARD_HEIGHT) then

                    board_idx := cell_row * BOARD_WIDTH + cell_col;

                    -----------------------------------------------------------------
                    -- TABLERO FIJO (ÍNDICE DIRECTO: consistente con board_memory.flatten)
                    -----------------------------------------------------------------
                    board_bit := board_filled_flat(board_idx);
                    board_col := board_color_flat(
                        3*board_idx + 2 downto
                        3*board_idx
                    );

                    -----------------------------------------------------------------
                    -- PIEZA ACTIVA
                    -----------------------------------------------------------------
                    piece_bit := '0';
                    local_x := cell_col - x;
                    local_y := cell_row - y;

                    if (local_x >= 0) and (local_x < 4) and
                       (local_y >= 0) and (local_y < 4) then

                        piece_idx := local_y * 4 + local_x;

                        if shape_16b(15 - piece_idx) = '1' then
                            piece_bit := '1';
                        end if;
                    end if;

                    -----------------------------------------------------------------
                    -- PRIORIDAD: pieza activa sobre tablero
                    -----------------------------------------------------------------
                    if piece_bit = '1' then
                        color := color_to_rgb(piece_color);
                    elsif board_bit = '1' then
                        color := color_to_rgb(board_col);
                    else
                        color := COLOR_EMPTY;
                    end if;

                end if;
            end if;
        end if;

        rgb <= color;
    end process;

end architecture;
