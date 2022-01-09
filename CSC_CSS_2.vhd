library IEEE;
use IEEE.STD_LOGIC_1164.all;   


entity CSC_CSS_2 is  
	port (Z : in std_logic_vector(3 downto 0);
	G: in std_logic;
	P: in std_logic;  
	S0: out std_logic_vector(3 downto 0);
	S1: out std_logic_vector(3 downto 0));
end CSC_CSS_2;


architecture CSC_CSS_2 of CSC_CSS_2 is		

component mux3
	 Port ( a : in  STD_LOGIC_vector(3 downto 0);
           b : in  STD_LOGIC_vector(3 downto 0);
           s : in  STD_LOGIC;
           q : out  STD_LOGIC_vector(3 downto 0));
end component;
component plus10
 	Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
               s : out  STD_LOGIC_VECTOR (3 downto 0));	
end component;

signal Z_prim: std_logic_vector(3 downto 0);
signal S0_sig,S1_sig: std_logic_vector(3 downto 0);
signal t : std_logic;

begin

	L2: plus10 port map(z(3 downto 0),z_prim(3 downto 0));
---------------------


	m1 : mux3 port map (Z(3 downto 0),Z_prim(3 downto 0),G,S0_sig(3 downto 0));
	--S0_sig(0) <= Z(0) when (G='1') else Z_prim(0) when (G='0');
	--S0_sig(1) <= Z(1) when (G='1') else Z_prim(1) when (G='0');
	--S0_sig(2) <= Z(2) when (G='1') else Z_prim(2) when (G='0');
	--S0_sig(3) <= Z(3) when (G='1') else Z_prim(3) when (G='0');
	----------------------
	--S0_sig+1
	S1_sig(0) <= not S0_sig(0);
	S1_sig(1) <= S0_sig(0) xor S0_sig(1);
	S1_sig(2) <= (S0_sig(2) xor (S0_sig(1) and S0_sig(0)));
	S1_sig(3) <= (S0_sig(3) xor (S0_sig(2) and S0_sig(1) and S0_sig(0)));

	--S1 = S1+sig + 0tt0
	t <= (not G) and P;
	S1(0) <= S1_sig(0);
	S1(1) <= (t xor S1_sig(1));
	S1(2) <= ((not S1_sig(1)) and t) xor S1_sig(2);
	S1(3) <= ((S1_sig(1) or S1_sig(2)) and t) xor S1_sig(3);
	----------------------
	S0 <= S0_sig;
end CSC_CSS_2;
