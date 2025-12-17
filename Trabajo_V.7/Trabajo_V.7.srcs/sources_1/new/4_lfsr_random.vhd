library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lfsr_random is
    port (
        clk        : in  std_logic;
        reset      : in  std_logic;
        random_out : out integer        -- número 0..6
    );
end entity;


architecture RTL of lfsr_random is

    signal lfsr : std_logic_vector(7 downto 0) := "10101010";

begin

    ----------------------------------------------------------------------
    -- LFSR de 8 bits con taps estándar
    ----------------------------------------------------------------------
    process(clk, reset)
    begin
        if reset = '1' then
            lfsr <= "10101010";  -- semilla
        elsif rising_edge(clk) then
            -- Real LFSR: x^8 + x^6 + x^5 + x^4 + 1 (taps 7,5,4,3)
            lfsr <= lfsr(6 downto 0) &
                    (lfsr(7) xor lfsr(5) xor lfsr(4) xor lfsr(3));
        end if;
    end process;

    ----------------------------------------------------------------------
    -- Mapeo a número 0..6 (las 7 piezas del Tetris)
    ----------------------------------------------------------------------
    random_out <= to_integer(unsigned(lfsr(2 downto 0))) mod 7;

end architecture;
