LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY counter IS
    PORT (
        active : IN STD_LOGIC;
        up : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        cars : in STD_LOGIC_VECTOR(9 DOWNTO 0);
        sum_cars : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
END counter;

ARCHITECTURE rtl OF counter IS
    COMPONENT adder10bit IS
        PORT (
            a : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            b : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            carry_in : IN STD_LOGIC;
            s : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
            carry_out : OUT STD_LOGIC);
    END COMPONENT;

    -- SIGNAL temp1_add : STD_LOGIC_VECTOR(9 DOWNTO 0) := ((OTHERS => '0'));
    -- SIGNAL temp1_sub : STD_LOGIC_VECTOR(9 DOWNTO 0) := ((OTHERS => '0'));
    SIGNAL temp2 : STD_LOGIC_VECTOR(9 DOWNTO 0) := ((OTHERS => '0'));
    SIGNAL carry_in : STD_LOGIC;
    SIGNAL carry_out : STD_LOGIC;
    SIGNAL carry_in_add : STD_LOGIC := '0';
    SIGNAL carry_in_sub : STD_LOGIC := '1';


    signal inc_val : std_logic_vector(9 downto 0) := "0000000001";
    signal dec_val : std_logic_vector(9 downto 0) := "1111111111";
BEGIN

    -- adder : adder10bit PORT MAP("0000000001", temp2, carry_in_add, temp1_add, carry_out);
    -- subtractor : adder10bit PORT MAP("0000000001", temp2, carry_in_sub, temp1_sub, carry_out);

    PROCESS (clk)
    BEGIN
        IF (clk'event AND clk = '1' AND active = '1') THEN
            -- IF (up = '1') THEN
            --     temp2 <= temp1_add;
            -- ELSE
            --     temp2 <= temp1_sub;
            -- END IF;

            IF up = '1' THEN
                temp2 <= STD_LOGIC_VECTOR(unsigned(cars) + unsigned(inc_val));
            ELSE
                temp2 <= STD_LOGIC_VECTOR(unsigned(cars) + unsigned(dec_val));
            END IF;
            -- temp2 <= temp1;
        END IF;
    END PROCESS;

    sum_cars <= temp2;
END rtl;