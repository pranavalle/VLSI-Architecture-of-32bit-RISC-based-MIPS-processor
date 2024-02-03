--PRANAV ALLE (1002058154)
--SAMYAM SANTOSH (100994596)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration for a sign extension block
entity SignExtend is
	Port (
			signExtend_in: in STD_LOGIC_VECTOR(15 downto 0);	-- Input to be sign extended
         signExtend_out: out STD_LOGIC_VECTOR(31 downto 0)	-- Output after sign extension
        );	
end SignExtend;

architecture SignExtend_arch of SignExtend is
begin

process(signExtend_in)
begin
	if (signExtend_in(15)='1') then 								-- Check if the first bit of the input is '1' (indicating a negative number)
		signExtend_out<="1111111111111111"&signExtend_in; 	-- Sign extend for a negative number
	else 																	-- The input is a positive number
		signExtend_out<="0000000000000000"&signExtend_in;	-- Sign extend for a positive number
	end if;
end process;

end SignExtend_arch;