library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_seg_driver is
    port (
        clk   : in  std_logic;                     -- reloj del sistema
        value : in  integer range 0 to 9999;        -- valor a mostrar
        seg   : out std_logic_vector(6 downto 0);   -- segmentos (abcdefg)
        an    : out std_logic_vector(3 downto 0)    -- ánodos
    );
end entity;

architecture RTL of seven_seg_driver is

    signal refresh_cnt : unsigned(15 downto 0) := (others => '0');
    signal digit_sel   : unsigned(1 downto 0)  := (others => '0');

    signal d0, d1, d2, d3 : integer range 0 to 9;
    signal digit         : integer range 0 to 9;

begin

    -------------------------------------------------------------------------
    -- Separación en dígitos decimales
    -------------------------------------------------------------------------
    d0 <= value mod 10;
    d1 <= (value / 10) mod 10;
    d2 <= (value / 100) mod 10;
    d3 <= (value / 1000) mod 10;

    -------------------------------------------------------------------------
    -- Contador de refresco (multiplexado)
    -------------------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            refresh_cnt <= refresh_cnt + 1;
            digit_sel   <= refresh_cnt(15 downto 14);
        end if;
    end process;

    -------------------------------------------------------------------------
    -- Selección de dígito activo (ánodo común)
    -------------------------------------------------------------------------
    process(digit_sel, d0, d1, d2, d3)
    begin
        case digit_sel is
            when "00" =>
                an    <= "1110";
                digit <= d0;
            when "01" =>
                an    <= "1101";
                digit <= d1;
            when "10" =>
                an    <= "1011";
                digit <= d2;
            when others =>
                an    <= "0111";
                digit <= d3;
        end case;
    end process;

    -------------------------------------------------------------------------
    -- Decodificador BCD → 7 segmentos (ánodo común)
    -------------------------------------------------------------------------
    process(digit)
    begin
        case digit is
            when 0 => seg <= "0000001";
            when 1 => seg <= "1001111";
            when 2 => seg <= "0010010";
            when 3 => seg <= "0000110";
            when 4 => seg <= "1001100";
            when 5 => seg <= "0100100";
            when 6 => seg <= "0100000";
            when 7 => seg <= "0001111";
            when 8 => seg <= "0000000";
            when 9 => seg <= "0000100";
            when others => seg <= "1111111";
        end case;
    end process;

end architecture RTL;
