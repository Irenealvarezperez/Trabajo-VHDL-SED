
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity detector_flanco is
    port (
        CLK : in std_logic;
        EDGE_IN : in std_logic;
        EDGE_OUT : out std_logic
    );
end detector_flanco;

architecture Behavioral of detector_flanco is
    signal sreg : std_logic_vector(2 downto 0);
begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            sreg <= sreg(1 downto 0) & EDGE_IN;
        end if;
    end process;
    with sreg select
 EDGE_OUT <= '1' when "100",
        '0' when others;
end Behavioral;
