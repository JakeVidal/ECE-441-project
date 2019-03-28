library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
	port (
	       ----------------------INPUTS-----------------------------------------------
           input_clk                    : in STD_LOGIC;
           undebounced_reset_button     : in STD_LOGIC;
           undebounced_input_button     : in STD_LOGIC;
           undebounced_switches         : in STD_LOGIC_VECTOR (15 downto 0);
           
	       ----------------------OUTPUTS---------------------------------------------- 
           led                      : out STD_LOGIC_VECTOR (15 downto 0);
           anode                    : out STD_LOGIC_VECTOR (3 downto 0);
           segment                  : out STD_LOGIC_VECTOR (6 downto 0);
           
           ---------------------TEST OUTPUTS------------------------------------------
           test_data_ready          : out STD_LOGIC;
           test_x_result            : out SIGNED (15 downto 0);
           test_y_result            : out SIGNED (15 downto 0);
           test_z_result            : out SIGNED (15 downto 0);
           test_iteration           : out UNSIGNED (3 downto 0)
		);
end top;

architecture behaviour of top is

    component debouncer is
        port ( 
               clk_100MHz    : in  STD_LOGIC;
               reset         : in  STD_LOGIC;
               PB_in         : in  STD_LOGIC;    -- the input PB that is bouncy
               PB_out        : out STD_LOGIC    -- the de-bounced output
            );  
    end component;
    
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
    
    ----------------------SIGNAL FOR GROUND REFERENCE----------------------------------
    signal zero                     : STD_LOGIC := '0';
    
    ----------------------USER INPUT TO SYSTEM-----------------------------------------
    signal reset                    : STD_LOGIC;
    signal input                    : STD_LOGIC;
    signal switches                 : STD_LOGIC_VECTOR (15 downto 0);
    
    ----------------------INPUT DRIVER TO CORDIC---------------------------------------
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
        
    ---------------------- DEBOUNCER PORT MAPS ------------------------------------------
    input_button_debouncer: debouncer port map (
        clk_100MHz => input_clk,
        reset => reset,
        PB_in => undebounced_input_button,
        PB_out => input
    );
    
    reset_button_debouncer: debouncer port map (
        clk_100MHz => input_clk,
        reset => zero,
        PB_in => undebounced_reset_button,
        PB_out => reset
    );
    
    generate_switches_debouncer: for i in 0 to 15 generate
        switch_debouncer: debouncer port map (
            clk_100MHz => input_clk,
            reset => reset,
            PB_in => undebounced_switches(i),
            PB_out => switches(i)
        );
    end generate generate_switches_debouncer;
    
    ---------------------- MODULE PORT MAPS -----------------------------------------------

    input_driver_map: input_driver port map (
        clk                     => input_clk,
        in_input_value          => switches,
        in_input_button         => input,
        in_reset_button         => reset,
        out_x_value             => in_x_transfer,
        out_y_value             => in_y_transfer,
        out_z_value             => in_z_transfer,
        out_led                 => led,
        out_cordic_mode         => cordic_mode,
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
        x_select                => switches(9),
        y_select                => switches(10),
        z_select                => switches(11),
        iteration_select        => switches(15 downto 12),
        anode                   => anode,
        segment                 => segment
    );

    test_data_ready <= complete_transfer;
    test_x_result   <= out_x_transfer;
    test_y_result   <= out_y_transfer;
    test_z_result   <= out_z_transfer; 
    test_iteration  <= iteration_transfer;
    
end behaviour;
