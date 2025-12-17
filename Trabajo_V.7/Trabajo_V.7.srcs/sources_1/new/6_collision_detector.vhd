library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity collision_detector is
    generic (
        BOARD_WIDTH  : integer := 10;
        BOARD_HEIGHT : integer := 20
    );
    port (
        piece_id   : in integer;
        rotation   : in integer;
        x          : in integer;
        y          : in integer;
        board_flat : in std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT-1 downto 0);

        can_move_left  : out std_logic;
        can_move_right : out std_logic;
        can_move_down  : out std_logic;
        can_rotate     : out std_logic
    );
end entity;


architecture COMB of collision_detector is

    -- Formas de la pieza
    signal shape_now     : std_logic_vector(15 downto 0);
    signal shape_rotated : std_logic_vector(15 downto 0);

    -- Rotación siguiente (0..3)
    signal rotation_next : integer;

    -----------------------------------------------------------------
    -- Declaración del ROM de piezas
    -----------------------------------------------------------------
    component piece_rom is
        port (
            piece_id  : in integer;
            rotation  : in integer;
            shape_16b : out std_logic_vector(15 downto 0)
        );
    end component;

    -----------------------------------------------------------------
    -- FUNCIÓN DE COLISIÓN
    -----------------------------------------------------------------
    function check_collision(
        shape      : std_logic_vector(15 downto 0);
        x_pos      : integer;
        y_pos      : integer;
        board_flat : std_logic_vector
    ) return std_logic is

        variable bit_row, bit_col : integer;
        variable cx, cy           : integer;
        variable idx              : integer;
    begin
        -- Recorremos los 16 bits de la matriz 4x4
        for i in 0 to 15 loop
            if shape(15 - i) = '1' then
                bit_row := i / 4;
                bit_col := i mod 4;

                cx := x_pos + bit_col;
                cy := y_pos + bit_row;

                -- 1) Comprobar límites del tablero
                if (cx < 0) or (cx >= BOARD_WIDTH) or
                   (cy < 0) or (cy >= BOARD_HEIGHT) then
                    return '1';
                end if;

                -- 2) Comprobar colisión con celda ocupada
                idx := cy*BOARD_WIDTH + cx;
                if board_flat(idx) = '1' then
                    return '1';
                end if;
            end if;
        end loop;

        return '0';
    end function;

begin

    -------------------------------------------------------------------------
    -- Rotación siguiente (cálculo separado del port map)
    -------------------------------------------------------------------------
    rotation_next <= (rotation + 1) mod 4;


    -------------------------------------------------------------------------
    -- Formas actual y rotada desde la ROM
    -------------------------------------------------------------------------
    NOW_SHAPE: piece_rom
        port map (
            piece_id  => piece_id,
            rotation  => rotation,
            shape_16b => shape_now
        );

    NEXT_SHAPE: piece_rom
        port map (
            piece_id  => piece_id,
            rotation  => rotation_next,
            shape_16b => shape_rotated
        );


    -------------------------------------------------------------------------
    -- Señales de colisión (lógica combinacional pura)
    -------------------------------------------------------------------------
    can_move_left  <= '0' when check_collision(shape_now,     x-1, y,   board_flat) = '1'
                       else '1';

    can_move_right <= '0' when check_collision(shape_now,     x+1, y,   board_flat) = '1'
                       else '1';

    can_move_down  <= '0' when check_collision(shape_now,     x,   y+1, board_flat) = '1'
                       else '1';

    can_rotate     <= '0' when check_collision(shape_rotated, x,   y,   board_flat) = '1'
                       else '1';

end architecture COMB;
