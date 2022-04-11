library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regbank is
	port (A: in std_logic_vector(15 downto 0);
			sel1, sel2, sel3: in std_logic_vector(2 downto 0); --sel1 --> write only --sel2 sel3 --> read only
			S1, S2: out std_logic_vector(15 downto 0));
end entity regbank;

architecture beh of regbank is
	component register_16 is
		port (A: in std_logic_vector(15 downto 0);
				w: in std_logic;
				S: out std_logic_vector(15 downto 0));
	end component register_16;
	
	component demux8x1_1 is
		port(sel: in std_logic_vector(2 downto 0);
			  S: out std_logic_vector(7 downto 0));
	end component demux8x1_1;
	
	type regArray is array(0 to 7) of std_logic_vector(15 downto 0);
	
	signal regfile: regArray := (others => (others => '0'));
	signal w: std_logic_vector(7 downto 0);
	signal temp1, temp2: std_logic_vector(15 downto 0);
begin
	
	dmx1: demux8x1_1 port map (sel1, w);
	reg0: register_16 port map(A, w(0), regfile(0));
	reg1: register_16 port map(A, w(1), regfile(1));
	reg2: register_16 port map(A, w(2), regfile(2));
	reg3: register_16 port map(A, w(3), regfile(3));
	reg4: register_16 port map(A, w(4), regfile(4));
	reg5: register_16 port map(A, w(5), regfile(5));
	reg6: register_16 port map(A, w(6), regfile(6));
	reg7: register_16 port map(A, w(7), regfile(7));
	w <= "00000000";
	--process(sel2, sel3, temp1, temp2)
	--begin
	--temp1 <= regfile(to_integer(unsigned(sel2)));
	--temp2 <= regfile(to_integer(unsigned(sel3)));
	--end process;
	--S1 <= temp1;
	--S2 <= temp2;
	
end beh;