--PRANAV ALLE (1002058154)
--SAMYAM SANTOSH (100994596)

--ProgramCounter
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration for a Program Counter
entity ProgramCounter is
	Port (
		clk: in std_logic;	-- Clock input
		reset: in std_logic;	-- Reset signal
		PC_in: in std_logic_vector(31 downto 0);	-- Input Program Counter value
		pcout: out std_logic_vector(31 downto 0) );	-- Output Program Counter value

end ProgramCounter;

architecture ProgramCounter_arch of ProgramCounter is
	signal PC_R: std_logic_vector(31 downto 0) := (others => '0');	-- Internal register to hold the Program Counter value
	
begin
	process(clk, reset)
	begin
		-- Reset the Program Counter value when reset is asserted
		if reset = '1' then
			PC_R <= (others => '0');
			
		-- Update the Program Counter value on the rising edge of the clock
		elsif clk'event and clk'last_value = '0' and clk = '1' then
			PC_R <= PC_in;
		end if;
	end process;
	
	-- Output the Program Counter value
	pcout <= PC_R;
end ProgramCounter_arch;