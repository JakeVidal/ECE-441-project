-- CORDIC input controller
-- Written by Jake Vidal

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity input_driver is 
    Port (
            clk                       : in STD_LOGIC;
            reset                     : in STD_LOGIC;

            x_input                   : in STD_LOGIC;
            y_input                   : in STD_LOGIC;
            z_input                   : in STD_LOGIC;
            cordic_mode               : in STD_LOGIC;
            start_cordic              : in STD_LOGIC;

            keypad_row                : in STD_LOGIC_VECTOR (3 downto 0);
            keypad_col                : out STD_LOGIC_VECTOR (3 downto 0);

            initial_x                 : out STD_LOGIC_VECTOR (15 downto 0);
            initial_y                 : out STD_LOGIC_VECTOR (15 downto 0);
            initial_z                 : out STD_LOGIC_VECTOR (15 downto 0);
            cordic_mode_debounced     : out STD_LOGIC;
            start_cordic_debounced    : out STD_LOGIC
    );
end input_driver;

architecture behavioural of input_driver is

    component debouncer is 
        Port ( 
            clk_100MHz    : in  STD_LOGIC;
            reset         : in  STD_LOGIC;
            PB_in         : in STD_LOGIC;
            PB_out        : out STD_LOGIC    
        );
    end component;

    signal x_input_debounced, y_input_debounced, z_input_debounced : STD_LOGIC;
    signal cordic_mode_debounced, start_cordic_debounced : STD_LOGIC;
    signal keypad_row_debounced : STD_LOGIC_VECTOR (3 downto 0);
    signal x_input_done, y_input_done, z_input_done : STD_LOGIC := "0";

    type   state_type is (mode_input, mode_input_x, mode_input_y, mode_input_z, mode_output);  
    signal state : state_type := mode_input;  

begin

    x_debouncer: debouncer port map (clk, reset, x_input, x_input_debounced);
    y_debouncer: debouncer port map (clk, reset, y_input, y_input_debounced);
    z_debouncer: debouncer port map (clk, reset, z_input, z_input_debounced);

    mode_debouncer: debouncer port map (clk, reset, cordic_mode, cordic_mode_debounced);
    start_debouncer: debouncer port map (clk, reset, start_cordic, start_cordic_debounced);

    generate_row_debouncer: for i in 0 to 3 generate
        row_debouncer: debouncer port map (clk, reset, keypad_row(i), keypad_row_debounced(i));
    end generate generate_row_debouncer;

    state_machine: process (clk, state, reset) is
    begin

        if rising_edge(reset) then
            state := mode_input;

        elsif rising_edge(clk) then
            case state is
                when (mode_input AND x_input) => state := mode_input_x;
                when (mode_input AND y_input) => state := mode_input_y; 
                when (mode_input AND z_input) => state := mode_input_z;  
                when (mode_input_x AND NOT x_input) => state := mode_input;
                when (mode_input_y AND NOT y_input) => state := mode_input; 
                when (mode_input_z AND NOT z_input) => state := mode_input;   
                when (mode_input AND x_input_done AND y_input_done AND z_input_done) => state := mode_output; 
            end case;

        end if;

    end process;

    decode: process (clk, state, reset) is

        signal decode_value : STD_LOGIC_VECTOR (3 downto 0)
        signal x_iteration, y_iteration, z_iteration : STD_LOGIC_VECTOR (1 downto 0);
    
    begin

        if rising_edge(reset) OR (state = mode_input) then
            x_iteration <= "00";
            y_iteration <= "00";
            z_iteration <= "00";
        
        elsif rising_edge(clk) then
            keypad_col <= "0111";
            if keypad_row_debounced = "0111" then
                decode_value <= "0001"; --1
            elsif keypad_row_debounced = "1011" then
                decode_value <= "0100"; --4
            elsif keypad_row_debounced = "1101" then
                decode_value <= "0111"; --7
            elsif keypad_row_debounced = "1110" then
                decode_value <= "0000"; --0
            end if;

            keypad_col <= "1011";
            if keypad_row_debounced = "0111" then        
                decode_value <= "0010"; --2
            elsif keypad_row_debounced = "1011" then
                decode_value <= "0101"; --5
            elsif keypad_row_debounced = "1101" then
                decode_value <= "1000"; --8
            elsif keypad_row_debounced = "1110" then
                decode_value <= "1111"; --F
            end if;

            keypad_col <= "1101";
            if keypad_row_debounced = "0111" then
                decode_value <= "0011"; --3    
            elsif keypad_row_debounced = "1011" then
                decode_value <= "0110"; --6
            elsif keypad_row_debounced = "1101" then
                decode_value <= "1001"; --9
            elsif keypad_row_debounced = "1110" then
                decode_value <= "1110"; --E
            end if;

            keypad_col <= "1110";
            if keypad_row_debounced = "0111" then
                decode_value <= "1010"; --A
            elsif keypad_row_debounced = "1011" then
                decode_value <= "1011"; --B
            elsif keypad_row_debounced = "1101" then
                decode_value <= "1100"; --C
            elsif keypad_row_debounced = "1110" then
                decode_value <= "1101"; --D
            end if;

            if (state = mode_input_x) then
                if x_iteration = "00"
                    initial_x(15 downto 12) <= decode_value;
                    x_iteration = x_iteration + "1"
                elif x_iteration = "01"
                    initial_x(11 downto 8) <= decode_value;
                    x_iteration = x_iteration + "1"
                elif x_iteration = "10"
                    initial_x(7 downto 4) <= decode_value;
                    x_iteration = x_iteration + "1"
                elif x_iteration = "11"
                    initial_x(3 downto 0) <= decode_value;
                    x_iteration <= "00"
                    x_done <= "1"
                end if;

            elsif (state = mode_input_y) then
                if y_iteration = "00"
                    initial_y(15 downto 12) <= decode_value;
                    y_iteration = y_iteration + "1"
                elif y_iteration = "01"
                    initial_y(11 downto 8) <= decode_value;
                    y_iteration = y_iteration + "1"
                elif y_iteration = "10"
                    initial_y(7 downto 4) <= decode_value;
                    y_iteration = y_iteration + "1"
                elif y_iteration = "11"
                    initial_y(3 downto 0) <= decode_value;
                    y_iteration <= "00"
                    y_done <= "1"
                end if;

            elsif (state = mode_input_z) then
                if z_iteration = "00"
                    initial_z(15 downto 12) <= decode_value;
                    z_iteration = z_iteration + "1"
                elif z_iteration = "01"
                    initial_z(11 downto 8) <= decode_value;
                    z_iteration = z_iteration + "1"
                elif z_iteration = "10"
                    initial_z(7 downto 4) <= decode_value;
                    z_iteration = z_iteration + "1"
                elif z_iteration = "11"
                    initial_z(3 downto 0) <= decode_value;
                    z_iteration <= "00"
                    z_done <= "1"
                end if;

            end if;

        end if;

    end process;

    output: process (clk, state, reset) is
    begin
        if state = output then
            
        end if;
    end process;

end behavioural;