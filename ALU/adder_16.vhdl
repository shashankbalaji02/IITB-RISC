library ieee;
use ieee.std_logic_1164.all;

entity adder_16 is
	port (A, B: in std_logic_vector(15 downto 0);
			Cin: in std_logic;
			S: out std_logic_vector(15 downto 0);
			Cout: out std_logic);
end entity adder_16;

architecture beh of adder_16 is

component adder_4 is
	port (A, B: in std_logic_vector(3 downto 0);
			Cin: in std_logic;
			S: out std_logic_vector(3 downto 0);
			Cout: out std_logic);
end component adder_4;

signal c1, c2, c3: std_logic;

begin

	add1: adder_4 port map (A(3 downto 0), B(3 downto 0), Cin, S(3 downto 0), c1);
	add2: adder_4 port map (A(7 downto 4), B(7 downto 4), c1, S(7 downto 4), c2);
	add3: adder_4 port map (A(11 downto 8), B(11 downto 8), c2, S(11 downto 8), c3);
	add4: adder_4 port map (A(15 downto 12), B(15 downto 12), c3, S(15 downto 12), Cout);

end beh;