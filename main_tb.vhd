LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY main_tb IS
END main_tb;
ARCHITECTURE behavior OF main_tb IS
    COMPONENT main
        PORT (
            clk, reset, car_in, car_out, switch : IN STD_LOGIC
        );
    END COMPONENT;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '1';
    SIGNAL car_in : STD_LOGIC := '0';
    SIGNAL car_out : STD_LOGIC := '0';
    SIGNAL switch : STD_LOGIC := '0';
    CONSTANT clk_period : TIME := 10 ns;

BEGIN
    uut : main PORT MAP(
        clk => clk,
        reset => reset,
        car_in => car_in,
        car_out => car_out,
        switch => switch
    );

    reset <= '1';
    switch <= '1';
    clk <= NOT(clk) AFTER clk_period/2;
    car_in <= '0',
        '1' AFTER 60 ns, '0' AFTER 70 ns
        , '1' AFTER 80 ns, '0' AFTER 90 ns
        , '1' AFTER 100 ns, '0' AFTER 110 ns;
    -- car_out <= '0',
    --     '1' AFTER 110 ns, '0' AFTER 120 ns;
END;