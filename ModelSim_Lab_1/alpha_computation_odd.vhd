library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;


entity alpha_computation_odd is 
	
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16; -- number of fractional bits
		N_iterations	: positive := 3); -- number of newton's iterations
		
	port(
		x	: in std_logic_vector(W_bits-1 downto 0);
		y	: out std_logic_vector(W_bits-1 downto 0));
		
end entity alpha_computation_odd;



architecture alpha_odd_comp_arch of alpha_computation_odd is

	---- Beta Even, Alpha = -2B + .5B


	begin
	
	
end architecture;
