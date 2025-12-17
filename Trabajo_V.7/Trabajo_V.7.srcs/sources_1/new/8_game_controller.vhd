library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity game_controller is
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- Señales desde pieza/tablero
        lock_request    : in std_logic;   -- cuando la pieza ya no puede bajar
        any_row_cleared : in std_logic;   -- indica si hay filas completas

        -- Señales de control para otros módulos
        spawn_new_piece : out std_logic;
        do_line_clear   : out std_logic;

        -- Estado (solo para debug)
        game_state : out std_logic_vector(2 downto 0)
    );
end entity;


architecture FSM of game_controller is

    -- Estados
    type state_t is (
        S_SPAWN,
        S_PLAYING,
        S_LOCK,
        S_LINE_CHECK,
        S_LINE_CLEAR
    );

    signal state, next_state : state_t;

begin

    -------------------------------------------------------------------------
    -- REGISTRO DEL ESTADO
    -------------------------------------------------------------------------
    process(clk, reset)
    begin
        if reset = '1' then
            state <= S_SPAWN;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;


    -------------------------------------------------------------------------
    -- LÓGICA DE TRANSICIÓN
    -------------------------------------------------------------------------
    process(state, lock_request, any_row_cleared)
    begin
        next_state <= state;

        case state is

            -----------------------------------------------------------------
            when S_SPAWN =>
                next_state <= S_PLAYING;

            -----------------------------------------------------------------
            when S_PLAYING =>
                if lock_request = '1' then
                    next_state <= S_LOCK;
                end if;

            -----------------------------------------------------------------
            when S_LOCK =>
                next_state <= S_LINE_CHECK;

            -----------------------------------------------------------------
            when S_LINE_CHECK =>
                if any_row_cleared = '1' then
                    next_state <= S_LINE_CLEAR;
                else
                    next_state <= S_SPAWN;
                end if;

            -----------------------------------------------------------------
            when S_LINE_CLEAR =>
                next_state <= S_SPAWN;

        end case;
    end process;


    -------------------------------------------------------------------------
    -- GENERACIÓN DE SEÑALES DE CONTROL
    -------------------------------------------------------------------------
    spawn_new_piece <= '1' when state = S_SPAWN      else '0';
    do_line_clear   <= '1' when state = S_LINE_CLEAR else '0';

    -------------------------------------------------------------------------
    -- CÓDIGO DE ESTADO PARA DEBUG (SIN USAR 'pos!)
    -------------------------------------------------------------------------
    with state select
        game_state <=
            "000" when S_SPAWN,
            "001" when S_PLAYING,
            "010" when S_LOCK,
            "011" when S_LINE_CHECK,
            "100" when S_LINE_CLEAR,
            "111" when others;

end architecture;