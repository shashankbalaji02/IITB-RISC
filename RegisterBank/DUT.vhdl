library ieee;
use ieee.std_logic_1164.all;

entity DUT is 
	port(input_vector: in std_logic_vector(25 downto 0);
		  output_vector: out std_logic_vector(31 downto 0));
end entity;

architecture DUTWrap of DUT is
	component regbank is
	port (A: in std_logic_vector(15 downto 0);
			sel1, sel2, sel3: in std_logic_vector(2 downto 0);  --sel1 --> write only --sel2 sel3 --> read only
			clk: in std_logic;
			S1, S2: out std_logic_vector(15 downto 0));
end component regbank;
begin
	
	add_instance: regbank
		port map (A => input_vector(25 downto 10),
					 sel1 => input_vector(9 downto 7),
					 sel2 => input_vector(6 downto 4),
					 sel3 => input_vector(3 downto 1),
					 clk => input_vector(0),
					 S1 => output_vector(31 downto 16),
					 S2 => output_vector(15 downto 0));
end DUTWrap;