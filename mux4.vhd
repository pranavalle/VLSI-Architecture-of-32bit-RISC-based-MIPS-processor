--PRANAV ALLE (1002058154)
--SAMYAM SANTOSH (100994596)

--mux to result

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration for a 2-to-1 multiplexer (mux3)
entity mux4 is
	port (
		ctrl: in STD_LOGIC;	-- Control signal for selecting input
		A_mux4 : in STD_LOGIC_VECTOR (31 downto 0);	--Input A
		B_mux4 : in STD_LOGIC_VECTOR (31 downto 0);	--Input B
		mux4_out : out STD_LOGIC_VECTOR (31 downto 0) );	--Output of multiplexer
end mux4;

architecture mux4_arch of mux4 is

begin
	-- Multiplexing logic: selects A_mux4 when ctrl is '0', and B_mux4 when ctrl is '1'
	mux4_out <= A_mux4 when ctrl = '0' else B_mux4;

end mux4_arch;