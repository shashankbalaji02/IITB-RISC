library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter is
	port (rst,clk: in std_logic; 
			S: out std_logic_vector(3 downto 0));
end entity counter;

architecture beh of counter is
signal count: std_logic_vector(3 downto 0) := "0000";
begin
	process(rst, clk)
	begin
		if(rst = '1') then count <= "0000";
		elsif(rising_edge(clk)) then count <= count + 1;
		end if;
	end process;
	S <= count;
end beh;