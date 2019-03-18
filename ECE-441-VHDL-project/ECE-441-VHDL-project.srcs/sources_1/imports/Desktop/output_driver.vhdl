-- CORDIC output controller
-- Written by Jake Vidal

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity output_driver is 
    Port (
            clk                       : in STD_LOGIC;
            reset                     : in STD_LOGIC;

            x_result                  : in STD_LOGIC_VECTOR (15 downto 0);
            y_result                  : in STD_LOGIC_VECTOR (15 downto 0);
            z_result                  : in STD_LOGIC_VECTOR (15 downto 0);
            iteration                 : in STD_LOGIC_VECTOR (3 downto 0);
            data_ready                : in STD_LOGIC;

            x_select                  : in STD_LOGIC;
            y_select                  : in STD_LOGIC;
            z_select                  : in STD_LOGIC;
            iteration_select          : in STD_LOGIC_VECTOR (3 downto 0);

            anode                     : out STD_LOGIC_VECTOR (3 downto 0);
            segment                   : out STD_LOGIC_VECTOR (6 downto 0)
    );
end output_driver;

architecture behavioural of output_driver is

	component Result_dist_mem_gen is
        Port (
            a : in STD_LOGIC_VECTOR(3 DOWNTO 0);
            d : in STD_LOGIC_VECTOR(15 DOWNTO 0);
            clk : in STD_LOGIC;
            we : in STD_LOGIC;
            spo : out STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    end component;
    
    component debouncer is 
        Port ( 
            clk_100MHz    : in  STD_LOGIC;
            reset         : in  STD_LOGIC;
            PB_in         : in STD_LOGIC;
            PB_out        : out STD_LOGIC    
        );
    end component;

    component hex_driver is
        Port (
            clk           : in STD_LOGIC;
            reset         : in STD_LOGIC;
            done          : in STD_LOGIC;
            d_in          : in STD_LOGIC_VECTOR (15 downto 0);
            anodes        : out STD_LOGIC_VECTOR (3 downto 0);
            cathodes      : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

    signal write_enable: STD_LOGIC := '0';
    signal store_value: STD_LOGIC_VECTOR (15 downto 0);
    signal ram_address: STD_LOGIC_VECTOR (3 downto 0);
    signal x_stored_value, y_stored_value, z_stored_value: STD_LOGIC_VECTOR (15 downto 0);

    signal x_select_debounced, y_select_debounced, z_select_debounced : STD_LOGIC;
    signal iteration_select_debounced : STD_LOGIC_VECTOR (3 downto 0);

    signal start_display : STD_LOGIC := '0';
    signal selected_value : STD_LOGIC_VECTOR (15 downto 0) := x"0000";
    
    type   state_type is (mode_write, mode_read);  
    signal state : state_type := mode_write; 

begin

	x_result_storage: Result_dist_mem_gen port map (
    a               =>   ram_address,
    d               =>   x_result,
    clk             =>   clk,
    we              =>   write_enable,
    spo             =>   x_stored_value
    ); 
    
    y_result_storage: Result_dist_mem_gen port map (
    a               =>   ram_address,
    d               =>   y_result,
    clk             =>   clk,
    we              =>   write_enable,
    spo             =>   y_stored_value
    ); 
    
    z_result_storage: Result_dist_mem_gen port map (
    a               =>   ram_address,
    d               =>   z_result,
    clk             =>   clk,
    we              =>   write_enable,
    spo             =>   z_stored_value
    ); 
    
    x_select_debouncer: debouncer port map (clk_100MHz => clk, reset => reset, PB_in => x_select, PB_out => x_select_debounced);
    y_select_debouncer: debouncer port map (clk_100MHz => clk, reset => reset, PB_in => y_select, PB_out => y_select_debounced);
    z_select_debouncer: debouncer port map (clk_100MHz => clk, reset => reset, PB_in => z_select, PB_out => z_select_debounced);

    generate_iteration_debouncer: for i in 0 to 3 generate
        iteration_debouncer: debouncer port map (clk_100MHz => clk, reset => reset, PB_in => iteration_select(i), PB_out => iteration_select_debounced(i));
    end generate generate_iteration_debouncer;

    display_value: hex_driver port map (clk => clk, reset => reset, done => start_display, d_in => selected_value, anodes => anode, cathodes => segment);

    handle_ui: process (clk, x_select_debounced, y_select_debounced, z_select_debounced, iteration_select_debounced, reset)
    begin

        if rising_edge(reset) then
            selected_value <= x"0000";

        elsif (state = mode_read) then
            if (x_select_debounced = '1') then
                selected_value <= x_stored_value;
            elsif (y_select_debounced = '1') then
                selected_value <= y_stored_value;
            elsif (z_select_debounced = '1') then
                selected_value <= z_stored_value;

            end if;

        end if;

    end process;
    
    state_machine: process (clk, state, reset) is
    begin

        if rising_edge(reset) then
            state <= mode_write;
            -- clear ram

        elsif rising_edge(clk) then
            case state is
                when mode_write => 
                    write_enable <= data_ready;
                    ram_address <= iteration;
                    start_display <= '0';
                    
                    if (iteration = "1111") then
                        state <= mode_read;
                    end if;
                    
                when mode_read => 
                    write_enable <= '0';
                    ram_address <= iteration_select_debounced;
                    start_display <= '1';
            end case;
        end if;
        
    end process;

end behavioural;