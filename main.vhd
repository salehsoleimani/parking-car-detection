LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY main IS
    PORT (
        clk, reset, car_in, car_out, switch : IN STD_LOGIC
    );
END main;

ARCHITECTURE Behavioral OF main IS

    SIGNAL a_greater, b_greater, equal : STD_LOGIC;

    SIGNAL cars : STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS => '0');

    SIGNAL cars_incremented : STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS => '0');
    SIGNAL cars_decremented : STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS => '0');

    COMPONENT comparator IS
        PORT (
            a, b : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            equal, a_greater, b_greater : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT up_counter IS
        PORT (
            active : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            sum_cars : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT mux_2to1 IS
        PORT (
            a, b : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            selector : IN STD_LOGIC;
            output : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
    END COMPONENT;

    COMPONENT down_counter IS
        PORT (
            active : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            sum_cars : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
        );
    END COMPONENT;

    TYPE STATES IS (IDLE, DOWN_COUNT, UP_COUNT);
    SIGNAL current_state, next_state : STATES;

    SIGNAL down_counter_active, up_counter_active : STD_LOGIC;

BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF reset = '0' THEN
            current_state <= IDLE;
        ELSIF rising_edge(clk) THEN
            current_state <= next_state;
        END IF;
    END PROCESS;

    PROCESS (current_state, car_in, car_out, switch)
    BEGIN
        CASE current_state IS
            WHEN IDLE =>
                down_counter_active <= '0';
                up_counter_active <= '0';
                IF (switch = '1') THEN
                    IF (car_in = '1') THEN
                        next_state <= UP_COUNT;
                    END IF;
                    IF (car_out = '1') THEN
                        next_state <= DOWN_COUNT;
                    END IF;
                ELSE
                    next_state <= current_state;
                END IF;
            WHEN DOWN_COUNT =>
                down_counter_active <= '1';
                up_counter_active <= '0';
                next_state <= IDLE;
            WHEN UP_COUNT =>
                IF b_greater = '1' THEN
                    up_counter_active <= '1';
                    down_counter_active <= '0';
                END IF;
                next_state <= IDLE;
            WHEN OTHERS =>
        END CASE;
    END PROCESS;

    COUNT_DOWN : down_counter PORT MAP(
        active => down_counter_active,
        clk => clk,
        sum_cars => cars_decremented
    );

    COUNT_UP : up_counter PORT MAP(
        active => up_counter_active,
        clk => clk,
        sum_cars => cars_incremented
    );

    COMPARE : comparator PORT MAP(
        a => cars,
        b => "1000000000",
        equal => equal,
        a_greater => a_greater,
        b_greater => b_greater);

    MUX : mux_2to1 PORT MAP(
        a => cars_incremented,
        b => cars_decremented,
        selector => down_counter_active,
        output => cars
    );

END Behavioral;