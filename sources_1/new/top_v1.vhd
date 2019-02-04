----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2018 20:56:10
-- Design Name: 
-- Module Name: top - Behavioral
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
-- Design unit header --
library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;


-- Included from components --
use ieee.NUMERIC_STD.all;

entity top_v1 is
  port(
       CLK : in STD_LOGIC;
       RST : in STD_LOGIC;
       playKick : in STD_LOGIC;
       playSnare : in STD_LOGIC;
       PDM : out STD_LOGIC;
       AUD_SD : out STD_LOGIC;
       WAVE : out std_logic_vector(7 downto 0)
  );
end top_v1;

architecture top_v1_beh of top_v1 is

---- Component declarations -----
-- ---------------------------------------------------------------------------------------------------------------
component audio_PWM
  generic(
       PWM_RES : POSITIVE := 8
  );
  port (
       CE : in STD_LOGIC;
       CLK : in STD_LOGIC;
       DATA : in std_logic_vector(PWM_RES-1 downto 0);
       LD : in STD_LOGIC;
       RES : in STD_LOGIC;
       PWM : out STD_LOGIC
  );
end component;
-- ---------------------------------------------------------------------------------------------------------------
component Kick
  port (
       CE : in STD_LOGIC;
       CLK : in STD_LOGIC;
       PLAY : in STD_LOGIC;
       RST : in STD_LOGIC;
       KICK_SAMP_O : out SIGNED(7 downto 0)
  );
end component;
-- ---------------------------------------------------------------------------------------------------------------
component Prescaler
  port (
       CLK : in STD_LOGIC;
       RST : in STD_LOGIC;
       CLK_100k : out STD_LOGIC;
       CLK_1k : out STD_LOGIC;
       CLK_25M : out STD_LOGIC
  );
end component;
-- ---------------------------------------------------------------------------------------------------------------
component Snare
  port (
       CE : in STD_LOGIC;
       CLK : in STD_LOGIC;
       PLAY : in STD_LOGIC;
       RST : in STD_LOGIC;
       SNARE_SAMP_O : out SIGNED(7 downto 0)
  );
end component;
-- ---------------------------------------------------------------------------------------------------------------
component SumSounds
  port (
       CE : in STD_LOGIC;
       CLK : in STD_LOGIC;
       CRASH_IN : in SIGNED(7 downto 0);
       HAT_IN : in SIGNED(7 downto 0);
       KICK_IN : in SIGNED(7 downto 0);
       RIDE_IN : in SIGNED(7 downto 0);
       RST : in STD_LOGIC;
       SNARE_IN : in SIGNED(7 downto 0);
       TOM1_IN : in SIGNED(7 downto 0);
       TOM2_IN : in SIGNED(7 downto 0);
       SAMPLE_AV : out STD_LOGIC;
       SAMPLE_OUT : out std_logic_vector(7 downto 0)
  );
end component;
-- ---------------------------------------------------------------------------------------------------------------

----     Constants     -----
constant DANGLING_INPUT_CONSTANT : STD_LOGIC := '0';

---- Signal declarations used on the diagram ----

signal CLK1 : STD_LOGIC := '0';
signal CLK100 : STD_LOGIC := '0';
signal CLK25 : STD_LOGIC := '0';
signal NET155 : STD_LOGIC := '0';
signal kick_o : SIGNED(7 downto 0) := (others => '0');
signal snare_o : SIGNED(7 downto 0) := (others => '0');
signal addedSamples : std_logic_vector(7 downto 0) := (others => '0');
signal pwm_int : std_logic;

---- Declaration for Dangling input ----
signal Dangling_Input_Signal : STD_LOGIC;
signal Dangling_Input_Signal_SIGNED : SIGNED(0 downto 0) := "0";

begin

----  Component instantiations  ----

U1 : audio_PWM
  port map(
       CE => CLK25,
       CLK => CLK,
       DATA => addedSamples,
       LD => NET155,
       PWM => PDM,
       RES => RST
  );

U2 : Prescaler
  port map(
       CLK => CLK,
       CLK_100k => CLK100,
       CLK_1k => CLK1,
       CLK_25M => CLK25,
       RST => RST
  );

