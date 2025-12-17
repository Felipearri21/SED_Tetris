library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clk_divider is
    generic (
        GAME_SPEED : integer := 5_000_000;   -- ~50 ms a 100 MHz
        DROP_SPEED : integer := 25_000_000   -- ~250 ms a 100 MHz
    );
    port (
        clk       : in  std_logic;
        reset     : in  std_logic;

        tick_game : out std_logic;
        tick_drop : out std_logic
    );
end entity clk_divider;

architecture RTL of clk_divider is

    signal cnt_game : unsigned(31 downto 0) := (others => '0');
    signal cnt_drop : unsigned(31 downto 0) := (others => '0');

begin

    ----------------------------------------------------------------------
    -- GAME TICK  (movimiento lateral / rotación)
    ----------------------------------------------------------------------
    process(clk, reset)
    begin
        if reset = '1' then
            cnt_game  <= (others => '0');
            tick_game <= '0';

        elsif rising_edge(clk) then
            if cnt_game = GAME_SPEED then
                cnt_game  <= (others => '0');
                tick_game <= '1';
            else
                cnt_game  <= cnt_game + 1;
                tick_game <= '0';
            end if;
        end if;
    end process;

    ----------------------------------------------------------------------
    -- DROP TICK  (caída automática)
    ----------------------------------------------------------------------
    process(clk, reset)
    begin
        if reset = '1' then
            cnt_drop  <= (others => '0');
            tick_drop <= '0';

        elsif rising_edge(clk) then
            if cnt_drop = DROP_SPEED then
                cnt_drop  <= (others => '0');
                tick_drop <= '1';
            else
                cnt_drop  <= cnt_drop + 1;
                tick_drop <= '0';
            end if;
        end if;
    end process;

end architecture RTL;
