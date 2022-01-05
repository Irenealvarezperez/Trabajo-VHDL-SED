LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY decodificador IS
    generic (
        long_opcion:positive:=4
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
            when "0000"=>
                salida_disp7<="0111111";---
                salida_disp6<="0111111";---
                salida_disp5<="0111111";---
                salida_disp4<="0111111";---
                salida_disp3<="0111111";---
                salida_disp2<="0111111";---
                salida_disp1<="0111111";---
                salida_disp0<="0111111";---
            when "0001"=> --Nivel az�car> AZUCAR
                salida_disp7<="0001000";--A
                salida_disp6<="0100100";--Z
                salida_disp5<="1000001";--U
                salida_disp4<="1000110";--C
                salida_disp3<="0001000";--A
                salida_disp2<="1001110";--r
                salida_disp1<="1111111";--vacio
                salida_disp0<="1111111";--vacio
            when "0010"=> --corto
                salida_disp7<="1000110";--C
                salida_disp6<="1000000";--o
                salida_disp5<="1001110";--r
                salida_disp4<="0000111";--t
                salida_disp3<="1000000";--o
                salida_disp2<="1111111";--vacio
                salida_disp1<="1111111";--vacio
                salida_disp0<="1111111";--vacio 
            when "0011"=> --corto-10seg
                salida_disp7<="1111001";--1
                salida_disp6<="1000000";--0
                salida_disp5<="0010010";--S
                salida_disp4<="0000110";--E
                salida_disp3<="0000010";--G
                salida_disp2<="1111111";--vacio
                salida_disp1<="1111111";--vacio
                salida_disp0<="1111111";--vacio 
            when "0100"=> --largo
                salida_disp7<="1000111";--L
                salida_disp6<="0001000";--A
                salida_disp5<="1001110";--r
                salida_disp4<="0000010";--G
                salida_disp3<="1000000";--0
                salida_disp2<="1111111";--vacio
                salida_disp1<="1111111";--vacio
                salida_disp0<="1111111";--vacio 
            when "0101"=> --largo-20seg
                salida_disp7<="0100100";--2
                salida_disp6<="1000000";--0
                salida_disp5<="0010010";--S
                salida_disp4<="0000110";--E
                salida_disp3<="0000010";--G
                salida_disp2<="1111111";--vacio
                salida_disp1<="1111111";--vacio
                salida_disp0<="1111111";--vacio 
            when "0110"=> -- con leche
                salida_disp7<="1000111";--L
                salida_disp6<="0000110";--E
                salida_disp5<="1000110";--C
                salida_disp4<="0001001";--H
                salida_disp3<="0000110";--E
                salida_disp2<="1111111";--vacio
                salida_disp1<="1111111";--vacio
                salida_disp0<="1111111";--vacio   
            when "0111"=> -- sin leche
                salida_disp7<="1001000";--N
                salida_disp6<="1000000";--O
                salida_disp5<="1111111";--vacio 
                salida_disp4<="1000111";--L
                salida_disp3<="0000110";--E
                salida_disp2<="1000110";--C
                salida_disp1<="0001001";--H
                salida_disp0<="0000110";--E
            when "1000"=> --preparar
                salida_disp7<="0001100";--P
                salida_disp6<="1001110";--r
                salida_disp5<="0000110";--E
                salida_disp4<="0001100";--P
                salida_disp3<="0001000";--A
                salida_disp2<="1001110";--r
                salida_disp1<="0001000";--A
                salida_disp0<="1001110";--r
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
