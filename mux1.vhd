--PRANAV ALLE (1002058154)
--SAMYAM SANTOSH (100994596)

--mux1_to_PC

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration for a 2-to-1 multiplexer (mux1)
entity mux1 is
	port (
		ctrl: in STD_LOGIC;	-- Control signal for selecting input
		A_mux1 : in STD_LOGIC_VECTOR (31 downto 0);	-- Input A
		B_mux1 : in STD_LOGIC_VECTOR (31 downto 0);	-- Input B
		mux1_out : out STD_LOGIC_VECTOR (31 downto 0) );	-- Output of the multiplexer
end mux1;

architecture mux1_arch of mux1 is

begin
	-- Multiplexing logic: selects A_mux1 when ctrl is '0', and B_mux1 when ctrl is '1'
	mux1_out <= A_mux1 when ctrl = '0' else B_mux1;

end mux1_arch;	