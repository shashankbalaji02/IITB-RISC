library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is 
	port (A, B: in std_logic_vector(15 downto 0);
			sel: in std_logic;
			S: out std_logic_vector(15 downto 0);
			C, Z: out std_logic);
end entity;

architecture behavioral of ALU is 
	component adder_16 is
		port (A, B: in std_logic_vector(15 downto 0);
				Cin: in std_logic;
				S: out std_logic_vector(15 downto 0);
				Cout: out std_logic);
	end component; 
	signal output_temp, add_temp: std_logic_vector(15 downto 0);
begin
	adder: adder_16
			 port map (A, B, '0', add_temp, C);
	output_temp <= add_temp when (sel = '0') else A nand B;
	Z <= '1' when (to_integer(unsigned(output_temp)) = 0) else '0';
	S <= output_temp;
end architecture;