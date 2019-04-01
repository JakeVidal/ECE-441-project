-- CORDIC output controller
-- Written by Jake Vidal

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity output_driver is 
    port (
            ----------------------INPUTS-----------------------------------------------
            clk                       : in STD_LOGIC;
            reset                     : in STD_LOGIC;
            x_result                  : in SIGNED (15 downto 0);
            y_result                  : in SIGNED (15 downto 0);
            z_result                  : in SIGNED (15 downto 0);
            iteration                 : in UNSIGNED (3 downto 0);
            data_ready                : in STD_LOGIC;
            x_select                  : in STD_LOGIC;
            y_select                  : in STD_LOGIC;
            z_select                  : in STD_LOGIC;
            iteration_select          : in STD_LOGIC_VECTOR (3 downto 0);

            ----------------------OUTPUTS----------------------------------------------
            anode                     : out STD_LOGIC_VECTOR (3 downto 0);
            segment                   : out STD_LOGIC_VECTOR (6 downto 0)
    );
end output_driver;

architecture behavioural of output_driver is

    component Result_dist_mem_gen is
        port (
            a                         : in STD_LOGIC_VECTOR(3 DOWNTO 0);
            d                         : in STD_LOGIC_VECTOR(15 DOWNTO 0);
            clk                       : in STD_LOGIC;
            we                        : in STD_LOGIC;
            qspo_rst                  : IN STD_LOGIC;
            qspo                      : out STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    end component;

    component hex_driver is
        port (
            clk                       : in STD_LOGIC;
            reset                     : in STD_LOGIC;
            done                      : in STD_LOGIC;
            d_in                      : in STD_LOGIC_VECTOR (15 downto 0);
            anodes                    : out STD_LOGIC_VECTOR (3 downto 0);
            cathodes                  : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

    ------------------------MEMORY ACCESS SIGNALS----------------------------------
    signal write_enable: STD_LOGIC := '0';
    signal ram_address: STD_LOGIC_VECTOR (3 downto 0);
    signal x_stored_value, y_stored_value, z_stored_value: STD_LOGIC_VECTOR (15 downto 0);
    
    ---------------------------INTERNAL SIGNALS------------------------------------
    signal start_display : STD_LOGIC := '0';
    signal selected_value : STD_LOGIC_VECTOR (15 downto 0) := x"0000";
    type   state_type is (mode_write, mode_read);  
    signal state : state_type := mode_write; 

begin

    -------------------------------MEMORY PORT MAPS--------------------------------
    x_result_storage: Result_dist_mem_gen port map (
    a               =>   ram_address,
    d               =>   STD_LOGIC_VECTOR(x_result),
    clk             =>   clk,
    we              =>   write_enable,
    qspo_rst        =>   reset,
    qspo            =>   x_stored_value
    ); 
    
    y_result_storage: Result_dist_mem_gen port map (
    a               =>   ram_address,
    d               =>   STD_LOGIC_VECTOR(y_result),
    clk             =>   clk,
    we              =>   write_enable,
    qspo_rst        =>   reset,
    qspo            =>   y_stored_value
    ); 
    
    z_result_storage: Result_dist_mem_gen port map (
    a               =>   ram_address,
    d               =>   STD_LOGIC_VECTOR(z_result),
    clk             =>   clk,
    we              =>   write_enable,
    qspo_rst        =>   reset,
    qspo            =>   z_stored_value
    ); 

    ------------------------------HEX DRIVER PORT MAP------------------------------
    display_value: hex_driver port map (clk => clk, reset => reset, done => start_display, d_in => selected_value, anodes => anode, cathodes => segment);

    handle_ui: process (clk, x_select, y_select, z_select, reset)
    begin

        if (reset = '1') then
            selected_value <= x"0000";

        else
            if rising_edge(clk) then -- use the user inputs to determine which RAM module to read a value from 
                if (state = mode_read) then
                    if (x_select = '1') then
                        selected_value <= x_stored_value;
                    elsif (y_select = '1') then
                        selected_value <= y_stored_value;
                    elsif (z_select = '1') then
                        selected_value <= z_stored_value;
                    end if;
                end if;    
            end if;
        end if;

    end process;
    
    state_machine: process (clk, state, reset) is
    begin

        if (reset = '1') then
            state <= mode_write;

        else
            if rising_edge(clk) then 
                case state is
                    when mode_write => -- When the CORDIC is processing, feed inputs from the CORDIC into the RAM
                        write_enable <= data_ready;
                        ram_address <= STD_LOGIC_VECTOR(iteration);
                        start_display <= '0';
                        
                        if (iteration = "1111") then -- after the CORDIC completes its last iteration, change states
                            state <= mode_read;
                        end if;
                        
                    when mode_read => -- Once the CORDIC is done processing, route user inputs into the RAM
                        write_enable <= '0';
                        ram_address <= iteration_select;
                        start_display <= '1';
                end case;
            end if;
        end if;
        
    end process;

end behavioural;