library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;



entity x_beta is 
	
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16); -- number of newton's iterations
		
	port(	clock		: in std_logic;
		beta		: in unsigned(W_bits-1 downto 0);
		x_beta_in	: in unsigned(W_bits-1 downto 0);
		x_beta_out	: out unsigned(W_bits-1 downto 0));
		
end entity;
 	

architecture x_beta_arch of x_beta is

	-- x beta = x2^-Beta
	
	signal delay1	: unsigned(W_bits-1 downto 0);
	signal delay2	: unsigned(W_bits-1 downto 0);
	signal delay3	: unsigned(W_bits-1 downto 0);
	signal delay4	: unsigned(W_bits-1 downto 0);

	begin
	

	process(clock)

	begin
		if(rising_edge(clock)) then
		delay1 <= x_beta_in;
		delay2 <= delay1;
		delay3 <= delay2;
		delay4 <= delay3;
		x_beta_out <= shift_right(delay4,to_integer(beta));
		end if;

	end process;
	
end architecture;
