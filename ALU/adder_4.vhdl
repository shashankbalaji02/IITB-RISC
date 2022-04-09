library ieee;
use ieee.std_logic_1164.all;

entity adder_4 is
	port (A, B: in std_logic_vector(3 downto 0);
			Cin: in std_logic;
			S: out std_logic_vector(3 downto 0);
			Cout: out std_logic);
end entity adder_4;

architecture beh of adder_4 is

component full_adder is
	port(A, B, Cin: in std_logic; S, P, G: out std_logic);
end component;

signal c1, c2, c3: std_logic;
signal P, G: std_logic_vector(3 downto 0);

begin

	fa1: full_adder port map (A(0), B(0), Cin, S(0), P(0), G(0));
	fa2: full_adder port map (A(1), B(1), c1,  S(1), P(1), G(1));
	fa3: full_adder port map (A(2), B(2), c2,  S(2), P(2), G(2));
	fa4: full_adder port map (A(3), B(3), c3,  S(3), P(3), G(3));
	
	c1 <= G(0) or (P(0) and Cin);
	c2 <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and Cin);
	c3 <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and Cin);
	Cout <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and Cin);

end beh;