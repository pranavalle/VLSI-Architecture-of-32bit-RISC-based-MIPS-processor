--PRANAV ALLE (1002058154)
--SAMYAM SANTOSH (100994596)


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- Entity declaration for a single cycle MIPS processor
entity mips is
	port (clk, reset: in STD_LOGIC;
			pcout: buffer STD_LOGIC_VECTOR (31 downto 0);
			instr: in STD_LOGIC_VECTOR (31 downto 0);
			memwrite: out STD_LOGIC;
			aluout, writedata: buffer STD_LOGIC_VECTOR (31 downto 0);
			readdata: in STD_LOGIC_VECTOR (31 downto 0));
end mips;

architecture mips_arch of mips is 
-- Component declarations for various units used in the processor
    
-- Component declaration for a 2-to-1 multiplexer (mux1)						
component mux1 is
	port (
		ctrl: in STD_LOGIC;
		A_mux1 : in STD_LOGIC_VECTOR (31 downto 0);
		B_mux1 : in STD_LOGIC_VECTOR (31 downto 0);
		mux1_out : out STD_LOGIC_VECTOR (31 downto 0) );
end component;

-- Component declaration for a 2-to-1 multiplexer (muxj)
component muxj is
	port (
		ctrl: in STD_LOGIC;
		A_muxj : in STD_LOGIC_VECTOR (31 downto 0);
		B_muxj : in STD_LOGIC_VECTOR (31 downto 0);
		muxj_out : out STD_LOGIC_VECTOR (31 downto 0) );
end component;

-- Component declaration for a Program Counter
component ProgramCounter is
	Port (
		clk: in std_logic;
		reset: in std_logic;
		PC_in: in std_logic_vector(31 downto 0);
		pcout: out std_logic_vector(31 downto 0) );
		
end component;

-- Component declaration for a 32-bit adder (adder1)
component adder1 is
    port (
        A_adder1, B_adder1: in std_logic_vector(31 downto 0);
        C_adder1: out std_logic_vector(31 downto 0)
    );
end component;

-- Component declaration for a 32-bit adder (adder2)
component adder2 is
    port (
        A_adder2, B_adder2: in std_logic_vector(31 downto 0);
        C_adder2: out std_logic_vector(31 downto 0)
    );
end component;

-- Component declaration for a register file
component Register_File is
    Port ( clk : in  STD_LOGIC;
           WE3 : in  STD_LOGIC;
           A1 : in  STD_LOGIC_VECTOR (4 downto 0);
           A2 : in  STD_LOGIC_VECTOR (4 downto 0);
           A3 : in  STD_LOGIC_VECTOR (4 downto 0);
           RD1 : out  STD_LOGIC_VECTOR (31 downto 0);
           RD2 : out  STD_LOGIC_VECTOR (31 downto 0);
           WD3 : in  STD_LOGIC_VECTOR (31 downto 0));
end component;

-- Component declaration for a single cycle control decoder
component controller is
	port (op, funct: in STD_LOGIC_VECTOR (5 downto 0);
			zero: in STD_LOGIC;
			memtoreg, memwrite: out STD_LOGIC;
			pcsrc, alusrc: out STD_LOGIC;
			regdst, regwrite: out STD_LOGIC;
			jump: out STD_LOGIC;
			alucontrol: out STD_LOGIC_VECTOR (2 downto 0));
end component;

