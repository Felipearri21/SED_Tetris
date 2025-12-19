library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity score_counter is
    port (
        clk           : in  std_logic;
        reset         : in  std_logic;
        score_pulse   : in  std_logic;              -- pulso 1 ciclo
        lines_cleared : in  integer range 0 to 4;   -- nº líneas borradas
        score         : out integer range 0 to 9999
    );
end entity;

architecture RTL of score_counter is
    signal score_reg : integer range 0 to 9999 := 0;

    function points_for_lines(n : integer) return integer is
    begin
        case n is
            when 1 => return 100;
            when 2 => return 300;
            when 3 => return 500;
            when 4 => return 800;
            when others => return 0;
        end case;
    end function;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                score_reg <= 0;

            elsif score_pulse = '1' then
                score_reg <= score_reg + points_for_lines(lines_cleared);
            end if;
        end if;
    end process;

    score <= score_reg;

end architecture RTL;
