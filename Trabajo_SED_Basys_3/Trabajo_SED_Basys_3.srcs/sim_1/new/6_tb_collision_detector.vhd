library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_collision_detector is
end entity;

architecture TB of tb_collision_detector is

    -------------------------------------------------------------------------
    -- Parámetros
    -------------------------------------------------------------------------
    constant BOARD_WIDTH  : integer := 10;
    constant BOARD_HEIGHT : integer := 20;

    -------------------------------------------------------------------------
    -- Señales del DUT
    -------------------------------------------------------------------------
    signal piece_id   : integer := 0; -- pieza I
    signal rotation   : integer := 0;
    signal x          : integer := 3;
    signal y          : integer := 0;

    signal board_flat : std_logic_vector(BOARD_WIDTH*BOARD_HEIGHT-1 downto 0)
                        := (others => '0');

    signal can_move_left  : std_logic;
    signal can_move_right : std_logic;
    signal can_move_down  : std_logic;
    signal can_rotate     : std_logic;

begin

    -------------------------------------------------------------------------
    -- Instancia del DUT
    -------------------------------------------------------------------------
    dut : entity work.collision_detector
        generic map (
            BOARD_WIDTH  => BOARD_WIDTH,
            BOARD_HEIGHT => BOARD_HEIGHT
        )
        port map (
            piece_id       => piece_id,
            rotation       => rotation,
            x              => x,
            y              => y,
            board_flat     => board_flat,
            can_move_left  => can_move_left,
            can_move_right => can_move_right,
            can_move_down  => can_move_down,
            can_rotate     => can_rotate
        );

    -------------------------------------------------------------------------
    -- Proceso de estímulos
    -------------------------------------------------------------------------
    stim_proc : process
        variable idx : integer;
    begin
        ---------------------------------------------------------------------
        -- Caso 1: tablero vacío, centro del tablero
        ---------------------------------------------------------------------
        x <= 3; y <= 0; rotation <= 0;
        board_flat <= (others => '0');
        wait for 20 ns;

        ---------------------------------------------------------------------
        -- Caso 2: borde izquierdo
        ---------------------------------------------------------------------
        x <= 0;
        wait for 20 ns;

        ---------------------------------------------------------------------
        -- Caso 3: borde derecho
        ---------------------------------------------------------------------
        x <= BOARD_WIDTH - 4;
        wait for 20 ns;

        ---------------------------------------------------------------------
        -- Caso 4: borde inferior
        ---------------------------------------------------------------------
        y <= BOARD_HEIGHT - 1;
        wait for 20 ns;

        ---------------------------------------------------------------------
        -- Caso 5: colisión con celda ocupada
        ---------------------------------------------------------------------
        board_flat <= (others => '0');
        idx := (y+1) * BOARD_WIDTH + x;
        board_flat(idx) <= '1';
        wait for 20 ns;

        ---------------------------------------------------------------------
        -- Caso 6: rotación inválida junto a borde
        ---------------------------------------------------------------------
        x <= 0;
        rotation <= 1;
        wait for 20 ns;

        ---------------------------------------------------------------------
        -- Fin de simulación
        ---------------------------------------------------------------------
        wait;
    end process;

end architecture;
