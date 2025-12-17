library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_collision_detector is
end entity;

architecture TB of tb_collision_detector is

    -----------------------------------------------------------------------
    -- PARAMETROS DEL TABLERO
    -----------------------------------------------------------------------
    constant W : integer := 10;
    constant H : integer := 20;

    -----------------------------------------------------------------------
    -- FUNCION PARA CALCULAR EL INDICE lineal: idx = row*W + col
    -----------------------------------------------------------------------
    function idx(row : integer; col : integer) return integer is
    begin
        return row*W + col;
    end function;

    -----------------------------------------------------------------------
    -- SEÑALES PARA EL DUT
    -----------------------------------------------------------------------
    signal piece_id  : integer range 0 to 6 := 0;
    signal rotation  : integer range 0 to 3 := 0;
    signal x         : integer := 3;
    signal y         : integer := 0;

    -- Tablero plano (rango DESCENDENTE para coincidir con el DUT)
    signal board : std_logic_vector(W*H-1 downto 0) := (others => '0');

    -- Salidas del DUT
    signal can_left, can_right, can_down, can_rot : std_logic;

begin

    -----------------------------------------------------------------------
    -- INICIALIZAR EL TABLERO A VACÍO
    -----------------------------------------------------------------------
    init_board : process
    begin
        board <= (others => '0');
        wait;
    end process;

    -----------------------------------------------------------------------
    -- INSTANCIA DEL DUT
    -----------------------------------------------------------------------
    DUT: entity work.collision_detector
        generic map (
            BOARD_WIDTH  => W,
            BOARD_HEIGHT => H
        )
        port map (
            piece_id       => piece_id,
            rotation       => rotation,
            x              => x,
            y              => y,
            board_flat     => board,
            can_move_left  => can_left,
            can_move_right => can_right,
            can_move_down  => can_down,
            can_rotate     => can_rot
        );

    -----------------------------------------------------------------------
    -- PROCESO DE ESTÍMULOS
    -----------------------------------------------------------------------
    stim_process : process
    begin

        report "==================== INICIO TB COLLISION DETECTOR ====================";

        ------------------------------------------------------------------
        -- 1) PRUEBA BÁSICA: Pieza I, tablero vacío
        ------------------------------------------------------------------
        report ">> TEST 1: Pieza I en tablero vacio";
        piece_id <= 0;
        rotation <= 0;
        x <= 3;
        y <= 0;

        wait for 50 ns;

        report "can_left  = " & std_logic'image(can_left);
        report "can_right = " & std_logic'image(can_right);
        report "can_down  = " & std_logic'image(can_down);
        report "can_rot   = " & std_logic'image(can_rot);

        ------------------------------------------------------------------
        -- 2) Límite izquierdo
        ------------------------------------------------------------------
        report ">> TEST 2: Limite izquierdo";
        x <= 0;
        wait for 50 ns;

        report "can_left (esperado=0) = " & std_logic'image(can_left);

        ------------------------------------------------------------------
        -- 3) Límite derecho
        ------------------------------------------------------------------
        report ">> TEST 3: Limite derecho";
        x <= W-1;
        wait for 20 ns;

        report "can_right (esperado=0) = " & std_logic'image(can_right);

        ------------------------------------------------------------------
        -- 4) Suelo
        ------------------------------------------------------------------
        report ">> TEST 4: Suelo";
        x <= 3;
        y <= H-1;
        wait for 20 ns;

        report "can_down (esperado=0) = " & std_logic'image(can_down);

        ------------------------------------------------------------------
        -- 5) Bloque fijo en tablero
        ------------------------------------------------------------------
        report ">> TEST 5: Bloque fijo";
        board(idx(10,5)) <= '1';

        piece_id <= 2; -- T
        rotation <= 0;
        x <= 5;
        y <= 9;

        wait for 50 ns;

        report "can_down (esperado=0) = " & std_logic'image(can_down);

        ------------------------------------------------------------------
        -- 6) Rotación bloqueada
        ------------------------------------------------------------------
        report ">> TEST 6: Rotacion bloqueada";

        rotation <= 0;
        x <= 5;
        y <= 10;

        wait for 20 ns;

        report "can_rot = " & std_logic'image(can_rot);

        ------------------------------------------------------------------
        -- FIN
        ------------------------------------------------------------------
        report "==================== FIN TESTBENCH ====================";
        assert false report "FIN SIMULACION" severity failure;

        wait;

    end process;

end architecture TB;
