----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.12.2018 23:25:25
-- Design Name: 
-- Module Name: Kick - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Kick is
    Port ( CLK : in STD_LOGIC;
           CE : in STD_LOGIC;
           RST : in STD_LOGIC;
           PLAY : in STD_LOGIC;
           KICK_SAMP_O : out signed(7 downto 0)
           );
end Kick;

architecture Behavioral of Kick is

type memory is array (0 to 2847) of signed(7 downto 0);
constant kick_sound: memory := (
	x"FF", x"00", x"FF", x"00", x"FF", x"00", x"00", x"00", x"FF", x"00", x"FE", x"00",
	x"FF", x"00", x"FF", x"00", x"FE", x"00", x"00", x"00", x"06", x"07", x"08", x"08",
	x"11", x"15", x"17", x"16", x"1C", x"21", x"21", x"1D", x"1F", x"22", x"23", x"1D",
	x"20", x"1F", x"22", x"23", x"21", x"22", x"1C", x"22", x"19", x"20", x"14", x"25",
	x"16", x"1F", x"1F", x"0C", x"2E", x"29", x"0C", x"F1", x"0A", x"D7", x"C5", x"E3",
	x"E8", x"F3", x"D9", x"D5", x"CB", x"CF", x"CF", x"AD", x"97", x"AA", x"B9", x"A5",
	x"8B", x"86", x"9C", x"9D", x"AE", x"B0", x"97", x"99", x"AD", x"B4", x"B4", x"B9",
	x"B3", x"A6", x"99", x"A7", x"C0", x"DB", x"CA", x"BA", x"C9", x"DC", x"F7", x"F0",
	x"FD", x"07", x"08", x"2A", x"26", x"22", x"34", x"3F", x"31", x"36", x"58", x"64",
	x"61", x"62", x"63", x"66", x"7B", x"7D", x"7A", x"7A", x"7A", x"77", x"68", x"71",
	x"7B", x"62", x"66", x"72", x"6E", x"6E", x"63", x"5F", x"5F", x"5A", x"5C", x"68",
	x"60", x"60", x"4C", x"43", x"45", x"46", x"3D", x"2A", x"29", x"24", x"13", x"FF",
	x"0E", x"0F", x"0D", x"04", x"FD", x"F9", x"E9", x"E8", x"E6", x"E6", x"DF", x"CF",
	x"C9", x"BD", x"AC", x"B0", x"AC", x"A6", x"AC", x"A7", x"9C", x"A5", x"A5", x"A1",
	x"8F", x"85", x"8F", x"88", x"89", x"91", x"96", x"8F", x"86", x"8E", x"90", x"8A",
	x"8C", x"98", x"8E", x"83", x"8A", x"8E", x"8F", x"93", x"93", x"90", x"8E", x"92",
	x"95", x"89", x"92", x"98", x"9D", x"A2", x"A2", x"A6", x"AA", x"B0", x"B2", x"BE",
	x"BB", x"C4", x"DB", x"DA", x"CE", x"CE", x"EA", x"E9", x"F4", x"FF", x"0E", x"15",
	x"1D", x"31", x"34", x"35", x"3C", x"42", x"46", x"4C", x"44", x"48", x"5D", x"5A",
	x"5D", x"65", x"66", x"64", x"5A", x"65", x"70", x"6A", x"73", x"76", x"75", x"75",
	x"71", x"68", x"6A", x"6D", x"71", x"79", x"78", x"74", x"72", x"77", x"78", x"72",
	x"6D", x"6A", x"64", x"5D", x"66", x"71", x"71", x"69", x"65", x"66", x"59", x"52",
	x"45", x"45", x"41", x"37", x"39", x"33", x"3C", x"38", x"2E", x"28", x"20", x"1A",
	x"1A", x"15", x"11", x"14", x"16", x"1B", x"1C", x"18", x"11", x"10", x"0B", x"03",
	x"00", x"03", x"03", x"04", x"07", x"06", x"0D", x"09", x"03", x"04", x"0C", x"08",
	x"06", x"09", x"13", x"10", x"0C", x"0B", x"0F", x"14", x"13", x"0F", x"0B", x"05",
	x"05", x"08", x"03", x"FD", x"F9", x"FC", x"F9", x"F6", x"F6", x"F9", x"FC", x"FF",
	x"FB", x"EC", x"EC", x"EB", x"E4", x"E4", x"E0", x"E1", x"DC", x"D5", x"D5", x"D1",
	x"D3", x"D9", x"D7", x"CC", x"CC", x"D1", x"CD", x"C9", x"C8", x"C7", x"C5", x"C3",
	x"C6", x"CB", x"C7", x"BE", x"C2", x"C2", x"B8", x"B8", x"C0", x"C6", x"C4", x"BD",
	x"B3", x"AC", x"AD", x"B4", x"B7", x"B9", x"BA", x"B7", x"AF", x"B0", x"B4", x"B6",
	x"BB", x"BD", x"BA", x"B7", x"B6", x"BB", x"BE", x"C0", x"C0", x"BE", x"C5", x"C6",
	x"C6", x"CB", x"CC", x"D3", x"D8", x"DC", x"D9", x"D5", x"D9", x"DE", x"E2", x"E3",
	x"E8", x"EF", x"F5", x"F7", x"ED", x"E6", x"EB", x"F2", x"F5", x"F2", x"F6", x"F6",
	x"F7", x"F1", x"EC", x"EB", x"F0", x"F8", x"F4", x"F0", x"ED", x"F2", x"F4", x"EF",
	x"E6", x"DF", x"E7", x"EA", x"EF", x"F1", x"F2", x"EF", x"EB", x"E6", x"DF", x"DE",
	x"E6", x"EF", x"F6", x"F8", x"F1", x"EC", x"F0", x"F4", x"F8", x"F8", x"FA", x"F9",
	x"FC", x"FD", x"FE", x"01", x"0B", x"0C", x"0C", x"0A", x"0A", x"0C", x"0D", x"13",
	x"1E", x"23", x"26", x"27", x"27", x"23", x"1E", x"1F", x"21", x"24", x"27", x"29",
	x"28", x"2C", x"2E", x"27", x"20", x"1E", x"23", x"24", x"22", x"25", x"26", x"1E",
	x"18", x"17", x"17", x"11", x"0B", x"05", x"FE", x"F9", x"FC", x"00", x"FA", x"F5",
	x"F4", x"F6", x"F5", x"EF", x"E8", x"E7", x"E7", x"EB", x"EE", x"EB", x"E7", x"E4",
	x"E5", x"E6", x"EB", x"EE", x"EB", x"E5", x"E1", x"E5", x"EC", x"EF", x"EF", x"EC",
	x"EB", x"F3", x"F3", x"F4", x"F4", x"F6", x"F6", x"F7", x"F8", x"00", x"06", x"0B",
	x"10", x"0E", x"07", x"03", x"07", x"09", x"0B", x"0D", x"0F", x"10", x"0B", x"09",
	x"0B", x"0D", x"12", x"17", x"15", x"11", x"0E", x"11", x"13", x"14", x"17", x"19",
	x"18", x"19", x"1A", x"1B", x"18", x"16", x"16", x"16", x"16", x"12", x"11", x"16",
	x"14", x"12", x"13", x"1A", x"1D", x"1B", x"1C", x"19", x"18", x"1B", x"1B", x"1B",
	x"1D", x"20", x"27", x"2C", x"2C", x"29", x"27", x"23", x"22", x"21", x"23", x"24",
	x"24", x"23", x"22", x"23", x"20", x"1F", x"1E", x"1F", x"27", x"28", x"2C", x"31",
	x"32", x"31", x"33", x"31", x"30", x"2E", x"2F", x"30", x"31", x"33", x"34", x"39",
	x"3C", x"3D", x"3E", x"3F", x"42", x"45", x"48", x"48", x"4B", x"4C", x"4E", x"4D",
	x"4C", x"48", x"48", x"4A", x"4C", x"51", x"50", x"4F", x"4A", x"48", x"46", x"46",
	x"47", x"45", x"43", x"41", x"3D", x"38", x"35", x"34", x"33", x"31", x"2E", x"2B",
	x"28", x"23", x"20", x"1C", x"1B", x"19", x"1A", x"15", x"0F", x"0B", x"08", x"05",
	x"03", x"FD", x"F9", x"F5", x"F2", x"F3", x"F3", x"EE", x"EB", x"EB", x"E8", x"E5",
	x"E2", x"E1", x"DF", x"DF", x"DD", x"DA", x"D6", x"D5", x"D5", x"D6", x"D4", x"CE",
	x"C8", x"C9", x"C9", x"C7", x"C4", x"C0", x"C0", x"BE", x"BD", x"B8", x"B8", x"B7",
	x"B8", x"B8", x"B5", x"B3", x"B1", x"B1", x"AF", x"AE", x"AB", x"AA", x"AA", x"A9",
	x"A9", x"A5", x"A4", x"A2", x"A3", x"A3", x"A1", x"A0", x"A0", x"9F", x"A3", x"A4",
	x"A5", x"A4", x"A5", x"A7", x"A9", x"A7", x"A5", x"A6", x"A5", x"AA", x"AA", x"AB",
	x"AB", x"AD", x"AD", x"B0", x"B1", x"B3", x"B2", x"B4", x"B9", x"BA", x"BC", x"BC",
	x"C1", x"C1", x"C2", x"C2", x"C5", x"C2", x"C0", x"C2", x"C1", x"C3", x"C5", x"C9",
	x"CE", x"D0", x"D1", x"D3", x"D3", x"D2", x"D0", x"D2", x"D2", x"D2", x"D7", x"DA",
	x"DA", x"DD", x"E0", x"E0", x"E2", x"E2", x"E4", x"E5", x"E7", x"EB", x"E9", x"EB",
	x"EA", x"EB", x"EB", x"EE", x"F0", x"F2", x"F3", x"F5", x"F9", x"F9", x"FC", x"FE",
	x"01", x"01", x"05", x"08", x"09", x"0C", x"0E", x"10", x"10", x"12", x"13", x"17",
	x"1A", x"1F", x"21", x"21", x"22", x"24", x"23", x"26", x"26", x"29", x"28", x"28",
	x"26", x"27", x"27", x"27", x"29", x"27", x"28", x"27", x"25", x"27", x"26", x"26",
	x"29", x"27", x"27", x"23", x"22", x"23", x"25", x"25", x"24", x"22", x"22", x"21",
	x"22", x"1F", x"1C", x"1E", x"1E", x"1E", x"1E", x"20", x"1F", x"22", x"22", x"20",
	x"1D", x"1E", x"1D", x"20", x"1F", x"20", x"1E", x"1D", x"1D", x"1F", x"1E", x"1E",
	x"1D", x"1E", x"1F", x"1C", x"1D", x"1D", x"1F", x"20", x"23", x"23", x"22", x"22",
	x"23", x"22", x"22", x"23", x"23", x"21", x"21", x"20", x"21", x"22", x"24", x"24",
	x"23", x"21", x"21", x"20", x"20", x"20", x"20", x"20", x"20", x"1E", x"20", x"1F",
	x"20", x"1F", x"20", x"1E", x"1E", x"1E", x"1E", x"1B", x"1A", x"18", x"18", x"18",
	x"1B", x"1A", x"1B", x"1B", x"19", x"1A", x"19", x"19", x"18", x"19", x"18", x"18",
	x"17", x"14", x"13", x"11", x"12", x"13", x"10", x"10", x"0F", x"0F", x"0E", x"0E",
	x"0B", x"0A", x"07", x"04", x"04", x"02", x"04", x"03", x"01", x"00", x"FE", x"FE",
	x"FD", x"FB", x"FB", x"F7", x"F6", x"F6", x"F5", x"F5", x"F2", x"F1", x"F0", x"F0",
	x"EF", x"EF", x"EE", x"EF", x"EE", x"ED", x"EE", x"EC", x"EE", x"EC", x"ED", x"EC",
	x"EC", x"EB", x"EB", x"EB", x"EB", x"EA", x"EC", x"EC", x"EB", x"ED", x"EE", x"EF",
	x"EF", x"F1", x"F0", x"F0", x"F0", x"F0", x"F0", x"EF", x"F0", x"F0", x"F2", x"F2",
	x"F4", x"F3", x"F4", x"F4", x"F2", x"F3", x"F3", x"F2", x"F4", x"F2", x"F2", x"F1",
	x"F1", x"F4", x"F4", x"F6", x"F4", x"F5", x"F2", x"F2", x"F1", x"F1", x"F1", x"F1",
	x"F2", x"F1", x"F2", x"F1", x"F3", x"F2", x"F3", x"F1", x"F2", x"F1", x"F0", x"F1",
	x"EF", x"F0", x"EF", x"F1", x"F1", x"F2", x"F3", x"F2", x"F3", x"F2", x"F2", x"F1",
	x"F1", x"F2", x"F2", x"F1", x"F1", x"F3", x"F3", x"F4", x"F4", x"F2", x"F2", x"F1",
	x"F2", x"F1", x"F2", x"F1", x"F2", x"F3", x"F2", x"F3", x"F2", x"F1", x"F1", x"F1",
	x"F1", x"F1", x"F0", x"F0", x"EF", x"F0", x"EE", x"EF", x"EF", x"ED", x"EE", x"ED",
	x"EE", x"EE", x"EF", x"EF", x"EF", x"F0", x"F0", x"F0", x"EF", x"F1", x"F0", x"F2",
	x"F1", x"F3", x"F4", x"F5", x"F4", x"F2", x"F3", x"F2", x"F4", x"F4", x"F6", x"F7",
	x"F8", x"F8", x"FA", x"F9", x"F8", x"FA", x"F9", x"FA", x"F9", x"FB", x"FB", x"FC",
	x"FC", x"FD", x"FE", x"FD", x"FF", x"FF", x"FF", x"02", x"03", x"02", x"04", x"04",
	x"04", x"03", x"05", x"04", x"05", x"04", x"06", x"05", x"06", x"06", x"06", x"04",
	x"06", x"06", x"08", x"08", x"0A", x"0A", x"0B", x"09", x"0A", x"0A", x"0B", x"09",
	x"0B", x"0A", x"0B", x"0B", x"0B", x"0B", x"0C", x"0C", x"0C", x"0D", x"0C", x"0C",
	x"0C", x"0D", x"0C", x"0E", x"0D", x"0F", x"0E", x"0E", x"0D", x"0D", x"0C", x"0B",
	x"0A", x"0A", x"0B", x"09", x"0A", x"09", x"0A", x"0A", x"08", x"09", x"09", x"09",
	x"08", x"08", x"07", x"07", x"07", x"07", x"07", x"07", x"06", x"07", x"06", x"06",
	x"06", x"06", x"05", x"05", x"05", x"04", x"05", x"05", x"06", x"05", x"06", x"06",
	x"04", x"04", x"03", x"03", x"02", x"03", x"01", x"02", x"02", x"01", x"02", x"01",
	x"00", x"01", x"00", x"FE", x"FC", x"FB", x"FA", x"FA", x"F9", x"F8", x"F9", x"F8",
	x"F9", x"F8", x"F9", x"F9", x"F7", x"F7", x"F5", x"F6", x"F6", x"F4", x"F6", x"F5",
	x"F5", x"F5", x"F5", x"F6", x"F5", x"F5", x"F4", x"F5", x"F4", x"F6", x"F7", x"F7",
	x"F7", x"F6", x"F8", x"F8", x"F7", x"F9", x"F8", x"F9", x"F9", x"F8", x"FA", x"F9",
	x"FA", x"F9", x"F9", x"FB", x"FA", x"FA", x"FA", x"FC", x"FD", x"FD", x"FE", x"FD",
	x"FE", x"FE", x"00", x"FF", x"00", x"00", x"01", x"01", x"00", x"01", x"02", x"01",
	x"02", x"00", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"FF", x"00", x"FF", x"FE",
	x"FF", x"FE", x"00", x"FF", x"FE", x"FE", x"FD", x"FD", x"FE", x"FE", x"FD", x"FE",
	x"FD", x"FC", x"FD", x"FC", x"FD", x"FC", x"FD", x"FD", x"FC", x"FC", x"FB", x"FC",
	x"FC", x"FD", x"FC", x"FD", x"FE", x"FE", x"FF", x"FE", x"FF", x"FE", x"FF", x"FF",
	x"FE", x"00", x"01", x"00", x"01", x"00", x"02", x"01", x"02", x"02", x"03", x"04",
	x"05", x"05", x"05", x"05", x"06", x"05", x"06", x"07", x"06", x"07", x"06", x"07",
	x"05", x"06", x"05", x"05", x"05", x"04", x"05", x"05", x"04", x"05", x"04", x"05",
	x"06", x"05", x"05", x"04", x"04", x"04", x"02", x"03", x"03", x"02", x"02", x"00",
	x"01", x"00", x"FF", x"FF", x"FE", x"FF", x"FE", x"00", x"FF", x"FF", x"FE", x"FF",
	x"FD", x"FE", x"FD", x"FE", x"FD", x"FE", x"FE", x"FC", x"FD", x"FC", x"FD", x"FC",
	x"FD", x"FC", x"FC", x"FC", x"FB", x"FA", x"FA", x"F9", x"FA", x"FA", x"F9", x"FA",
	x"F9", x"F8", x"F9", x"F8", x"F9", x"F7", x"F8", x"F7", x"F6", x"F7", x"F6", x"F7",
	x"F6", x"F5", x"F6", x"F5", x"F6", x"F5", x"F6", x"F7", x"F6", x"F7", x"F7", x"F6",
	x"F7", x"F7", x"F8", x"F7", x"F9", x"F9", x"FB", x"FB", x"FA", x"FC", x"FB", x"FC",
	x"FD", x"FE", x"FD", x"FE", x"FE", x"FF", x"FF", x"00", x"00", x"02", x"02", x"01",
	x"02", x"02", x"01", x"03", x"02", x"04", x"04", x"04", x"05", x"05", x"06", x"06",
	x"06", x"05", x"05", x"04", x"05", x"03", x"05", x"04", x"05", x"05", x"04", x"05",
	x"03", x"04", x"03", x"03", x"03", x"02", x"03", x"01", x"02", x"02", x"01", x"02",
	x"02", x"00", x"01", x"FF", x"00", x"FF", x"FE", x"FE", x"FD", x"FE", x"FD", x"FC",
	x"FD", x"FD", x"FC", x"FC", x"FB", x"FC", x"FB", x"FC", x"FB", x"FC", x"FB", x"FC",
	x"FB", x"FC", x"FA", x"FB", x"FA", x"FA", x"F9", x"FA", x"FA", x"FA", x"F9", x"FA",
	x"FA", x"F9", x"FA", x"FA", x"FA", x"F9", x"F9", x"FA", x"FA", x"F9", x"F9", x"F8",
	x"F9", x"F8", x"F9", x"F8", x"F9", x"F8", x"F9", x"F8", x"F9", x"F8", x"F9", x"F8",
	x"F9", x"F9", x"F9", x"F9", x"F9", x"F9", x"F9", x"FA", x"FA", x"FB", x"FC", x"FB",
	x"FC", x"FC", x"FC", x"FB", x"FC", x"FB", x"FC", x"FC", x"FD", x"FC", x"FE", x"FE",
	x"FD", x"FE", x"FD", x"FE", x"FD", x"FE", x"FF", x"FE", x"00", x"FF", x"FF", x"01",
	x"00", x"02", x"02", x"02", x"03", x"02", x"04", x"03", x"04", x"04", x"05", x"04",
	x"05", x"06", x"06", x"06", x"06", x"05", x"06", x"07", x"06", x"07", x"06", x"07",
	x"07", x"08", x"09", x"08", x"09", x"08", x"09", x"09", x"08", x"09", x"09", x"08",
	x"08", x"07", x"08", x"07", x"08", x"07", x"08", x"07", x"07", x"08", x"07", x"08",
	x"07", x"08", x"08", x"06", x"07", x"06", x"07", x"05", x"06", x"05", x"06", x"05",
	x"04", x"05", x"05", x"04", x"04", x"03", x"04", x"03", x"02", x"03", x"02", x"01",
	x"01", x"00", x"00", x"FF", x"00", x"FF", x"FF", x"FE", x"FF", x"FE", x"FC", x"FD",
	x"FC", x"FC", x"FB", x"FA", x"FB", x"F9", x"FA", x"F9", x"FA", x"F9", x"FA", x"F9",
	x"FA", x"F9", x"FA", x"F8", x"F9", x"F8", x"F9", x"F8", x"F9", x"F8", x"F7", x"F7",
	x"F8", x"F7", x"F8", x"F8", x"F7", x"F8", x"F7", x"F9", x"F8", x"F9", x"F9", x"F8",
	x"F9", x"F8", x"FA", x"F9", x"FA", x"FA", x"F9", x"FA", x"F9", x"FA", x"FA", x"FA",
	x"F9", x"FA", x"FB", x"FA", x"FA", x"FB", x"F9", x"FA", x"F9", x"FA", x"FA", x"FA",
	x"FA", x"F9", x"FA", x"F9", x"FA", x"FA", x"FA", x"FB", x"FA", x"FB", x"FA", x"FA",
	x"F9", x"FB", x"F9", x"FA", x"F9", x"FA", x"FA", x"FA", x"FA", x"FB", x"FA", x"FB",
	x"FB", x"FA", x"FB", x"FB", x"FA", x"FB", x"FB", x"FB", x"FC", x"FB", x"FC", x"FB",
	x"FD", x"FD", x"FC", x"FD", x"FD", x"FD", x"FE", x"FD", x"FE", x"FE", x"FE", x"FF",
	x"FE", x"FF", x"00", x"FF", x"00", x"00", x"FF", x"00", x"01", x"01", x"01", x"00",
	x"01", x"01", x"01", x"01", x"00", x"01", x"00", x"01", x"01", x"00", x"01", x"00",
	x"01", x"00", x"01", x"00", x"02", x"02", x"01", x"01", x"01", x"01", x"00", x"01",
	x"01", x"00", x"01", x"00", x"00", x"01", x"00", x"01", x"00", x"00", x"01", x"00",
	x"01", x"00", x"01", x"00", x"01", x"00", x"01", x"00", x"01", x"00", x"01", x"00",
	x"01", x"00", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"00", x"FF", x"01",
	x"00", x"00", x"00", x"FF", x"01", x"00", x"01", x"00", x"01", x"00", x"01", x"01",
	x"01", x"00", x"00", x"00", x"01", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"FF",
	x"00", x"00", x"FF", x"00", x"FF", x"00", x"00", x"FF", x"00", x"00", x"FF", x"00",
	x"FF", x"00", x"FF", x"00", x"00", x"00", x"00", x"FF", x"00", x"FF", x"00", x"FF",
	x"00", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"FF", x"FF", x"FF", x"00", x"00",
	x"FF", x"00", x"FF", x"01", x"FF", x"01", x"01", x"FF", x"01", x"00", x"01", x"00",
	x"01", x"00", x"01", x"00", x"01", x"00", x"02", x"01", x"02", x"01", x"02", x"01",
	x"02", x"02", x"02", x"02", x"02", x"02", x"03", x"03", x"02", x"03", x"02", x"03",
	x"02", x"03", x"02", x"03", x"02", x"03", x"03", x"02", x"03", x"02", x"03", x"02",
	x"03", x"03", x"01", x"02", x"01", x"02", x"00", x"02", x"00", x"01", x"00", x"00",
	x"FF", x"00", x"00", x"FE", x"FF", x"FE", x"FE", x"FD", x"FE", x"FD", x"FE", x"FD",
	x"FE", x"FD", x"FC", x"FD", x"FC", x"FC", x"FB", x"FC", x"FB", x"FC", x"FC", x"FB",
	x"FC", x"FA", x"FB", x"FB", x"FA", x"FB", x"FA", x"FB", x"FB", x"FB", x"FA", x"FB",
	x"FB", x"FB", x"FB", x"FA", x"FB", x"FA", x"FB", x"FA", x"FB", x"FA", x"FB", x"FB",
	x"FA", x"FB", x"FA", x"FB", x"FA", x"FB", x"FA", x"FB", x"FA", x"FB", x"FA", x"FB",
	x"FA", x"FB", x"FA", x"FB", x"FB", x"FA", x"FB", x"FA", x"FB", x"FB", x"FA", x"FB",
	x"FA", x"FB", x"FB", x"FA", x"FB", x"FA", x"FC", x"FB", x"FC", x"FC", x"FB", x"FC",
	x"FB", x"FC", x"FB", x"FC", x"FC", x"FD", x"FC", x"FD", x"FC", x"FE", x"FD", x"FE",
	x"FD", x"FE", x"FD", x"FF", x"FE", x"FF", x"FE", x"FF", x"FF", x"FF", x"00", x"FF",
	x"00", x"FF", x"00", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"00", x"00",
	x"00", x"01", x"00", x"01", x"FF", x"00", x"00", x"00", x"00", x"00", x"FF", x"00",
	x"FF", x"00", x"FF", x"00", x"00", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00",
	x"FF", x"00", x"FF", x"00", x"00", x"FF", x"00", x"FF", x"00", x"00", x"01", x"00",
	x"01", x"00", x"01", x"00", x"01", x"01", x"00", x"01", x"00", x"01", x"01", x"00",
	x"01", x"01", x"00", x"02", x"01", x"02", x"02", x"00", x"01", x"00", x"01", x"00",
	x"01", x"01", x"01", x"01", x"00", x"01", x"01", x"00", x"01", x"00", x"01", x"01",
	x"00", x"01", x"00", x"01", x"00", x"01", x"00", x"00", x"FF", x"00", x"FF", x"00",
	x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"00", x"FF", x"00",
	x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"00", x"FE", x"FF", x"FF", x"00",
	x"FF", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"00", x"FF",
	x"00", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00",
	x"FF", x"00", x"00", x"FF", x"00", x"00", x"00", x"FF", x"00", x"FF", x"00", x"FF",
	x"00", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"00", x"FF",
	x"00", x"FF", x"FF", x"FF", x"FF", x"FE", x"FF", x"FE", x"FF", x"FE", x"FF", x"FE",
	x"FF", x"FE", x"FF", x"FE", x"FF", x"FF", x"FE", x"FE", x"FF", x"FF", x"FD", x"FE",
	x"FD", x"FE", x"FD", x"FE", x"FD", x"FE", x"FE", x"FE", x"FD", x"FE", x"FD", x"FE",
	x"FD", x"FD", x"FE", x"FE", x"FE", x"FE", x"FD", x"FE", x"FE", x"FE", x"FE", x"FD",
	x"FE", x"FE", x"FE", x"FE", x"FD", x"FE", x"FD", x"FE", x"FD", x"FE", x"FE", x"FE",
	x"FE", x"FF", x"FE", x"FD", x"FE", x"FD", x"FE", x"FD", x"FE", x"FD", x"FE", x"FD",
	x"FE", x"FD", x"FE", x"FE", x"FD", x"FE", x"FD", x"FE", x"FC", x"FD", x"FC", x"FD",
	x"FD", x"FC", x"FD", x"FD", x"FC", x"FD", x"FC", x"FD", x"FD", x"FC", x"FD", x"FC",
	x"FD", x"FD", x"FC", x"FD", x"FC", x"FD", x"FC", x"FD", x"FD", x"FC", x"FD", x"FC",
	x"FD", x"FC", x"FD", x"FC", x"FD", x"FC", x"FD", x"FD", x"FE", x"FE", x"FD", x"FE",
	x"FD", x"FE", x"FE", x"FD", x"FE", x"FE", x"FE", x"FD", x"FE", x"FD", x"FE", x"FE",
	x"FE", x"FE", x"FF", x"FE", x"FF", x"FE", x"FF", x"FF", x"FE", x"FF", x"FF", x"FE",
	x"FF", x"FE", x"FF", x"FE", x"FF", x"FE", x"FF", x"FF", x"FE", x"FF", x"FE", x"FF",
	x"FE", x"FF", x"FF", x"FF", x"00", x"00", x"00", x"00", x"FF", x"00", x"FF", x"00",
	x"FF", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"00", x"00", x"01", x"01",
	x"01", x"01", x"01", x"01", x"01", x"01", x"00", x"01", x"00", x"01", x"00", x"00",
	x"01", x"00", x"01", x"01", x"01", x"01", x"01", x"01", x"01", x"00", x"01", x"01",
	x"01", x"00", x"01", x"00", x"01", x"00", x"01", x"01", x"01", x"00", x"01", x"00",
	x"01", x"00", x"01", x"01", x"00", x"01", x"00", x"01", x"00", x"01", x"01", x"00",
	x"01", x"01", x"01", x"00", x"01", x"00", x"00", x"00", x"FF", x"00", x"FF", x"00",
	x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"FF", x"00", x"00", x"FF", x"00",
	x"FF", x"00", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"00", x"FF", x"FF",
	x"FE", x"FF", x"FE", x"FF", x"FF", x"FF", x"FE", x"FF", x"FE", x"FF", x"FE", x"FF",
	x"FE", x"FF", x"FF", x"FE", x"FF", x"FE", x"FF", x"FE", x"FF", x"FE", x"FF", x"FE",
	x"FF", x"FE", x"FF", x"FE", x"FF", x"FE", x"FF", x"FF", x"FE", x"FF", x"FE", x"FF",
	x"FE", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF",
	x"FE", x"FF", x"FE", x"FF", x"FE", x"FF", x"FE", x"FF", x"FE", x"FF", x"FE", x"FF",
	x"FE", x"FF", x"FE", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FE", x"FF", x"FE",
	x"FF", x"FE", x"FF", x"FE", x"FF", x"FD", x"FE", x"FD", x"FE", x"FE", x"FD", x"FE",
	x"FD", x"FE", x"FD", x"FE", x"FD", x"FE", x"FE", x"FD", x"FE", x"FD", x"FE", x"FE",
	x"FF", x"FF", x"FE", x"FF", x"FE", x"FE", x"FF", x"FE", x"FF", x"FF", x"FF", x"FE",
	x"FF", x"FF", x"FE", x"FF", x"FE", x"FF", x"FF", x"FE", x"FF", x"FE", x"FF", x"FE",
	x"FF", x"FE", x"FF", x"FE", x"FF", x"FE", x"FF", x"FE", x"FF", x"FE", x"FF", x"FF",
	x"FF", x"FE", x"FF", x"FF", x"FE", x"FF", x"FE", x"FF", x"FF", x"FE", x"FF", x"FE",
	x"FF", x"FE", x"FF", x"FE", x"FF", x"FF", x"FE", x"FF", x"FE", x"FF", x"FE", x"FF",
	x"FE", x"FF", x"FE", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FF", x"FE", x"FF",
	x"FF", x"FF", x"FE", x"FF", x"FE", x"FF", x"FE", x"FF", x"FF", x"FE", x"FF", x"FF",
	x"FF", x"FF", x"FE", x"FF", x"FE", x"FF", x"FF", x"FE", x"FF", x"FE", x"FF", x"FE",
	x"FF", x"FE", x"FF", x"FE", x"FF", x"FE", x"FF", x"FF", x"FE", x"FF", x"FE", x"FF",
	x"FE", x"FF", x"FE", x"FF", x"FE", x"00", x"FF", x"00", x"00", x"FF", x"00", x"00",
	x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"00",
	x"00", x"FF", x"00", x"00", x"00", x"00", x"00", x"FF", x"00", x"FF", x"00", x"00",
	x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"00", x"FF", x"00",
	x"FF", x"00", x"FF", x"00", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"00",
	x"FF", x"00", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"FF",
	x"00", x"00", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"00", x"00", x"00",
	x"00", x"00", x"FF", x"00", x"FF", x"00", x"00", x"FF", x"00", x"FF", x"00", x"FF",
	x"00", x"FF", x"00", x"00", x"FF", x"00", x"FF", x"00", x"FF", x"00", x"00", x"FE",
	x"FF", x"FE", x"FF", x"FF"
	);
	
signal cnt_out: integer := 0;	
signal play_sound: std_logic := '0';
constant cnt_max: integer := 2847;
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
            cnt_out <= 0;
        elsif CE = '1' and play_sound = '1' then
            cnt_out <= cnt_out + 1;       
        end if;
        if cnt_out = cnt_max then
            cnt_out <= 0;            
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
            out_signal <= kick_sound(cnt_out);
        end if;
    end if;    
end process;

KICK_SAMP_O <= out_signal;

end Behavioral;
