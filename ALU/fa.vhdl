library ieee;
use ieee.std_logic_1164.all;

--Partial Full Adder

entity full_adder is 
	port(A, B, Cin: in std_logic; S, P, G: out std_logic);
end entity full_adder;

architecture beh of full_adder is
begin 
	S <= A xor B xor Cin;
	P <= A xor B;
	G <= A and B;
end beh;