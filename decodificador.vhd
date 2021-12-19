LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY decodificador IS
    generic (
        long_opcion:positive:=3
    );
    PORT (
        seleccion : in std_logic_vector(long_opcion -1 downto 0);
        salida_disp0 : OUT std_logic_vector(6 downto 0);
        salida_disp1: out std_logic_vector(6 downto 0);
        salida_disp2 : out std_logic_vector(6 downto 0);
        salida_disp3 : out std_logic_vector(6 downto 0);
        salida_disp4 : out std_logic_vector(6 downto 0);
        salida_disp5 : out std_logic_vector(6 downto 0);
        salida_disp6 : out std_logic_vector(6 downto 0);
        salida_disp7 : out std_logic_vector(6 downto 0)
    );
END ENTITY decodificador;
ARCHITECTURE behavioral OF decodificador IS
BEGin
    process(seleccion)
    begin
        case seleccion is

            when "001"=> --Nivel azúcar> AZUCAR
                salida_disp7<="0001000";--A
                salida_disp6<="0010010";--Z
                salida_disp5<="1000001";--U
                salida_disp4<="0110001";--C
                salida_disp3<="0001000";--A
                salida_disp2<="0001000";--R
                salida_disp1<="1111111";--vacio
                salida_disp0<="1111111";--vacio
            when "010"=> --corto
                salida_disp7<="1001111";--1
                salida_disp6<="0000001";--0
                salida_disp5<="0100100";--S
                salida_disp4<="0110000";--E
                salida_disp3<="0100000";--G
                salida_disp2<="1111111";--vacio
                salida_disp1<="1111111";--vacio
                salida_disp0<="1111111";--vacio 
            when "011"=> --largo
                salida_disp7<="0010010";--2
                salida_disp6<="0000001";--0
                salida_disp5<="0100100";--S
                salida_disp4<="0110000";--E
                salida_disp3<="0100000";--G
                salida_disp2<="1111111";--vacio
                salida_disp1<="1111111";--vacio
                salida_disp0<="1111111";--vacio 
            when "100"=> -- con leche
                salida_disp7<="0001110";--L
                salida_disp6<="0110000";--E
                salida_disp5<="0110001";--C
                salida_disp4<="1001000";--H
                salida_disp3<="0110000";--E
                salida_disp2<="1111111";--vacio
                salida_disp1<="1111111";--vacio
                salida_disp0<="1111111";--vacio   
            when "101"=> -- sin leche
                salida_disp7<="0001001";--N
                salida_disp6<="0000001";--O
                salida_disp5<="1111111";--vacio 
                salida_disp4<="0001110";--L
                salida_disp3<="0110000";--E
                salida_disp2<="0110001";--C
                salida_disp1<="1001000";--H
                salida_disp0<="0110000";--E
            when others=>
                salida_disp7<="1111111";--vacio
                salida_disp6<="1111111";--vacio
                salida_disp5<="1111111";--vacio 
                salida_disp4<="1111111";--vacio
                salida_disp3<="1111111";--vacio
                salida_disp2<="1111111";--vacio
                salida_disp1<="1111111";--vacio
                salida_disp0<="1111111";--vacio
        end case;
    end process;
end behavioral;
