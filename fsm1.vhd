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
        long_opcion:positive:=3
    );
    port (
        RESET : in std_logic;
        CLK : in std_logic;
        EDGE : in std_logic;

        --Añadir contadores o temporizadores (?)
        MODOS : in std_logic_vector(1 downto 0);
        SEL_LECHE: in std_logic;
        SEL_AZUCAR: in std_logic;
        SEL_OKEY: in std_logic;
        MODO_DISPLAY: out std_logic_vector(long_opcion -1 downto 0); --salida para indicarle al display el modo
        -- TIEMPO_DISPLAY: out string(1 downto 0);
        LED_ENCENDIDA: out std_logic;
        LED_BOMBA: out std_logic;
        LED_LECHE: out std_logic;
        LED_AZUCAR: out std_logic;
        --Salidas para la esclava
        --PARAM: out std_logic;
        START: out std_logic;
        DONE: in std_logic;
        DELAY : out unsigned (7 downto 0)
    );
end fsm1;

architecture Behavioral of fsm1 is
    --¿¿Estado de preparación (calentamiento/molido cafe)??
    type STATES is (S0, S1, S2_1, S2_2, S3, S4, S5, S6); --creo que hace falta un estado mas
    -- estado 0 :reposo  estado 1: encendida/preparación estado 2 :indicar nivel de azucar
    -- estado 3: seleccion tipo cafe  estado 4: echar cafe  estado 5: seleccionar leche 
    -- estado 6: echar leche
    signal current_state: STATES := S0;
    signal next_state: STATES;

    constant tiempo_preparacion :positive := 3000; --tiempo de calentamiento/molido cafe
    constant tiempo_azucar : positive := 10000;
    constant tiempo_corto : positive := 4000;  --tiempo de echar el cafe
    constant tiempo_largo : positive := 4000;
    constant tiempo_leche : positive := 5000; --tiempo de echar la leche
begin
    state_register: process (RESET, CLK)
    begin
        if RESET = '0' then
            current_state <= S0;

        elsif rising_edge(CLK) then
            current_state <= next_state;
        end if;
    end process;

    nextstate: process (RESET,MODOS,EDGE, current_state, DONE)
    begin
        next_state <= current_state;
        START <= '0';
        --DELAY <= (others => '0');

        case current_state is

            when S0 =>
                START <= '0';
                --DELAY <= (others => '0');

                MODO_DISPLAY <= "000";
                if EDGE = '1' then
                    START <= '1';
                    DELAY <= to_unsigned(tiempo_preparacion -2, DELAY'length);
                    next_state <= S1;
                end if;
            when S1 =>
                START<='0';
                --DELAY <= (others => '0');
                if DONE = '1' then
                    next_state <= S2_1;
                end if;
            when S2_1=>
                START<='1';
                DELAY <= to_unsigned(tiempo_azucar -2, DELAY'length);
                next_state <= S2_2;
            when s2_2=>
                START<='0';
                if DONE = '1' then
                    next_state <= S3;
                end if;
            when S3 =>
                START <= '1';
                if MODOS = "01"  then --???????????
                    DELAY <= to_unsigned(tiempo_corto -2, DELAY'length);
                    if SEL_OKEY='1' then
                        next_state <= S4;
                    end if;
                end if;
                if MODOS = "10"  then
                    DELAY <= to_unsigned(tiempo_largo -2, DELAY'length);
                    if SEL_OKEY='1' then
                        next_state <= S4;
                    end if;
                end if;
            when S4 =>
                START <= '0';
                if DONE = '1' then
                    next_state <= S5;
                end if;
            when S5 =>
            
                if SEL_OKEY='1' then

                    if SEL_LECHE = '1' then
                        START <= '1';
                        DELAY <= to_unsigned(tiempo_leche -2, DELAY'length);

                        next_state <= S6;
                    else
                        next_state <= S0;
                    end if;
                end if;
            when S6 =>
                -- if temporizador_leche <= 15 segundos then (la esclava le dice que ha acabado)
                START<='0';
                if DONE = '1' then
                    next_state <= S0;
                end if;
        end case;
    end process;


    outputs: process (current_state,SEL_LECHE,SEL_AZUCAR,SEL_OKEY,MODOS)

    begin
        case current_state is
            when S0 =>
                LED_LECHE<='0';
                LED_BOMBA<='0';
                LED_AZUCAR <= '0';
                LED_ENCENDIDA <= '0';
                MODO_DISPLAY <= "000";

            when s1=>
                LED_ENCENDIDA <= '1';
                MODO_DISPLAY<="000";
            when S2_1 =>
                MODO_DISPLAY <= "001";
            when S2_2 =>
                MODO_DISPLAY <= "001";
                if SEL_AZUCAR = '1' then
                    LED_AZUCAR <= '1';
                end if;
            when S3 =>
                if MODOS = "01" then
                    MODO_DISPLAY <= "010"; --le dice al display el modo
                end if;
                if MODOS = "10" then
                    MODO_DISPLAY <= "100"; --le dice al display el modo
                end if;
            when S4 =>
                if MODOS = "01" then
                    LED_BOMBA <= '1';
                    MODO_DISPLAY <= "011";
                end if;
                if MODOS = "10" then
                    LED_BOMBA <= '1';
                    MODO_DISPLAY <= "101";
                end if;
            when S5 =>
                LED_BOMBA<='0';
                if SEL_LECHE = '1' then
                    LED_LECHE <= '1';
                    MODO_DISPLAY <= "110";
                else if SEL_LECHE = '0' then
                        MODO_DISPLAY <= "111";
                    end if;
                end if;
            when S6 =>
                if SEL_LECHE = '1' then
                    LED_LECHE <= '1';
                end if;
            when others =>
                MODO_DISPLAY<= "000";
        end case;
    end process;
end Behavioral;