-- Component declaration for an Arithmetic Logic Unit (ALU)
component ALU is
    Port ( a : in  STD_LOGIC_VECTOR (31 downto 0);
           b : in  STD_LOGIC_VECTOR (31 downto 0);
           func : in  STD_LOGIC_VECTOR (2 downto 0);
			  zero: out std_logic ;
           rslt : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

-- Component declaration for sign extension
component SignExtend is
	Port (
			signExtend_in: in STD_LOGIC_VECTOR(15 downto 0);
         signExtend_out: out STD_LOGIC_VECTOR(31 downto 0)
        );
end component;

-- Component declaration for a 2-to-1 multiplexer (mux2)
component mux2 is
	port (
		ctrl: in STD_LOGIC;
		A_mux2 : in STD_LOGIC_VECTOR (4 downto 0);
		B_mux2 : in STD_LOGIC_VECTOR (4 downto 0);
		mux2_out : out STD_LOGIC_VECTOR (4 downto 0) );
end component;

-- Component declaration for a 2-to-1 multiplexer (mux3)
component mux3 is
	port (
		ctrl: in STD_LOGIC;
		A_mux3 : in STD_LOGIC_VECTOR (31 downto 0);
		B_mux3 : in STD_LOGIC_VECTOR (31 downto 0);
		mux3_out : out STD_LOGIC_VECTOR (31 downto 0) );
end component;

-- Component declaration for left shift block
component multiply_4 is
	port(
		multiply_in: in std_logic_vector(31 downto 0);	--input signal 32 bits
		multiply_out: out std_logic_vector(31 downto 0) );	--output signal 32 bits
end component;

-- Component declaration for left shift block for jump
component jump_lft is
	port(
		jump_lft_in: in std_logic_vector(25 downto 0);	--input signal 25 bits
		jump_lft_out: out std_logic_vector(27 downto 0) );	--output signal 27 bits
end component;

-- Component declaration for a 2-to-1 multiplexer (mux4)
component mux4 is
	port (
		ctrl: in STD_LOGIC;
		A_mux4 : in STD_LOGIC_VECTOR (31 downto 0);
		B_mux4 : in STD_LOGIC_VECTOR (31 downto 0);
		mux4_out : out STD_LOGIC_VECTOR (31 downto 0) );
end component;

-- Signal declarations for internal usage in the processor

	signal memtoreg_r,alusrc_r,regdst_r,regwrite_r,jump_r,memwrite_r,zero, pcsrc, rst_pc : std_logic;

	signal alucontrol : std_logic_vector(2 downto 0);
	
	signal jump_lft_out: std_logic_vector(27 downto 0);
	
	signal mux2out : std_logic_vector(4 downto 0);
	
	signal srca, srcb, rd2, extsig_out, pc_plus4_out, ls_out, pc_branch, result_mem, addr32, pc_next_j, mux1out : std_logic_vector(31 downto 0);
	
begin
-- Internal connections and logic for the single cycle MIPS processor
	
	-- Instantiate the controller unit
	Inst_controller: controller 
	PORT MAP(op => instr(31 downto 26), 
				funct => instr(5 downto 0), 
				zero => zero, 
				memtoreg => memtoreg_r, 
				memwrite => memwrite_r, 
				pcsrc => pcsrc, 
				alusrc => alusrc_r, 
				regdst => regdst_r, 
				regwrite => regwrite_r, 
				jump => jump_r, 
				alucontrol => alucontrol);
	
	-- Instantiate the Program Counter unit
	Inst_ProgramCounter: ProgramCounter 
	PORT MAP(clk => clk, 
				reset => reset, 
				PC_in => pc_next_j, 
				pcout => pcout);

	-- Instantiate the adder1 unit
	Inst_Add1_adder1: adder1 
	PORT MAP(A_adder1 => pcout, 
				B_adder1 => x"00000004", 
				C_adder1 => pc_plus4_out);
	
	-- Instantiate the mux2 unit
	Inst_mux2: mux2 
	PORT MAP(ctrl => regdst_r, 
				A_mux2 => instr(20 downto 16), 
				B_mux2 => instr(15 downto 11), 
				mux2_out => mux2out);
	
	-- Instantiate the Register File unit
	Inst_Register_File: Register_File 
	PORT MAP(clk => clk,
				WE3 => regwrite_r,
				A1 => instr(25 downto 21),
				A2 => instr(20 downto 16),
				A3 => mux2out,
				RD1 => srca,
				RD2 => rd2,
				WD3 => result_mem);
	
	-- Instantiate the ALU unit
	Inst_ALU: ALU 
	PORT MAP(a => srca,
				b => srcb,
				func => alucontrol,
				zero => zero,
				rslt => aluout);
	
	-- Instantiate the SignExtend unit
	Inst_SignExtend: SignExtend 
	PORT MAP(signExtend_in => instr(15 downto 0), 
				signExtend_out => extsig_out);
	
	-- Instantiate the mux3 unit
	Inst_mux3 : mux3 
	PORT MAP(ctrl => alusrc_r, 
				A_mux3 => rd2, 
				B_mux3 => extsig_out,
				mux3_out => srcb);
	
	-- Instantiate the multiply_4 unit
	Inst_multiply_4: multiply_4 
	PORT MAP(multiply_in => extsig_out, 
				multiply_out => ls_out);
	
	-- Instantiate the adder2 unit
	Inst_Add2_adder2: adder2 
	PORT MAP(A_adder2 => ls_out, 
				B_adder2 => pc_plus4_out, 
				C_adder2 => pc_branch);
	
	-- Instantiate the mux1 unit
	Inst_mux1: mux1 
	PORT MAP(ctrl => pcsrc, 
				A_mux1 => pc_plus4_out, 
				B_mux1 => pc_branch, 
				mux1_out => mux1out);
	
	-- Instantiate the mux4 unit
	Inst_mux4: mux4 
	PORT MAP(ctrl => memtoreg_r, 
				A_mux4 => aluout, 
				B_mux4 => readdata, 
				mux4_out => result_mem);
	
	-- Instantiate the jump_lft unit
   Inst_jump_lft: jump_lft 
	PORT MAP(jump_lft_in => instr (25 downto 0),
				jump_lft_out => jump_lft_out);
	
	-- Instantiate the muxj unit
	Inst_muxj : muxj 
	PORT MAP(ctrl => jump_r, 
				A_muxj => mux1out, 
				B_muxj => addr32, 
				muxj_out => pc_next_j);
	
	-- Create the 32-bit address for branching
	addr32 <= pc_plus4_out (31 downto 28) & jump_lft_out (27 downto 0);
	
	writedata<=rd2;	--assigning rd2 signal to writedata of mips
	memwrite <= memwrite_r;		--assigning memwrite_r signal to memwrite of mips
	
	
end mips_arch;