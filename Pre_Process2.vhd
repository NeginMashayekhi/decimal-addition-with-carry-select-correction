library IEEE;
use IEEE.STD_LOGIC_1164.all;  


entity Pre_Process2 is
	port (x: in std_logic_vector (3 downto 0);
			y: in std_logic_vector (3 downto 0);
			Z: out std_logic_vector (3 downto 0);
			Gla: out std_logic;
			Pla: out std_logic);
end Pre_Process2;

architecture Pre_Process2 of Pre_Process2 is 

component plus6
 	Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
               s : out  STD_LOGIC_VECTOR (3 downto 0));	
end component;

signal y_prim: std_logic_vector (3 downto 0);
--signal p0,g0,g1,p1,p2,g2,p3,g3 : std_logic;
signal c2, c3: std_logic;
signal h,p,g : std_logic_vector (3 downto 0);


begin	


	L1: plus6 port map(y(3 downto 0),y_prim(3 downto 0));

	Stage2:for I in 0 to 3 generate
		L1: g(I) <= x(I) and y_prim(I);
		L2: p(I) <= x(I) or y_prim(I);
		L5: h(I) <= x(I) xor y_prim(I);
	end generate Stage2;
	
	c2 <= g(1) or (p(1) and g(0)); 
	c3 <= g(2) or (p(2) and c2);
	-----------------------
	
	Gla <= (g(3) or (g(2) and p(3)) or (g(1) and p(2) and p(3)) or (g(0) and p(1) and p(2) and p(3)));
	Pla <= (p(3) and p(2) and p(1) and p(0));
	----------Z------------
	Z(0) <= h(0);
	Z(1) <= h(1) xor g(0);  --g0=c1
	Z(2) <= h(2) xor c2;
	Z(3) <= h(3) xor c3;	-- h(3) xor G2:0
	
end Pre_Process2;
