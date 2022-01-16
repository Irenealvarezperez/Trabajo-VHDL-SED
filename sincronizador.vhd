
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sincronizador is
    PORT (
        CLK : in std_logic;
        SYNC_IN : in std_logic;--Entrada sincronizador
        SYNC_OUT : out std_logic--Salida sincronizador
    );
end sincronizador;

architecture Behavioral of sincronizador is
    signal sreg : std_logic_vector(1 downto 0);
begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            sync_out <= sreg(1);
            sreg <= sreg(0) & sync_in;
        end if;
    end process;

end Behavioral;
