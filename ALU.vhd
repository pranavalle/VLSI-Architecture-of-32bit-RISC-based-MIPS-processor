--PRANAV ALLE (1002058154)
--SAMYAM SANTOSH (100994596)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entity declaration for an Arithmetic Logic Unit (ALU)
entity ALU is
    Port (
        a     : in  STD_LOGIC_VECTOR(31 downto 0);	-- Input operand a
        b     : in  STD_LOGIC_VECTOR(31 downto 0);	-- Input operand b
        func  : in  STD_LOGIC_VECTOR(2 downto 0);	-- Function control for ALU operation
        rslt  : out STD_LOGIC_VECTOR(31 downto 0);	-- Result of the ALU operation
        zero  : out STD_LOGIC);	-- Zero flag indicating if result is zero
end ALU;

architecture ALU_arch of ALU is
signal v_rslt : std_logic_vector(31 downto 0);	-- Internal signal to store the ALU result
begin
    process (a, b, func)
	 begin
        case func is
            when "010" =>
                v_rslt <= std_logic_vector(signed(a) + signed(b)); -- ADD
            when "110" =>
                v_rslt <= std_logic_vector(signed(a) - signed(b)); -- SUB
            when "000" =>
                v_rslt <= std_logic_vector(signed(a) and signed(b)); -- AND
            when "001" =>
                v_rslt <= std_logic_vector(signed(a) or signed(b)); -- OR
            when "111" =>
							   if (signed(a) < signed(b)) then -- Set all bits to '1' for "111"
					   v_rslt <= X"00000001";
						else 
						v_rslt <= (others => '0');
						
						end if;
						
            when others =>
                v_rslt <= (others => 'X'); -- Undefined
        end case;
	end process;
   rslt <= v_rslt;
   zero <= '1' when v_rslt = X"00000000" else '0'; -- Set zero if result is all zeros
end ALU_arch;
