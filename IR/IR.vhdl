library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IR is
	port(Din: in std_logic_vector(15 downto 0);
		  WE: in std_logic;
		  Dout: out std_logic_vector(15 downto 0));
end entity;

architecture behavioral of IR is
	signal reg: std_logic_vector(15 downto 0) := (others => '0');
begin
	reg <= Din when (WE = '1');
	Dout <= reg;
end architecture;