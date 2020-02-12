library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity beta_computation is 
	
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16; -- number of fractional bits
		Z_bits			: positive := 5);		-- leading zeros
		
	port(
		clock	: in std_logic;
		beta	: out integer);				
		
end entity beta_computation;



architecture beta_comp_arch of beta_computation is

	-- beta = W - F - Z - 1

	begin

	Process(clock)

	begin
	
		if(rising_edge(clock)) then
			beta <= W_bits - F_bits - Z_bits - 1;
		end if;
	
	end process;

end architecture;
