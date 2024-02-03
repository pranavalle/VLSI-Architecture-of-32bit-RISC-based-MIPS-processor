--PRANAV ALLE (1002058154)
--SAMYAM SANTOSH (100994596)

--jump_lftby 4 (jump)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity declaration for a left shift block for the jump
entity jump_lft is
	port(
		jump_lft_in: in std_logic_vector(25 downto 0) ;	--input signal 25 bits
		jump_lft_out: out std_logic_vector(27 downto 0) );	--output signal 28 bits
end jump_lft;

architecture jump_lft_arch of jump_lft is

begin
	jump_lft_out <= jump_lft_in(25 downto 0) & "00";	--output is input shifted left by 2 positions by concatenating with 2 zeros effectively jump_lfting by 4
end jump_lft_arch;