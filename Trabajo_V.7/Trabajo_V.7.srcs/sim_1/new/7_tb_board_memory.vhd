library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_board_memory is
end entity;

architecture TB of tb_board_memory is

    constant BOARD_W : integer := 10;
    constant BOARD_H : integer := 20;

    signal clk   : std_logic := '0';
    signal reset : std_logic := '1';

    signal x         : integer := 0;
    signal y         : integer := 0;
    signal shape_16b : std_logic_vector(15 downto 0) := (others => '0');

    signal lock_request  : std_logic := '0';
    signal do_line_clear : std_logic := '0';

    signal board_flat      : std_logic_vector(BOARD_W*BOARD_H-1 downto 0);
    signal rows_cleared    : std_logic_vector(BOARD_H-1 downto 0);
    signal any_row_cleared : std_logic;

    constant CLK_PERIOD : time := 10 ns;

    -------------------------------------------------------------------------
    -- FUNCIÓN PARA CONVERTIR std_logic_vector A STRING (COMPATIBLE VHDL-93)
    -------------------------------------------------------------------------
    function slv_to_string(slv : std_logic_vector) return string is
        variable result : string(1 to slv'length);
        variable idx    : integer := 1;
    begin
        for i in slv'range loop
            result(idx) := std_logic'image(slv(i))(2); -- extrae '0' o '1'
            idx := idx + 1;
        end loop;
        return result;
    end function;

begin

    -------------------------------------------------------------------------
    -- Instancia del DUT
    -------------------------------------------------------------------------
    UUT : entity work.board_memory
        generic map (
            BOARD_WIDTH  => BOARD_W,
            BOARD_HEIGHT => BOARD_H
        )
        port map (
            clk    => clk,
            reset  => reset,
            x         => x,
            y         => y,
            shape_16b => shape_16b,
            lock_request  => lock_request,
            do_line_clear => do_line_clear,
            board_flat      => board_flat,
            rows_cleared    => rows_cleared,
            any_row_cleared => any_row_cleared
        );


    -------------------------------------------------------------------------
    -- Generación del reloj
    -------------------------------------------------------------------------
    clk <= not clk after CLK_PERIOD/2;


    -------------------------------------------------------------------------
    -- PROCESO DE ESTÍMULOS
    -------------------------------------------------------------------------
    stim_proc : process
        procedure print_board is
            variable line_v : std_logic_vector(BOARD_W-1 downto 0);
        begin
            report "-------- TABLERO --------";
            for r in 0 to BOARD_H-1 loop
                for c in 0 to BOARD_W-1 loop
                    line_v(c) := board_flat(r*BOARD_W + c);
                end loop;
                report "Fila " & integer'image(r) & " : " & slv_to_string(line_v);
            end loop;
            report "--------------------------";
        end procedure;
    begin

        ---------------------------------------------------------------------
        -- RESET
        ---------------------------------------------------------------------
        reset <= '1';
        wait for 5*CLK_PERIOD;
        reset <= '0';
        wait for 5*CLK_PERIOD;

        report "RESET COMPLETADO";


        ---------------------------------------------------------------------
        -- Fijar una pieza 2x2 en la esquina superior
        ---------------------------------------------------------------------
        shape_16b <= "1100" & "1100" & "0000" & "0000";
        x <= 0;
        y <= 0;

        lock_request <= '1';
        wait for CLK_PERIOD;
        lock_request <= '0';

        wait for 30*CLK_PERIOD;

        report "Pieza fijada correctamente";
        print_board;


        ---------------------------------------------------------------------
        -- Forzar una fila completa (fila 5) SOLO PARA TESTBENCH
        ---------------------------------------------------------------------
        report "Forzando fila completa en la fila 5";

        for c in 0 to BOARD_W-1 loop
            board_flat(5*BOARD_W + c) <= '1';
        end loop;

        wait for 10*CLK_PERIOD;

        report "rows_cleared = " & slv_to_string(rows_cleared);
        report "any_row_cleared = " & std_logic'image(any_row_cleared);


        ---------------------------------------------------------------------
        -- Borrado de líneas
        ---------------------------------------------------------------------
        report "Ejecutando compactación (do_line_clear)";

        do_line_clear <= '1';
        wait for CLK_PERIOD;
        do_line_clear <= '0';

        wait for 200*CLK_PERIOD;

        report "Compactación completada";
        print_board;


        ---------------------------------------------------------------------
        -- Fin de test
        ---------------------------------------------------------------------
        report "FIN DEL TESTBENCH";
        wait;
    end process;

end architecture;
