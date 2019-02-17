library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity input_driver is 
    Port (
            clk             : in STD_LOGIC;
            reset           : in STD_LOGIC;

            x_input         : in STD_LOGIC;
            y_input         : in STD_LOGIC;
            z_input         : in STD_LOGIC;
            cordic_mode     : in STD_LOGIC;
            start_cordic    : in STD_LOGIC;

            keypad_row      : in STD_LOGIC_VECTOR (3 downto 0);
            keypad_col      : out STD_LOGIC_VECTOR (3 downto 0);

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

    type   state_type is (input, input_x, input_y, input_z, output);  
    signal state : state_type := input;  

begin

    x_debouncer: debouncer port map (clk, reset, x_input, x_input_debounced);
    y_debouncer: debouncer port map (clk, reset, y_input, y_input_debounced);
    z_debouncer: debouncer port map (clk, reset, z_input, z_input_debounced);

    mode_debouncer: debouncer port map (clk, reset, cordic_mode, cordic_mode_debounced);
    start_debouncer: debouncer port map (clk, reset, start_cordic, start_cordic_debounced);

    row0_debouncer: debouncer port map (clk, reset, keypad_row(0), keypad_row_debounced(0));
    row1_debouncer: debouncer port map (clk, reset, keypad_row(1), keypad_row_debounced(1));
    row2_debouncer: debouncer port map (clk, reset, keypad_row(2), keypad_row_debounced(2));
    row3_debouncer: debouncer port map (clk, reset, keypad_row(3), keypad_row_debounced(3));

    generate_row_debouncer: for i in 0 to 3 generate
        row_debouncer: debouncer port map (clk, reset, keypad_row(i), keypad_row_debounced(i));
    end generate generate_row_debouncer;

    decode: process (state) is
    begin
    end process;

    state_machine: process (state) is
    begin
    end process;

end behavioural;