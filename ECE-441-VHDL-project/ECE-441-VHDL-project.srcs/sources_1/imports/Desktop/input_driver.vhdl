---- CORDIC input controller
---- Written by Jake Vidal

--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

--entity input_driver is 
--    Port (
--            clk                       : in STD_LOGIC;
--            reset                     : in STD_LOGIC;
--            x_input                   : in STD_LOGIC;
--            y_input                   : in STD_LOGIC;
--            z_input                   : in STD_LOGIC;
--            cordic_mode               : in STD_LOGIC;
--            keypad_row                : in STD_LOGIC_VECTOR (3 downto 0);
            
--            keypad_col                : out STD_LOGIC_VECTOR (3 downto 0)   := "1111";
--            led                       : out STD_LOGIC_VECTOR (15 downto 0)  := x"0000";
--            initial_x                 : out STD_LOGIC_VECTOR (15 downto 0)  := x"0000";
--            initial_y                 : out STD_LOGIC_VECTOR (15 downto 0)  := x"0000";
--            initial_z                 : out STD_LOGIC_VECTOR (15 downto 0)  := x"0000";
--            initial_cordic_mode       : out STD_LOGIC                       := '0';
--            start_cordic              : out STD_LOGIC                       := '0'
--    );
--end input_driver;

--architecture behavioural of input_driver is

--    component debouncer is 
--        Port ( 
--            clk_100MHz    : in  STD_LOGIC;
--            reset         : in  STD_LOGIC;
--            PB_in         : in STD_LOGIC;
--            PB_out        : out STD_LOGIC    
--        );
--    end component;

--    signal x_input_debounced : STD_LOGIC;
--    signal y_input_debounced : STD_LOGIC;
--    signal z_input_debounced : STD_LOGIC;
    
--    signal cordic_mode_debounced : STD_LOGIC;
--    signal start_cordic_debounced : STD_LOGIC;
--    signal keypad_row_debounced : STD_LOGIC_VECTOR (3 downto 0);
    
--    signal keypad_col_internal : STD_LOGIC_VECTOR  (3 downto 0);
    
--    signal x_input_done : STD_LOGIC := '0';
--    signal y_input_done : STD_LOGIC := '0';
--    signal z_input_done : STD_LOGIC := '0';

--    type   state_type is (mode_input, mode_input_x, mode_input_y, mode_input_z, mode_output);  
--    signal state : state_type := mode_input;  

--begin

--    x_debouncer: debouncer port map (clk_100MHz => clk, reset => reset, PB_in => x_input, PB_out => x_input_debounced);
--    y_debouncer: debouncer port map (clk_100MHz => clk, reset => reset, PB_in => y_input, PB_out => y_input_debounced);
--    z_debouncer: debouncer port map (clk_100MHz => clk, reset => reset, PB_in => z_input, PB_out => z_input_debounced);
--    mode_debouncer: debouncer port map (clk_100MHz => clk, reset => reset, PB_in => cordic_mode, PB_out => cordic_mode_debounced);

--    generate_row_debouncer: for i in 0 to 3 generate
--        row_debouncer: debouncer port map (clk_100MHz => clk, reset => reset, PB_in => keypad_row(i), PB_out => keypad_row_debounced(i));
--    end generate generate_row_debouncer;

--    state_machine: process (clk, state, reset) is
--    begin

--        if rising_edge(reset) then
--            state <= mode_input;
--            x_input_done <= '0';
--            y_input_done <= '0';
--            z_input_done <= '0';
--            start_cordic <= '0';

--        elsif rising_edge(clk) then
--            case state is
--                when mode_input =>
--                    if (x_input_debounced = '1') then
--                        state <= mode_input_x;
--                    elsif (y_input_debounced = '1') then
--                        state <= mode_input_y;
--                    elsif (z_input_debounced = '1') then
--                        state <= mode_input_z;
--                    elsif (x_input_done = '1') AND (y_input_done = '1') AND (z_input_done = '1') then
--                        state <= mode_output;
--                    end if; 
--                when mode_input_x =>
--                    if (x_input_debounced = '0') then
--                        state <= mode_input;
--                    end if;
--                when mode_input_y =>
--                    if (y_input_debounced = '0') then
--                        state <= mode_input;
--                    end if;
--                when mode_input_z =>
--                    if (z_input_debounced = '0') then
--                        state <= mode_input;
--                    end if;
--                when mode_output =>
--                    if (reset = '1') then
--                        state <= mode_input;
--                    end if;
--                            -- after a few ns, mode must go back to input
--            end case;

--        end if;

--    end process;

--    -- process to continuously poll set low the columns of the hex pad
--    column_select: process (clk, reset, state) is
--        variable counter        :   unsigned (1 downto 0)           := "00";
--    begin

