library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_render_unit is
end entity;

architecture TB of tb_render_unit is

    constant BOARD_W : integer := 10;
    constant BOARD_H : integer := 20;

    -- Señales de prueba
    signal board_flat : std_logic_vector(BOARD_W*BOARD_H-1 downto 0);
    signal x, y       : integer := 0;
    signal shape_16b  : std_logic_vector(15 downto 0) := (others => '0');
    signal rotation   : integer := 0;

    signal pixel_x       : integer := 0;
    signal pixel_y       : integer := 0;
    signal video_active  : std_logic := '0';

    signal rgb : std_logic_vector(11 downto 0);

    -------------------------------------------------------------------------
    -- Helper: convierte vector a string para report
    -------------------------------------------------------------------------
    function slv_to_string(slv : std_logic_vector) return string is
        variable s : string(1 to slv'length);
        variable i : integer := 1;
    begin
        for idx in slv'range loop
            s(i) := std_logic'image(slv(idx))(2);
            i := i + 1;
        end loop;
        return s;
    end function;

begin

    -------------------------------------------------------------------------
    -- Instancia del DUT
    -------------------------------------------------------------------------
    DUT : entity work.render_unit
        generic map (
            BOARD_WIDTH  => BOARD_W,
            BOARD_HEIGHT => BOARD_H
        )
        port map (
            board_flat   => board_flat,
            x            => x,
            y            => y,
            shape_16b    => shape_16b,
            rotation     => rotation,
            pixel_x      => pixel_x,
            pixel_y      => pixel_y,
            video_active => video_active,
            rgb          => rgb
        );

    -------------------------------------------------------------------------
    -- PROCESO PRINCIPAL DE ESTÍMULOS
    -------------------------------------------------------------------------
    stim_proc : process
    begin
        ---------------------------------------------------------------------
        -- Inicializar tablero vacío
        ---------------------------------------------------------------------
        board_flat <= (others => '0');

        report "Tablero inicializado vacío";

        ---------------------------------------------------------------------
        -- Activamos zona visible (para que rgb se calcule)
        ---------------------------------------------------------------------
        video_active <= '1';

        ---------------------------------------------------------------------
        -- Definimos una pieza 2x2 en el origen (equivalente a tu test previo)
        -- Shape 4×4:
        -- 1100
        -- 1100
        -- 0000
        -- 0000
        ---------------------------------------------------------------------
        shape_16b <= "1100" & "1100" & "0000" & "0000";
        x <= 0;
        y <= 0;

        wait for 10 ns;

        ---------------------------------------------------------------------
        -- PROBAMOS PIXEL A PIXEL ALGUNAS POSICIONES
        ---------------------------------------------------------------------
        report "==== PRUEBAS DE PIXELES SOBRE LA PIEZA ====";

        -- Pixel dentro de celda (0,0)
        pixel_x <= 160 + 5;   -- dentro del tablero, celda 0,0
        pixel_y <= 5;
        wait for 10 ns;
        report "Pixel (0,0) rgb = " & slv_to_string(rgb);

        -- Pixel dentro de celda (1,0)
        pixel_x <= 160 + 40;  -- ~32 pix hacia la derecha → celda 1
        pixel_y <= 5;
        wait for 10 ns;
        report "Pixel (1,0) rgb = " & slv_to_string(rgb);

        -- Pixel en celda vacía (columna 5)
        pixel_x <= 160 + 32*5;
        pixel_y <= 10;
        wait for 10 ns;
        report "Pixel (5,0) rgb = " & slv_to_string(rgb);

        -- Pixel fuera del tablero (izquierda)
        pixel_x <= 50;
        pixel_y <= 100;
        wait for 10 ns;
        report "Pixel fuera tablero rgb = " & slv_to_string(rgb);

        ---------------------------------------------------------------------
        -- Añadimos un bit del tablero fijado (fila 10, col 3)
        ---------------------------------------------------------------------
        board_flat(10*BOARD_W + 3) <= '1';

        wait for 10 ns;

        report "==== TEST PIXEL CELDA FIJADA ====";

        pixel_x <= 160 + 3*32 + 10; -- Un punto dentro de celda (3,10)
        pixel_y <= 10*24 + 10;
        wait for 10 ns;
        report "Pixel en celda fijada rgb = " & slv_to_string(rgb);

        ---------------------------------------------------------------------
        -- FIN DEL TEST
        ---------------------------------------------------------------------
        report "FIN DEL TESTBENCH";
        wait;
    end process;

end architecture;
