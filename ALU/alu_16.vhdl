library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_16 is 
	port (A, B: in std_logic_vector(15 downto 0);
			sel: in std_logic;
			S: out std_logic_vector(15 downto 0);
			cy, z: out std_logic);
end entity;

architecture beh of alu_16 is 

component adder_16 is
	port (A, B: in std_logic_vector(15 downto 0);
			Cin: in std_logic;
			S: out std_logic_vector(15 downto 0);
			Cout: out std_logic);
end component adder_16; 

signal output_temp, add_temp: std_logic_vector(15 downto 0);

begin

	a1: adder_16 port map (A, B, '0', add_temp, cy);
	
	process(A, B, sel, output_temp, add_temp)
	begin
		if (sel = '0') then
			output_temp <= add_temp;
		else
			output_temp <= A nand B;
		end if;
	end process;

	z <= '1' when (to_integer(unsigned(output_temp)) = 0) else '0';
	S <= output_temp;
	
end beh;