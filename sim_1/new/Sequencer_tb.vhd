----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.01.2019 00:49:08
-- Design Name: 
-- Module Name: Sequencer_tb - Behavioral
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

entity Sequencer_tb is
end;

architecture bench of Sequencer_tb is

  component Sequencer
  Port ( CLK : in STD_LOGIC;
         CE : in STD_LOGIC;
         RST : in STD_LOGIC;
         MODE : in STD_LOGIC;
         CLEAR : in STD_LOGIC;
         SOUNDS_IN : in STD_LOGIC_VECTOR(7 downto 0);
         SOUNDS_OUT : out STD_LOGIC_VECTOR(7 downto 0)
         );
  end component;

  signal CLK: STD_LOGIC := '0';
  signal CE: STD_LOGIC := '0'; 
  signal RST: STD_LOGIC;
  signal MODE: STD_LOGIC;
  signal CLEAR: STD_LOGIC;
  signal SOUNDS_IN: STD_LOGIC_VECTOR(7 downto 0);
  signal SOUNDS_OUT: STD_LOGIC_VECTOR(7 downto 0) ;

  constant clock_period: time := 10 ps;
  signal stop_the_clock: boolean;

begin

  uut: Sequencer port map ( CLK        => CLK,
                            CE         => CE,
                            RST        => RST,
                            MODE       => MODE,
                            CLEAR      => CLEAR,
                            SOUNDS_IN  => SOUNDS_IN,
                            SOUNDS_OUT => SOUNDS_OUT );

    -- Put initialisation code here
    
 CLK <= not CLK after clock_period;
 CE <= not CE after clock_period*4;
    
process
begin
    RST <= '1';
    wait for 20 ps;
    RST <= '0';
    wait for 20 ps;    
    wait;
end process;
        -- Put test bench stimulus code here
    
    signals_p: process
        begin  
        MODE <= '1'; 
            SOUNDS_IN <= b"1000_0000";
            wait for 20ps;
            SOUNDS_IN <= b"0100_0000";
            wait for 20ps;
            SOUNDS_IN <= b"0010_0000";
            wait for 20ps;
            SOUNDS_IN <= b"1001_0000";
            wait for 20ps;
            SOUNDS_IN <= b"1000_0000";
        wait for 50ps;           
        MODE <= '1';
        SOUNDS_IN <= b"1000_0000";
                wait for 20ps;
                SOUNDS_IN <= b"0100_0000";
                wait for 20ps;
                SOUNDS_IN <= b"0010_0000";
                wait for 20ps;
                SOUNDS_IN <= b"1001_0000";
                wait for 20ps;
                SOUNDS_IN <= b"1000_0000";            
        wait;
        end process;

end;