library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity input_controller is
    generic (
        CLK_FREQ_HZ    : integer := 50_000_000; -- reloj de la FPGA
        DEBOUNCE_MS    : integer := 20          -- tiempo de debounce
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- Botones físicos
        btn_left  : in std_logic;
        btn_right : in std_logic;
        btn_rot   : in std_logic;
        btn_drop  : in std_logic;

        -- Pulsos limpios (1 ciclo)
        p_left  : out std_logic;
        p_right : out std_logic;
        p_rot   : out std_logic;
        p_drop  : out std_logic
    );
end entity;

architecture RTL of input_controller is

    -------------------------------------------------------------------------
    -- Cálculo del tiempo de debounce
    -------------------------------------------------------------------------
    constant DEBOUNCE_COUNT_MAX : integer :=
        (CLK_FREQ_HZ / 1000) * DEBOUNCE_MS;

    -------------------------------------------------------------------------
    -- Tipo para reutilizar debounce
    -------------------------------------------------------------------------
    type debounce_t is record
        ff1      : std_logic;
        ff2      : std_logic;
        stable   : std_logic;
        counter  : integer range 0 to DEBOUNCE_COUNT_MAX;
        stable_d : std_logic;
    end record;

    signal db_left, db_right, db_rot, db_drop : debounce_t;

begin

    -------------------------------------------------------------------------
    -- PROCESO DE DEBOUNCE (4 botones)
    -------------------------------------------------------------------------
    process(clk, reset)
    begin
        if reset = '1' then

            db_left  <= ('0','0','0',0,'0');
            db_right <= ('0','0','0',0,'0');
            db_rot   <= ('0','0','0',0,'0');
            db_drop  <= ('0','0','0',0,'0');

        elsif rising_edge(clk) then

            -----------------------------------------------------------------
            -- LEFT
            -----------------------------------------------------------------
            db_left.ff1 <= btn_left;
            db_left.ff2 <= db_left.ff1;

            if db_left.ff2 = db_left.stable then
                db_left.counter <= 0;
            else
                if db_left.counter = DEBOUNCE_COUNT_MAX then
                    db_left.stable  <= db_left.ff2;
                    db_left.counter <= 0;
                else
                    db_left.counter <= db_left.counter + 1;
                end if;
            end if;

            db_left.stable_d <= db_left.stable;

            -----------------------------------------------------------------
            -- RIGHT
            -----------------------------------------------------------------
            db_right.ff1 <= btn_right;
            db_right.ff2 <= db_right.ff1;

            if db_right.ff2 = db_right.stable then
                db_right.counter <= 0;
            else
                if db_right.counter = DEBOUNCE_COUNT_MAX then
                    db_right.stable  <= db_right.ff2;
                    db_right.counter <= 0;
                else
                    db_right.counter <= db_right.counter + 1;
                end if;
            end if;

            db_right.stable_d <= db_right.stable;

            -----------------------------------------------------------------
            -- ROT
            -----------------------------------------------------------------
            db_rot.ff1 <= btn_rot;
            db_rot.ff2 <= db_rot.ff1;

            if db_rot.ff2 = db_rot.stable then
                db_rot.counter <= 0;
            else
                if db_rot.counter = DEBOUNCE_COUNT_MAX then
                    db_rot.stable  <= db_rot.ff2;
                    db_rot.counter <= 0;
                else
                    db_rot.counter <= db_rot.counter + 1;
                end if;
            end if;

            db_rot.stable_d <= db_rot.stable;

            -----------------------------------------------------------------
            -- DROP
            -----------------------------------------------------------------
            db_drop.ff1 <= btn_drop;
            db_drop.ff2 <= db_drop.ff1;

            if db_drop.ff2 = db_drop.stable then
                db_drop.counter <= 0;
            else
                if db_drop.counter = DEBOUNCE_COUNT_MAX then
                    db_drop.stable  <= db_drop.ff2;
                    db_drop.counter <= 0;
                else
                    db_drop.counter <= db_drop.counter + 1;
                end if;
            end if;

            db_drop.stable_d <= db_drop.stable;

        end if;
    end process;

    -------------------------------------------------------------------------
    -- GENERACIÓN DE PULSOS (flanco de subida estable)
    -------------------------------------------------------------------------
    p_left  <= '1' when (db_left.stable  = '1' and db_left.stable_d  = '0') else '0';
    p_right <= '1' when (db_right.stable = '1' and db_right.stable_d = '0') else '0';
    p_rot   <= '1' when (db_rot.stable   = '1' and db_rot.stable_d   = '0') else '0';
    p_drop  <= '1' when (db_drop.stable  = '1' and db_drop.stable_d  = '0') else '0';

end architecture RTL;
