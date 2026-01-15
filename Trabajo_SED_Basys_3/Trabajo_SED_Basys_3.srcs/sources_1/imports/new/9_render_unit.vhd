library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity render_unit is
    generic (
        BOARD_WIDTH  : integer := 10;
        BOARD_HEIGHT : integer := 20
    );
    port (
        board_filled_flat : in std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT-1 downto 0);
        board_color_flat  : in std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT*3-1 downto 0);

        x            : in integer;
        y            : in integer;
        shape_16b    : in std_logic_vector(15 downto 0);
        piece_color  : in std_logic_vector(2 downto 0);

        game_over    : in std_logic;
        win          : in std_logic;

        pixel_x      : in integer;
        pixel_y      : in integer;
        video_active : in std_logic;

        rgb          : out std_logic_vector(11 downto 0)
    );
end entity;

architecture COMB of render_unit is

    constant SCREEN_W : integer := 640;

    constant CELL_W : integer := 24;
    constant CELL_H : integer := 24;

    constant BOARD_PIX_W : integer := BOARD_WIDTH  * CELL_W;
    constant BOARD_PIX_H : integer := BOARD_HEIGHT * CELL_H;

    constant BOARD_X0 : integer := (SCREEN_W - BOARD_PIX_W) / 2;
    constant BOARD_Y0 : integer := 0;

    constant BORDER_THICKNESS : integer := 3;

    constant COLOR_BG        : std_logic_vector(11 downto 0) := x"000";
    constant COLOR_BOARD_BG  : std_logic_vector(11 downto 0) := x"222";
    constant COLOR_BORDER    : std_logic_vector(11 downto 0) := x"FFF";
    constant COLOR_WIN       : std_logic_vector(11 downto 0) := x"0F0";
    constant COLOR_GAME_OVER : std_logic_vector(11 downto 0) := x"F00";
    constant COLOR_CELL_EDGE : std_logic_vector(11 downto 0) := x"000";

    function color_to_rgb(c : std_logic_vector(2 downto 0))
        return std_logic_vector is
    begin
        case c is
            when "000" => return "111100000000";
            when "001" => return "000011110000";
            when "010" => return "000000001111";
            when "011" => return "111111110000";
            when "100" => return "111100001111";
            when "101" => return "000011111111";
            when "110" => return "111110100000";
            when others=> return "111111111111";
        end case;
    end function;

    -------------------------------------------------------------------------
    -- 5x7 FONT (SIN CAMBIOS)
    -------------------------------------------------------------------------
    function glyph5x7(ch : character) return std_logic_vector is
        variable g : std_logic_vector(34 downto 0);
    begin
        g := (others => '0');
        case ch is
            when 'A' => g := "01110"&"10001"&"10001"&"11111"&"10001"&"10001"&"10001";
            when 'E' => g := "11111"&"10000"&"10000"&"11110"&"10000"&"10000"&"11111";
            when 'G' => g := "01110"&"10001"&"10000"&"10111"&"10001"&"10001"&"01110";
            when 'I' => g := "11111"&"00100"&"00100"&"00100"&"00100"&"00100"&"11111";
            when 'M' => g := "10001"&"11011"&"10101"&"10001"&"10001"&"10001"&"10001";
            when 'N' => g := "10001"&"11001"&"10101"&"10011"&"10001"&"10001"&"10001";
            when 'O' => g := "01110"&"10001"&"10001"&"10001"&"10001"&"10001"&"01110";
            when 'R' => g := "11110"&"10001"&"10001"&"11110"&"10100"&"10010"&"10001";
            when 'V' => g := "10001"&"10001"&"10001"&"10001"&"10001"&"01010"&"00100";
            when 'W' => g := "10001"&"10001"&"10001"&"10001"&"10101"&"11011"&"10001";
            when others => g := (others => '0');
        end case;
        return g;
    end function;

    function glyph_on(ch : character; px, py, x0, y0, s : integer) return boolean is
        variable dx, dy, col, row, idx : integer;
        variable g : std_logic_vector(34 downto 0);
    begin
        dx := px - x0;
        dy := py - y0;
        if (dx < 0) or (dy < 0) or (dx >= 5*s) or (dy >= 7*s) then
            return false;
        end if;
        col := dx / s;
        row := dy / s;
        g := glyph5x7(ch);
        idx := row*5 + col;
        return g(34-idx) = '1';
    end function;

