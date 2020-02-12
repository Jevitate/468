library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;



entity y_guess_even is 
	
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16); -- number of newton's iterations
		
	port(	clock		: in std_logic;
		x_alpha_yn	: in std_logic_vector(W_bits-1 downto 0);
		x_beta_lookup	: in std_logic_vector(7 downto 0);
		y_even_out	: out std_logic_vector(W_bits-1 downto 0));
		
end entity;
 	

architecture y_guess_even_arch of y_guess_even is

	-- yn = Xalpha(Xbeta)^(-3/2)
	
	signal XalphBeta		: std_logic_vector(W_bits+7 downto 0);
	signal XalphBeta_resized	: std_logic_vector(W_bits-1 downto 0);

	begin
	

	process(clock)

	begin
		if(rising_edge(clock)) then

		XalphBeta <= x_alpha_yn * x_beta_lookup;
		XalphBeta_resized <= XalphBeta(W_bits-1+8 downto 8);
		y_even_out <= XalphBeta_resized;

		end if;

	end process;
	
end architecture;
