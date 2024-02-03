--PRANAV ALLE (1002058154)
--SAMYAM SANTOSH (100994596)

--multiply by 4

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity declaration for a left shift block
entity multiply_4 is
	port(
		multiply_in: in std_logic_vector(31 downto 0);	--input signal 32 bits
		multiply_out: out std_logic_vector(31 downto 0) );	--output signal 32 bits
end multiply_4;

architecture multiply_4_arch of multiply_4 is

begin
	multiply_out <= multiply_in(29 downto 0) & "00";	--output is input shifted left by 2 positions by concatenating with 2 zeros effectively multiplying by 4
end multiply_4_arch;