library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_bank is
	port(A1, A2, A3: in std_logic_vector(2 downto 0);
		  Din: in std_logic_vector(15 downto 0);
		  WE: in std_logic;
		  D1, D2: out std_logic_vector(15 downto 0));
end entity;

architecture behavioral of register_bank is
	type memory is array (0 to 7) of std_logic_vector(15 downto 0);
	signal bank: memory := (others => (others => '0'));
begin
	D1 <= bank(to_integer(unsigned(A1)));
	D2 <= bank(to_integer(unsigned(A2)));
	bank(to_integer(unsigned(A3))) <= Din when (WE = '1');
end architecture;