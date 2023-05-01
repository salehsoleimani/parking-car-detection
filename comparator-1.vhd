LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity comparator is
    port (
        a, b: in std_logic_vector(9 downto 0);
        equal, a_greater, b_greater: out std_logic
    );
end comparator;

architecture Behavioral of comparator is
begin
    equal <= '1' when a = b else '0';
    a_greater <= '1' when unsigned(a) > unsigned(b) else '0';
    b_greater <= '1' when unsigned(a) < unsigned(b) else '0';
end Behavioral;