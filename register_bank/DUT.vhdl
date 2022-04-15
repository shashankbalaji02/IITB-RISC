library ieee;
use ieee.std_logic_1164.all;

entity DUT is 
	port(input_vector: in std_logic_vector(25 downto 0);
		  output_vector: out std_logic_vector(31 downto 0));
end entity;

architecture DUTWrap of DUT is
	component register_bank is
		port(A1, A2, A3: in std_logic_vector(2 downto 0);
			  Din: in std_logic_vector(15 downto 0);
			  RE: in std_logic;
			  D1, D2: out std_logic_vector(15 downto 0));
	end component;
begin
	add_instance: register_bank
		port map(A1 => input_vector(25 downto 23),
					A2 => input_vector(22 downto 20),
					A3 => input_vector(19 downto 17),
					Din => input_vector(16 downto 1),
					RE => input_vector(0),
					D1 => output_vector(31 downto 16),
					D2 => output_vector(15 downto 0));
end DUTWrap;