begin

    process(board_filled_flat, board_color_flat,
            x, y, shape_16b, piece_color,
            game_over, win,
            pixel_x, pixel_y, video_active)

        variable color      : std_logic_vector(11 downto 0);
        variable base_color : std_logic_vector(11 downto 0);

        variable cell_col, cell_row : integer;
        variable cell_x0, cell_y0   : integer;
        variable local_x, local_y   : integer;

        variable board_idx : integer;
        variable board_bit : std_logic;
        variable board_col : std_logic_vector(2 downto 0);

        variable piece_bit : std_logic;
        variable lx, ly, pidx : integer;

        variable in_board, in_border : boolean;
        variable occupied, edge_px  : boolean;
        variable draw_text           : boolean;

        constant S    : integer := 8;
        constant CW   : integer := 5*S;
        constant CH   : integer := 7*S;
        constant GAPX : integer := 2*S;
        constant GAPY : integer := 3*S;

        constant X_GAME : integer := (SCREEN_W - (4*CW + 3*GAPX)) / 2;
        constant Y_GAME : integer := 180;

        constant X_WIN  : integer := (SCREEN_W - (3*CW + 2*GAPX)) / 2;
        constant Y_WIN  : integer := 200;

        variable x0, y0 : integer;

    begin
        color := COLOR_BG;

        if video_active = '1' then

            ------------------------------------------------------------------
            -- GAME OVER / WIN (SIN CAMBIOS)
            ------------------------------------------------------------------
            if game_over = '1' or win = '1' then
                draw_text := false;

                if game_over = '1' then
                    x0 := X_GAME; y0 := Y_GAME;
                    if glyph_on('G',pixel_x,pixel_y,x0+0*(CW+GAPX),y0,S) or
                       glyph_on('A',pixel_x,pixel_y,x0+1*(CW+GAPX),y0,S) or
                       glyph_on('M',pixel_x,pixel_y,x0+2*(CW+GAPX),y0,S) or
                       glyph_on('E',pixel_x,pixel_y,x0+3*(CW+GAPX),y0,S) then
                        draw_text := true;
                    end if;

                    x0 := X_GAME; y0 := Y_GAME+CH+GAPY;
                    if glyph_on('O',pixel_x,pixel_y,x0+0*(CW+GAPX),y0,S) or
                       glyph_on('V',pixel_x,pixel_y,x0+1*(CW+GAPX),y0,S) or
                       glyph_on('E',pixel_x,pixel_y,x0+2*(CW+GAPX),y0,S) or
                       glyph_on('R',pixel_x,pixel_y,x0+3*(CW+GAPX),y0,S) then
                        draw_text := true;
                    end if;

                    if draw_text then color := COLOR_GAME_OVER; end if;
                else
                    x0 := X_WIN; y0 := Y_WIN;
                    if glyph_on('W',pixel_x,pixel_y,x0+0*(CW+GAPX),y0,S) or
                       glyph_on('I',pixel_x,pixel_y,x0+1*(CW+GAPX),y0,S) or
                       glyph_on('N',pixel_x,pixel_y,x0+2*(CW+GAPX),y0,S) then
                        draw_text := true;
                    end if;

                    if draw_text then color := COLOR_WIN; end if;
                end if;

            ------------------------------------------------------------------
            -- NORMAL GAME (OPCION B: renderer robusto)
            ------------------------------------------------------------------
            else
                in_board :=
                    (pixel_x >= BOARD_X0 - BORDER_THICKNESS) and
                    (pixel_x <  BOARD_X0 + BOARD_PIX_W + BORDER_THICKNESS) and
                    (pixel_y >= BOARD_Y0 - BORDER_THICKNESS) and
                    (pixel_y <  BOARD_Y0 + BOARD_PIX_H + BORDER_THICKNESS);

                if in_board then
                    in_border :=
                        (pixel_x < BOARD_X0) or
                        (pixel_x >= BOARD_X0 + BOARD_PIX_W) or
                        (pixel_y < BOARD_Y0) or
                        (pixel_y >= BOARD_Y0 + BOARD_PIX_H);

                    if in_border then
                        color := COLOR_BORDER;
                    else
                        cell_col := (pixel_x - BOARD_X0) / CELL_W;
                        cell_row := (pixel_y - BOARD_Y0) / CELL_H;

                        cell_x0 := BOARD_X0 + cell_col * CELL_W;
                        cell_y0 := BOARD_Y0 + cell_row * CELL_H;

                        if (pixel_x >= cell_x0) and (pixel_x < cell_x0 + CELL_W) and
                           (pixel_y >= cell_y0) and (pixel_y < cell_y0 + CELL_H) then

                            local_x := pixel_x - cell_x0;
                            local_y := pixel_y - cell_y0;

                            -- PRIORIDAD LIMPIA: tablero primero al fijarse
                            board_idx := cell_row * BOARD_WIDTH + cell_col;
                            board_bit := board_filled_flat(board_idx);
                            board_col := board_color_flat(3*board_idx+2 downto 3*board_idx);

                            if board_bit = '1' then
                                base_color := color_to_rgb(board_col);
                                occupied   := true;
                            else
                                piece_bit := '0';
                                lx := cell_col - x;
                                ly := cell_row - y;
                                if (lx>=0 and lx<4 and ly>=0 and ly<4) then
                                    pidx := ly*4 + lx;
                                    if shape_16b(15-pidx)='1' then
                                        piece_bit := '1';
                                    end if;
                                end if;

                                if piece_bit='1' then
                                    base_color := color_to_rgb(piece_color);
                                    occupied   := true;
                                else
                                    base_color := COLOR_BOARD_BG;
                                    occupied   := false;
                                end if;
                            end if;

                            edge_px := (local_x=0) or (local_x=CELL_W-1) or
                                       (local_y=0) or (local_y=CELL_H-1);

                            if occupied and edge_px then
                                color := COLOR_CELL_EDGE;
                            else
                                color := base_color;
                            end if;
                        else
                            color := COLOR_BOARD_BG;
                        end if;
                    end if;
                else
                    color := COLOR_BG;
                end if;
            end if;
        end if;

        rgb <= color;
    end process;

end architecture;
