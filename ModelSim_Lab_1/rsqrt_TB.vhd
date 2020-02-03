library IEEe;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
use STD.textio.all;
use ieee.std_logic_textio.all;
use ieee.fixed_pkg.all;
use ieee.float_pkg.all;

entity rsqrt_TB is
end entity;

architecture rsqrt_arch of rsqrt_TB is
	

	--Component rsqrt
	
	component rsqrt is
		generic(
			W_bits			: positive := 32; -- size of word
			F_bits			: positive := 16; -- number of fractional bits
			N_iterations		: positive := 3); -- number of newton's iterations
		
		port(
			x	: in std_logic_vector(W_bits-1 downto 0);
			y	: out std_logic_vector(W_bits-1 downto 0));
	end component;

	--Testbench signals

	file file_input		: text;
	file file_output	: text;

	signal in_number	: std_logic_vector(31 downto 0);
	signal out_number	: std_logic_vector(31 downto 0);

    begin
	
	rsqrt_1 : rsqrt
	generic map(
		W_bits => 32,
		F_bits => 16)
	port map(
		x => in_number,
		y => out_number);


	process

	variable in_line	: line;
	variable out_line	: line;
	variable in_num		: std_logic_vector(31 downto 0);

	
	begin

	file_open(file_input, "matlab_fixed_point.txt", read_mode);
	file_open(file_output, "output_file.txt", write_mode);

	
	while not endfile(file_input) loop

	readline(file_input, in_line);
	read(in_line, in_num);

	in_number <= std_logic_vector(in_num);
	
	wait for 50 ns;
	
	

	write(out_line, out_number, right);
	writeline(file_output, out_line);
	end loop;

	file_close(file_input);
	file_close(file_output);
	
	wait;
	
	end process;

	

end architecture;