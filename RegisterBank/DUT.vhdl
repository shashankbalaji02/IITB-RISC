library ieee;
use ieee.std_logic_1164.all;

entity DUT is 
	port(input_vector: in std_logic_vector(16 downto 0);
		  output_vector: out std_logic_vector(15 downto 0));
end entity;

architecture DUTWrap of DUT is
	component register_16 is
		port( 
			A:  in std_logic_vector(15 downto 0);
			w: in std_logic;
			S: out std_logic_vector(15 downto 0));
	end component;
begin
	
	add_instance: register_16
		port map (A => input_vector(15 downto 0),
					 w => input_vector(16),
					 S => output_vector(15 downto 0));
end DUTWrap;