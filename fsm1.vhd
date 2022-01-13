---------------------------------------------------------------------------------
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm1 is
    generic (
        long_opcion:positive:=4
    );
    port (
        RESET : in std_logic; --señal de reset asíncrona
        CLK : in std_logic; --clk activo flanco de subida
        EDGE : in std_logic; --señal boton pulsado

        MODOS : in std_logic_vector(1 downto 0); --switches para los modos
        SEL_LECHE: in std_logic; --switch elegir leche
        SEL_AZUCAR: in std_logic; --switch elegir azucar
        SENSOR: in std_logic; --switch que simula un sensor de presencia
        COMENZAR: in std_logic; --switch para comenzar a preparar el café

        DONE: in std_logic; --indica que se ha terminado de contar

        LED_ENCENDIDA: out std_logic; --activa en el estado encendida
        LED_BOMBA: out std_logic; --activa cuand se echa leche o café
        LED_LECHE: out std_logic; --indica que se quiere leche 
        LED_AZUCAR: out std_logic; --indica que se quiere azucar
        START: out std_logic;
        MODO_DISPLAY: out std_logic_vector(long_opcion -1 downto 0); --codigo que indica al display que poner
        DELAY : out unsigned (14 downto 0)
    );
end fsm1;

architecture Behavioral of fsm1 is
    type STATES is (S0, S1, S2, S3_1, S3_2, s4_1, S4_2, S5, S6_1, S6_2,S7);
    signal current_state: STATES := S0;
    signal next_state: STATES;
    constant tiempo_preparacion :positive := 5000; --tiempo de calentamiento/molido cafe
    constant tiempo_azucar : positive := 5000; --tiempo para elegir azucar
    constant tiempo_corto : positive := 12000;  --tiempo de echar el cafe
    constant tiempo_largo : positive:= 21000;
    constant tiempo_espera_leche: positive := 5000; --tiempo para elegir leche
    constant tiempo_leche : positive := 11000; --tiempo de echar la leche
begin

    state_register: process (RESET, CLK)
    begin
        if RESET = '0' then
            current_state <= S0;

        elsif rising_edge(CLK) then
            current_state <= next_state;
        end if;
    end process;
    nextstate: process (RESET,MODOS,EDGE, current_state, DONE,SEL_LECHE,SEL_AZUCAR,SENSOR,MODOS)
    begin
        next_state <= current_state;
        case current_state is
            when S0 => --estado reposo
                LED_LECHE<='0';
                LED_BOMBA<='0';
                LED_AZUCAR <= '0';
                LED_ENCENDIDA <= '0';
                MODO_DISPLAY <= "0000";
                if EDGE = '1' then  --se ha pulsado el boton de on/off y se enciende
                    next_state <= S1;
                end if;

            when S1 => --estado encendida
                START<='0';
                DELAY<=(others=>'0');
                LED_ENCENDIDA <= '1';
                MODO_DISPLAY<="0000";
                 START <= '1';
                 DELAY <= to_unsigned(tiempo_preparacion -2, DELAY'length);
                if COMENZAR = '1' then
                    next_state <= S2;
                end if;
                
 --              if EDGE='1' then --se vuelve a pulsar on/off y se apaga yendo a reposo
 --              next_state<= S0;
 --                end if;
                
                
           when S2 => --estado preparacion
                START<='0';
                DELAY<=(others=>'0');
                LED_ENCENDIDA <= '0';---
                MODO_DISPLAY<="1000";
                if DONE = '1' then
                    next_state <= S3_1;
                end if;
            when S3_1=> --estado cargar tiempo de azucar
                LED_ENCENDIDA <= '0';
                START<='1';
                DELAY <= to_unsigned(tiempo_azucar -2, DELAY'length);
                MODO_DISPLAY <= "0001";
                next_state <= S3_2;

            when s3_2=> --estado seleccion de azucar
                START<='0';
                DELAY<=(others=>'0');
                LED_ENCENDIDA <= '1';
                MODO_DISPLAY <= "0001";
                if SEL_AZUCAR = '1' then
                    LED_AZUCAR <= '1';
                end if;
                if DONE = '1' then
                    next_state <= S4_1;
                end if;

            when S4_1 => --estado seleccion modo de cafe y carga de tiempos
                START <= '1';
                LED_BOMBA<='0';
                LED_ENCENDIDA <= '1';
                MODO_DISPLAY <= "0000";
                if MODOS="01" then
                    next_state <= S4_2;
                    MODO_DISPLAY <= "0010"; --le dice al display el modo
                    DELAY <= to_unsigned(tiempo_corto -2, DELAY'length);
                end if;
                if MODOS="10" then
                    MODO_DISPLAY <= "0100"; --le dice al display el modo
                    DELAY <= to_unsigned(tiempo_largo -2, DELAY'length);
                    next_state <= S3_2;
                end if;

            when S4_2 => --estado para detectar el sensor
                --START<='1';
                LED_ENCENDIDA <= '1';
                LED_BOMBA<='0';
                if SENSOR='1' then
                    next_state<=s5;
                end if;

            when S5 => --estado para echar cafe
                LED_ENCENDIDA <= '1';
                LED_BOMBA <= '0';
                START <= '0';
                DELAY<=(others=>'0');
                if MODOS = "01" then
                    LED_BOMBA <= '1';
                    MODO_DISPLAY <= "0011";
                end if;
                if MODOS = "10" then
                    LED_BOMBA <= '1';
                    MODO_DISPLAY <= "0101";
                end if;
                if DONE = '1' then
                    next_state <= S6_1;
                end if;

            when S6_1 => --estado cargar tiempo espera leche
                LED_BOMBA<='0';
                LED_ENCENDIDA <= '1';
                START<='1';
                DELAY <= to_unsigned(tiempo_espera_leche -2, DELAY'length);
                next_state <= S6_2;

            when S6_2 => --estado para ver si se quiere o no leche
                LED_BOMBA<='0';
                LED_ENCENDIDA <= '1';
                START <= '0';
                DELAY<=(others=>'0');

                if SEL_LECHE = '0' then
                    MODO_DISPLAY <= "0111";
                end if;

                if SEL_LECHE ='1' then
                    LED_LECHE <= '1';
                    LED_BOMBA<='1';
                    MODO_DISPLAY <= "0110";
                    START <= '1';
                    DELAY <= to_unsigned(tiempo_leche -2, DELAY'length);
                    next_state <= S7;
                end if;
                -- START<='0';
                if DONE = '1' then
                    next_state <= S1;
                end if;

            when S7 => --estado para echar leche
                LED_ENCENDIDA <= '1';
                START<='0';
                DELAY<=(others=>'0');
                LED_LECHE <= '1';
                LED_BOMBA<='1';
                if DONE = '1' then
                    next_state <= S1;
                end if;
            when others =>
                MODO_DISPLAY<= "0000";
                LED_LECHE<='0';
                LED_BOMBA<='0';
                LED_AZUCAR <= '0';
                LED_ENCENDIDA <= '0';
                start<='0';
                DELAY<=(others=>'0');
        end case;
    end process;
end Behavioral;