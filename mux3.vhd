

--------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux3 is
    Port ( a : in  STD_LOGIC_vector(3 downto 0);
           b : in  STD_LOGIC_vector(3 downto 0);
           s : in  STD_LOGIC;
           q : out  STD_LOGIC_vector(3 downto 0));
end mux3;

architecture Behavioral of mux3 is

begin
q <= a WHEN s ='1' ELSE 
            b; 
end Behavioral;
