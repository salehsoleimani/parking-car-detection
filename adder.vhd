LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

ENTITY adder IS
  PORT(
    a : IN STD_LOGIC;
    b : IN STD_LOGIC;
    carry_in : IN STD_LOGIC;
    sum : OUT STD_LOGIC;
    carry_out : OUT STD_LOGIC);
END adder;

ARCHITECTURE model OF adder IS
BEGIN
 sum <= a XOR b XOR carry_in;
 carry_out <= (a AND b) OR (carry_in AND (a XOR b));
END model;
