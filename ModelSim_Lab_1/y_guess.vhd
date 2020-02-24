library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

--kathrynn dawn price aka kevin durant aka katie price porn star

entity y_guess is 
	
	generic(
		W_bits			: positive := 32; -- size of word
		F_bits			: positive := 16); -- number of newton's iterations
		
	port(	clock		: in std_logic;
		beta		: in unsigned(W_bits-1 downto 0);
		x_alpha_yn	: in std_logic_vector(W_bits-1 downto 0);
		x_beta_lookup	: in std_logic_vector(7 downto 0);
		y_out	: out std_logic_vector(W_bits-1 downto 0));
		
end entity;
 	

architecture y_guess_arch of y_guess is

	-- yn = Xalpha(Xbeta)^(-3/2)(0.70710678) < ODD   	-- yn = Xalpha(Xbeta)^(-3/2)
 
	
	signal XalphBeta		: std_logic_vector(W_bits+7 downto 0);
	signal XalphBeta_resized	: std_logic_vector(W_bits-1 downto 0);

	signal root_2			: std_logic_vector(W_bits-1 downto 0) := "00000000000000001011010100000100";
	signal root_2_unsized		: std_logic_vector(2*W_bits-1 downto 0);
	signal root_2_sized		: std_logic_vector(W_bits-1 downto 0);

	signal even_odd			: std_logic := '0';

	--constant root_2_under_one	: unsigned := "00000000000000001011010100000100";

	begin
-----------------------------------------------------------------------------------------------------------
	-- First step

	process(clock)

	begin
		if(rising_edge(clock)) then
			XalphBeta <= x_alpha_yn * x_beta_lookup;
			XalphBeta_resized <= XalphBeta(W_bits-1+7 downto 7);

			root_2_unsized <= XalphBeta_resized * root_2;
			root_2_sized <= root_2_unsized(W_bits-1+F_bits downto F_bits);

		end if;


	end process;
------------------------------------------------------------------------------------------------------------
	-- Even or Odd

	process(clock)

	begin

		if(rising_edge(clock)) then
			if(beta(0) = '1') then -- '1' is odd, '0' is even
				even_odd <= '1';
			elsif(beta(0) = '0') then
				even_odd <= '0';
			end if;		
		
		end if;

	end process;
------------------------------------------------------------------------------------------------------------

	process(clock,even_odd)

	begin
		if(rising_edge(clock)) then
			if(even_odd = '0') then -- EVEN	
				y_out <= XalphBeta_resized;
			else			 -- ODD
				y_out <= root_2_sized;
			end if;
		end if;
	end process;



------------------------------------------------------------------------------------------------------------
--	process(clock)
--
--	begin
--		if(rising_edge(clock)) then

		--root_2 <= std_logic_vector(root_2_under_one);
		
--		XalphBeta <= x_alpha_yn * x_beta_lookup;
--		XalphBeta_resized <= XalphBeta(W_bits-1+7 downto 7);
--
--		root_2_unsized <= XalphBeta_resized * root_2;
--		root_2_sized <= root_2_unsized(W_bits-1+F_bits downto F_bits);
--
--		y_odd_out <= root_2_sized;
		
--		end if;

--	end process;
------------------------------------------------------------------------------------------------------------	
	-- yn = Xalpha(Xbeta)^(-3/2)  
	
--	signal XalphBeta		: std_logic_vector(W_bits+7 downto 0);
--	signal XalphBeta_resized	: std_logic_vector(W_bits-1 downto 0);

--	begin
	

--	process(clock)

--	begin
--		if(rising_edge(clock)) then

--		XalphBeta <= x_alpha_yn * x_beta_lookup;
--		XalphBeta_resized <= XalphBeta(W_bits-1+7 downto 7);
--		y_even_out <= XalphBeta_resized;

--		end if;

--	end process;
end architecture;
	
