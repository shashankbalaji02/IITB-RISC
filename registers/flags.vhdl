library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flags is
	port(Cin, Zin, CE, ZE: in std_logic;
		  Cout, Zout: out std_logic);
end entity;

architecture behavioral of flags is
	signal C, Z: std_logic;
begin
	C <= Cin when (CE = '1');
	Z <= Zin when (ZE = '1');
	Cout <= C;
	Zout <= Z;
end architecture;