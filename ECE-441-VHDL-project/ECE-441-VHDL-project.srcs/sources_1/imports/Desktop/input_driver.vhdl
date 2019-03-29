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
    port (
        ----------------------INPUTS-----------------------------------------------
        in_input_value          : in STD_LOGIC_VECTOR (15 downto 0);
        in_input_button         : in STD_LOGIC;
        in_reset_button         : in STD_LOGIC;
        
        ----------------------OUTPUTS----------------------------------------------
        out_x_value             : out SIGNED (15 downto 0)            := x"0000";
        out_y_value             : out SIGNED (15 downto 0)            := x"0000";
        out_z_value             : out SIGNED (15 downto 0)            := x"0000";
        out_led                 : out STD_LOGIC_VECTOR (15 downto 0)  := x"0001";
        out_cordic_mode         : out STD_LOGIC                       := '0';
        out_start_cordic        : out STD_LOGIC                       := '0'
    );  
end input_driver;

architecture behaviour of input_driver is

    ---------------------------INTERNAL SIGNALS------------------------------------
    type   state_type is (  state_begin, state_input_x, state_input_y, state_input_z, state_input_cordic_mode,
                            state_start_cordic, state_end  );  
    signal state : state_type := state_begin;

begin

------------------STATE MACHINE------------------------------------

    state_machine: process(in_reset_button, in_input_button) is
    begin
        -- If the reset button is pressed, at ANY time, reset the mode to mode_begin, which is our starting mode
        if (in_reset_button = '1') then
            state <= state_begin; -- reset the mode
            out_x_value <= x"0000";
            out_y_value <= x"0000";
            out_z_value <= x"0000";
            out_cordic_mode <= '0';
            out_start_cordic <= '0';
            
            -- shut off internal message signals
            --start_cordic_timer_signal_send <= '0';
            
            out_led <= x"0001"; 
        --end if; 
        else  
            -- State machine transitions occur on the rising edge of the input button
            -- all actions taken during the state are gated by the edge
            -- all actions taken to prepare a state have to happen the state before
            -- (e.g. lighting the LEDs)
            -- NOTE on LEDs:    They never turn off until we reach the end state.
            --                  In this sense they indicate progress thru state machine
            if rising_edge(in_input_button) then 
                
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
                        out_x_value <= SIGNED(in_input_value);
                        -- prepare the next state by turning on LED 2
                        out_led <= x"0004";
                        state <= state_input_y;
                        
                    when state_input_y =>
                        -- received signal to move to state_input_z
                        -- save debounced input vector into y output
                        out_y_value <= SIGNED(in_input_value);
                        -- prepare the next state by turning on LED 3
                        out_led <= x"0008";
                        state <= state_input_z;
                        
                    when state_input_z =>
                        -- received signal to move to state_input_cordic_mode
                        -- save debounced input vector into z output
                        out_z_value <= SIGNED(in_input_value);
                        -- prepare the next state by turning on LED 4
                        out_led <= x"0010";
                        state <= state_input_cordic_mode;
                        
                    when state_input_cordic_mode =>
                        -- received signal to move to state_start_cordic
                        -- save LSB of input vector into out_cordic_mode
                        out_cordic_mode <= in_input_value(0);
                        -- prepare the next state by turning on LED 5
                        out_led <= x"0020";
                        state <= state_start_cordic;
                        
                    when state_start_cordic =>
                        -- received signal to start cordic
                        -- set the start_cordic output high, and send a signal to start counting
                        -- when the returned signal (start_cordic_timer_signal_recv, goes high
                        -- since it is in the sensitivity list, this block runs again, but the "else"
                        -- runs, and so out_start_cordic is set low, and then we enter the "end" state.
        
                            out_start_cordic <= '1';
                            out_led <= x"0040";
                            state <= state_end;       
                        
                    when state_end =>
                        -- Do nothing. No way to get out except reset
                        
                end case; -- case state is
            
            end if; -- if rising_edge(reset_button_db)
        end if;
        
    end process state_machine;

end behaviour;
