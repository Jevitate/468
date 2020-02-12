library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity beta_computation is 
	
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16); -- leading zeros
		
	port(	Z_bits	: in integer;
		clock	: in std_logic;
		beta	: out integer);				
		
end entity beta_computation;



architecture beta_comp_arch of beta_computation is

	-- beta = W - F - Z - 1
	signal W_bit		: positive;
	signal F_bit		: positive;
	signal Z_bit		: natural := 1;

	begin
	
	W_bit <= W_bits;
	F_bit <= F_bits;
	Z_bit <= Z_bits;

	Process(clock,Z_bit)

	begin
	
		if(rising_edge(clock)) then
			beta <= W_bit - F_bit - Z_bit - 1;
		end if;
	
	end process;

end architecture;
