library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;


entity beta_computation is 
	
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16; -- number of fractional bits
		Z_bits			: positive);		-- leading zeros
		
	port(

		beta	: out integer);				
		
end entity beta_computation;



architecture beta_comp_arch of beta_computation is

	----Beta = W - F - Z - 1
	
	

	begin
	
	
	--beta <= W - F - Z - 1;
	
	
end architecture;