--        if rising_edge(reset) or (state = mode_input) or (state = mode_output) then
--            counter     := "00";
--            keypad_col <= "1111";
--            keypad_col_internal <= "1111";
--        elsif rising_edge(clk) then
        
--            case counter is
--                when "00" =>
--                    keypad_col <= "0111";
--                    keypad_col_internal <= "0111";
--                    counter := "01";
                    
--                when "01" =>
--                    keypad_col <= "1011";
--                    keypad_col_internal <= "1011";
--                    counter := "10";
                
--                when "10" =>
--                    keypad_col <= "1101";
--                    keypad_col_internal <= "1101";
--                    counter := "11";
                    
--                when "11" =>
--                    keypad_col <= "1110";
--                    keypad_col_internal <= "1110";
--                    counter := "00";
--                when others => counter := "00"; -- will never get here
--            end case; 
--        end if; -- if rising_edge(clk)

--    end process; --column_select
    
--    await_row_edge: process(keypad_row_debounced, reset, state) is
--        variable x_iteration    :   STD_LOGIC_VECTOR (1 downto 0)   := "00";
--        variable y_iteration    :   STD_LOGIC_VECTOR (1 downto 0)   := "00";
--        variable z_iteration    :   STD_LOGIC_VECTOR (1 downto 0)   := "00";
--        variable decode_value   :   STD_LOGIC_VECTOR (3 downto 0)   := "0000";
--    begin
    
