library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity rsqrt is 
	
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16; -- number of fractional bits
		N_iterations		: positive := 3); -- number of newton's iterations
		
	port(
		x	: in std_logic_vector(W_bits-1 downto 0);
		y_0	: in std_logic_vector(W_bits-1 downto 0);
		y	: out std_logic_vector(W_bits-1 downto 0));
		
end entity rsqrt;

--0000 0000 0000 0000 . 0000 0000 0000 0000

architecture rsqrt_arch of rsqrt is

	signal arithimetric 		: signed(W_bits-1 downto 0);
	signal three			: signed(W_bits-1 downto 0); -- W - F - 00s, 2 1s,

	signal yn_squared		: signed(2*W_bits-1 downto 0);
	signal yn_squared_resized	: signed(W_bits-1 downto 0);

	signal x_yn_2			: signed(2*W_bits-1 downto 0);
	signal x_yn_2_resized		: signed(W_bits-1 downto 0);

	signal three_xyn_2		: signed(W_bits-1 downto 0);

	signal yn_3_xyn_2		: signed(2*W_bits-1 downto 0);
	signal yn_3_xyn_2_resized	: signed(W_bits-1 downto 0);
	signal yn_3_xyn_2_resized_shift	: signed(W_bits-1 downto 0);

	begin
	
	
	three <= "00000000000000110000000000000000";

	--		yn^2			--

	yn_squared <= signed(y_0) * signed(y_0);
	
	yn_squared_resized <= yn_squared(2*W_bits-1) & yn_squared(W_bits-2+F_bits downto F_bits);

	------------------------------------------

	--		x*yn^2			--

	
	x_yn_2 <= yn_squared_resized * signed(x);

	x_yn_2_resized <= x_yn_2(2*W_bits-1) & x_yn_2(W_bits-2+F_bits downto F_bits);

	------------------------------------------

	--		3-x*yn^2		--

	three_xyn_2 <= signed(three) - x_yn_2_resized;

	------------------------------------------
	
	--		yn(3-x*yn^2)		--

	yn_3_xyn_2 <= signed(y_0)*three_xyn_2;

	yn_3_xyn_2_resized <= yn_3_xyn_2(2*W_bits-1) & yn_3_xyn_2(W_bits-2+F_bits downto F_bits);
	
	------------------------------------------

	--		(yn(3-x*yn*2))/2	--

	yn_3_xyn_2_resized_shift <= shift_right(yn_3_xyn_2_resized,1);

	------------------------------------------


	y <= std_logic_vector(yn_3_xyn_2_resized_shift);

end architecture;

