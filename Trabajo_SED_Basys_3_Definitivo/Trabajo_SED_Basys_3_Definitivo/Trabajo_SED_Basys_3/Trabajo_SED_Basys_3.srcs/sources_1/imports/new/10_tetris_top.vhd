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
        vga_b     : out std_logic_vector(3 downto 0);

        -- 7 segmentos
        seg : out std_logic_vector(6 downto 0);
        an  : out std_logic_vector(3 downto 0)
    );
end entity;

architecture RTL of tetris_top is

    -------------------------------------------------------------------------
    -- CLOCK WIZARD
    -------------------------------------------------------------------------
    signal clk_game   : std_logic;   -- 25 MHz
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
    -- RESET ROBUSTO
    -------------------------------------------------------------------------
    constant RESET_BTN_ACTIVE_LOW : boolean := false;

    signal reset_btn_int : std_logic;
    signal rst_int       : std_logic;
    signal rst_ff1       : std_logic := '1';
    signal rst_ff2       : std_logic := '1';
    signal reset_sync    : std_logic;

    -------------------------------------------------------------------------
    -- SEÑALES DEL JUEGO
    -------------------------------------------------------------------------
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

    signal any_row_full    : std_logic;
    signal lines_cleared   : integer range 0 to 4;

    signal board_filled_flat : std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT-1 downto 0);
    signal board_color_flat  : std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT*3-1 downto 0);

    signal shape_16b : std_logic_vector(15 downto 0);

    -------------------------------------------------------------------------
    -- SCORE / FSM GLOBAL
    -------------------------------------------------------------------------
    signal score_pulse : std_logic;
    signal score_value : integer range 0 to 9999;

    signal level     : integer range 1 to 10;
    signal game_over : std_logic;
    signal win       : std_logic;

    signal game_over_cond : std_logic;

    -- NUEVO: restart & reset de juego
    signal restart_pulse : std_logic;
    signal game_reset    : std_logic;
    signal reset_game    : std_logic;

    -------------------------------------------------------------------------
    -- SPAWN CHECK (GAME OVER REAL)
    -------------------------------------------------------------------------
    constant SPAWN_X : integer := (BOARD_WIDTH / 2) - 2;
    constant SPAWN_Y : integer := 0;

    signal can_down_spawn  : std_logic;
    signal spawn_collision : std_logic;

    -------------------------------------------------------------------------
    -- VGA
    -------------------------------------------------------------------------
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

    -------------------------------------------------------------------------
    -- RESET (duro)
    -------------------------------------------------------------------------
    gen_reset_low : if RESET_BTN_ACTIVE_LOW generate
        reset_btn_int <= not reset_btn;
    end generate;

    gen_reset_high : if not RESET_BTN_ACTIVE_LOW generate
        reset_btn_int <= reset_btn;
    end generate;

    rst_int <= (not clk_locked) or reset_btn_int;

    process(clk_game)
    begin
        if rising_edge(clk_game) then
            rst_ff1 <= rst_int;
            rst_ff2 <= rst_ff1;
        end if;
    end process;

    reset_sync <= rst_ff2;

    -------------------------------------------------------------------------
    -- INPUT CONTROLLER (debounce -> pulsos)
    -------------------------------------------------------------------------
    input_ctrl_inst : entity work.input_controller
        port map (
            clk       => clk_game,
            reset     => reset_sync,
            btn_left  => btn_left,
            btn_right => btn_right,
            btn_rot   => btn_rot,
            btn_drop  => btn_drop,
            p_left    => p_left,
            p_right   => p_right,
            p_rot     => p_rot,
            p_drop    => p_drop
        );

    -------------------------------------------------------------------------
    -- RESTART: usar btn_rot SOLO si estás en WIN o GAME_OVER
    -- (si no, btn_rot sigue siendo rotación normal)
    -------------------------------------------------------------------------
    restart_pulse <= p_rot when (win = '1' or game_over = '1') else '0';

    -------------------------------------------------------------------------
    -- RANDOM (lo reseteamos con reset_game para que al reiniciar sea limpio)
    -------------------------------------------------------------------------
    random_inst : entity work.lfsr_random
        port map (
            clk        => clk_game,
            reset      => reset_game,
            random_out => random_id
        );

    -------------------------------------------------------------------------
    -- SPAWN CHECK (collision_detector clásico)
    -------------------------------------------------------------------------
    spawn_chk_inst : entity work.collision_detector
        generic map (
            BOARD_WIDTH  => BOARD_WIDTH,
            BOARD_HEIGHT => BOARD_HEIGHT
        )
        port map (
            piece_id   => random_id,
            rotation   => 0,
            x          => SPAWN_X,
            y          => SPAWN_Y,
            board_flat => board_filled_flat,

            can_move_left  => open,
            can_move_right => open,
            can_move_down  => can_down_spawn,
            can_rotate     => open
        );

    spawn_collision <= not can_down_spawn;
    game_over_cond  <= spawn_new_piece and spawn_collision;

    -------------------------------------------------------------------------
    -- GAME CONTROLLER (NUEVO)
    -------------------------------------------------------------------------
    game_ctrl_inst : entity work.game_controller
        port map (
            clk             => clk_game,
            reset           => reset_sync,

            lock_request    => lock_request,
            any_row_cleared => any_row_full,
            lines_cleared   => lines_cleared,

            score           => score_value,
            game_over_cond  => game_over_cond,

            restart         => restart_pulse,

            spawn_new_piece => spawn_new_piece,
            do_line_clear   => clear_enable,
            score_pulse     => score_pulse,

            level           => level,
            game_over       => game_over,
            win             => win,

            game_reset      => game_reset,

            game_state      => open
        );

    -------------------------------------------------------------------------
    -- RESET DE JUEGO (suave) -> se aplica a los bloques "de estado del juego"
    -------------------------------------------------------------------------
    reset_game <= reset_sync or game_reset;

    -------------------------------------------------------------------------
    -- DIVISOR DE TICKS (DEPENDE DE LEVEL)
    -------------------------------------------------------------------------
    clkdiv_inst : entity work.clk_divider
        port map (
            clk       => clk_game,
            reset     => reset_game,
            level     => level,
            tick_game => tick_game,
            tick_drop => tick_drop
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
            reset => reset_game,

            left_pulse  => p_left,
            right_pulse => p_right,
            rot_pulse   => p_rot,
            drop_pulse  => p_drop,

            tick_game   => tick_game,
            tick_drop   => tick_drop,

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
    -- COLISIONES (NORMAL)
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
    -- BOARD MEMORY
    -------------------------------------------------------------------------
    board_inst : entity work.board_memory
        generic map (
            BOARD_WIDTH  => BOARD_WIDTH,
            BOARD_HEIGHT => BOARD_HEIGHT
        )
        port map (
            clk   => clk_game,
            reset => reset_game,

            piece_x     => x_pos,
            piece_y     => y_pos,
            piece_mask  => shape_16b,
            piece_color => piece_color,

            lock_piece   => lock_request,
            clear_enable => clear_enable,

            any_row_full  => any_row_full,
            lines_cleared => lines_cleared,

            board_filled_flat => board_filled_flat,
            board_color_flat  => board_color_flat
        );

    -------------------------------------------------------------------------
    -- SCORE
    -------------------------------------------------------------------------
    score_inst : entity work.score_counter
        port map (
            clk           => clk_game,
            reset         => reset_game,
            score_pulse   => score_pulse,
            lines_cleared => lines_cleared,
            score         => score_value
        );

    -------------------------------------------------------------------------
    -- SEVEN SEG
    -------------------------------------------------------------------------
    seg_inst : entity work.seven_seg_driver
        port map (
            clk   => clk_game,
            value => score_value,
            seg   => seg,
            an    => an
        );

    -------------------------------------------------------------------------
    -- VGA CONTROLLER
    -------------------------------------------------------------------------
    vga_inst : entity work.vga_controller
        port map (
            pixel_clk    => clk_game,
            reset        => reset_sync,
            hsync        => vga_hsync,
            vsync        => vga_vsync,
            video_active => video_active,
            pixel_x      => pixel_x,
            pixel_y      => pixel_y
        );

    -------------------------------------------------------------------------
    -- RENDER
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

            game_over    => game_over,
            win          => win,

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
