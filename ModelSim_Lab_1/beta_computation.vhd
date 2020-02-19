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
	signal Z_bit		: integer;

	signal delay1	: integer;
	signal delay2	: integer;
	signal delay3	: integer;

	begin
	
	--W_bit <= W_bits;
	--F_bit <= F_bits;
	--Z_bit <= Z_bits;

	Process(clock,Z_bit)

	begin
	
		if(rising_edge(clock)) then
			delay1 <= 0;--W_bits - F_bits - 1;
			delay2 <= delay1;
			--delay3 <= delay2;
			beta <= W_bits - F_bits - Z_bits -1;
		end if;
	
	end process;

end architecture;
