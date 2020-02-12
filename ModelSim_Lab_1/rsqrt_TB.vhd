library IEEe;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
use STD.textio.all;
use ieee.std_logic_textio.all;


entity rsqrt_TB is
end entity;

architecture rsqrt_arch of rsqrt_TB is
	

	--Component rsqrt
	
	component rsqrt is
		generic(
			W_bits			: positive := 32; -- size of word
			F_bits			: positive := 16; -- number of fractional bits
			N_iterations		: positive := 3); -- number of newton's iterations
		
		port(
			x	: in std_logic_vector(W_bits-1 downto 0);
			y_0	: in std_logic_vector(W_bits-1 downto 0);
			y	: out std_logic_vector(W_bits-1 downto 0));
	end component;


	--Component ROM
	
	component ROM is 
		port(
			address	: in std_logic_vector(7 downto 0);
			clock	: in std_logic := '1';
			q	: out std_logic_vector(7 downto 0));
	end component;

	--Component Alpha Even

	component alpha_computation_even is
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16); -- number of newton's iterations
		
	port(	clock		: in std_logic;
		beta_even	: in signed(W_bits-1 downto 0);
		alpha_even	: out signed(W_bits-1 downto 0));	
	end component;

	--Component Alpha Odd

	component alpha_computation_odd is
	generic(
		W_bits		: positive := 32;
		F_bits		: positive := 16);
	port(	clock		: in std_logic;
		beta_odd	: in signed(W_bits-1 downto 0);
		alpha_odd	: out signed(W_bits-1 downto 0));
	end component;

	--Component x_alpha

	component x_alpha is
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16); -- number of newton's iterations
		
	port(	clock		: in std_logic;
		alpha		: in signed(W_bits-1 downto 0);
		x_alpha_in	: in unsigned(W_bits-1 downto 0);
		x_alpha_out	: out unsigned(W_bits-1 downto 0));
	end component;

	--Component x_beta

	component x_beta is
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16); -- number of newton's iterations
		
	port(	clock		: in std_logic;
		beta		: in signed(W_bits-1 downto 0);
		x_beta_in	: in unsigned(W_bits-1 downto 0);
		x_beta_out	: out unsigned(W_bits-1 downto 0));
	end component;

	--Component Beta Computation

	component beta_computation is
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16; -- number of fractional bits
		Z_bits			: positive);		-- leading zeros
		
	port(
		clock	: in std_logic;
		beta	: out integer);	
	end component;

	--Component IZC 

	component lzc is
	port (
        	clk        : in  std_logic;
        	lzc_vector : in  std_logic_vector (31 downto 0);
        	lzc_count  : out std_logic_vector ( 4 downto 0));
	end component;

	--Component Y guess, Beta Even
	
	component y_guess_even is
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16); -- number of newton's iterations
		
	port(	clock		: in std_logic;
		x_alpha_yn	: in std_logic_vector(W_bits-1 downto 0);
		x_beta_lookup	: in std_logic_vector(7 downto 0);
		y_even_out	: out std_logic_vector(W_bits-1 downto 0));
	end component;

	--Testbench signals
	constant W		: positive := 32;
	constant F		: positive := 16;
	signal Z 		: positive := 5;

	signal rom_address	: std_logic_vector(7 downto 0);
	signal rom_output	: std_logic_vector(7 downto 0);
	signal rom_output_resized : std_logic_vector(W-1 downto 0);



	file file_input		: text;
	file file_output	: text;

	signal in_number	: std_logic_vector(W-1 downto 0);
	signal out_number	: std_logic_vector(W-1 downto 0);
	signal out_alpha_number	: std_logic_vector(W-1 downto 0);
	signal out_beta_number	: std_logic_vector(W-1 downto 0);
	signal yn 		: std_logic_Vector(W-1 downto 0);
	signal yn_even_output	: std_logic_vector(W-1 downto 0);
	signal B_even		: signed(W-1 downto 0);
	signal A_even		: signed(W-1 downto 0);
	signal B_odd		: signed(W-1 downto 0);
	signal A_odd		: signed(W-1 downto 0);
	signal real_alpha	: signed(W-1 downto 0);
	signal clock		: std_logic := '0';
	constant clk_period	: time := 1 ns;	

	signal beta_int		: integer;
	signal beta_signed	: signed(W-1 downto 0);

	signal leading_zero	: std_logic_vector(4 downto 0);

    begin
