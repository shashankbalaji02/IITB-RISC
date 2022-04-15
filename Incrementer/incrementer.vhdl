library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity incrementer is
	port (Din: in std_logic_vector(15 downto 0);
			RE: in std_logic;
			Dout: out std_logic_vector(15 downto 0));
end entity;

architecture behavioral of incrementer is
	signal temp: std_logic_vector(15 downto 0);
begin
	temp <= std_logic_vector(unsigned(Din) + 1) when (RE = '1');
	Dout <= temp;
end architecture;