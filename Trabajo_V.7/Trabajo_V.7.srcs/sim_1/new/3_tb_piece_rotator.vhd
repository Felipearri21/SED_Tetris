library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_piece_rom is
end entity;

architecture TB of tb_piece_rom is

    -- Entradas del DUT
    signal piece_id  : integer := 0;
    signal rotation  : integer := 0;

    -- Salida del DUT
    signal shape_16b : std_logic_vector(15 downto 0);

begin

    --------------------------------------------------------------------
    -- Instancia del DUT
    --------------------------------------------------------------------
    DUT: entity work.piece_rom
        port map (
            piece_id  => piece_id,
            rotation  => rotation,
            shape_16b => shape_16b
        );

    --------------------------------------------------------------------
    -- PROCESO DE ESTÍMULOS
    --------------------------------------------------------------------
    stim_process : process
        variable fila0, fila1, fila2, fila3 : std_logic_vector(3 downto 0);
        variable s0, s1, s2, s3 : string(1 to 4);
    begin

        report "==== INICIO TEST PIECE_ROM ====";

        -- Recorrer todas las piezas (0 a 6)
        for p in 0 to 6 loop
            piece_id <= p;

            -- Recorrer las 4 rotaciones (0 a 3)
            for r in 0 to 3 loop
                rotation <= r;

                -- Dar tiempo a que shape_16b se actualice
                wait for 20 ns;

                -- Extraer filas 4x4 de shape_16b
                fila0 := shape_16b(15 downto 12);
                fila1 := shape_16b(11 downto 8);
                fila2 := shape_16b(7  downto 4);
                fila3 := shape_16b(3  downto 0);

                -- Convertir cada fila a una cadena de 4 caracteres ('#' o '.')
                for i in 0 to 3 loop
                    -- Ojo: fila0(3) es el bit más a la izquierda
                    if fila0(3 - i) = '1' then
                        s0(i+1) := '#';
                    else
                        s0(i+1) := '.';
                    end if;

                    if fila1(3 - i) = '1' then
                        s1(i+1) := '#';
                    else
                        s1(i+1) := '.';
                    end if;

                    if fila2(3 - i) = '1' then
                        s2(i+1) := '#';
                    else
                        s2(i+1) := '.';
                    end if;

                    if fila3(3 - i) = '1' then
                        s3(i+1) := '#';
                    else
                        s3(i+1) := '.';
                    end if;
                end loop;

                -- Imprimir la pieza en consola de simulación
                report "Pieza " & integer'image(p) &
                       ", Rotacion " & integer'image(r) & ":";

                report "  " & s0;
                report "  " & s1;
                report "  " & s2;
                report "  " & s3;
            end loop;
        end loop;

        report "==== FIN TEST PIECE_ROM ====";
        assert false report "Fin de simulación" severity failure;
        wait;

    end process;

end architecture TB;
