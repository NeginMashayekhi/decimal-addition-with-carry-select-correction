library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity dorri3 is
	port (x: in std_logic_vector (63 downto 0);
	      y: in std_logic_vector (63 downto 0);
		cout : out std_logic;
		    sum: out std_logic_vector (63 downto 0));
end dorri3;


architecture dorri3 of dorri3 is 

component CSC_CSS_2 is  
	port (Z : in std_logic_vector(3 downto 0);
	      G: in std_logic;
	      P: in std_logic;
	      S0: out std_logic_vector(3 downto 0);
	      S1: out std_logic_vector(3 downto 0));
end component; 
component mux3
	 Port ( a : in  STD_LOGIC_vector(3 downto 0);
           b : in  STD_LOGIC_vector(3 downto 0);
           s : in  STD_LOGIC;
           q : out  STD_LOGIC_vector(3 downto 0));
end component;
component Pre_Process2 is
	port (x: in std_logic_vector (3 downto 0);
	      y: in std_logic_vector (3 downto 0);
	      Z: out std_logic_vector (3 downto 0);
	      Gla: out std_logic;
	      Pla: out std_logic);
end component;

component QPPN16 is
   port ( G : in std_logic_vector(15 downto 0);
	  P : in std_logic_vector(15 downto 0);
	 carry	: out std_logic_vector(16 downto 1)
        );
end component;
 

--signal c: std_logic_vector(63 downto 1);
signal carry: std_logic_vector(16 downto 1);
signal G4: std_logic_vector(15 downto 0);
signal P4: std_logic_vector(15 downto 0);
signal Z: std_logic_vector (63 downto 0);							 
signal S0: std_logic_vector(63 downto 0);
signal S1: std_logic_vector(63 downto 0);

begin					   
	
	Stage1:for I in 1 to 16 generate
		L2: Pre_Process2 port map(x((4*I)-1 downto 4*(I-1)),y((4*I)-1 downto 4*(I-1)),Z((4*I)-1 downto 4*(I-1)),G4(I-1),P4(I-1));
	end generate Stage1;
	

	Stage2:for I in 1 to 16 generate
		L2: CSC_CSS_2 port map(Z((4*I)-1 downto 4*(I-1)),G4(I-1),P4(I-1),S0((4*I)-1 downto 4*(I-1)),S1((4*I)-1 downto 4*(I-1)));
	end generate Stage2;
	
	Stage3: QPPN16 port map(G4,P4,carry); 
	
	--sum(3 downto 0)<= S0(3 downto 0);

	L7: mux3 port map(S1(3 downto 0),S0(3 downto 0),'0',sum(3 downto 0));

	Stage4:for I in 2 to 16 generate
		L5: mux3 port map(S1((4*I)-1 downto 4*(I-1)),S0((4*I)-1 downto 4*(I-1)),carry(I-1),sum((4*I)-1 downto 4*(I-1)));
	end generate Stage4;
cout <= carry(16);
end dorri3;
