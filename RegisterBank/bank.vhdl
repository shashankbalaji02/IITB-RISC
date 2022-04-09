library ieee;
use ieee.std_logic_1164.all;

entity bank is
	port(A1, A2, A3: in std_logic_vector(15 downto 0);
		  sel1, sel2, sel3: in std_logic_vector(2 downto 0);
		  sel0: in std_logic_vector(2 downto 0);
		  S: out std_logic_vector(15 downto 0));
end entity bank;

architecture beh of bank is

component register_16 is
	port (A: in std_logic_vector(15 downto 0);
			w: in std_logic;
			S: out std_logic_vector(15 downto 0));
end component register_16;

component mux8x1_16 is
	port(sel: in std_logic_vector(2 downto 0);
		  A0, A1, A2, A3, A4, A5, A6, A7: in std_logic_vector(15 downto 0);
		  S: out std_logic_vector(15 downto 0));
end component mux8x1_16;

component demux8x1_16 is
	port(A: in std_logic_vector(15 downto 0);
		  sel: in std_logic_vector(2 downto 0);
		  S0, S1, S2, S3, S4, S5, S6, S7: out std_logic_vector(15 downto 0));
end component demux8x1_16;

	signal ti0, ti1, ti2, ti3, ti4, ti5, ti6, ti7: std_logic_vector(15 downto 0) := "0000000000000000";
	signal to0, to1, to2, to3, to4, to5, to6, to7: std_logic_vector(15 downto 0) := "0000000000000000";
	signal w0, w1, w2, w3, w4, w5, w6, w7: std_logic := '0';
begin
	
	process(w0, w1, w2, w3, w4, w5, w6, w7, sel3) is
	begin
		w0 <= '0';
		w1 <= '0';
		w2 <= '0';
		w3 <= '0';
		w4 <= '0';
		w5 <= '0';
		w6 <= '0';
		w7 <= '0';
		case sel3 is
			when "000" =>
				w0 <= '1';
			when "001" =>
				w1 <= '1';
			when "010" =>
				w2 <= '1';
			when "011" =>
				w3 <= '1';
			when "100" =>
				w4 <= '1';
			when "101" =>
				w5 <= '1';
			when "110" =>
				w6 <= '1';
			when "111" =>
				w7 <= '1';
		end case;
	end process;
	
	demux1: demux8x1_16 port map (A1, sel1, ti0, ti1, ti2, ti3, ti4, ti5, ti6, ti7);
	demux2: demux8x1_16 port map (A2, sel2, ti0, ti1, ti2, ti3, ti4, ti5, ti6, ti7);
	demux3: demux8x1_16 port map (A3, sel3, ti0, ti1, ti2, ti3, ti4, ti5, ti6, ti7);
	reg0: register_16 port map (ti0, w0, to0);
	reg1: register_16 port map (ti1, w1, to1);
	reg2: register_16 port map (ti2, w2, to2);
	reg3: register_16 port map (ti3, w3, to3);
	reg4: register_16 port map (ti4, w4, to4);
	reg5: register_16 port map (ti5, w5, to5);
	reg6: register_16 port map (ti6, w6, to6);
	reg7: register_16 port map (ti7, w7, to7);
	mux1: mux8x1_16 port map (sel0, to0, to1, to2, to3, to4, to5, to6, to7, S);
end beh;