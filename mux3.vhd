--PRANAV ALLE (1002058154)
--SAMYAM SANTOSH (100994596)

--mux to ALU

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration for a 2-to-1 multiplexer (mux3)
entity mux3 is
	port (
		ctrl: in STD_LOGIC;	-- Control signal for selecting input
		A_mux3 : in STD_LOGIC_VECTOR (31 downto 0);	--Input A
		B_mux3 : in STD_LOGIC_VECTOR (31 downto 0);	--Input B
		mux3_out : out STD_LOGIC_VECTOR (31 downto 0) );	-- Output of the multiplexer
end mux3;

architecture mux3_arch of mux3 is

begin
	-- Multiplexing logic: selects A_mux3 when ctrl is '0', and B_mux3 when ctrl is '1'
	mux3_out <= A_mux3 when ctrl = '0' else B_mux3;

end mux3_arch;