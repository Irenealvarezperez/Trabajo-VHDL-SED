----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2021 11:13:59
-- Design Name: 
-- Module Name: fsm1 - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm1 is
port (
RESET : in std_logic;
 CLK : in std_logic;
 EDGE : in std_logic;
 --Añadir contadores o temporizadores (?)
 MODOS : in std_logic_vector(0 TO 1);
 COM_DISPLAY: out string(1 downto 0); --salida para indicarle al display el modo
 LED_ENCENDIDA: out std_logic;
 LED_BOMBA: out std_logic;
 LED_LECHE: out std_logic;
 --Salidas para la esclava
 PARAM: out std_logic;
 START: out std_logic;
 DONE: out std_logic
  );
end fsm1;

architecture Behavioral of fsm1 is
type STATES is (S0, S1, S2, S3, S4); 
-- estado 0 :espera  estado 1 :encendida 
-- estado 2: modo corto  estado 3: modo largo  estado 4: echar leche
signal current_state: STATES := S0; 
signal next_state: STATES;

begin
state_register: process (RESET, CLK)

begin

if RESET = '0' then
        current_state <= S0;
    
    elsif rising_edge(CLK) then
        current_state <= next_state;
    end if;
end process;

nextstate: process (RESET,MODOS,EDGE, current_state)
 begin
     next_state <= current_state;
          
     case current_state is
     
         when S0 =>
            if EDGE = '1' then
            next_state <= S1;
            end if;
         when S1 =>
            if MODOS = "01" then
            next_state <= S2;
            end if;
            
         when S1 =>
             if MODOS = "10"  then
             next_state <= S3;
             end if;
            
         when S2 =>
            -- if temporizador_corto= 10 segundos  then
             next_state <= S4;
            -- end if;    
         
         when S3 =>
           --  f temporizador_largo= 20 segundos  then
             next_state <= S4;
            -- end if; 

         when S4 =>
          --  temporizador_leche = '15' then
            next_state <= S1;
            --end if;
            
            
     end case;
 end process;



outputs: process (current_state)
     
 begin
     case current_state is
         when S0 =>
         LED_LECHE<='0';
         LED_BOMBA<='0';
         --temporizador_corto <= '0'
         --temporizador_largo <= '0'
         --temporizador_leche <= '0'
         LED_ENCENDIDA <= '0';
         COM_DISPLAY <= "--";
         
            
        when S1 =>
            
           LED_ENCENDIDA <= '1';
                  
           
           
         when S2 =>
           --se activa el temporizador_corto
             LED_BOMBA <= '1';
          COM_DISPLAY <= "01";
         
         when S3 =>
            --se activa el temporizador_largo
            
            COM_DISPLAY <= "10";
        LED_BOMBA <= '1';
            
         when S4 =>
        --se activa el temporizador_leche;
          LED_LECHE <= '1';
         
         when others =>
         
             COM_DISPLAY<= "00";
     end case;
 end process;
end Behavioral;
