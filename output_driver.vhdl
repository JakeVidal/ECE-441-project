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

    type matrix is array (15 downto 0) of STD_LOGIC_VECTOR (15 downto 0);
    signal x_data : matrix := (others => (others => "0"));
    signal y_data : matrix := (others => (others => "0"));
    signal z_data : matrix := (others => (others => "0"));

    signal x_select_debounced, y_select_debounced, z_select_debounced : STD_LOGIC;
    signal iteration_select_debounced : STD_LOGIC_VECTOR (3 downto 0);

    signal start_display : STD_LOGIC := "0";
    signal selected_value : STD_LOGIC_VECTOR (15 downto 0)

begin

    x_select_debouncer: debouncer port map (clk, reset, x_input, x_input_debounced);
    y_select_debouncer: debouncer port map (clk, reset, y_input, y_input_debounced);
    z_select_debouncer: debouncer port map (clk, reset, z_input, z_input_debounced);

    generate_iteration_debouncer: for i in 0 to 3 generate
        iteration_debouncer: debouncer port map (clk, reset, iteration_select(i), iteration_select_debounced(i));
    end generate generate_iteration_debouncer;

    display_value: hex_driver port map (clk, reset, start_display, selected_value, anode, segment);

    storage: process (clk, data_ready, reset) is
    begin

        if rising_edge(reset) then
            x_data := (others => (others => "0"));
            y_data := (others => (others => "0"));
            z_data := (others => (others => "0"));

        elsif rising_edge(clk) then
            if (data_ready = "1") then
                x_data(iteration) := x_result;
                y_data(iteration) := y_result;
                z_data(iteration) := z_result;

            end if;

        end if;

    end process;

    handle_ui: process (clk, x_select_debounced, y_select_debounced, z_select_debounced, iteration_select_debounced, reset)
    begin

        if rising_edge(reset) then
            selected_value = "0000000000000000";

        elsif rising_edge(clk) then
            if rising_edge(x_select_debounced) then
                selected_value := x_data(iteration_select_debounced);
            elsif rising_edge(y_select_debounced) then
                selected_value := y_data(iteration_select_debounced);
            elsif rising_edge(z_select_debounced) then
                selected_value := z_data(iteration_select_debounced);

            end if;

        end if;

    end process;

    handle_display: process (clk, data_ready, reset)
    begin

        if rising_edge(reset) then
            start_display <= "0";

        elsif rising_edge(clk) then
            if (data_ready = "1") then
                if (iteration = "1111") then
                    start_display <= "1";

                end if;

            end if;

        end if;

    end process;

end behavioural;