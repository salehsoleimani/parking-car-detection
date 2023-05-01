LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux_2to1 IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        selector : IN STD_LOGIC;
        output : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
END ENTITY;

ARCHITECTURE behavior OF mux_2to1 IS
BEGIN
    output <= a WHEN selector = '0' ELSE
        b;
END ARCHITECTURE;