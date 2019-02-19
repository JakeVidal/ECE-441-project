-- CORDIC input cotroller
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

    signal decode_value : STD_LOGIC_VECTOR (3 downto 0)

    type   state_type is (input, input_x, input_y, input_z, output);  
    signal state : state_type := input;  

begin

    x_debouncer: debouncer port map (clk, reset, x_input, x_input_debounced);
    y_debouncer: debouncer port map (clk, reset, y_input, y_input_debounced);
    z_debouncer: debouncer port map (clk, reset, z_input, z_input_debounced);

    mode_debouncer: debouncer port map (clk, reset, cordic_mode, cordic_mode_debounced);
    start_debouncer: debouncer port map (clk, reset, start_cordic, start_cordic_debounced);

    generate_row_debouncer: for i in 0 to 3 generate
        row_debouncer: debouncer port map (clk, reset, keypad_row(i), keypad_row_debounced(i));
    end generate generate_row_debouncer;

    decode: process (state, reset) is
    begin

        keypad_col <= "0111";
        if keypad_row = "0111" then
            decode_value <= "0001"; --1
        elsif keypad_row = "1011" then
            decode_value <= "0100"; --4
        elsif keypad_row = "1101" then
            decode_value <= "0111"; --7
        elsif keypad_row = "1110" then
            decode_value <= "0000"; --0
        end if;

        keypad_col <= "1011";
        if keypad_row = "0111" then        
            decode_value <= "0010"; --2
        elsif keypad_row = "1011" then
            decode_value <= "0101"; --5
        elsif keypad_row = "1101" then
            decode_value <= "1000"; --8
        elsif keypad_row = "1110" then
            decode_value <= "1111"; --F
        end if;

        keypad_col <= "1101";
        if keypad_row = "0111" then
            decode_value <= "0011"; --3    
        elsif keypad_row = "1011" then
            decode_value <= "0110"; --6
        elsif keypad_row = "1101" then
            decode_value <= "1001"; --9
        elsif keypad_row = "1110" then
            decode_value <= "1110"; --E
        end if;

        keypad_col <= "1110";
        if keypad_row = "0111" then
            decode_value <= "1010"; --A
        elsif keypad_row = "1011" then
            decode_value <= "1011"; --B
        elsif keypad_row = "1101" then
            decode_value <= "1100"; --C
        elsif keypad_row = "1110" then
            decode_value <= "1101"; --D
        end if;

    end process decode;

    state_machine: process (state, reset) is
    begin
    end process state_machine;

end behavioural;