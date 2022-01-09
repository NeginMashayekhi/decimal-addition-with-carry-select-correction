
-------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity plus6 is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           
           
           
           s : out  STD_LOGIC_VECTOR (3 downto 0));
end plus6;

architecture plus6 of plus6 is

	 
	signal c1: STD_LOGIC;

	begin


	s(0) <= a(0);
	
	s(1) <= not a(1);

	s(2) <= not (a(1) xor a(2));
	
	c1 <= a(1) or a(2);
	s(3) <= a(3) xor c1;
	
end plus6;

