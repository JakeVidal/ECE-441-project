
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
        z_out       :	out	signed ( 15 downto 0 )                := (others => '0');
        done		:	out std_logic                             := '0'
    );
end cordic_alu;


architecture behav of cordic_alu is
    signal x_done: std_logic := '0';
    signal y_done: std_logic := '0';
    signal z_done: std_logic := '0';
begin

    x_calc: process ( trigger ) is
        variable tempx: signed (15 downto 0);
    begin	
        if rising_edge(trigger) then
            --x_done <= '0';
            
            if (y_in >= 0) then
                tempx := signed( shift_right(unsigned(abs(y_in)),to_integer(unsigned(i))));
            else
                tempx := -signed( shift_right(unsigned(abs(y_in)),to_integer(unsigned(i))));
            end if;
            
            if (mu = '1') then
                x_out <= x_in - tempx;
            else
                x_out <= x_in + tempx;
            end if;
            
            x_done <= '1';
        
        end if;
    
    end process;
    
    y_calc: process ( trigger ) is
        variable tempy: signed (15 downto 0);
    begin
        
        if rising_edge(trigger) then
            --y_done <= '0';
            
            if (x_in >= 0) then
                tempy :=  signed( shift_right(unsigned(abs(x_in)), to_integer(unsigned(i)) ) );
            else
                tempy := -signed( shift_right(unsigned(abs(x_in)), to_integer(unsigned(i)) ) );
            end if;
            
            if (mu = '1') then
                y_out <= y_in + tempy;
            else
                y_out <= y_in - tempy;
            end if;
            
            y_done <= '1';
        end if;
    
    end process;
    
    z_calc: process ( trigger ) is
    
    begin
        if rising_edge(trigger) then
            --z_done <= '0';
        
            if (mu = '1') then
                z_out <= z_in - theta; --theta never greater than 14 bits -> signed/unsigned doesn't matter
            else
                z_out <= z_in + theta;
            end if;
            
            z_done <= '1';
        
        end if;
    
    end process;
    
    done_reset: process(trigger) is
    begin
        if falling_edge(trigger) then
            x_done <= '0';
            y_done <= '0';
            z_done <= '0';
            --done <= '0';
        end if;
    end process done_reset;
    
    done_set: process(x_done, y_done, z_done) is
    begin
        if((x_done = '1') and (y_done = '1') and (z_done = '1')) then
            done <= '1';
        else
            done <= '0';
        end if;
    end process done_set;
end;