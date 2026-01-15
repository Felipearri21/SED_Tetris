library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clk_divider is
    generic (
        GAME_SPEED : integer := 5_000_000;

        DROP_BASE  : integer := 25_000_000;
        DROP_STEP  : integer := 2_000_000;
        DROP_MIN   : integer := 3_000_000
    );
    port (
        clk       : in  std_logic;
        reset     : in  std_logic;

        level     : in  integer;

        tick_game : out std_logic;
        tick_drop : out std_logic
    );
end entity clk_divider;

architecture RTL of clk_divider is

    signal cnt_game : unsigned(31 downto 0) := (others => '0');
    signal cnt_drop : unsigned(31 downto 0) := (others => '0');

    signal drop_period : unsigned(31 downto 0) := (others => '0');

    function clamp_int(x, lo, hi : integer) return integer is
    begin
        if x < lo then
            return lo;
        elsif x > hi then
            return hi;
        else
            return x;
        end if;
    end function;

begin

    ------------------------------------------------------------------
    -- Drop period calculation based on level
    ------------------------------------------------------------------
    process(level)
        variable lvl      : integer;
        variable drop_int : integer;
    begin
        lvl := clamp_int(level, 1, 10);

        drop_int := DROP_BASE - (lvl - 1) * DROP_STEP;

        if drop_int < DROP_MIN then
            drop_int := DROP_MIN;
        end if;

        drop_period <= to_unsigned(drop_int, drop_period'length);
    end process;

    ------------------------------------------------------------------
    -- GAME TICK
    ------------------------------------------------------------------
    process(clk, reset)
    begin
        if reset = '1' then
            cnt_game  <= (others => '0');
            tick_game <= '0';

        elsif rising_edge(clk) then
            if cnt_game = to_unsigned(GAME_SPEED, cnt_game'length) then
                cnt_game  <= (others => '0');
                tick_game <= '1';
            else
                cnt_game  <= cnt_game + 1;
                tick_game <= '0';
            end if;
        end if;
    end process;

    ------------------------------------------------------------------
    -- DROP TICK
    ------------------------------------------------------------------
    process(clk, reset)
    begin
        if reset = '1' then
            cnt_drop  <= (others => '0');
            tick_drop <= '0';

        elsif rising_edge(clk) then
            if cnt_drop = drop_period then
                cnt_drop  <= (others => '0');
                tick_drop <= '1';
            else
                cnt_drop  <= cnt_drop + 1;
                tick_drop <= '0';
            end if;
        end if;
    end process;

end architecture RTL;
