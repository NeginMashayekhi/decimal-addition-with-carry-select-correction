library ieee;
use ieee.std_logic_1164.all;

entity pp_gray is 
   port(
         g_L,g_R,p_L : in std_logic;
         g_out : out std_logic
         );
end pp_gray;

architecture pp_gray of pp_gray is

begin
  
	g_out <= g_L or (p_L and g_R) ;
     
end pp_gray;


