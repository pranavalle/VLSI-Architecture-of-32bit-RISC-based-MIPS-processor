--PRANAV ALLE (1002058154)
--SAMYAM SANTOSH (100994596)

--mux to register file

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration for a 2-to-1 multiplexer (mux2)
entity mux2 is
	port (
		ctrl: in STD_LOGIC;	-- Control signal for selecting input
		A_mux2 : in STD_LOGIC_VECTOR (4 downto 0);	--Input A
		B_mux2 : in STD_LOGIC_VECTOR (4 downto 0);	--Input B
		mux2_out : out STD_LOGIC_VECTOR (4 downto 0) );	-- Output of the multiplexer
end mux2;

architecture mux2_arch of mux2 is

begin
	-- Multiplexing logic: selects A_mux2 when ctrl is '0', and B_mux2 when ctrl is '1'
	mux2_out <= A_mux2 when ctrl = '0' else B_mux2;

end mux2_arch;