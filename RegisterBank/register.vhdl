library ieee;
use ieee.std_logic_1164.all;

entity register_16 is
	port (A: in std_logic_vector(15 downto 0);
			w: in std_logic;
			S: out std_logic_vector(15 downto 0));
end entity register_16;

architecture beh of register_16 is
	signal temp: std_logic_vector(15 downto 0) := "0000000000000000";
begin
	process(w, temp) is
		begin
		if (w = '1') then
			temp <= A;
		end if;
	end process;
	S <= temp;
end beh;
			