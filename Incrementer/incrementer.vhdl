library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity incrementer is
	port (A: in std_logic_vector(15 downto 0);
			S: out std_logic_vector(15 downto 0));
end entity incrementer;

architecture beh of incrementer is
	signal temp: integer;
	
begin
	temp <= to_integer(unsigned(A)) + 1;
	S <= std_logic_vector(to_unsigned(temp, 16));
end beh;