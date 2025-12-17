library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity input_controller is
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- Botones físicos (raw)
        btn_left  : in std_logic;
        btn_right : in std_logic;
        btn_rot   : in std_logic;
        btn_drop  : in std_logic;

        -- Pulsos debounced
        p_left  : out std_logic;
        p_right : out std_logic;
        p_rot   : out std_logic;
        p_drop  : out std_logic
    );
end entity;

architecture RTL of input_controller is

    -- registros de sincronización
    signal left_ff1,  left_ff2  : std_logic := '0';
    signal right_ff1, right_ff2 : std_logic := '0';
    signal rot_ff1,   rot_ff2   : std_logic := '0';
    signal drop_ff1,  drop_ff2  : std_logic := '0';

begin

    -------------------------------------------------------------------------
    -- Sincronización y detección de flanco para cada botón
    -------------------------------------------------------------------------
    process(clk, reset)
    begin
        if reset = '1' then
            left_ff1  <= '0'; left_ff2  <= '0';
            right_ff1 <= '0'; right_ff2 <= '0';
            rot_ff1   <= '0'; rot_ff2   <= '0';
            drop_ff1  <= '0'; drop_ff2  <= '0';

        elsif rising_edge(clk) then
            left_ff1  <= btn_left;
            left_ff2  <= left_ff1;

            right_ff1 <= btn_right;
            right_ff2 <= right_ff1;

            rot_ff1   <= btn_rot;
            rot_ff2   <= rot_ff1;

            drop_ff1  <= btn_drop;
            drop_ff2  <= drop_ff1;
        end if;
    end process;

    -------------------------------------------------------------------------
    -- Generación de pulsos de 1 ciclo con detección de flanco de subida
    -------------------------------------------------------------------------
    p_left  <= '1' when (left_ff1 = '1' and left_ff2 = '0')   else '0';
    p_right <= '1' when (right_ff1 = '1' and right_ff2 = '0') else '0';
    p_rot   <= '1' when (rot_ff1 = '1' and rot_ff2 = '0')     else '0';
    p_drop  <= '1' when (drop_ff1 = '1' and drop_ff2 = '0')   else '0';

end architecture;