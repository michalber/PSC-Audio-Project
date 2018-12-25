----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.12.2018 17:39:59
-- Design Name: 
-- Module Name: HHat - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HHat is
    Port ( CLK : in STD_LOGIC;
           CE : in STD_LOGIC;
           RST : in STD_LOGIC;
           PLAY : in STD_LOGIC;
           SAMPLE_OUT : out signed(7 downto 0)
           );
end HHat;

architecture Behavioral of HHat is

type memory is array (0 to 3079) of signed(7 downto 0);
constant hhat_sound: memory := (
	x"01", x"FE", x"01", x"FE", x"01", x"01", x"FF", x"F8", x"C6", x"E9", x"27", x"03",
	x"00", x"15", x"06", x"04", x"ED", x"11", x"20", x"17", x"04", x"F9", x"F0", x"06",
	x"FD", x"0B", x"10", x"E1", x"D9", x"DA", x"F1", x"E1", x"F6", x"F7", x"FF", x"E2",
	x"E0", x"F5", x"FC", x"0A", x"EF", x"D7", x"D0", x"F0", x"FC", x"DA", x"DF", x"F6",
	x"07", x"22", x"06", x"F3", x"F2", x"E9", x"EB", x"0E", x"FB", x"04", x"21", x"1C",
	x"23", x"D3", x"DB", x"DA", x"D0", x"FF", x"05", x"0E", x"0C", x"01", x"FC", x"0C",
	x"02", x"15", x"06", x"0F", x"F3", x"FF", x"E5", x"C8", x"D6", x"B3", x"FD", x"04",
	x"25", x"13", x"18", x"17", x"00", x"27", x"0D", x"ED", x"09", x"1A", x"12", x"2A",
	x"26", x"27", x"1A", x"19", x"F7", x"ED", x"EE", x"F0", x"FE", x"F1", x"F4", x"DD",
	x"F9", x"F9", x"0D", x"F1", x"D9", x"13", x"0F", x"03", x"0F", x"18", x"07", x"1E",
	x"0C", x"E7", x"18", x"2B", x"17", x"24", x"ED", x"08", x"26", x"3A", x"06", x"F6",
	x"14", x"08", x"24", x"1B", x"21", x"0A", x"04", x"F9", x"09", x"F6", x"08", x"09",
	x"FF", x"F4", x"E7", x"04", x"1D", x"F6", x"F7", x"00", x"F9", x"03", x"1C", x"06",
	x"10", x"22", x"FF", x"2C", x"18", x"2C", x"0E", x"2F", x"1B", x"FC", x"28", x"FC",
	x"F1", x"F9", x"F2", x"00", x"FF", x"02", x"FD", x"DD", x"F5", x"00", x"FA", x"02",
	x"19", x"05", x"13", x"09", x"03", x"04", x"FB", x"12", x"23", x"02", x"19", x"1B",
	x"F6", x"FA", x"E8", x"ED", x"FB", x"FC", x"EF", x"09", x"F1", x"15", x"F7", x"FD",
	x"F3", x"F5", x"03", x"FB", x"FE", x"DC", x"02", x"ED", x"E9", x"D1", x"03", x"01",
	x"E1", x"03", x"0F", x"14", x"03", x"18", x"24", x"14", x"F9", x"04", x"10", x"10",
	x"07", x"F7", x"1A", x"04", x"07", x"FE", x"24", x"E2", x"F8", x"04", x"F8", x"04",
	x"F2", x"13", x"E8", x"00", x"F0", x"13", x"DA", x"13", x"E2", x"F5", x"00", x"F7",
	x"15", x"F0", x"0D", x"00", x"05", x"EA", x"00", x"FC", x"13", x"DB", x"EE", x"FC",
	x"03", x"07", x"05", x"FA", x"FD", x"F5", x"FF", x"09", x"ED", x"F8", x"FA", x"E3",
	x"07", x"0B", x"F1", x"14", x"F1", x"08", x"12", x"16", x"F0", x"06", x"11", x"F3",
	x"E0", x"F9", x"FE", x"D9", x"F0", x"F6", x"E7", x"E8", x"F0", x"FB", x"F2", x"EB",
	x"06", x"E2", x"EE", x"08", x"EB", x"F9", x"F2", x"07", x"03", x"DD", x"0A", x"E9",
	x"FA", x"EC", x"F4", x"ED", x"F9", x"09", x"04", x"07", x"EF", x"00", x"F5", x"FF",
	x"00", x"F7", x"E1", x"01", x"DB", x"F1", x"F1", x"F6", x"F6", x"E5", x"FB", x"F5",
	x"F8", x"FA", x"FF", x"FD", x"FC", x"F3", x"09", x"E3", x"06", x"01", x"F7", x"00",
	x"EB", x"F1", x"F6", x"05", x"EF", x"05", x"EE", x"E4", x"F1", x"E1", x"06", x"F6",
	x"F8", x"16", x"F8", x"1A", x"17", x"F2", x"19", x"09", x"15", x"14", x"0A", x"00",
	x"04", x"FF", x"F6", x"02", x"EA", x"F1", x"DA", x"02", x"E1", x"EB", x"F9", x"E5",
	x"F8", x"F2", x"EE", x"01", x"0B", x"F4", x"08", x"00", x"11", x"FB", x"FB", x"07",
	x"08", x"02", x"08", x"FE", x"F9", x"13", x"04", x"16", x"01", x"FC", x"01", x"15",
	x"12", x"F6", x"0F", x"00", x"03", x"12", x"FD", x"F2", x"21", x"F5", x"FC", x"0C",
	x"F0", x"01", x"EB", x"F2", x"FB", x"00", x"F3", x"FF", x"DA", x"04", x"00", x"F3",
	x"F0", x"FB", x"FD", x"ED", x"FB", x"F2", x"03", x"F5", x"0C", x"F2", x"0D", x"FD",
	x"18", x"0E", x"FF", x"17", x"0F", x"0C", x"04", x"FD", x"FF", x"17", x"FA", x"0E",
	x"FE", x"F5", x"06", x"0A", x"F7", x"08", x"FE", x"11", x"11", x"09", x"0C", x"FE",
	x"06", x"00", x"07", x"FE", x"F5", x"F5", x"0F", x"EB", x"F5", x"00", x"F2", x"0D",
	x"01", x"F8", x"F9", x"F4", x"0F", x"F2", x"F5", x"FA", x"F4", x"F8", x"F6", x"0A",
	x"F8", x"0E", x"04", x"11", x"19", x"10", x"1F", x"0A", x"0E", x"08", x"11", x"1B",
	x"02", x"0A", x"EC", x"01", x"04", x"F1", x"04", x"FA", x"FB", x"03", x"06", x"F1",
	x"03", x"FC", x"F0", x"FF", x"FA", x"09", x"00", x"FC", x"13", x"FD", x"07", x"FF",
	x"FF", x"FF", x"FE", x"01", x"08", x"10", x"F7", x"06", x"0B", x"0B", x"01", x"05",
	x"0E", x"FA", x"04", x"03", x"0A", x"0F", x"FD", x"0B", x"07", x"07", x"08", x"00",
	x"00", x"04", x"FD", x"01", x"F0", x"F8", x"FF", x"F8", x"FF", x"F1", x"FC", x"03",
	x"05", x"03", x"07", x"03", x"0C", x"09", x"0A", x"09", x"0A", x"0C", x"02", x"F8",
	x"06", x"FC", x"FA", x"FD", x"F1", x"00", x"FA", x"05", x"FC", x"04", x"FE", x"05",
	x"F4", x"FE", x"07", x"FA", x"02", x"FF", x"03", x"F4", x"00", x"05", x"00", x"05",
	x"0B", x"FC", x"07", x"05", x"07", x"0D", x"00", x"01", x"F7", x"F9", x"F1", x"FA",
	x"F2", x"F8", x"05", x"F4", x"F4", x"F0", x"FB", x"F2", x"0A", x"FC", x"F8", x"06",
	x"F6", x"F9", x"FF", x"06", x"FA", x"FF", x"FB", x"02", x"01", x"0B", x"10", x"0B",
	x"0B", x"0E", x"FF", x"0B", x"06", x"0C", x"08", x"FF", x"FC", x"F9", x"05", x"FC",
	x"09", x"00", x"04", x"F4", x"00", x"00", x"07", x"F8", x"F1", x"00", x"F3", x"F7",
	x"FF", x"F7", x"F6", x"FD", x"F1", x"FE", x"F7", x"FF", x"04", x"07", x"0C", x"00",
	x"09", x"08", x"0A", x"10", x"0E", x"0A", x"09", x"01", x"01", x"0B", x"00", x"00",
	x"FD", x"06", x"02", x"01", x"03", x"09", x"00", x"03", x"FC", x"FA", x"03", x"FC",
	x"0A", x"FC", x"03", x"FA", x"FD", x"F6", x"FF", x"F8", x"FC", x"03", x"FE", x"FB",
	x"FB", x"0A", x"FD", x"FD", x"FD", x"02", x"FB", x"FF", x"01", x"06", x"08", x"05",
	x"FD", x"03", x"FB", x"02", x"00", x"00", x"07", x"03", x"01", x"F9", x"FF", x"F8",
	x"FC", x"FE", x"04", x"00", x"03", x"0C", x"02", x"09", x"0E", x"06", x"07", x"00",
	x"02", x"04", x"09", x"06", x"FF", x"FE", x"00", x"01", x"FF", x"01", x"FA", x"FC",
	x"F8", x"F9", x"FB", x"FF", x"F4", x"F9", x"FE", x"F8", x"FF", x"02", x"03", x"01",
	x"06", x"07", x"01", x"0D", x"09", x"03", x"08", x"03", x"0F", x"0A", x"0A", x"04",
	x"FF", x"00", x"02", x"FF", x"F9", x"F8", x"F7", x"F7", x"F8", x"FB", x"FC", x"FD",
	x"FA", x"FD", x"FD", x"00", x"FF", x"03", x"FE", x"01", x"07", x"00", x"05", x"06",
	x"04", x"0B", x"02", x"03", x"06", x"FF", x"00", x"03", x"FC", x"FC", x"FB", x"F4",
	x"F8", x"F3", x"F7", x"FA", x"FD", x"F4", x"FC", x"FA", x"FD", x"FD", x"00", x"05",
	x"01", x"05", x"03", x"0C", x"05", x"08", x"07", x"04", x"08", x"03", x"05", x"02",
	x"FC", x"05", x"FE", x"FE", x"FD", x"FB", x"FA", x"F9", x"00", x"FD", x"02", x"01",
	x"FA", x"FF", x"FF", x"01", x"04", x"03", x"01", x"00", x"07", x"06", x"08", x"06",
	x"07", x"03", x"FF", x"03", x"06", x"04", x"02", x"01", x"00", x"01", x"04", x"FD",
	x"FB", x"FE", x"FD", x"FE", x"FF", x"00", x"FD", x"00", x"FD", x"02", x"04", x"00",
	x"03", x"05", x"07", x"07", x"00", x"06", x"01", x"FE", x"FF", x"01", x"FD", x"02",
	x"04", x"01", x"04", x"FB", x"01", x"FD", x"02", x"FA", x"FA", x"F9", x"FA", x"FF",
	x"FC", x"FC", x"F6", x"FD", x"01", x"FF", x"01", x"01", x"07", x"0A", x"07", x"0B",
	x"01", x"09", x"04", x"08", x"08", x"08", x"06", x"02", x"04", x"FF", x"FC", x"FA",
	x"FA", x"F7", x"FA", x"F8", x"FA", x"F7", x"F8", x"F5", x"F5", x"F4", x"F7", x"FC",
	x"F9", x"FD", x"FC", x"00", x"02", x"03", x"06", x"09", x"09", x"07", x"09", x"0B",
	x"0E", x"09", x"0B", x"08", x"03", x"05", x"04", x"04", x"FF", x"02", x"FC", x"FC",
	x"F9", x"FB", x"F7", x"F4", x"F9", x"F5", x"F9", x"FA", x"F6", x"F8", x"FC", x"FF",
	x"04", x"00", x"04", x"03", x"04", x"06", x"08", x"08", x"09", x"03", x"03", x"02",
	x"03", x"01", x"00", x"00", x"FC", x"FB", x"FA", x"FE", x"F8", x"FE", x"F9", x"FB",
	x"F8", x"F8", x"FC", x"FC", x"02", x"00", x"FF", x"FF", x"01", x"04", x"02", x"03",
	x"00", x"FB", x"FE", x"00", x"00", x"03", x"02", x"FF", x"FF", x"00", x"FD", x"FD",
	x"FC", x"FA", x"00", x"FB", x"FD", x"F9", x"FA", x"F9", x"FD", x"FE", x"FA", x"FE",
	x"FC", x"00", x"02", x"02", x"FF", x"01", x"03", x"FF", x"02", x"04", x"01", x"02",
	x"FF", x"01", x"FE", x"FE", x"FE", x"FD", x"FB", x"F9", x"FA", x"FB", x"FC", x"FC",
	x"FE", x"F9", x"FA", x"FF", x"FF", x"FE", x"FF", x"FD", x"FF", x"02", x"00", x"FF",
	x"03", x"00", x"05", x"03", x"00", x"01", x"FF", x"00", x"02", x"00", x"FD", x"FE",
	x"FC", x"00", x"FC", x"FD", x"FC", x"FA", x"F9", x"FA", x"FB", x"FA", x"FC", x"FC",
	x"FA", x"FD", x"FE", x"FF", x"00", x"FD", x"01", x"00", x"00", x"02", x"04", x"01",
	x"02", x"01", x"FF", x"00", x"FF", x"FB", x"FC", x"FF", x"FB", x"F8", x"F9", x"FB",
	x"FA", x"FF", x"F8", x"FA", x"FB", x"F9", x"03", x"FC", x"FD", x"FB", x"FE", x"00",
	x"00", x"02", x"FE", x"03", x"00", x"03", x"04", x"01", x"05", x"05", x"03", x"05",
	x"05", x"03", x"01", x"01", x"FE", x"FF", x"01", x"FA", x"FF", x"FB", x"FC", x"FC",
	x"F7", x"FA", x"F9", x"FC", x"FD", x"FD", x"FC", x"FD", x"01", x"FD", x"01", x"04",
	x"01", x"01", x"04", x"03", x"02", x"04", x"05", x"03", x"02", x"03", x"00", x"02",
	x"01", x"FF", x"FE", x"FD", x"FE", x"FB", x"FC", x"FF", x"01", x"01", x"FD", x"FF",
	x"FE", x"00", x"04", x"00", x"01", x"00", x"03", x"01", x"FE", x"02", x"FF", x"FE",
	x"00", x"FF", x"FD", x"00", x"00", x"FD", x"FC", x"FB", x"FC", x"FB", x"F9", x"FB",
	x"FB", x"FC", x"FC", x"FC", x"FD", x"FE", x"01", x"01", x"01", x"FE", x"01", x"03",
	x"04", x"02", x"02", x"04", x"01", x"01", x"02", x"00", x"FC", x"FF", x"FE", x"FD",
	x"FE", x"FD", x"FE", x"FE", x"FE", x"FF", x"FF", x"FF", x"00", x"01", x"01", x"00",
	x"02", x"FF", x"02", x"FF", x"FD", x"FF", x"FD", x"00", x"FD", x"FF", x"F9", x"FB",
	x"FE", x"FD", x"FD", x"FB", x"FE", x"FC", x"FE", x"00", x"00", x"00", x"FF", x"00",
	x"01", x"01", x"00", x"01", x"02", x"05", x"03", x"02", x"01", x"00", x"00", x"00",
	x"00", x"01", x"FF", x"FD", x"FF", x"FC", x"FE", x"FE", x"FE", x"FE", x"FD", x"FE",
	x"FC", x"00", x"FC", x"FF", x"FD", x"FC", x"FE", x"FC", x"FF", x"00", x"00", x"FF",
	x"FD", x"FF", x"00", x"FF", x"02", x"02", x"02", x"01", x"02", x"01", x"03", x"03",
	x"02", x"03", x"01", x"FF", x"01", x"01", x"FE", x"FE", x"FE", x"FD", x"FC", x"FC",
	x"FA", x"FB", x"FC", x"FB", x"FC", x"FE", x"FD", x"FE", x"00", x"00", x"02", x"02",
	x"02", x"02", x"02", x"04", x"02", x"04", x"03", x"04", x"00", x"00", x"00", x"FD",
	x"FE", x"FE", x"FF", x"FD", x"FE", x"FD", x"FE", x"FD", x"FD", x"FE", x"FE", x"FF",
	x"FF", x"FF", x"01", x"00", x"01", x"04", x"02", x"02", x"01", x"02", x"00", x"01",
	x"01", x"01", x"02", x"01", x"00", x"01", x"01", x"FE", x"00", x"FE", x"FD", x"FF",
	x"FF", x"FE", x"FF", x"FF", x"FF", x"FF", x"FD", x"00", x"FE", x"00", x"01", x"00",
	x"FF", x"00", x"01", x"00", x"01", x"01", x"03", x"00", x"01", x"03", x"FF", x"01",
	x"01", x"01", x"02", x"02", x"00", x"01", x"00", x"FE", x"FF", x"FE", x"FD", x"FD",
	x"FF", x"FF", x"00", x"00", x"01", x"00", x"FF", x"00", x"00", x"00", x"FE", x"FE",
	x"FF", x"FF", x"00", x"01", x"FF", x"FF", x"01", x"FF", x"FF", x"FF", x"FE", x"01",
	x"FF", x"00", x"FF", x"FE", x"FF", x"FE", x"00", x"FF", x"FE", x"FE", x"00", x"00",
	x"01", x"01", x"01", x"02", x"02", x"02", x"00", x"01", x"00", x"01", x"01", x"FE",
	x"FF", x"00", x"FF", x"FF", x"FF", x"FE", x"FE", x"FE", x"FE", x"FF", x"FF", x"FE",
	x"FF", x"FE", x"FE", x"FE", x"FF", x"FF", x"FF", x"00", x"FE", x"00", x"00", x"00",
	x"00", x"00", x"00", x"FF", x"01", x"00", x"FF", x"01", x"01", x"FF", x"00", x"FF",
	x"00", x"01", x"01", x"00", x"00", x"00", x"00", x"02", x"00", x"00", x"00", x"FE",
	x"FE", x"FF", x"00", x"00", x"00", x"00", x"FF", x"00", x"FF", x"FE", x"FF", x"FE",
	x"FD", x"FD", x"FD", x"FD", x"FE", x"FF", x"FD", x"FE", x"FF", x"FE", x"FE", x"FE",
	x"FE", x"00", x"00", x"00", x"00", x"00", x"FF", x"02", x"03", x"03", x"01", x"01",
	x"02", x"01", x"02", x"00", x"00", x"00", x"FF", x"FF", x"FF", x"FE", x"FE", x"FE",
	x"FD", x"FE", x"FD", x"FD", x"FE", x"FE", x"FE", x"FE", x"FF", x"FD", x"FE", x"FF",
	x"FF", x"00", x"00", x"01", x"00", x"01", x"02", x"02", x"02", x"00", x"01", x"03",
	x"02", x"00", x"01", x"FF", x"FF", x"FF", x"00", x"00", x"00", x"00", x"FF", x"01",
	x"00", x"FF", x"00", x"02", x"FF", x"00", x"01", x"00", x"02", x"02", x"02", x"01",
	x"02", x"01", x"02", x"01", x"02", x"01", x"01", x"00", x"FF", x"01", x"00", x"00",
	x"00", x"01", x"FF", x"00", x"FF", x"01", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF",
	x"01", x"FF", x"00", x"FF", x"01", x"01", x"01", x"02", x"03", x"01", x"01", x"02",
	x"01", x"01", x"01", x"01", x"00", x"FF", x"FE", x"00", x"FE", x"FE", x"FE", x"FD",
	x"FF", x"FE", x"FE", x"FE", x"FE", x"FE", x"00", x"00", x"00", x"01", x"00", x"00",
	x"00", x"01", x"01", x"FF", x"00", x"FE", x"FF", x"FE", x"FE", x"FE", x"FE", x"FE",
	x"FE", x"FF", x"FE", x"FE", x"FF", x"FF", x"00", x"FF", x"FF", x"00", x"00", x"00",
	x"00", x"01", x"01", x"00", x"01", x"02", x"02", x"02", x"02", x"01", x"01", x"00",
	x"00", x"00", x"00", x"00", x"00", x"01", x"00", x"FF", x"FF", x"00", x"00", x"00",
	x"00", x"00", x"01", x"01", x"01", x"01", x"00", x"01", x"01", x"02", x"01", x"01",
	x"01", x"01", x"02", x"00", x"01", x"01", x"01", x"01", x"00", x"00", x"00", x"00",
	x"01", x"01", x"00", x"00", x"00", x"FE", x"00", x"00", x"FF", x"00", x"FF", x"00",
	x"FF", x"00", x"00", x"00", x"01", x"01", x"00", x"00", x"01", x"01", x"01", x"00",
	x"00", x"00", x"00", x"00", x"00", x"00", x"FF", x"FF", x"FF", x"FE", x"FE", x"FE",
	x"FD", x"FE", x"FC", x"FC", x"FE", x"FE", x"FD", x"FE", x"FF", x"FE", x"FF", x"00",
	x"FF", x"FF", x"00", x"01", x"00", x"00", x"00", x"00", x"01", x"01", x"00", x"00",
	x"00", x"FF", x"FF", x"FF", x"FE", x"FE", x"FE", x"FD", x"FD", x"FD", x"FD", x"FD",
	x"FE", x"FD", x"FD", x"FE", x"FE", x"FF", x"FE", x"FE", x"FF", x"FF", x"FF", x"00",
	x"FF", x"FE", x"FF", x"FF", x"FF", x"FF", x"00", x"FF", x"FF", x"00", x"00", x"FF",
	x"00", x"FF", x"FF", x"00", x"FE", x"FF", x"FE", x"FE", x"FE", x"FD", x"FD", x"FD",
	x"FD", x"FC", x"FC", x"FD", x"FE", x"FD", x"FE", x"FE", x"FE", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"00", x"00", x"01", x"01", x"00", x"00", x"FF", x"00", x"FF", x"FF",
	x"00", x"FF", x"FF", x"FF", x"FE", x"FF", x"FF", x"FF", x"FE", x"FE", x"FE", x"FE",
	x"FF", x"FF", x"FE", x"FE", x"FF", x"FE", x"FE", x"FF", x"FE", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"00", x"00", x"01", x"00", x"00", x"00", x"00", x"FF", x"00", x"00",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"00", x"FF", x"00", x"00", x"FF",
	x"FF", x"00", x"FF", x"FF", x"FE", x"FF", x"FF", x"FE", x"00", x"00", x"00", x"00",
	x"00", x"01", x"00", x"00", x"01", x"01", x"00", x"00", x"01", x"00", x"00", x"FF",
	x"FF", x"00", x"FF", x"FF", x"FF", x"FF", x"FE", x"FE", x"FE", x"FE", x"FE", x"FE",
	x"FE", x"FE", x"FE", x"FF", x"00", x"01", x"00", x"00", x"01", x"01", x"01", x"01",
	x"01", x"01", x"01", x"00", x"00", x"01", x"01", x"00", x"00", x"00", x"FF", x"00",
	x"FF", x"FF", x"00", x"FF", x"00", x"FF", x"FF", x"FF", x"00", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"00", x"00", x"00", x"01", x"00", x"FF", x"00", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"FF", x"00", x"00", x"00", x"00",
	x"00", x"FF", x"00", x"00", x"FF", x"00", x"FF", x"FF", x"00", x"FF", x"00", x"FF",
	x"00", x"00", x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"00", x"00", x"00", x"01",
	x"01", x"00", x"00", x"00", x"00", x"FF", x"FF", x"FF", x"00", x"FF", x"FF", x"FF",
	x"FF", x"00", x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"FF", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FE", x"00", x"FF", x"FF", x"FF", x"00", x"00",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"FF", x"00", x"00", x"FF", x"00", x"00",
	x"FF", x"00", x"00", x"FF", x"00", x"00", x"00", x"00", x"00", x"00", x"01", x"00",
	x"00", x"00", x"FF", x"00", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"00", x"FF",
	x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FE", x"FE", x"FE", x"FF", x"FF", x"FE", x"FF", x"FF",
	x"FF", x"FF", x"00", x"00", x"01", x"00", x"01", x"02", x"01", x"02", x"01", x"02",
	x"01", x"01", x"01", x"00", x"00", x"00", x"00", x"FF", x"FF", x"FE", x"FE", x"FE",
	x"FE", x"FE", x"FF", x"FE", x"FE", x"FE", x"FF", x"FF", x"FF", x"00", x"00", x"00",
	x"00", x"01", x"01", x"02", x"01", x"01", x"01", x"01", x"02", x"01", x"01", x"01",
	x"01", x"00", x"01", x"00", x"00", x"00", x"00", x"00", x"00", x"FF", x"00", x"FF",
	x"FF", x"00", x"FF", x"00", x"FF", x"FF", x"00", x"00", x"00", x"00", x"FF", x"00",
	x"FF", x"FF", x"00", x"00", x"FF", x"00", x"00", x"00", x"00", x"FF", x"00", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"00", x"00", x"00", x"00", x"FF", x"FF",
	x"00", x"FF", x"FF", x"FF", x"00", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"FF",
	x"FF", x"FF", x"00", x"00", x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"00", x"FF",
	x"FF", x"FF", x"FF", x"00", x"FF", x"FF", x"00", x"FF", x"FF", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FE", x"FF", x"FF",
	x"FF", x"FF", x"FE", x"FF", x"FF", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
	x"00", x"00", x"00", x"00", x"00", x"00", x"FF", x"00", x"00", x"FF", x"FF", x"FF",
	x"FE", x"FE", x"FE", x"FE", x"FE", x"FE", x"FE", x"FE", x"FE", x"FE", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"00", x"00", x"00", x"00", x"FF", x"FF", x"00", x"FF", x"00",
	x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"FF", x"FF", x"00",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"00", x"00", x"00", x"00", x"00", x"00", x"01", x"00", x"00", x"01",
	x"00", x"01", x"01", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"FF", x"00",
	x"FF", x"FF", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
	x"00", x"FF", x"00", x"00", x"FF", x"00", x"00", x"FF", x"FF", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"FF", x"FF", x"FF", x"00", x"00",
	x"00", x"FF", x"00", x"00", x"00", x"00", x"FF", x"FF", x"00", x"FF", x"00", x"00",
	x"FF", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"FF",
	x"00", x"00", x"00", x"FF", x"00", x"FF", x"FF", x"FF", x"00", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"00", x"FF", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
	x"00", x"00", x"00", x"01", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
	x"00", x"00", x"00", x"00", x"00", x"01", x"00", x"00", x"00", x"01", x"00", x"00",
	x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"00", x"00",
	x"00", x"00", x"00", x"00", x"00", x"FF", x"00", x"00", x"00", x"FF", x"00", x"00",
	x"00", x"00", x"00", x"FF", x"00", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"00",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF",
	x"FF", x"00", x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"FF", x"00", x"00", x"00",
	x"00", x"00", x"00", x"00", x"FF", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
	x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
	x"FF", x"00", x"00", x"00", x"00", x"00", x"FF", x"00", x"00", x"FF", x"FF", x"FF",
	x"00", x"00", x"FF", x"FF", x"FF", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
	x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
	x"00", x"00", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FE", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"FF", x"FF", x"00", x"FF", x"00", x"00",
	x"00", x"00", x"00", x"00", x"00", x"00", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF",
	x"FF", x"00", x"00", x"00", x"00", x"00", x"FF", x"FF", x"00", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF",
	x"00", x"FF", x"00", x"00", x"FF", x"00", x"FF", x"00", x"00", x"00", x"00", x"00",
	x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"FF", x"00",
	x"00", x"00", x"00", x"00", x"00", x"FF", x"00", x"00", x"00", x"00", x"00", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF",
	x"FF", x"00", x"FF", x"00", x"00", x"00", x"00", x"00", x"00", x"FF", x"00", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"FF", x"00", x"00",
	x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
	x"FF", x"FF", x"FF", x"00", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"00",
	x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
	x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
	x"00", x"00", x"FF", x"FF", x"FF", x"FF", x"00", x"FF", x"FF", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"FF", x"FF", x"00",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"FF", x"00", x"00", x"00",
	x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
	x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FE", x"FF", x"FE", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"00", x"FF", x"00", x"FF", x"FF",
	x"00", x"00", x"FF", x"FF", x"00", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"00", x"00", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"FF", x"FF", x"FF",
	x"FF", x"00", x"00", x"00", x"FF", x"00", x"00", x"FF", x"00", x"00", x"FF", x"FF",
	x"FF", x"FF", x"00", x"FF", x"00", x"FF", x"FF", x"FF", x"00", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"00", x"00", x"00", x"00",
	x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"00", x"00", x"00", x"00",
	x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
	x"00", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF",
	x"FF", x"FF", x"FF", x"FF", x"FF", x"00", x"FF", x"00"
	);
	
