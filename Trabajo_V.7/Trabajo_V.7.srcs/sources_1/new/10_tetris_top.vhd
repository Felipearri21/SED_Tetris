library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tetris_top is
    generic (
        BOARD_WIDTH  : integer := 10;
        BOARD_HEIGHT : integer := 20
    );
    port (
        clk_100MHz : in  std_logic;
        reset_btn  : in  std_logic;

        btn_left  : in std_logic;
        btn_right : in std_logic;
        btn_rot   : in std_logic;
        btn_drop  : in std_logic;

        -- VGA
        vga_hsync : out std_logic;
        vga_vsync : out std_logic;
        vga_r     : out std_logic_vector(3 downto 0);
        vga_g     : out std_logic_vector(3 downto 0);
        vga_b     : out std_logic_vector(3 downto 0)
    );
end entity;

architecture RTL of tetris_top is

    -------------------------------------------------------------------------
    -- CLOCK WIZARD
    -------------------------------------------------------------------------
    signal clk_game   : std_logic;
    signal clk_locked : std_logic;

    component clk_wiz_tetris
        port (
            clk_in1  : in  std_logic;
            reset    : in  std_logic;
            clk_out1 : out std_logic;
            locked   : out std_logic
        );
    end component;

    -------------------------------------------------------------------------
    -- SEÑALES INTERNAS
    -------------------------------------------------------------------------
    signal reset_sync : std_logic;

    signal p_left, p_right, p_rot, p_drop : std_logic;
    signal tick_game, tick_drop : std_logic;

    signal random_id : integer;
    signal piece_id  : integer;
    signal rotation  : integer;
    signal x_pos     : integer;
    signal y_pos     : integer;
    signal piece_color : std_logic_vector(2 downto 0);

    signal can_l, can_r, can_rot, can_d : std_logic;

    signal spawn_new_piece : std_logic;
    signal clear_enable    : std_logic;
    signal lock_request    : std_logic;

    signal any_row_full : std_logic;

    signal board_filled_flat : std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT-1 downto 0);
    signal board_color_flat  : std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT*3-1 downto 0);

    signal shape_16b : std_logic_vector(15 downto 0);

    -------------------------------------------------------------------------
    -- VGA
    -------------------------------------------------------------------------
    signal pixel_clk    : std_logic;
    signal pixel_x      : integer;
    signal pixel_y      : integer;
    signal video_active : std_logic;
    signal rgb          : std_logic_vector(11 downto 0);

