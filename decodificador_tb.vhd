library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;
ENTITY decoder_tb IS
END decoder_tb;
ARCHITECTURE BEHAVIORAL OF decodificador_tb IS
    COMPONENT decodificador
        PORT(
            seleccion : IN std_logic_vector(3 DOWNTO 0);
            salida : OUT std_logic_vector(6 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL seleccion : std_logic_vector(3 DOWNTO 0);
    SIGNAL salida : std_logic_vector(6 DOWNTO 0);
    TYPE vtest is record
        seleccion : std_logic_vector(3 DOWNTO 0);
        salida : std_logic_vector(6 DOWNTO 0);
    END RECORD;
    TYPE vtest_vector IS ARRAY (natural RANGE <>) OF vtest;
    CONSTANT test: vtest_vector := (
        (seleccion => "0000", salida => "0000001"),
        (seleccion => "0001", salida => "1001111"),
        (seleccion => "0010", salida => "0010010"),
        (seleccion => "0011", salida => "0000110"),
        (seleccion => "0100", salida => "1001100"),
        (seleccion => "0101", salida => "0100100"),
        (seleccion => "0110", salida => "0100000"),
        (seleccion => "0111", salida => "0001111"),
        (seleccion => "1000", salida => "0000000"),
        (seleccion => "1001", salida => "0000100"),
        (seleccion => "1010", salida => "1111110"),
        (seleccion => "1011", salida => "1111110"),
        (seleccion => "1100", salida => "1111110"),
        (seleccion => "1101", salida => "1111110"),
        (seleccion => "1110", salida => "1111110"),
        (seleccion => "1111", salida => "1111110")
    );
BEGIN
    uut: decodificador PORT MAP(
            seleccion => seleccion,
            salida => salida
        );
    tb: PROCESS
    BEGIN
        FOR i IN 0 TO test'HIGH LOOP
            seleccion <= test(i).seleccion;
            WAIT FOR 20 ns;
            ASSERT salida = test(i).salida
            REPORT "Salida incorrecta."
            SEVERITY FAILURE;
        END LOOP;
        ASSERT false
        REPORT "Simulacin finalizada. Test superado."
        SEVERITY FAILURE;
    END PROCESS;
END BEHAVIORAL;