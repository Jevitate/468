library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;



entity x_alpha is 
	
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16); -- number of newton's iterations
		
	port(	clock		: in std_logic;
		alpha		: in unsigned(W_bits-1 downto 0);
		x_alpha_in	: in unsigned(W_bits-1 downto 0);
		x_alpha_out	: out unsigned(W_bits-1 downto 0));
		
end entity x_alpha;
 	

architecture x_alpha_arch of x_alpha is

	-- x alpha = x2^alpha

	signal delay1	: unsigned(W_bits-1 downto 0);
	signal delay2	: unsigned(W_bits-1 downto 0);
	signal delay3	: unsigned(W_bits-1 downto 0);
	signal delay4	: unsigned(W_bits-1 downto 0);
	signal delay5	: unsigned(W_bits-1 downto 0);
	signal delay6	: unsigned(W_bits-1 downto 0);
	signal alpha_del: unsigned(W_bits-1 downto 0);

	begin
	

	process(clock)

	begin
		if(rising_edge(clock)) then
		delay1 <= x_alpha_in;
		delay2 <= delay1;
		delay3 <= delay2;
		delay4 <= delay3;
		delay5 <= delay4;
		delay6 <= delay5;
		alpha_del <= shift_left(delay6,to_integer(alpha));
		x_alpha_out <= alpha_del;
		
		end if;

	end process;
	
end architecture;
