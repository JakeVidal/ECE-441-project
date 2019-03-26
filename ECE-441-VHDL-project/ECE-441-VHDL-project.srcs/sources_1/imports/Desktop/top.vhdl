library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
	port (
	       ----------------------INPUTS-----------------------------------------------
           input_clk                : in STD_LOGIC;
           undebounced_reset        : in STD_LOGIC;
           input_button             : in STD_LOGIC;
           sw                       : in STD_LOGIC_VECTOR (15 downto 0);
           
	       ----------------------OUTPUTS---------------------------------------------- 
           led                      : out STD_LOGIC_VECTOR (15 downto 0);
           anode                    : out STD_LOGIC_VECTOR (3 downto 0);
           segment                  : out STD_LOGIC_VECTOR (6 downto 0)
		);
end top;

architecture behaviour of top is

    component input_driver is
        port (
            ----------------------INPUTS-----------------------------------------------
            clk                     : in STD_LOGIC;
            in_input_value          : in STD_LOGIC_VECTOR (15 downto 0);
            in_input_button         : in STD_LOGIC;
            in_reset_button         : in STD_LOGIC;
            
            ----------------------OUTPUTS----------------------------------------------
            out_x_value             : out SIGNED (15 downto 0)            := x"0000";
            out_y_value             : out SIGNED (15 downto 0)            := x"0000";
            out_z_value             : out SIGNED (15 downto 0)            := x"0000";
            out_led                 : out STD_LOGIC_VECTOR (15 downto 0)  := x"0001";
            out_cordic_mode         : out STD_LOGIC                       := '0';
            out_reset               : out STD_LOGIC                       := '0';
            out_start_cordic        : out STD_LOGIC                       := '0'
        );
    end component;

    component CORDIC is
        port (
            ----------------------INPUTS-----------------------------------------------        
            in_clock                : in STD_LOGIC;
            in_reset                : in STD_LOGIC;
            in_x_initial            : in SIGNED ( 15 downto 0 );
            in_y_initial            : in SIGNED ( 15 downto 0 );
            in_z_initial            : in SIGNED ( 15 downto 0 );
            in_cordic_mode          : in STD_LOGIC;
            in_start                : in STD_LOGIC;
            
             ----------------------OUTPUTS----------------------------------------------               
            out_x_result            : out SIGNED ( 15 downto 0 );
            out_y_result            : out SIGNED ( 15 downto 0 );
            out_z_result            : out SIGNED ( 15 downto 0 );
            out_iteration           : out UNSIGNED (  3 downto 0 );
            out_mu                  : out STD_LOGIC;
            out_iteration_complete  : out STD_LOGIC
        );
    end component;
    
    component output_driver is 
        port (
            ----------------------INPUTS-----------------------------------------------       
            clk                     : in STD_LOGIC;
            reset                   : in STD_LOGIC;
            x_result                : in SIGNED (15 downto 0);
            y_result                : in SIGNED (15 downto 0);
            z_result                : in SIGNED (15 downto 0);
            iteration               : in UNSIGNED (3 downto 0);
            data_ready              : in STD_LOGIC;
            x_select                : in STD_LOGIC;
            y_select                : in STD_LOGIC;
            z_select                : in STD_LOGIC;
            iteration_select        : in STD_LOGIC_VECTOR (3 downto 0);
            
            ----------------------OUTPUTS-----------------------------------------------
            anode                   : out STD_LOGIC_VECTOR (3 downto 0);
            segment                 : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;
    
    signal reset                    : STD_LOGIC;
    
    ----------------------INPUT DRIVER TO CORDIC----------------------------------------
    signal in_x_transfer            : SIGNED (15 downto 0);
    signal in_y_transfer            : SIGNED (15 downto 0);
    signal in_z_transfer            : SIGNED (15 downto 0);
    signal cordic_mode              : STD_LOGIC;
    signal start_cordic             : STD_LOGIC;
    
    ----------------------CORDIC TO OUTPUT DRIVER--------------------------------------- 
    signal out_x_transfer           : SIGNED (15 downto 0);
    signal out_y_transfer           : SIGNED (15 downto 0);
    signal out_z_transfer           : SIGNED (15 downto 0);   
    signal iteration_transfer       : UNSIGNED (3 downto 0);
    signal mu_trash                 : STD_LOGIC;
    signal complete_transfer        : STD_LOGIC;
    
begin

    input_driver_map: input_driver port map (
        clk                     => input_clk,
        in_input_value          => sw,
        in_input_button         => input_button,
        in_reset_button         => undebounced_reset,
        out_x_value             => in_x_transfer,
        out_y_value             => in_y_transfer,
        out_z_value             => in_z_transfer,
        out_led                 => led,
        out_cordic_mode         => cordic_mode,
        out_reset               => reset,
        out_start_cordic        => start_cordic
    );              

    cordic_map: CORDIC port map (
        in_clock                => input_clk,
        in_reset                => reset,      
        in_x_initial            => in_x_transfer,  
        in_y_initial            => in_y_transfer,  
        in_z_initial            => in_z_transfer,  
        in_cordic_mode          => cordic_mode,
        in_start                => start_cordic,                                 
        out_x_result            => out_x_transfer,
        out_y_result            => out_y_transfer,
        out_z_result            => out_z_transfer,
        out_iteration           => iteration_transfer,
        out_mu                  => mu_trash,
        out_iteration_complete  => complete_transfer
    );
    
    output_driver_map: output_driver port map (
        clk                     => input_clk,
        reset                   => reset,
        x_result                => out_x_transfer,
        y_result                => out_y_transfer,
        z_result                => out_z_transfer,
        iteration               => iteration_transfer,
        data_ready              => complete_transfer,
        x_select                => sw(9),
        y_select                => sw(10),
        z_select                => sw(11),
        iteration_select        => sw(15 downto 12),
        anode                   => anode,
        segment                 => segment
    );
    
end behaviour;
