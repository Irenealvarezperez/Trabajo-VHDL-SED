library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;
ENTITY decodificador_tb IS
END decodificador_tb;
ARCHITECTURE BEHAVIORAL OF decodificador_tb IS
    COMPONENT decodificador

        PORT(
            seleccion : IN std_logic;
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
    constant reloj_periodo: time := 2 sec;
    constant long_opcion:positive:=5;
    SIGNAL seleccion : std_logic;
    SIGNAL salida_disp0 : std_logic_vector(6 DOWNTO 0);
    SIGNAL salida_disp1 : std_logic_vector(6 DOWNTO 0);
    SIGNAL salida_disp2 : std_logic_vector(6 DOWNTO 0);
    SIGNAL salida_disp3 : std_logic_vector(6 DOWNTO 0);
    SIGNAL salida_disp4 : std_logic_vector(6 DOWNTO 0);
    SIGNAL salida_disp5 : std_logic_vector(6 DOWNTO 0);
    SIGNAL salida_disp6 : std_logic_vector(6 DOWNTO 0);
    SIGNAL salida_disp7 : std_logic_vector(6 DOWNTO 0);

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
        seleccion<= std_logic(1);
        wait for 2*reloj_periodo;
        seleccion<=std_logic(2);
        wait for 2*reloj_periodo;
        seleccion<=std_logic(3);
        wait for 2*reloj_periodo;
        seleccion<=std_logic(4);
        wait for 2*reloj_periodo;
        seleccion<=std_logic(5);
        wait for 2*reloj_periodo;
        --seleccion<=std_logic(6);
       -- wait for 2*reloj_periodo;
        ASSERT false
        REPORT "Simulacin finalizada. Test superado."
        SEVERITY FAILURE;
    END PROCESS;
END BEHAVIORAL;