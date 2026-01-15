library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity game_controller is
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- Desde pieza / tablero
        lock_request    : in std_logic;
        any_row_cleared : in std_logic;
        lines_cleared   : in integer range 0 to 4;

        -- Puntuacion / estado global
        score           : in integer;
        game_over_cond  : in std_logic;

        -- Reinicio del juego (pulso, p_rot)
        restart         : in std_logic;

        -- Control
        spawn_new_piece : out std_logic;
        do_line_clear   : out std_logic;

        -- Puntuacion
        score_pulse     : out std_logic;

        -- Estado global
        level           : out integer;
        game_over       : out std_logic;
        win             : out std_logic;

        -- Reset logico del juego
        game_reset      : out std_logic;

        -- Debug
        game_state : out std_logic_vector(3 downto 0)
    );
end entity;

architecture FSM of game_controller is

    -------------------------------------------------------------------------
    -- Parametros de juego
    -------------------------------------------------------------------------
    constant SCORE_WIN       : integer := 9900;
    constant LINES_PER_LEVEL : integer := 10;
    constant LEVEL_MAX       : integer := 10;

    -------------------------------------------------------------------------
    -- Estados
    -------------------------------------------------------------------------
    type state_t is (
        S_SPAWN,
        S_PLAYING,
        S_LOCK,
        S_LINE_CHECK,
        S_LINE_CLEAR,
        S_LEVEL_UP,
        S_GAME_OVER,
        S_WIN
    );

    signal state, next_state : state_t;

    -------------------------------------------------------------------------
    -- Registros
    -------------------------------------------------------------------------
    signal level_r        : integer range 1 to LEVEL_MAX := 1;
    signal lines_accum    : integer := 0;
    signal score_pulse_r  : std_logic := '0';

begin

    -------------------------------------------------------------------------
    -- REGISTRO DE ESTADO / NIVEL / PULSOS
    -------------------------------------------------------------------------
    process(clk, reset)
    begin
        if reset = '1' then
            state         <= S_SPAWN;
            level_r       <= 1;
            lines_accum   <= 0;
            score_pulse_r <= '0';

        elsif rising_edge(clk) then
            state <= next_state;

            -- Pulso de puntuacion (1 ciclo, sincronizado)
            if state = S_LINE_CLEAR then
                score_pulse_r <= '1';
            else
                score_pulse_r <= '0';
            end if;

            -- Reset logico del juego
            if restart = '1' then
                level_r     <= 1;
                lines_accum <= 0;
            else
                if state = S_LINE_CLEAR then
                    lines_accum <= lines_accum + lines_cleared;
                end if;

                if state = S_LEVEL_UP then
                    if level_r < LEVEL_MAX then
                        level_r     <= level_r + 1;
                        lines_accum <= 0;
                    end if;
                end if;
            end if;
        end if;
    end process;

    level <= level_r;

    -------------------------------------------------------------------------
    -- TRANSICIONES DE ESTADO
    -------------------------------------------------------------------------
    process(state, lock_request, any_row_cleared,
            score, lines_accum, game_over_cond, restart)
    begin
        next_state <= state;

        case state is

            when S_SPAWN =>
                if game_over_cond = '1' then
                    next_state <= S_GAME_OVER;
                else
                    next_state <= S_PLAYING;
                end if;

            when S_PLAYING =>
                if score >= SCORE_WIN then
                    next_state <= S_WIN;
                elsif lock_request = '1' then
                    next_state <= S_LOCK;
                end if;

            when S_LOCK =>
                next_state <= S_LINE_CHECK;

            when S_LINE_CHECK =>
                if any_row_cleared = '1' then
                    next_state <= S_LINE_CLEAR;
                else
                    next_state <= S_SPAWN;
                end if;

            when S_LINE_CLEAR =>
                if lines_accum + lines_cleared >= LINES_PER_LEVEL then
                    next_state <= S_LEVEL_UP;
                else
                    next_state <= S_SPAWN;
                end if;

            when S_LEVEL_UP =>
                next_state <= S_SPAWN;

            when S_GAME_OVER =>
                if restart = '1' then
                    next_state <= S_SPAWN;
                else
                    next_state <= S_GAME_OVER;
                end if;

            when S_WIN =>
                if restart = '1' then
                    next_state <= S_SPAWN;
                else
                    next_state <= S_WIN;
                end if;

        end case;
    end process;

    -------------------------------------------------------------------------
    -- SALIDAS DE CONTROL
    -------------------------------------------------------------------------
    spawn_new_piece <= '1' when state = S_SPAWN      else '0';
    do_line_clear   <= '1' when state = S_LINE_CLEAR else '0';

    score_pulse <= score_pulse_r;

    game_over <= '1' when state = S_GAME_OVER else '0';
    win       <= '1' when state = S_WIN       else '0';

    game_reset <= restart;

    -------------------------------------------------------------------------
    -- DEBUG
    -------------------------------------------------------------------------
    with state select
        game_state <=
            "0000" when S_SPAWN,
            "0001" when S_PLAYING,
            "0010" when S_LOCK,
            "0011" when S_LINE_CHECK,
            "0100" when S_LINE_CLEAR,
            "0101" when S_LEVEL_UP,
            "0110" when S_GAME_OVER,
            "0111" when S_WIN,
            "1111" when others;

end architecture FSM;
