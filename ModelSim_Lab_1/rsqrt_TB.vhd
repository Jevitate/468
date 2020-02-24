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
			clock	: in std_logic;
			x	: in std_logic_vector(W_bits-1 downto 0);
			y_0	: in std_logic_vector(W_bits-1 downto 0);
			y	: out std_logic_vector(W_bits-1 downto 0));
	end component;
------------------------------------------------------------------------------------------------------------
	--Component ROM
	
	component ROM is 
		port(
			address	: in std_logic_vector(7 downto 0);
			clock	: in std_logic := '1';
			q	: out std_logic_vector(7 downto 0));
	end component;
------------------------------------------------------------------------------------------------------------
	-- Component Alpha Computation

	component alpha_computation is
	generic(
		W_bits		: positive := 32;
		F_bits		: positive := 16);
	port(
		clock	: in std_logic;
		beta	: in unsigned(W_bits-1 downto 0);
		alpha	: out unsigned(W_bits-1 downto 0));
	end component;
------------------------------------------------------------------------------------------------------------
	--Component x_alpha

	component x_alpha is
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16); -- number of newton's iterations
		
	port(	clock		: in std_logic;
		alpha		: in unsigned(W_bits-1 downto 0);
		x_alpha_in	: in unsigned(W_bits-1 downto 0);
		x_alpha_out	: out unsigned(W_bits-1 downto 0));
	end component;
------------------------------------------------------------------------------------------------------------
	--Component x_beta

	component x_beta is
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16); -- number of newton's iterations
		
	port(	clock		: in std_logic;
		beta		: in unsigned(W_bits-1 downto 0);
		x_beta_in	: in unsigned(W_bits-1 downto 0);
		x_beta_out	: out unsigned(W_bits-1 downto 0));
	end component;
------------------------------------------------------------------------------------------------------------
	--Component Beta Computation

	component beta_computation is
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16);		-- leading zeros
		
	port(	Z_bits	: in natural;
		clock	: in std_logic;
		beta	: out integer);	
	end component;
------------------------------------------------------------------------------------------------------------
	--Component IZC 

	component lzc is
	port (
        	clk        : in  std_logic;
        	lzc_vector : in  std_logic_vector (31 downto 0);
        	lzc_count  : out std_logic_vector ( 4 downto 0));
	end component;
------------------------------------------------------------------------------------------------------------
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

	--Component Y guess, Beta Odd

	component y_guess_odd is
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16); -- number of newton's iterations
		
	port(	clock		: in std_logic;
		x_alpha_yn	: in std_logic_vector(W_bits-1 downto 0);
		x_beta_lookup	: in std_logic_vector(7 downto 0);
		y_odd_out	: out std_logic_vector(W_bits-1 downto 0));
	end component;
------------------------------------------------------------------------------------------------------------
	--Component Y guess

	component y_guess is
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16); -- number of newton's iterations
		
	port(	clock		: in std_logic;
		beta		: in unsigned(W_bits-1 downto 0);
		x_alpha_yn	: in std_logic_vector(W_bits-1 downto 0);
		x_beta_lookup	: in std_logic_vector(7 downto 0);
		y_out	: out std_logic_vector(W_bits-1 downto 0));
	end component;
------------------------------------------------------------------------------------------------------------
	--Testbench signals
	signal W		: positive := 32;
	signal F		: positive := 16;
	signal Z 		: natural;

	signal rom_address	: std_logic_vector(7 downto 0);
	signal rom_output	: std_logic_vector(7 downto 0);

	file file_input		: text;
	file file_output	: text;

	signal in_number	: std_logic_vector(W-1 downto 0);
	signal out_number	: std_logic_vector(W-1 downto 0);

	signal out_alpha_number	: std_logic_vector(W-1 downto 0);
	signal out_beta_number	: std_logic_vector(W-1 downto 0);

	signal yn_guess_output	: std_logic_vector(W-1 downto 0);	

	signal clock		: std_logic := '0';
	constant clk_period	: time := 1 ns;	

	signal beta_int		: integer := 0;
	signal beta_unsigned	: unsigned(W-1 downto 0);

	signal leading_zero	: std_logic_vector(4 downto 0);
	signal real_alpha	: unsigned(W-1 downto 0);

    begin
------------------------------------------------------------------------------------------------------------
	rsqrt_1 : rsqrt
	generic map(
		W_bits => W,
		F_bits => F)
	port map(
		clock => clock,
		x => in_number,
		y_0 => yn_guess_output,
		y => out_number);
------------------------------------------------------------------------------------------------------------
	rom1	: ROM 
	port map(
		address => rom_address,
		clock 	=> clock,
		q	=> rom_output);
------------------------------------------------------------------------------------------------------------
	alpha_comp : alpha_computation
	generic map(
		W_bits => W,
		F_bits => F)
	port map(
		clock => clock,
		beta => beta_unsigned,
		alpha => real_alpha);
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
		beta => beta_unsigned,
		x_beta_in => unsigned(in_number),
		std_logic_vector(x_beta_out) => out_beta_number);
------------------------------------------------------------------------------------------------------------	
	beta_comp : beta_computation
	generic map(
		W_bits => W,
		F_bits => F)
	port map(
		Z_bits => Z,
		clock => clock,
		beta => beta_int);
------------------------------------------------------------------------------------------------------------
	lzc1 : lzc
	port map(
		clk => clock,
		lzc_vector => in_number,
		lzc_count => leading_zero);
------------------------------------------------------------------------------------------------------------
	Y_G : y_guess
	generic map(
		W_bits => W,
		F_bits => F)
	port map(
		clock => clock,
		beta => beta_unsigned,
		x_alpha_yn => out_alpha_number,
		x_beta_lookup => rom_output,
		y_out => yn_guess_output);
------------------------------------------------------------------------------------------------------------
	clk_propro : process

	begin
	clock <= '0';
	wait for clk_period;
	clock <= '1';
	wait for clk_period;
	end process;
------------------------------------------------------------------------------------------------------------
	step1 : process(clock)

	begin

	if(rising_edge(clock)) then
		beta_unsigned <= to_unsigned(beta_int,W);
	end if;
	end process;
------------------------------------------------------------------------------------------------------------
	step4 : process(clock)

	begin

	if(rising_edge(clock)) then
		rom_address <= out_beta_number(15 downto 8);
	end if;
	end process;
------------------------------------------------------------------------------------------------------------
	step2	: process(clock)

	begin
	
	if(rising_edge(clock)) then
		Z <= to_integer(unsigned("0" & leading_zero));
	end if;
	end process;
------------------------------------------------------------------------------------------------------------	
	process

	variable in_line	: line;
	variable out_line	: line;
	variable in_num		: std_logic_vector(W-1 downto 0);
	
	begin

	file_open(file_input, "matlab_fixed_point.txt", read_mode);

	while (not endfile(file_input)) loop

	readline(file_input, in_line);
	read(in_line, in_num);

	wait for 1 ns;
	in_number <= std_logic_vector(in_num);
	wait for 1 ns;

	end loop;
	
	file_close(file_input);
	

	wait;	
	end process;
------------------------------------------------------------------------------------------------------------	

	process(out_number)
	
	variable out_line	: line;

	begin

	file_open(file_output, "output_file.txt", write_mode);

	write(out_line, out_number, right);
	writeline(file_output, out_line);

	end process;


end architecture;