library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity rsqrt is 
	
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16; -- number of fractional bits
		N_iterations		: positive := 3); -- number of newton's iterations
		
	port(	clock	: in std_logic;
		x	: in std_logic_vector(W_bits-1 downto 0);
		y_0	: in std_logic_vector(W_bits-1 downto 0);
		test	: out std_logic_vector(W_bits-1 downto 0);
		big	: out std_logic_vector(2*W_bits-1 downto 0);
		y	: out std_logic_vector(W_bits-1 downto 0));
		
end entity rsqrt;

--0000 0000 0000 0000 . 0000 0000 0000 0000

architecture rsqrt_arch of rsqrt is

	signal arithimetric 		: unsigned(W_bits-1 downto 0);
	signal three			: unsigned(W_bits-1 downto 0); -- W - F - 00s, 2 1s,

	signal yn_squared		: unsigned(2*W_bits-1 downto 0);
	signal yn_squared_resized	: unsigned(W_bits-1 downto 0);

	signal x_yn_2			: unsigned(2*W_bits-1 downto 0);
	signal x_yn_2_resized		: unsigned(W_bits-1 downto 0);

	signal three_xyn_2		: unsigned(W_bits-1 downto 0);

	signal yn_3_xyn_2		: unsigned(2*W_bits-1 downto 0);
	signal yn_3_xyn_2_resized	: unsigned(W_bits-1 downto 0);
	signal yn_3_xyn_2_resized_shift	: unsigned(W_bits-1 downto 0);


	begin
	
	process(clock)

	begin


	three <= "00000000000000110000000000000000";

	if(rising_edge(clock)) then
	--		yn^2			--

	yn_squared <= unsigned(y_0) * unsigned(y_0);
	
	yn_squared_resized <= yn_squared(W_bits-1+F_bits downto F_bits);
	big <= std_logic_Vector(yn_squared);
	test <= std_logic_vector(yn_squared_resized);

	------------------------------------------

	--		x*yn^2			--

	
	x_yn_2 <= yn_squared_resized * unsigned(x);

	x_yn_2_resized <= x_yn_2(W_bits-1+F_bits downto F_bits);

	--test <= x_yn_resized;

	------------------------------------------

	--		3-x*yn^2		--

	three_xyn_2 <= unsigned(three) - x_yn_2_resized;

	--test <= three_xyn_2;

	------------------------------------------
	
	--		yn(3-x*yn^2)		--

	yn_3_xyn_2 <= unsigned(y_0)*three_xyn_2;

	yn_3_xyn_2_resized <= yn_3_xyn_2(W_bits-1+F_bits downto F_bits);
	
	--test <= yn_3_xyn_2_resized;

	------------------------------------------

	--		(yn(3-x*yn*2))/2	--

	yn_3_xyn_2_resized_shift <= shift_right(yn_3_xyn_2_resized,1);

	------------------------------------------


	y <= std_logic_vector(yn_3_xyn_2_resized_shift);
	end if;	
	end process;
end architecture;

