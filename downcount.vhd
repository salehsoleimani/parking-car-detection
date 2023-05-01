LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY downcount IS
    PORT (
        active : IN STD_LOGIC;
        input_vector : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        output_vector : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
END downcount;

ARCHITECTURE behavioral OF downcount IS
    SIGNAL temp : unsigned(9 DOWNTO 0);

BEGIN

    PROCESS (input_vector)
    BEGIN
        IF (active = '1') THEN
            temp <= unsigned(input_vector) - 1;
        END IF;
        output_vector <= STD_LOGIC_VECTOR(temp);
    END PROCESS;

END behavioral;