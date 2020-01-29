library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity addition is
	port (	input	: in integer;
		out_put	: out integer);
end;

architecture addition_arch of addition is
	

	begin

	out_put <= input + 1;

end addition_arch;