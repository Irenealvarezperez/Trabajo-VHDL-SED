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
        RESET : in std_logic; --reset asíncrono
        CLK : in std_logic; --reloj activo en el flanco de subida
        EDGE : in std_logic; --indicación de que se ha pulsado el boton de inicio

        MODOS : in std_logic_vector(1 downto 0); --switches para los modos del cafe
        SEL_LECHE: in std_logic; --switch para seleccionar si se desea leche
        SEL_AZUCAR: in std_logic; --switch para seleccionar si se desea azúcar
        SENSOR: in std_logic; --switch que simula sensor de presencia

        DONE: in std_logic; --entrada recibida de la esclava indica que se ha terminado de contar

        LED_ENCENDIDA: out std_logic; --led que muestra que se va a comenzar a prepar cafe
        LED_BOMBA: out std_logic; --led indica que esta activa la bomba
        LED_LECHE: out std_logic; --led indica que se desea leche
        LED_AZUCAR: out std_logic; --led indica que se desea azucar
        START: out std_logic; 
        MODO_DISPLAY: out std_logic_vector(long_opcion -1 downto 0);--codigo que indica al display que palabra msotrar
        DELAY : out unsigned (14 downto 0)
    );
end fsm1;

architecture Behavioral of fsm1 is
    type STATES is (S0, S1, S2_1, S2_2, S3_1, s3_2, S4, S5_1, s5_2, S6);
    signal current_state: STATES := S0;
    signal next_state: STATES;
    constant tiempo_preparacion :positive := 5000; --tiempo de calentamiento/molido cafe
    constant tiempo_azucar : positive := 5000; --tiempo de seleccion de azucar
    constant tiempo_corto : positive := 12000;  --tiempo de echar el cafe corto
    constant tiempo_largo : positive:= 21000;--tiempo de echar cafe largo
    constant tiempo_espera_leche: positive := 5000; --tiempo de seleccion leche
    constant tiempo_leche : positive := 11000; --tiempo de echar la leche
