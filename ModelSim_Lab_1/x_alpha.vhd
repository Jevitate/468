library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;



entity x_alpha is 
	
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16); -- number of newton's iterations
		
	port(	clock		: in std_logic;
		alpha		: in signed(W_bits-1 downto 0);
		x_alpha_in	: in unsigned(W_bits-1 downto 0);
		x_alpha_out	: out unsigned(W_bits-1 downto 0));
		
end entity x_alpha;
 	

architecture x_alpha_arch of x_alpha is

	-- x alpha = x2^alpha


	begin
	

	process(clock)

	begin
		if(rising_edge(clock)) then

		x_alpha_out <= shift_left(x_alpha_in,to_integer(alpha));
		
		end if;

	end process;
	
end architecture;
