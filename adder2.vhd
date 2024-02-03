--PRANAV ALLE (1002058154)
--SAMYAM SANTOSH (100994596)

--PC_Branch

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity declaration for a 32-bit adder (adder2)
entity adder2 is
    port (
        A_adder2, B_adder2: in std_logic_vector(31 downto 0);	-- Input signals for addition
        C_adder2: out std_logic_vector(31 downto 0)	-- Output of the addition
    );
end adder2;

architecture adder2_arch of adder2 is
begin
    process (A_adder2, B_adder2)
    begin
        -- Perform the addition by converting input vectors to unsigned and then back to std_logic_vector
        C_adder2 <= std_logic_vector(unsigned(A_adder2) + unsigned(B_adder2));
    end process;
end adder2_arch;