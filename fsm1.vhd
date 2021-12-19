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
        SEL_LECHE: in std_logic;
        SEL_AZUCAR: in std_logic;
        MODO_DISPLAY: out std_logic_vector(1 downto 0); --salida para indicarle al display que enseñe el modo
        TIEMPO_DISPLAY: out string(1 downto 0);
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
    type STATES is (S0, S1, S2, S3, S4, S5);
    -- estado 0 :reposo  estado 1 :encendida/indicar nivel de azucar
    -- estado 2: seleccion tipo cafe  estado 3: echar cafe  estado 4: seleccionar leche 
    -- estado 5: echar leche
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

                -- if temporizador_azucar <= 30 segundos then
                next_state <= S2;
            --end if

            when S2 =>
                if MODOS = "01"  then
                    next_state <= S3;
                end if;
                if MODOS = "10"  then
                    next_state <= S3;
                end if;

            when S3 =>
                -- if temporizador_corto <= 10 segundos then
                next_state <= S4;
                -- end if; 
                -- if temporizador_largo <= 20 segundos then
                next_state <= S4;
            -- end if; 

            when S4 =>
                if SEL_LECHE = '1' then
                    next_state <= S5;
                else
                    next_state <= S0;
                end if;

            when S5 =>
                -- if temporizador_leche <= 15 segundos then
                next_state <= S0;
                --end if;


        end case;
    end process;



    outputs: process (current_state,SEL_LECHE,SEL_AZUCAR)

    begin
        case current_state is
            when S0 =>
                LED_LECHE<='0';
                LED_BOMBA<='0';
                --temporizador_corto <= '0'
                --temporizador_largo <= '0'
                --temporizador_leche <= '0'
                --temporizador_azcuar <= '0'
                LED_ENCENDIDA <= '0';
                MODO_DISPLAY <= "--";


            when S1 =>

                LED_ENCENDIDA <= '1';
                TIEMPO_DISPLAY <= "30"; --le dice al display que enseñe la cuenta atras
                -- se activa el temporizador de azucar      


            when S2 =>
                if MODOS = "01" then

                    MODO_DISPLAY <= "01"; --le dice al display el modo
                end if;
                if MODOS = "10" then
                    MODO_DISPLAY <= "10"; --le dice al display el modo
                end if;

            when S3 =>

                if MODOS = "01" then
                    LED_BOMBA <= '1';
                    --se activa el temporizador de corto
                    TIEMPO_DISPLAY <= "10";
                end if;
                if MODOS = "10" then
                    LED_BOMBA <= '1';
                    --se activa el temporizador de corto
                    TIEMPO_DISPLAY <= "20";
                end if;

            when S4 =>
                if SEL_LECHE = '1' then
                    LED_LECHE <= '1';
                end if;

            when S5 =>
                if SEL_LECHE = '1' then
                    LED_LECHE <= '1';
                    --se activa el temporizador de leche
                    TIEMPO_DISPLAY <= "15";
                end if;

            when others =>

                MODO_DISPLAY<= "00";
                TIEMPO_DISPLAY <="00";
        end case;
    end process;
end Behavioral;
