library ieee;
use ieee.std_logic_1164.all;

entity DUT is 
	port(input_vector: in std_logic_vector(18 downto 0);
		  output_vector: out std_logic_vector(27 downto 0));
end entity;

architecture DUTWrap of DUT is
	component controller is
		port (IR: in std_logic_vector(15 downto 0);
				clk, cy, zflag: in std_logic;
				S: out std_logic_vector(27 downto 0));
	end component controller;
begin
	
	add_instance: controller
		port map (IR          => input_vector(15 downto 0),
					 clk         => input_vector(16),
					 zflag       => input_vector(17),
					 cy          => input_vector(18),
					 S           => output_vector(27 downto 0));
end DUTWrap;