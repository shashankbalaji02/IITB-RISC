library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM is
	generic(mask: integer := 4);
	port(address: in std_logic_vector(15 downto 0);
		  data_in: in std_logic_vector(15 downto 0);
		  write_enable: in std_logic;
		  data_out: out std_logic_vector(15 downto 0));
end entity;

architecture behavioral of RAM is
	type ram_type is array (0 to 2**mask) of std_logic_vector(15 downto 0);
	signal memory: ram_type := (0 => "0011001000110000", 1 => "0011010000000011", 2 => "0001011001010000",
										 3 => "0101011010000111", others => "0000000000000000");
	
begin
	memory(to_integer(unsigned(address(mask downto 0)))) <= data_in when (write_enable = '1');
	data_out <= memory(to_integer(unsigned(address(mask downto 0))));
end architecture;