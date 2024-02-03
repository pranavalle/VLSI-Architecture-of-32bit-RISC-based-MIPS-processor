--PRANAV ALLE (1002058154)
--SAMYAM SANTOSH (100994596)

--PC Plus 4 ADDER

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity declaration for a 32-bit adder (adder1)
entity adder1 is
    port (
        A_adder1, B_adder1: in std_logic_vector(31 downto 0);	-- Input signals for addition
        C_adder1: out std_logic_vector(31 downto 0)	-- Output of the addition
    );
end adder1;

architecture adder1_arch of adder1 is
begin
    process (A_adder1, B_adder1)
    begin
        -- Perform the addition by converting input vectors to unsigned and then back to std_logic_vector
        C_adder1 <= std_logic_vector(unsigned(A_adder1) + unsigned(B_adder1));
    end process;
end adder1_arch;