begin

    -------------------------------------------------------------------------
    -- CLOCK WIZARD
    -------------------------------------------------------------------------
    u_clk_wiz : clk_wiz_tetris
        port map (
            clk_in1  => clk_100MHz,
            reset    => '0',
            clk_out1 => clk_game,
            locked   => clk_locked
        );

    reset_sync <= (not reset_btn) or (not clk_locked);

    -------------------------------------------------------------------------
    -- DIVISOR DE RELOJ
    -------------------------------------------------------------------------
    clkdiv_inst : entity work.clk_divider
        port map (
            clk       => clk_game,
            reset     => reset_sync,
            tick_game => tick_game,
            tick_drop => tick_drop
        );

    -------------------------------------------------------------------------
    -- INPUT CONTROLLER
    -------------------------------------------------------------------------
    input_ctrl_inst : entity work.input_controller
        port map (
            clk       => clk_game,
            reset     => reset_sync,

            btn_left  => btn_left,
            btn_right => btn_right,
            btn_rot   => btn_rot,
            btn_drop  => btn_drop,

            p_left  => p_left,
            p_right => p_right,
            p_rot   => p_rot,
            p_drop  => p_drop
        );

    -------------------------------------------------------------------------
    -- RANDOM
    -------------------------------------------------------------------------
    random_inst : entity work.lfsr_random
        port map (
            clk        => clk_game,
            reset      => reset_sync,
            random_out => random_id
        );

    -------------------------------------------------------------------------
    -- GAME CONTROLLER
    -------------------------------------------------------------------------
    game_ctrl_inst : entity work.game_controller
        port map (
            clk             => clk_game,
            reset           => reset_sync,

            lock_request    => lock_request,
            any_row_cleared => any_row_full,

            spawn_new_piece => spawn_new_piece,
            do_line_clear   => clear_enable,

            game_state => open
        );

    -------------------------------------------------------------------------
    -- PIEZA ACTUAL
    -------------------------------------------------------------------------
    piece_ctrl_inst : entity work.current_piece_ctrl
        generic map (
            BOARD_WIDTH  => BOARD_WIDTH,
            BOARD_HEIGHT => BOARD_HEIGHT
        )
        port map (
            clk   => clk_game,
            reset => reset_sync,

            left_pulse  => p_left,
            right_pulse => p_right,
            rot_pulse   => p_rot,
            drop_pulse  => p_drop,

            tick_game => tick_game,
            tick_drop => tick_drop,

            can_move_left  => can_l,
            can_move_right => can_r,
            can_rotate     => can_rot,
            can_move_down  => can_d,

            spawn_new_piece => spawn_new_piece,
            random_id       => random_id,

            piece_id    => piece_id,
            rotation    => rotation,
            x           => x_pos,
            y           => y_pos,
            piece_color => piece_color,

            lock_request => lock_request
        );

    -------------------------------------------------------------------------
    -- ROM PIEZAS
    -------------------------------------------------------------------------
    rom_inst : entity work.piece_rom
        port map (
            piece_id  => piece_id,
            rotation  => rotation,
            shape_16b => shape_16b
        );

    -------------------------------------------------------------------------
    -- COLISIONES
    -------------------------------------------------------------------------
    col_inst : entity work.collision_detector
        generic map (
            BOARD_WIDTH  => BOARD_WIDTH,
            BOARD_HEIGHT => BOARD_HEIGHT
        )
        port map (
            piece_id   => piece_id,
            rotation   => rotation,
            x          => x_pos,
            y          => y_pos,
            board_flat => board_filled_flat,

            can_move_left  => can_l,
            can_move_right => can_r,
            can_move_down  => can_d,
            can_rotate     => can_rot
        );

    -------------------------------------------------------------------------
    -- BOARD MEMORY (con color)
    -------------------------------------------------------------------------
    board_inst : entity work.board_memory
        generic map (
            BOARD_WIDTH  => BOARD_WIDTH,
            BOARD_HEIGHT => BOARD_HEIGHT
        )
        port map (
            clk   => clk_game,
            reset => reset_sync,

            piece_x     => x_pos,
            piece_y     => y_pos,
            piece_mask  => shape_16b,
            piece_color => piece_color,

            lock_piece   => lock_request,
            clear_enable => clear_enable,

            any_row_full => any_row_full,

            board_filled_flat => board_filled_flat,
            board_color_flat  => board_color_flat
        );

    -------------------------------------------------------------------------
    -- VGA CONTROLLER
    -------------------------------------------------------------------------
    vga_inst : entity work.vga_controller
        port map (
            clk_100MHz   => clk_100MHz,
            reset        => reset_sync,

            pixel_clk    => pixel_clk,
            hsync        => vga_hsync,
            vsync        => vga_vsync,

            video_active => video_active,
            pixel_x      => pixel_x,
            pixel_y      => pixel_y
        );

    -------------------------------------------------------------------------
    -- RENDER CON COLOR
    -------------------------------------------------------------------------
    render_inst : entity work.render_unit
        generic map (
            BOARD_WIDTH  => BOARD_WIDTH,
            BOARD_HEIGHT => BOARD_HEIGHT
        )
        port map (
            board_filled_flat => board_filled_flat,
            board_color_flat  => board_color_flat,

            x            => x_pos,
            y            => y_pos,
            shape_16b    => shape_16b,
            piece_color  => piece_color,

            pixel_x      => pixel_x,
            pixel_y      => pixel_y,
            video_active => video_active,

            rgb          => rgb
        );

    -------------------------------------------------------------------------
    -- SALIDA VGA
    -------------------------------------------------------------------------
    vga_r <= rgb(11 downto 8);
    vga_g <= rgb(7 downto 4);
    vga_b <= rgb(3 downto 0);

end architecture RTL;
