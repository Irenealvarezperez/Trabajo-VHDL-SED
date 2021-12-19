library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;
ENTITY decodificador_tb IS
END decodificador_tb;
ARCHITECTURE BEHAVIORAL OF decodificador_tb IS

    constant reloj_periodo: time :=20 ns;
    constant long_opcion:positive:=3;
    SIGNAL seleccion : std_logic_vector(long_opcion -1 DOWNTO 0);
    SIGNAL salida_disp0 : std_logic_vector(6 DOWNTO 0);
    SIGNAL salida_disp1 : std_logic_vector(6 DOWNTO 0);
    SIGNAL salida_disp2 : std_logic_vector(6 DOWNTO 0);
    SIGNAL salida_disp3 : std_logic_vector(6 DOWNTO 0);
    SIGNAL salida_disp4 : std_logic_vector(6 DOWNTO 0);
    SIGNAL salida_disp5 : std_logic_vector(6 DOWNTO 0);
    SIGNAL salida_disp6 : std_logic_vector(6 DOWNTO 0);
    SIGNAL salida_disp7 : std_logic_vector(6 DOWNTO 0);

    COMPONENT decodificador

        PORT(
            seleccion : IN std_logic_vector(long_opcion -1 DOWNTO 0);
            salida_disp0 : OUT std_logic_vector(6 DOWNTO 0);
            salida_disp1: OUT std_logic_vector(6 DOWNTO 0);
            salida_disp2 : OUT std_logic_vector(6 DOWNTO 0);
            salida_disp3 : OUT std_logic_vector(6 DOWNTO 0);
            salida_disp4 : OUT std_logic_vector(6 DOWNTO 0);
            salida_disp5 : OUT std_logic_vector(6 DOWNTO 0);
            salida_disp6 : OUT std_logic_vector(6 DOWNTO 0);
            salida_disp7 : OUT std_logic_vector(6 DOWNTO 0)
        );
    END COMPONENT;


BEGIN
    uut: decodificador PORT MAP(
            seleccion => seleccion,
            salida_disp0 => salida_disp0,
            salida_disp1 => salida_disp1,
            salida_disp2 => salida_disp2,
            salida_disp3 => salida_disp3,
            salida_disp4 => salida_disp4,
            salida_disp5 => salida_disp5,
            salida_disp6 => salida_disp6,
            salida_disp7 => salida_disp7
        );
    tb: PROCESS
    BEGIN
        seleccion<= "001";
        wait for 2*reloj_periodo;
        seleccion<="010";
        wait for 2*reloj_periodo;
        seleccion<="011";
        wait for 2*reloj_periodo;
        seleccion<="100";
        wait for 2*reloj_periodo;
        seleccion<="101";
        wait for 2*reloj_periodo;
        seleccion<="110";
        wait for 2*reloj_periodo;
        ASSERT false
        REPORT "Simulacin finalizada. Test superado."
        SEVERITY FAILURE;
    END PROCESS;
END BEHAVIORAL;