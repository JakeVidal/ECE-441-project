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

            anode                     : out STD_LOGIC_VECTOR ( 3 downto 0 );
            segment                   : out STD_LOGIC_VECTOR ( 6 downto 0 )
    );
end output_driver;

architecture behavioural of output_driver is

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

    display_value: hex_driver port map (clk, reset, display, selected_value, anode, segment);

begin

end behavioural;