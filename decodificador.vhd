----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.12.2021 18:55:01
-- Design Name: 
-- Module Name: decodificador - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY decodificador IS
    PORT (
        seleccion : IN std_logic_vector(1 DOWNTO 0);
        salida : OUT std_logic_vector(6 DOWNTO 0)
    );
END ENTITY decodificador;
ARCHITECTURE dataflow OF decodificador IS
BEGIN
    WITH seleccion SELECT
 salida <= "0000001" WHEN "00",
        "1001111" WHEN "01",
        "0010010" WHEN "10";
END ARCHITECTURE dataflow;



