library ieee;
use ieee.std_logic_1164.all;

entity pp_black is 
   port(
         g_L,g_R,p_L,p_R : in std_logic;
         g_out : out std_logic;
	 p_out : out std_logic
         );
end pp_black;

architecture pp_black of pp_black is

begin
   g_out <= g_L or (p_L and g_R);
   p_out <= p_L and p_R;
   
end pp_black;

