library ieee;
use ieee.std_logic_1164.all;

entity DUT is 
	port(input_vector: in std_logic_vector(15 downto 0);
		  output_vector: out std_logic_vector(15 downto 0));
end entity;

architecture DUTWrap of DUT is
	component incrementer is
		port( 
			A:  in std_logic_vector(15 downto 0);
			S: out std_logic_vector(15 downto 0));
	end component;
begin
	
	add_instance: incrementer
		port map (A => input_vector(15 downto 0),
					 S => output_vector(15 downto 0));
end DUTWrap;