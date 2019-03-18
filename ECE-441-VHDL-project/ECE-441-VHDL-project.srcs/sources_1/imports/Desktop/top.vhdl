library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
	port (
	        in_clock                : in STD_LOGIC;
	        in_reset                : in STD_LOGIC;
	        
	        in_x_initial            : in SIGNED ( 15 downto 0 );
	        in_y_initial            : in SIGNED ( 15 downto 0 );
	        in_z_initial            : in SIGNED ( 15 downto 0 );
	        in_cordic_mode          : in STD_LOGIC;
	        in_start                : in STD_LOGIC;
	        
	        x_select                  : in STD_LOGIC;
            y_select                  : in STD_LOGIC;
            z_select                  : in STD_LOGIC;
            iteration_select          : in STD_LOGIC_VECTOR (3 downto 0);
            anode                     : out STD_LOGIC_VECTOR (3 downto 0);
            segment                   : out STD_LOGIC_VECTOR (6 downto 0)
		);
end top;

architecture behaviour of top is

    component CORDIC is
        port (
                in_clock                : in STD_LOGIC;
                in_reset                : in STD_LOGIC;
                in_x_initial            : in SIGNED ( 15 downto 0 );
                in_y_initial            : in SIGNED ( 15 downto 0 );
                in_z_initial            : in SIGNED ( 15 downto 0 );
                in_cordic_mode          : in STD_LOGIC;
                in_start                : in STD_LOGIC;
                
                out_x_result             : out SIGNED ( 15 downto 0 );
                out_y_result             : out SIGNED ( 15 downto 0 );
                out_z_result             : out SIGNED ( 15 downto 0 );
                out_iteration            : out UNSIGNED (  3 downto 0 );
                out_mu                   : out STD_LOGIC;
                out_iteration_complete   : out STD_LOGIC
            );
    end component;
    
    component output_driver is 
        Port (
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
    
                anode                     : out STD_LOGIC_VECTOR (3 downto 0);
                segment                   : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;
    
    signal x_transfer, y_transfer, z_transfer : SIGNED (15 downto 0);
    signal iteration_transfer : UNSIGNED (3 downto 0);
    signal mu_trash : STD_LOGIC;
    signal complete_transfer : STD_LOGIC;
    
begin
    cordic_map: CORDIC port map (
        in_clock                 => in_clock,
        in_reset                 => in_reset,      
        in_x_initial             => in_x_initial,  
        in_y_initial             => in_y_initial,  
        in_z_initial             => in_z_initial,  
        in_cordic_mode           => in_cordic_mode,
        in_start                 => in_start,                                 
        out_x_result             => x_transfer,
        out_y_result             => y_transfer,
        out_z_result             => z_transfer,
        out_iteration            => iteration_transfer,
        out_mu                   => mu_trash,
        out_iteration_complete   => complete_transfer
    );
    
    output_driver_map: output_driver port map (
        clk                => in_clock,
        reset              => in_reset,
        x_result           => x_transfer,
        y_result           => y_transfer,
        z_result           => z_transfer,
        iteration          => iteration_transfer,
        data_ready         => complete_transfer,
        x_select           => x_select,
        y_select           => y_select,
        z_select           => z_select,
        iteration_select   => iteration_select,
        anode              => anode,
        segment            => segment
    );
    
end behaviour;
