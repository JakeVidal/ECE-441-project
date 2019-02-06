library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity myNANDgate is
port (
a,b : in STD_LOGIC;
Y : out STD_LOGIC
);
end myNANDgate;
architecture Lab2 of myNANDgate is
begin
Y <= a NAND b;
end Lab2;
