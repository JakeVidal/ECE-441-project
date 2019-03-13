
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Describes mathematical heart of the cordic algorithm
-- mu: boolean, false -> -1, true -> 1

entity cordic_alu is 

    Port (
        trigger		:	in	std_logic;
        x_in        :	in	signed ( 15 downto 0 );
        y_in        :   in	signed ( 15 downto 0 );
        z_in        :   in	signed ( 15 downto 0 );
        theta       :   in  signed ( 15 downto 0 );
        i		    :   in 	std_logic_vector (  3 downto 0 );
        mu			:	in	std_logic;
        x_out       :	out	signed ( 15 downto 0 )                := (others => '0');
        y_out       :	out	signed ( 15 downto 0 )                := (others => '0');
        z_out       :	out	signed ( 15 downto 0 )                := (others => '0')
    );
end cordic_alu;


architecture behav of cordic_alu is

begin

    x_calc: process ( trigger ) is
        variable tempx: signed (15 downto 0);
    begin	
        if rising_edge(trigger) then
            
            tempx := shift_right(y_in, to_integer(unsigned(i)));
            
            if (mu = '1') then
                x_out <= x_in - tempx;
            else
                x_out <= x_in + tempx;
            end if;
        end if;
    
    end process;
    
    y_calc: process ( trigger ) is
        variable tempy: signed (15 downto 0);
    begin
        
        if rising_edge(trigger) then
        
            tempy :=  shift_right(x_in, to_integer(unsigned(i)));
            
            if (mu = '1') then
                y_out <= y_in + tempy;
            else
                y_out <= y_in - tempy;
            end if;
        end if;
    
    end process;
    
    z_calc: process ( trigger ) is
    
    begin
        if rising_edge(trigger) then
            if (mu = '1') then
                z_out <= z_in - theta; --theta never greater than 14 bits -> signed/unsigned doesn't matter
            else
                z_out <= z_in + theta;
            end if;
        end if;
    
    end process;
end;