U3 : Kick
  port map(
       CE => CLK100,
       CLK => CLK,
       PLAY => playKick,
       RST => RST,
       KICK_SAMP_O => kick_o
  );

U4 : Snare
  port map(
       CE => CLK100,
       CLK => CLK,
       PLAY => playSnare,
       RST => RST,
       SNARE_SAMP_O => snare_o
  );

U5 : SumSounds
  port map(
       CE => CLK100,
       CLK => CLK,
       CRASH_IN(0) => Dangling_Input_Signal_SIGNED(0),
       CRASH_IN(1) => Dangling_Input_Signal_SIGNED(0),
       CRASH_IN(2) => Dangling_Input_Signal_SIGNED(0),
       CRASH_IN(3) => Dangling_Input_Signal_SIGNED(0),
       CRASH_IN(4) => Dangling_Input_Signal_SIGNED(0),
       CRASH_IN(5) => Dangling_Input_Signal_SIGNED(0),
       CRASH_IN(6) => Dangling_Input_Signal_SIGNED(0),
       CRASH_IN(7) => Dangling_Input_Signal_SIGNED(0),
       
       HAT_IN(0) => Dangling_Input_Signal_SIGNED(0),
       HAT_IN(1) => Dangling_Input_Signal_SIGNED(0),
       HAT_IN(2) => Dangling_Input_Signal_SIGNED(0),
       HAT_IN(3) => Dangling_Input_Signal_SIGNED(0),
       HAT_IN(4) => Dangling_Input_Signal_SIGNED(0),
       HAT_IN(5) => Dangling_Input_Signal_SIGNED(0),
       HAT_IN(6) => Dangling_Input_Signal_SIGNED(0),
       HAT_IN(7) => Dangling_Input_Signal_SIGNED(0),
       
       KICK_IN => kick_o,
       
       RIDE_IN(0) => Dangling_Input_Signal_SIGNED(0),
       RIDE_IN(1) => Dangling_Input_Signal_SIGNED(0),
       RIDE_IN(2) => Dangling_Input_Signal_SIGNED(0),
       RIDE_IN(3) => Dangling_Input_Signal_SIGNED(0),
       RIDE_IN(4) => Dangling_Input_Signal_SIGNED(0),
       RIDE_IN(5) => Dangling_Input_Signal_SIGNED(0),
       RIDE_IN(6) => Dangling_Input_Signal_SIGNED(0),
       RIDE_IN(7) => Dangling_Input_Signal_SIGNED(0),
       
       RST => RST,
       SAMPLE_AV => NET155,
       SAMPLE_OUT => addedSamples,
       SNARE_IN => snare_o,
       
       TOM1_IN(0) => Dangling_Input_Signal_SIGNED(0),
       TOM1_IN(1) => Dangling_Input_Signal_SIGNED(0),
       TOM1_IN(2) => Dangling_Input_Signal_SIGNED(0),
       TOM1_IN(3) => Dangling_Input_Signal_SIGNED(0),
       TOM1_IN(4) => Dangling_Input_Signal_SIGNED(0),
       TOM1_IN(5) => Dangling_Input_Signal_SIGNED(0),
       TOM1_IN(6) => Dangling_Input_Signal_SIGNED(0),
       TOM1_IN(7) => Dangling_Input_Signal_SIGNED(0),
       
       TOM2_IN(0) => Dangling_Input_Signal_SIGNED(0),
       TOM2_IN(1) => Dangling_Input_Signal_SIGNED(0),
       TOM2_IN(2) => Dangling_Input_Signal_SIGNED(0),
       TOM2_IN(3) => Dangling_Input_Signal_SIGNED(0),
       TOM2_IN(4) => Dangling_Input_Signal_SIGNED(0),
       TOM2_IN(5) => Dangling_Input_Signal_SIGNED(0),
       TOM2_IN(6) => Dangling_Input_Signal_SIGNED(0),
       TOM2_IN(7) => Dangling_Input_Signal_SIGNED(0)
  );


---- Dangling input signal assignment ----

Dangling_Input_Signal <= DANGLING_INPUT_CONSTANT;
WAVE <= addedSamples;

AUD_SD <= '1';

end top_v1_beh;