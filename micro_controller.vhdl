library ieee;
use ieee.std_logic_1164.all;

entity micro_controller is
	port (clk: in std_logic);
end entity;

architecture beh of micro_controller is

component processor is
	port(CLK: in std_logic;
		  memory_address: out std_logic_vector(15 downto 0);
	     to_memory: out std_logic_vector(15 downto 0);
	     memory_WE_out: out std_logic;
	     from_memory: in std_logic_vector(15 downto 0));
end component;

component RAM is
	port(address: in std_logic_vector(15 downto 0);
		  data_in: in std_logic_vector(15 downto 0);
		  write_enable: in std_logic;
		  data_out: out std_logic_vector(15 downto 0));
end component;

signal memory_address, to_memory, from_memory : std_logic_vector(15 downto 0);
signal memory_WE_out : std_logic;

begin
	processor_01 : processor port map (clk, memory_address, to_memory, memory_WE_out, from_memory);
	RAM_01 : RAM port map (memory_address, to_memory, memory_WE_out, from_memory);
end beh;