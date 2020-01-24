library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;


entity beta_computation is 
	
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16; -- number of fractional bits
		N_iterations	: positive := 3); -- number of newton's iterations
		
	port(
		x	: in std_logic_vector(W_bits-1 downto 0);
		y	: out std_logic_vector(W_bits-1 downto 0));
		
end entity beta_computation;



architecture beta_comp_arch of beta_computation is

	begin
	
	
end architecture;
