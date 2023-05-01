LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY down_counter IS
	PORT (
		active : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		not_reset : IN STD_LOGIC;
		car_in : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		sum_cars : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END down_counter;

ARCHITECTURE rtl OF down_counter IS
	COMPONENT adder10bit IS
		PORT (
			a : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			b : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			carry_in : IN STD_LOGIC;
			s : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
			carry_out : OUT STD_LOGIC);
	END COMPONENT;

	SIGNAL temp1 : STD_LOGIC_VECTOR(9 DOWNTO 0) := ((OTHERS => '0'));
	SIGNAL temp2 : STD_LOGIC_VECTOR(9 DOWNTO 0) := ((OTHERS => '0'));
	SIGNAL carry_in : STD_LOGIC;
	SIGNAL carry_out : STD_LOGIC;

BEGIN
	carry_in <= '1';

	adder : adder10bit PORT MAP("0000000001", temp2, carry_in, temp1, carry_out);

	PROCESS (clk)
	BEGIN
		IF (clk'event AND clk = '1' AND active = '1') THEN
			IF (not_reset = '0') THEN
				temp2 <= (OTHERS => '0');
			ELSE
				temp2 <= temp1;
			END IF;
		END IF;
	END PROCESS;

	sum_cars <= temp2;
END rtl;