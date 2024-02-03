--4 input mux

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux5_4in is
    Port ( ctrl : in  STD_LOGIC_VECTOR (1 downto 0);
           a : in  STD_LOGIC_VECTOR (31 downto 0);
           b : in  STD_LOGIC_VECTOR (31 downto 0);
           c : in  STD_LOGIC_VECTOR (31 downto 0);
           d : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end mux5_4in;

architecture mux5_4in_arch of mux5_4in is

begin
	output<= a when (ctrl="00") else
			b when (ctrl="01") else
			c when (ctrl="10") else
			d;

end mux5_4in_arch;