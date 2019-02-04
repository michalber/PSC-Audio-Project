----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.01.2019 01:47:24
-- Design Name: 
-- Module Name: BMP_Setter_tb - Behavioral
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
use IEEE.Numeric_Std.all;

entity BPM_Setter_tb is
end;

architecture bench of BPM_Setter_tb is

  component BPM_Setter
  Port ( CLK : in STD_LOGIC;       
         RST : in STD_LOGIC;
         BPM_UP : in STD_LOGIC;
         BPM_DOWN : in STD_LOGIC;
         BPM_OUT_LCD : out STD_LOGIC_VECTOR(7 downto 0);
         BPM_OUT : out STD_LOGIC_VECTOR(11 downto 0)
         );
  end component;

  signal CLK: STD_LOGIC := '0';
  signal RST: STD_LOGIC;
  signal BPM_UP: STD_LOGIC;
  signal BPM_DOWN: STD_LOGIC;
  signal BPM_OUT_LCD: STD_LOGIC_VECTOR(7 downto 0);
  signal BPM_OUT: STD_LOGIC_VECTOR(11 downto 0);

  constant clock_period: time := 10 ps;
  signal stop_the_clock: boolean;

begin

  uut: BPM_Setter port map ( CLK         => CLK,
                             RST         => RST,
                             BPM_UP      => BPM_UP,
                             BPM_DOWN    => BPM_DOWN,
                             BPM_OUT_LCD => BPM_OUT_LCD,
                             BPM_OUT     => BPM_OUT
                             );

  CLK <= not CLK after clock_period;
    
process
begin
    RST <= '1';
    wait for 5 ps;
    RST <= '0';
    wait for 5 ps;    
    wait;
end process;
        -- Put test bench stimulus code here
        
process
begin
for i in 0 to 10 loop
    wait for 100ps;
    BPM_UP <= '1';        
    wait for 10ps;
    BPM_UP <= '0';
    wait for 100ps; 
end loop;    
end process;                                       
                
end;