library ieee;
use ieee.std_logic_1164.all;


entity QPPN16 is
  port ( G : in std_logic_vector(15 downto 0);
	 P : in std_logic_vector(15 downto 0);
	 carry	: out std_logic_vector(16 downto 1)
        );
end QPPN16;

architecture QPPN16 of QPPN16 is

	
component pp_black is 
	 port(
         g_L,g_R,p_L,p_R : in std_logic;
         g_out : out std_logic;
	 p_out : out std_logic
         );
end component pp_black;
	
component pp_gray is 
	port (
			g_L,g_R,p_L	: in 	std_logic;
			g_out		: out 	std_logic
         );
end component pp_gray;
	
	--signal	f :std_logic_vector(15 downto 0);
	--signal	k :std_logic_vector(15 downto 0);
	signal g1 : std_logic_vector(15 downto 0);
	signal p1 : std_logic_vector(15 downto 0);
	signal g2 : std_logic_vector(15 downto 0);
	signal p2 : std_logic_vector(15 downto 0);
	signal g3 : std_logic_vector(15 downto 0);
	signal p3 : std_logic_vector(15 downto 8);
	--signal g4 : std_logic_vector(63 downto 0);
	--signal p4 : std_logic_vector(63 downto 0);
	--signal g5 : std_logic_vector(63 downto 0);
	--signal p5 : std_logic_vector(63 downto 0);
       -- signal g6 : std_logic_vector(63 downto 0);
	--signal p6 : std_logic_vector(63 downto 0);


begin 
	--f <= G;
	--k <= P;
	--carry(0) <= '0';
	 
--------------------------------------------------------------------------------------------
	
	pp1_stage_nodes: for i in 1 to 15 generate
				pp1_nodes: pp_black port map (G(i),G(i-1),P(i),P(i-1),g1(i),p1(i));
	end generate pp1_stage_nodes;
	g1(0) <= G(0);
	p1(0) <= P(0);
--------------------------------------------------------------------------------------------
	

pp2_stage_last_nodes:	for i in 2 to 15 generate	
	L1: if i<3 generate
		 pp2_gray:	pp_gray port map (g1(i),g1(i-2),p1(i),g2(i));
	end generate L1; 
	L2: if i>2 generate
		pp2_nodes:	pp_black port map (g1(i),g1(i-2),p1(i),p1(i-2),g2(i),p2(i));
	end generate L2;
	end generate pp2_stage_last_nodes;
	p2(2) <= '0';

	buffer_insertion_2:	for i in 0 to 1 generate
		gs:	g2(i) <= g1(i);
		ps:	p2(i) <= p1(i);
	end generate buffer_insertion_2;

	--g2(0) <= g1(0);
	--p2(0) <= p1(0);

--------------------------------------------------------------------------------------------		

pp3_stage_last_nodes:	for i in 3 to 15 generate 
	L3: if i<8 generate
		pp3_gray:	pp_gray port map (g2(i),g2(i-3),p2(i),g3(i));	
	end generate L3;
	L4: if i>7 generate
		pp3_nodes:	pp_black port map (g2(i),g2(i-3),p2(i),p2(i-3),g3(i),p3(i));
	end generate L4;
end generate pp3_stage_last_nodes;
	
buffer_insertion_3:	for i in 0 to 2 generate
	gs:	g3(i) <= g2(i);
	
end generate buffer_insertion_3;

--p3(6 downto 3) <="0000";

--------------------------------------------------------------------------------------------

	pp4_stage_last_nodes:	for i in 8 to 15 generate
		pp6_nodes:	pp_gray port map (g3(i),g3(i-8),p3(i),carry(i+1));
	end generate pp4_stage_last_nodes;
	pp4_stage_last_carry: for i in 0 to 7 generate
		carry(i+1)<=g3(i);
	end generate pp4_stage_last_carry;	


-----------------------------------------------------------------------------------------------------



end architecture QPPN16;
