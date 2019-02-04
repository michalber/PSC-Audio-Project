----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2019 21:55:28
-- Design Name: 
-- Module Name: top2 - Behavioral
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

entity top2 is
end;

architecture bench of top2 is

  component top
    port(
           BPM_DOWN : in STD_LOGIC;
           BPM_UP : in STD_LOGIC;
           CLEAR : in STD_LOGIC;
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           MODE : in STD_LOGIC;
           SOUNDS_IN : in STD_LOGIC_VECTOR(7 downto 0);
           PDM : out STD_LOGIC;
           Anode_Activate : out STD_LOGIC_VECTOR(7 downto 0);
           LED_out : out STD_LOGIC_VECTOR(6 downto 0);
           AUD_SD : out STD_LOGIC;
           
           BPM_LED : out STD_LOGIC;
           
           WAVE : out std_logic_vector(7 downto 0)
    );
  end component;

  signal BPM_DOWN: STD_LOGIC;
  signal BPM_UP: STD_LOGIC;
  signal CLEAR: STD_LOGIC;
  signal CLK: STD_LOGIC := '0';
  signal RST: STD_LOGIC;
  signal MODE: STD_LOGIC;
  signal SOUNDS_IN: STD_LOGIC_VECTOR(7 downto 0);
  signal PDM: STD_LOGIC;
  signal Anode_Activate: STD_LOGIC_VECTOR(7 downto 0);
  signal LED_out: STD_LOGIC_VECTOR(6 downto 0);
  signal AUD_SD: STD_LOGIC ;
  signal BPM_LED : STD_LOGIC;
  signal WAVE: std_logic_vector(7 downto 0);

begin

  uut: top port map ( BPM_DOWN       => BPM_DOWN,
                      BPM_UP         => BPM_UP,
                      CLEAR          => CLEAR,
                      CLK            => CLK,
                      RST            => RST,
                      MODE           => MODE,
                      SOUNDS_IN      => SOUNDS_IN,
                      PDM            => PDM,
                      Anode_Activate => Anode_Activate,
                      LED_out        => LED_out,
                      AUD_SD         => AUD_SD, 
                      BPM_LED        => BPM_LED,
                      WAVE           => WAVE    );

    -- Put initialisation code here
    CLK <= not CLK after 10 ps;
    
    RST_p : process 
    begin
        RST <= '1';
        wait for 40ps;
        RST <= '0';
        wait;
    end process;
    
    MODE_p : process
    begin
        MODE <= '1';
        wait;
    end process;

    -- Put test bench stimulus code here
end bench;