begin

    state_register: process (RESET, CLK)
    begin
        if RESET = '0' then
            current_state <= S0; --vuelve al estado por defecto encendida

        elsif rising_edge(CLK) then
            current_state <= next_state; --se pasa al siguiente estado
        end if;
    end process;
    nextstate: process (RESET,MODOS,EDGE, current_state, DONE,SEL_LECHE,SEL_AZUCAR,SENSOR,MODOS)
    begin
        next_state <= current_state;
        case current_state is
            when S0 => --estado de maquina encendida
                LED_LECHE<='0'; --apaga todos los leds
                LED_BOMBA<='0';
                LED_AZUCAR <= '0';
                LED_ENCENDIDA <= '0';
                MODO_DISPLAY <= "0001"; --le indica al display que ponga "ON"
                if EDGE = '1' then --se pulsa el boton de inicio
                    START <= '1';
                    DELAY <= to_unsigned(tiempo_preparacion -2, DELAY'length); --carga el tiempo de preparacion
                    next_state <= S1; --pasa a preparacion
                end if;

            when S1 => --estado de preparacion
                START<='0';
                DELAY<=(others=>'0');
                LED_ENCENDIDA <= '1'; --indica led que esta preparando
                MODO_DISPLAY<="0000"; --indica que aparece palabra "PREPARAR"
                if DONE = '1' then --terminada la cuenta del tiempo se pasa al siguiente estado
                    next_state <= S2_1;
                end if;

            when S2_1=> --estado para cargar el tiempo de seleccion azucar
                LED_ENCENDIDA <= '0';
                START<='1';
                DELAY <= to_unsigned(tiempo_azucar -2, DELAY'length); --carga el tiempo de seleccion azucar
                MODO_DISPLAY <= "0010"; --indica que aparezca la plabra "AZUCAR"
                next_state <= S2_2;

            when s2_2=> --estado de seleccion azucar
                START<='0';
                DELAY<=(others=>'0');
                LED_ENCENDIDA <= '0';
                MODO_DISPLAY <= "0010"; --indica que aparezca la plabra "AZUCAR"
                if SEL_AZUCAR = '1' then --se selecciona que se desea azucar
                    LED_AZUCAR <= '1'; --se actva led azucar
                end if;
                if DONE = '1' then --pasado el tiempoo de seleccion de azucar se va al estado siguiente
                    next_state <= S3_1;
                end if;

            when S3_1 => --estado para cargar tiempos del cafe
                START <= '1';
                LED_BOMBA<='0';
                LED_ENCENDIDA <= '0';
                MODO_DISPLAY <= "0011"; --indica que escriba palabra "ELIGE"
                if MODOS="01" then --se elige modo corto
                    next_state <= S3_2;
                    MODO_DISPLAY <= "0100"; --le dice al display que escriva "CORTO"
                    DELAY <= to_unsigned(tiempo_corto -2, DELAY'length);--carga el tiempo de corto
                end if;
                if MODOS="10" then
                    MODO_DISPLAY <= "1000"; --le dice al display que escriba "LARGO"
                    DELAY <= to_unsigned(tiempo_largo -2, DELAY'length);--carga el tiempo de largo
                    next_state <= S3_2;
                end if;

            when s3_2 => --estado para detectar vaso
              
                LED_ENCENDIDA <= '0';
                LED_BOMBA<='0';
                if SENSOR='1' then --detecta que se coloca el vaso y pasa al estado de echar cafe
                    next_state<=s4;
                end if;

            when S4 => --estado echar cafe
                LED_ENCENDIDA <= '0';
                LED_BOMBA <= '0';
                START <= '0';
                DELAY<=(others=>'0');
                if MODOS = "01" then
                    LED_BOMBA <= '1'; --se activa la bomba
                    MODO_DISPLAY <= "0110"; --se indica al display que indique el tiempo corto "10 SEG"
                end if;
                if MODOS = "10" then
                    LED_BOMBA <= '1';--se activa la bomba
                    MODO_DISPLAY <= "1010"; --se indica al display que indique el tiempo largo "20 SEG"
                end if;
                if DONE = '1' then --termina de contar el tiempo y pasa de estado
                    next_state <= S5_1;
                end if;

            when S5_1 => --estado para cargar el tiempo de seleccion leche
                LED_BOMBA<='0';
                LED_ENCENDIDA <= '0';
                START<='1';
                DELAY <= to_unsigned(tiempo_espera_leche -2, DELAY'length);--carga el timpo de eleccion leche
                next_state <= S5_2;

            when S5_2 => --estado para seleccionar leche
                LED_BOMBA<='0';
                LED_ENCENDIDA <= '0';
                START <= '0';
                DELAY<=(others=>'0');

                if SEL_LECHE = '0' then --no se quiere leche
                    MODO_DISPLAY <= "1110";--se indica al display que ponga "NO LECHE"
                end if;

                if SEL_LECHE ='1' then--se quiere leche
                    LED_LECHE <= '1';--indica que queremos leche
                    LED_BOMBA<='1';--activa la bomba
                    MODO_DISPLAY <= "1100";--se indica al display que ponga "LECHE"
                    START <= '1';
                    DELAY <= to_unsigned(tiempo_leche -2, DELAY'length);--carga el tiempo de echar leche
                    next_state <= S6;-- se pasa a echar leche
                end if;
                
                if DONE = '1' then --si se termina el tiempo de seleecion sin querer leche se vuelve a encendida
                    next_state <= S0;
                end if;

            when S6 =>--estado para echar leche
                LED_ENCENDIDA <= '0';
                START<='0';
                DELAY<=(others=>'0');
                LED_LECHE <= '1';
                LED_BOMBA<='1';--se activa la bomba
                if DONE = '1' then --se termina de contar el tiempo de echar leche y se vuelve a encendida
                    next_state <= S0;
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