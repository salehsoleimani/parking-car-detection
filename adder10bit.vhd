library ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

ENTITY adder10bit IS
  PORT(
	a : in std_logic_vector(9 downto 0);
	b : in std_logic_vector(9 downto 0);
	carry_in: in std_logic;
	s: out std_logic_vector(9 downto 0);
	carry_out: out std_logic);
end adder10bit;

architecture rtl of adder10bit is
signal c: std_logic_vector(9 downto 1) := (others => '0');
	COMPONENT adder
	  PORT(
		 a : IN STD_LOGIC;
		 b : IN STD_LOGIC;
		 carry_in : IN STD_LOGIC;
		 sum : OUT STD_LOGIC;
		 carry_out : OUT STD_LOGIC
		 );
	END COMPONENT;
BEGIN
	bit0 : adder PORT MAP (a(0),b(0),carry_in,s(0),c(1));
	bit1 : adder PORT MAP (a(1),b(1),c(1),s(1),c(2));
	bit2 : adder PORT MAP (a(2),b(2),c(2),s(2),c(3));
	bit3 : adder PORT MAP (a(3),b(3),c(3),s(3),c(4));
	bit4 : adder PORT MAP (a(4),b(4),c(4),s(4),c(5));
	bit5 : adder PORT MAP (a(5),b(5),c(5),s(5),c(6));
	bit6 : adder PORT MAP (a(6),b(6),c(6),s(6),c(7));
	bit7 : adder PORT MAP (a(7),b(7),c(7),s(7),c(8));
	bit8 : adder PORT MAP (a(8),b(8),c(8),s(8),c(9));
    bit9 : adder PORT MAP (a(9),b(9),c(9),s(9),carry_out);
	
END rtl;
