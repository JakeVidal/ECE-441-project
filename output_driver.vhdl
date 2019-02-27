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

            anode                     : out STD_LOGIC_VECTOR ( 3 downto 0 );
            segment                   : out STD_LOGIC_VECTOR ( 6 downto 0 )
    );
end output_driver;

architecture behavioural of output_driver is

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
            clk : in STD_LOGIC;
            reset   : in STD_LOGIC;
            done    : in STD_LOGIC;
            d_in    : in STD_LOGIC_VECTOR ( 15 downto 0 );
            anodes  : out STD_LOGIC_VECTOR ( 3 downto 0 );
            cathodes: out STD_LOGIC_VECTOR ( 6 downto 0 )
        );
    end component;

    type matrix is array (15 downto 0) of STD_LOGIC_VECTOR (15 downto 0);
    signal x_data : matrix := (others => (others => "0"));
    signal y_data : matrix := (others => (others => "0"));
    signal z_data : matrix := (others => (others => "0"));

    signal x_select_debounced, y_select_debounced, z_select_debounced : STD_LOGIC;
    signal iteration_select_debounced : STD_LOGIC_VECTOR (3 downto 0);

begin

    x_select_debouncer: debouncer port map (clk, reset, x_input, x_input_debounced);
    y_select_debouncer: debouncer port map (clk, reset, y_input, y_input_debounced);
    z_select_debouncer: debouncer port map (clk, reset, z_input, z_input_debounced);

    generate_iteration_debouncer: for i in 0 to 3 generate
        iteration_debouncer: debouncer port map (clk, reset, iteration_select(i), iteration_select_debounced(i));
    end generate generate_iteration_debouncer;

    display_value: hex_driver port map (clk, reset, display, selected_value, anode, segment);

end behavioural;