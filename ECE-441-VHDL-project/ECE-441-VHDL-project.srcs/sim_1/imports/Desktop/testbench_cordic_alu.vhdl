library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity cordic_alu_tb is
end cordic_alu_tb;

architecture tb of cordic_alu_tb is
    signal trigger : std_logic;
    signal x_in, y_in, z_in, theta : signed( 15 downto 0 ); 
    signal i : std_logic_vector (3 downto 0);
    signal mu : std_logic;
    signal x_out, y_out, z_out : signed ( 15 downto 0 );
    signal done : std_logic;
begin
    -- connecting testbench signals with half_adder.vhd
    UUT : entity work.cordic_alu port map (
     trigger => trigger,
     x_in => x_in,
     y_in => y_in,
     z_in => z_in,
     theta => theta,
     i => i,
     mu => mu,
     x_out => x_out,
     y_out => y_out,
     z_out => z_out,
     done => done
    );

    testbench: process
    begin
        trigger <= '0', '1' after 10ns, '0' after 20ns, '1' after 30ns, '0' after 40ns, '1' after 50ns,
        '0' after 60ns, '1' after 70ns, '0' after 80ns, '1' after 90ns, '0' after 100ns,
        '1' after 110ns, '0' after 120ns, '1' after 130ns, '0' after 140ns, '1' after 150ns,
        '0' after 160ns, '1' after 170ns, '0' after 180ns, '1' after 190ns, '0' after 200ns,
        '1' after 210ns, '0' after 220ns, '1' after 230ns, '0' after 240ns, '1' after 250ns,
        '0' after 260ns, '1' after 270ns, '0' after 280ns, '1' after 290ns, '0' after 300ns;
        
        x_in <= x"4000", x"4000" after 25ns, x"6000" after 45ns, x"5800" after 65ns, x"5F00" after 85ns,
        x"5C30" after 105ns, x"5A99" after 125ns, x"5B70" after 145ns, x"5B07" after 165ns, x"5B3C" after 185ns,
        x"5B56" after 205ns, x"5B49" after 225ns, x"5B43" after 245ns, x"5B46" after 265ns, x"5B44" after 285ns, x"5B45" after 305ns;
        
        y_in <= x"0000", x"4000" after 25ns, x"2000" after 45ns, x"3800" after 65ns, x"2D00" after 85ns,
        x"32F0" after 105ns, x"35D2" after 125ns, x"3467" after 145ns, x"351E" after 165ns, x"534C3" after 185ns,
        x"3495" after 205ns, x"34AC" after 225ns, x"34B8" after 245ns, x"34B2" after 265ns, x"34B5" after 285ns, x"34B3" after 305ns;
        
        i <= x"0", x"1" after 25ns, x"2" after 45ns, x"3" after 65ns, x"4" after 85ns, x"5" after 105ns, x"6" after 125ns, x"7" after 145ns,
        x"8" after 165ns, x"9" after 185ns, x"A" after 205ns, x"B" after 225ns, x"C" after 245ns, x"D" after 265ns, x"E" after 285ns, x"F" after 305ns;
        
        z_in <= x"0000";
        theta <= x"0000";
        
        mu <= '1', '0' after 25ns, '1' after 45ns, '0' after 65ns, '1' after 85ns,
        '1' after 105ns, '0' after 125ns, '1' after 145ns, '0' after 165ns, '0' after 185ns,
        '1' after 205ns , '1' after 225ns, '0' after 245ns, '1' after 265ns, '0' after 285ns, '0' after 305ns;
        wait;
    end process;
end tb;