--PRANAV ALLE (1002058154)
--SAMYAM SANTOSH (100994596)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entity declaration for a register file
entity Register_File is
    Port (
        clk : in  STD_LOGIC;								-- Clock input
        WE3 : in  STD_LOGIC;								-- Write enable for the third register
        A1 : in  STD_LOGIC_VECTOR (4 downto 0);		-- Address for the first register read
        A2 : in  STD_LOGIC_VECTOR (4 downto 0);		-- Address for the second register read
        A3 : in  STD_LOGIC_VECTOR (4 downto 0);		-- Address for the third register write
        RD1 : out  STD_LOGIC_VECTOR (31 downto 0);	-- Data output from the first register
        RD2 : out  STD_LOGIC_VECTOR (31 downto 0);	-- Data output from the second register
        WD3 : in  STD_LOGIC_VECTOR (31 downto 0)	-- Data input for the third register write
    );
end Register_File;

architecture behavioral of Register_File is
    type reg_type is array (0 to 31) of STD_LOGIC_VECTOR (31 downto 0);	-- Type definition for the register file
    signal reg : reg_type;	-- Signal representing the register file

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if WE3 = '1' then
                reg(to_integer(unsigned(A3))) <= WD3;	-- Write to the specified register if write enable is active
            end if;
        end if;
    end process;

    process(A1, A2)
    begin
        RD1 <= (others => '0');	-- Initialize RD1 to all zeros
        if A1 /= "00000" then
            RD1 <= reg(to_integer(unsigned(A1)));	-- Read data from the first specified register
        end if;

        RD2 <= (others => '0');	-- Initialize RD2 to all zeros
        if A2 /= "00000" then
            RD2 <= reg(to_integer(unsigned(A2)));	-- Read data from the second specified register
        end if;
    end process;
end behavioral;