--        if rising_edge(reset) or (state = mode_input) or (state = mode_output) then
--            x_iteration := "00";
--            y_iteration := "00";
--            z_iteration := "00";
--        elsif ( (keypad_row_debounced'event) and (keypad_row_debounced /= "1111") and (keypad_col_internal /= "1111") ) then -- something was actually pressed
--            -- depending on mode, store the result in the correct output
                
--            -- decode the row and column combo
--            -- this is happening anytime the row value changes and its not nothing (1111)
--            if keypad_col_internal <= "0111" then
--                if keypad_row_debounced = "0111" then
--                    decode_value := "0001"; --1
--                elsif keypad_row_debounced = "1011" then
--                    decode_value := "0100"; --4
--                elsif keypad_row_debounced = "1101" then
--                    decode_value := "0111"; --7
--                elsif keypad_row_debounced = "1110" then
--                    decode_value := "0000"; --0
--                end if;
--            elsif keypad_col_internal = "1011" then
--                if keypad_row_debounced = "0111" then        
--                   decode_value := "0010"; --2
--                elsif keypad_row_debounced = "1011" then
--                   decode_value := "0101"; --5
--                elsif keypad_row_debounced = "1101" then
--                   decode_value := "1000"; --8
--                elsif keypad_row_debounced = "1110" then
--                   decode_value := "1111"; --F
--                end if;
--            elsif keypad_col_internal = "1101" then
--                if keypad_row_debounced = "0111" then
--                    decode_value := "0011"; --3    
--                elsif keypad_row_debounced = "1011" then
--                    decode_value := "0110"; --6
--                elsif keypad_row_debounced = "1101" then
--                    decode_value := "1001"; --9
--                elsif keypad_row_debounced = "1110" then
--                    decode_value := "1110"; --E
--                end if;
--            elsif keypad_col_internal = "1110" then
--                if keypad_row_debounced = "0111" then
--                    decode_value := "1010"; --A
--                elsif keypad_row_debounced = "1011" then
--                    decode_value := "1011"; --B
--                elsif keypad_row_debounced = "1101" then
--                    decode_value := "1100"; --C
--                elsif keypad_row_debounced = "1110" then
--                    decode_value := "1101"; --D
--                end if;
--            end if;
                
--            -- take the appropriate actions based on the iteration number and the mode
--            if (state = mode_input_x) then
--                if (x_iteration = "00") then
--                   initial_x(15 downto 12) <= decode_value;
--                   x_iteration := "01";
--                elsif (x_iteration = "01") then
--                   initial_x(11 downto 8) <= decode_value;
--                   x_iteration := "10";
--                elsif (x_iteration = "10") then
--                   initial_x(7 downto 4) <= decode_value;
--                   x_iteration := "11";
--                elsif (x_iteration = "11") and (x_input_done = '0') then
--                   initial_x(3 downto 0) <= decode_value;
--                   x_input_done <= '1';
--                   led(0) <= '1'; --LED's are the indication to user that the input for a specific vector is done
--                                  -- and that they can release the input switch
--                                  -- they don't get turned off until reset
--                end if;
                
--            elsif (state = mode_input_y) then
--                if (y_iteration = "00") then
--                   initial_y(15 downto 12) <= decode_value;
--                   y_iteration := "01";
--                elsif (y_iteration = "01") then
--                   initial_y(11 downto 8) <= decode_value;
--                   y_iteration := "10";
--                elsif (y_iteration = "10") then
--                   initial_y(7 downto 4) <= decode_value;
--                   y_iteration := "11";
--                elsif (y_iteration = "11") and (y_input_done = '0') then
--                   initial_y(3 downto 0) <= decode_value;
--                   y_input_done <= '1';
--                   led(1) <= '1';
--                end if;
                
--            elsif (state = mode_input_z) then
--                if (z_iteration = "00") then
--                   initial_z(15 downto 12) <= decode_value;
--                   z_iteration := "01";
--                elsif (z_iteration = "01") then
--                   initial_z(11 downto 8) <= decode_value;
--                   z_iteration := "10";
--                elsif (z_iteration = "10") then
--                   initial_z(7 downto 4) <= decode_value;
--                   z_iteration := "11";
--                elsif (z_iteration = "11") and (z_input_done = '0') then
--                   initial_z(3 downto 0) <= decode_value;
--                   z_input_done <= '1';
--                   led(2) <= '1';
--                end if;
--            end if; -- state-based store  
--        end if;
--    end process; --await_row_edge
    
    

--    output: process (clk, state, reset) is
--    begin
--        if state = mode_output then
--            initial_cordic_mode <= cordic_mode_debounced;
--            start_cordic <= '1';
--        else
--            start_cordic <= '0';
--        end if;

--    end process;

--end behavioural;



--------------------------------- ALTERNATIVE IMPLEMENTATION --------------------------------

-- INPUT DRIVER
-- AUTHOR: NOAH RONDEAU

-- INPUTS:
--          Array of 16 switch inputs: std_logic_vector in_input_value
--              each a bit of the input (when getting hex values)
--              bottom bit is the mode
--          Button 1: in_input_button
--              press to start input sequence
--              after setting switches, press the button to capture values
--              first time is x, then y, then z, then mode
--              last press starts cordic
--              ( == 6 button pushes total)
--          Button 2: in_reset_button
--              if pressed, resets the entire system
--          Clock: the system clock
--
--          NOTE: ALL inputs are debounced

-- OUTPUTS:
--          out_x_value: the initial x value for CORDIC
--          out_y_value: ""     ""   y  ""    ""   "
--          out_z_value: ""     ""   z  ""    ""   "
--          out_cordic_mode: the mode for the cordic operation
--          out_reset: output to tell system to reset (includes input, core, and output reset)
--          out_start_cordic: output signal to tell CORDIC to start
--          out_led: 16 LEDs to indicate status

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity input_driver is
    Port (
        ----------------------INPUTS-----------------------------------------------
        clk             :       in      STD_LOGIC;
        in_input_value  :       in      STD_LOGIC_VECTOR (15 downto 0);
        in_input_button :       in      STD_LOGIC;
        in_reset_button :       in      STD_LOGIC;
        ----------------------OUTPUTS----------------------------------------------
        out_x_value     :       out     SIGNED (15 downto 0)            := x"0000";
        out_y_value     :       out     SIGNED (15 downto 0)            := x"0000";
        out_z_value     :       out     SIGNED (15 downto 0)            := x"0000";
        out_led         :       out     STD_LOGIC_VECTOR (15 downto 0)  := x"0001";
        out_cordic_mode :       out     STD_LOGIC                       := '0';
        out_reset       :       out     STD_LOGIC                       := '0';
        out_start_cordic:       out     STD_LOGIC                       := '0'
    );  
end input_driver;


architecture behavioural of input_driver is

    component debouncer is 
        Port ( 
            clk_100MHz    : in  STD_LOGIC;
            reset         : in  STD_LOGIC;
            PB_in         : in  STD_LOGIC;
            PB_out        : out STD_LOGIC    
        );
    end component;
    
    -- DEBOUNCED input signals
    signal input_value_db  : STD_LOGIC_VECTOR (15 downto 0);
    signal input_button_db : STD_LOGIC;
    signal reset_button_db : STD_LOGIC;
    signal zero : STD_LOGIC := '0';
    
    -- INTERNAL SIGNALS
    
    type   state_type is (  state_begin, state_input_x, state_input_y, state_input_z, state_input_cordic_mode,
                            state_start_cordic, state_end  );  
    signal state : state_type := state_begin;
    
    --signal start_cordic_timer_signal_send : STD_LOGIC := '0';
    --signal start_cordic_timer_signal_recv : STD_LOGIC := '0';

begin

-- GENERATE debouncers for all inputs --------------------------------------------------------------------------------------------------------
input_button_debouncer: debouncer port map (clk_100MHz => clk, reset => reset_button_db, PB_in => in_input_button, PB_out => input_button_db);
reset_button_debouncer: debouncer port map (clk_100MHz => clk, reset => zero, PB_in => in_reset_button, PB_out => reset_button_db);
generate_input_value_debouncer: for i in 0 to 15 generate
    row_debouncer: debouncer port map (clk_100MHz => clk, reset => reset_button_db, PB_in => in_input_value(i), PB_out => input_value_db(i));
end generate generate_input_value_debouncer;
----------------------------------------------------------------------------------------------------------------------------------------------

-- SIGNAL Pass thru to the CORDIC controller
--      cordic must be aware of the reset at the same time
out_reset <= reset_button_db;
--out_led(15) <= reset_button_db;

-- STATE_MACHINE process --------------------------------
 
state_machine: process(reset_button_db, input_button_db) is
begin
    -- If the reset button is pressed, at ANY time, reset the mode to mode_begin, which is our starting mode
    if (reset_button_db = '1') then
        state <= state_begin; -- reset the mode
        out_x_value <= x"0000";
        out_y_value <= x"0000";
        out_z_value <= x"0000";
        out_cordic_mode <= '0';
        out_start_cordic <= '0';
        
        -- shut off internal message signals
        --start_cordic_timer_signal_send <= '0';
        
        out_led <= x"0001"; 
    end if; 
     
    -- State machine transitions occur on the rising edge of the input button
    -- all actions taken during the state are gated by the edge
    -- all actions taken to prepare a state have to happen the state before
    -- (e.g. lighting the LEDs)
    -- NOTE on LEDs:    They never turn off until we reach the end state.
    --                  In this sense they indicate progress thru state machine
    if rising_edge(input_button_db) then --OR rising_edge(start_cordic_timer_signal_recv) then
        
        case state is
            
            when state_begin =>
                -- received signal to move to state_input_x
                -- prepare that state:
                -- turn on indicator LED
                out_led <= x"0002";
                state <= state_input_x;
                
            when state_input_x =>
                -- received signal to move to state_input_y
                -- save debounced input vector into x output
                out_x_value <= SIGNED(input_value_db);
                -- prepare the next state by turning on LED 2
                out_led <= x"0004";
                state <= state_input_y;
            when state_input_y =>
                -- received signal to move to state_input_z
                -- save debounced input vector into y output
                out_y_value <= SIGNED(input_value_db);
                -- prepare the next state by turning on LED 3
                out_led <= x"0008";
                state <= state_input_z;
                
            when state_input_z =>
                -- received signal to move to state_input_cordic_mode
                -- save debounced input vector into z output
                out_z_value <= SIGNED(input_value_db);
                -- prepare the next state by turning on LED 4
                out_led <= x"0010";
                state <= state_input_cordic_mode;
                
            when state_input_cordic_mode =>
                -- received signal to move to state_start_cordic
                -- save LSB of input vector into out_cordic_mode
                out_cordic_mode <= input_value_db(0);
                -- prepare the next state by turning on LED 5
                out_led <= x"0020";
                state <= state_start_cordic;
                
            when state_start_cordic =>
                -- received signal to start cordic
                -- set the start_cordic output high, and send a signal to start counting
                -- when the returned signal (start_cordic_timer_signal_recv, goes high
                -- since it is in the sensitivity list, this block runs again, but the "else"
                -- runs, and so out_start_cordic is set low, and then we enter the "end" state.
                -- NOTE that the way this is written, if the input_button goes high a second time while we
                --      are in here, nothing will actually happen, since we only do things if the recv signal is low for the first run
                --      that is triggered by the input_button, then if it is high, which it will be if there is a rising edge. It won't be high
                --      if a second signal on the input_button occurs, so nothing happens. After, we will have already reached the end state. 

                    out_start_cordic <= '1';
                    out_led <= x"0040";
                    state <= state_end;
--                if start_cordic_timer_signal_recv = '0' then
--                    out_start_cordic <= '1';  
--                    start_cordic_timer_signal_send <= '1';
--                else -- there was a rising edge on the timer_signal_recv signal
--                    out_start_cordic <= '0';
--                    out_led <= x"0040";
--                    state <= state_end;
--                end if;           
                
            when state_end =>
                -- Do nothing. No way to get out except reset
                
        end case; -- case state is
        
    end if; -- if rising_edge(reset_button_db)
    
end process state_machine;

--start_cordic_timer: process(clk, reset_button_db) is
--    variable counter : unsigned (7 downto 0) := x"00";
--begin

--    if (reset_button_db = '1') then
--        -- shut off internal message signals
--        start_cordic_timer_signal_recv <= '0';   
--        counter := x"00";
--    end if;

--    if rising_edge(clk) then
--        if (start_cordic_timer_signal_send = '1') then
--            -- count 16 clock cycles then send signal to turn off the start cordic
--            if counter = x"0f" then --after 16 clk go down
--                start_cordic_timer_signal_recv <= '1';
--            else
--                counter := counter + "1"; -- note double quotes here are necessary, it will still run without but won't work
--            end if;                         
--        end if;
--    end if; --rising_edge(clk)
--end process start_cordic_timer;

end behavioural;
