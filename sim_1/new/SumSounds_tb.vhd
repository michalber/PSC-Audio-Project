----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2018 13:52:17
-- Design Name: 
-- Module Name: SumSounds_tb - Behavioral
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
use IEEE.Std_logic_1164.all;

entity SumSounds_tb is
end;

architecture Behavioral of SumSounds_tb is

  component SumSounds
      Port ( CLK : in STD_LOGIC;
             CE : in STD_LOGIC;
             RST : in STD_LOGIC;
             KICK_IN : in STD_LOGIC_VECTOR (7 downto 0);
             SNARE_IN : in STD_LOGIC_VECTOR (7 downto 0);
             HAT_IN : in STD_LOGIC_VECTOR (7 downto 0);
             CRASH_IN : in STD_LOGIC_VECTOR (7 downto 0);
             RIDE_IN : in STD_LOGIC_VECTOR (7 downto 0);
             TOM1_IN : in STD_LOGIC_VECTOR (7 downto 0);
             TOM2_IN : in STD_LOGIC_VECTOR (7 downto 0);
             SAMPLE_AV : out STD_LOGIC;
             SAMPLE_OUT : out STD_LOGIC_VECTOR (7 downto 0)
             );
  end component;

  signal CLK: STD_LOGIC := '0';
  signal CE: STD_LOGIC := '0';
  signal RST: STD_LOGIC := '0';
  signal KICK_IN: STD_LOGIC_VECTOR (7 downto 0) := (others=> '0');
  signal SNARE_IN: STD_LOGIC_VECTOR (7 downto 0) := (others=> '0');
  signal HAT_IN: STD_LOGIC_VECTOR (7 downto 0) := (others=> '0');
  signal CRASH_IN: STD_LOGIC_VECTOR (7 downto 0) := (others=> '0');
  signal RIDE_IN: STD_LOGIC_VECTOR (7 downto 0) := (others=> '0');
  signal TOM1_IN: STD_LOGIC_VECTOR (7 downto 0) := (others=> '0');
  signal TOM2_IN: STD_LOGIC_VECTOR (7 downto 0) := (others=> '0');
  signal SAMPLE_AV: STD_LOGIC;
  signal SAMPLE_OUT: STD_LOGIC_VECTOR (7 downto 0) ;

begin

  uut: SumSounds port map ( CLK,CE,RST,KICK_IN,SNARE_IN,
                            HAT_IN,CRASH_IN,RIDE_IN,TOM1_IN,
                            TOM2_IN,SAMPLE_AV,SAMPLE_OUT);

CLK <= not CLK after 10ps;

RST_p : process
begin

RST <= '1';
wait for 100 ns;
RST <= '0';
wait;
end process;
  
  ce_p: process
  begin  
    CE <= '1';
    wait;
 end process;

kick_p: process
begin
    wait for 150 ns;
    KICK_IN <= x"11";
    wait for 100ns;
    KICK_IN <= x"bb";
    wait for 50ns;
    wait;    
end process;

snare_p: process
begin
    wait for 250 ns;
    SNARE_IN <= x"0a";
    wait for 100ns;
    SNARE_IN <= x"12";
    wait for 50ns;
    wait;    
end process;

end Behavioral;
