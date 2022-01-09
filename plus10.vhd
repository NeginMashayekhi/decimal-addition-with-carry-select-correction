
-------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity plus10 is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           
           
           
           s : out  STD_LOGIC_VECTOR (3 downto 0));
end plus10;

architecture plus10 of plus10 is

	 
	signal c1: STD_LOGIC;

	begin


	s(0) <= a(0);
	
	s(1) <= not a(1);

	s(2) <= (a(1) xor a(2));
	
	c1 <= a(1) and a(2);
	s(3) <=not( a(3) xor c1);
	
end plus10;

