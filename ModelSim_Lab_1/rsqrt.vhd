library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_arith.all; 

entity rsqrt is 
	
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16; -- number of fractional bits
		N_iterations		: positive := 3); -- number of newton's iterations
		
	port(
		x	: in std_logic_vector(W_bits-1 downto 0);
		y	: out std_logic_vector(W_bits-1 downto 0));
		
end entity rsqrt;



architecture rsqrt_arch of rsqrt is

	signal arithimetric 	: std_logic_vector(31 downto 0);


	begin
	
	arithimetric <= x + 8;

	y <= arithimetric;

end architecture;