signal cnt_out: unsigned(12 downto 0) := (others => '0');	
signal play_sound: std_logic := '0';
constant cnt_max: integer := 3079;
signal out_signal: signed(7 downto 0) := x"00";

begin
	
process (CLK)
begin
    if rising_edge(CLK) then
        if RST = '1' then
            play_sound <= '0';
        elsif PLAY = '1' then
            play_sound <= '1';
        elsif PLAY = '0' and cnt_out = cnt_max then
            play_sound <= '0';
        end if;
    end if;
end process;

	
-- 12bit counter
process (CLK)
begin     
    if rising_edge(CLK) then
        if RST = '1' then
            cnt_out <= (others => '0');
        elsif CE = '1' and play_sound = '1' then
            cnt_out <= cnt_out + 1;       
        end if;
        if cnt_out = cnt_max then
            cnt_out <= (others => '0');            
        end if;        
    end if;
end process;

--SAMPLE_OUT <= kick_sound(conv_integer(cnt_out));
process (CLK) 
begin
    if rising_edge(CLK) then
        if RST = '1' then
            out_signal <= x"00";
        elsif CE = '1' then
            out_signal <= hhat_sound(conv_integer(cnt_out));
        end if;
    end if;    
end process;

SAMPLE_OUT <= out_signal;

end Behavioral;