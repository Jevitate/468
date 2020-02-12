library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;


entity alpha_computation_odd is 
	
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16); -- number of newton's iterations
		
	port(	clock		: in std_logic;
		beta_odd	: in signed(W_bits-1 downto 0);
		alpha_odd	: out signed(W_bits-1 downto 0));
		
end entity alpha_computation_odd;



architecture alpha_odd_comp_arch of alpha_computation_odd is

	---- Beta Even, Alpha = -2B + .5B + .5


	signal beta_one		: signed(W_bits-1 downto 0);
	signal beta_two		: signed(W_bits-1 downto 0);

	begin
	

	process(clock)

	begin
		if(rising_edge(clock)) then
		
		beta_one <= beta_odd;
		beta_two <= beta_odd;

		beta_one <= shift_left(beta_odd,1);

		beta_two <= shift_right(beta_odd,1);
		
		alpha_odd <= beta_two - beta_one + 1;
		
		end if;

	end process;
	
end architecture;