------------------------------------------------------------------------------------------------------------
	rsqrt_1 : rsqrt
	generic map(
		W_bits => W,
		F_bits => F)
	port map(
		x => in_number,
		y_0 => "00000000000000100000000000000000",
		y => out_number);
------------------------------------------------------------------------------------------------------------
	rom1	: ROM 
		port map(
			address => rom_address,
			clock 	=> clock,
			q	=> rom_output);
------------------------------------------------------------------------------------------------------------
	alpha_even : alpha_computation_even 	
	generic map(
		W_bits => W,
		F_bits => F)
	port map(
		clock => clock,
		beta_even => B_even,
		alpha_even => A_even);
------------------------------------------------------------------------------------------------------------
	alpha_odd : alpha_computation_odd 	
	generic map(
		W_bits => W,
		F_bits => F)
	port map(
		clock => clock,
		beta_odd => B_odd,
		alpha_odd => A_odd);
------------------------------------------------------------------------------------------------------------
	x_alphfalfa : x_alpha
	generic map(
		W_bits => W,
		F_bits => F)
	port map(
		clock => clock,
		alpha => real_alpha,
		x_alpha_in => unsigned(in_number),
		std_logic_vector(x_alpha_out) => out_alpha_number);
------------------------------------------------------------------------------------------------------------
	x_betfalfa : x_beta
	generic map(
		W_bits => W,
		F_bits => F)
	port map(
		clock => clock,
		beta => beta_signed,
		x_beta_in => unsigned(in_number),
		std_logic_vector(x_beta_out) => out_beta_number);
------------------------------------------------------------------------------------------------------------	
	beta_comp : beta_computation
	generic map(
		W_bits => W,
		F_bits => F,
		Z_bits => Z)
	port map(
		clock => clock,
		beta => beta_int);
------------------------------------------------------------------------------------------------------------
	lzc1 : lzc
	port map(
		clk => clock,
		lzc_vector => in_number,
		lzc_count => leading_zero);
------------------------------------------------------------------------------------------------------------
	Y_G_E : y_guess_even
	generic map(
		W_bits => W,
		F_bits => F)
	port map(
		clock => clock,
		x_alpha_yn => std_logic_vector(out_alpha_number),
		x_beta_lookup => rom_output,
		y_even_out => yn_even_output);

------------------------------------------------------------------------------------------------------------
	clk_propro : process

	begin
	clock <= '0';
	wait for clk_period;
	clock <= '1';
	wait for clk_period;
	end process;
------------------------------------------------------------------------------------------------------------
	testtest : process(clock)

	begin
	if(rising_edge(clock)) then
		B_even<=x"00000002";
		B_odd <=x"00000005";
		beta_signed <= to_signed(beta_int,W);
		rom_address <= "00001111";
		real_alpha <= A_even;
		in_number <= x"000f000f";
		Z <= to_integer(unsigned(leading_zero));

	end if;
	end process;
------------------------------------------------------------------------------------------------------------	
--	process

--	variable in_line	: line;
--	variable out_line	: line;
--	variable in_num		: std_logic_vector(W-1 downto 0);
	
--	begin

--	file_open(file_input, "matlab_fixed_point.txt", read_mode);
--	file_open(file_output, "output_file.txt", write_mode);

	
--	while not endfile(file_input) loop

--	readline(file_input, in_line);
--	read(in_line, in_num);

--	in_number <= std_logic_vector(in_num);
	
--	wait for 50 ns;
	
--	write(out_line, out_number, right);
--	writeline(file_output, out_line);
--	end loop;

--	file_close(file_input);
--	file_close(file_output);
	
--	wait;
	
--	end process;

	
	

end architecture;