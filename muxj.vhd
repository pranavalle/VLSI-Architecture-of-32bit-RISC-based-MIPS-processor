--PRANAV ALLE (1002058154)
--SAMYAM SANTOSH (100994596)

--muxj

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration for a 2-to-1 multiplexer (muxj)
entity muxj is
	port (
		ctrl: in STD_LOGIC;	-- Control signal for selecting input
		A_muxj : in STD_LOGIC_VECTOR (31 downto 0);	-- Input A
		B_muxj : in STD_LOGIC_VECTOR (31 downto 0);	-- Input B
		muxj_out : out STD_LOGIC_VECTOR (31 downto 0) );	-- Output of the multiplexer
end muxj;	

architecture muxj_arch of muxj is

begin
	-- Multiplexing logic: selects A_muxj when ctrl is '0', and B_muxj when ctrl is '1'
	muxj_out <= A_muxj when ctrl = '0' else B_muxj;

end muxj_arch;	