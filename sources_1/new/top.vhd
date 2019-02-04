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

entity top is
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
end top;

architecture top of top is

---- Component declarations -----
-- ---------------------------------------------------------------------------------------------------------------
component audio_PWM
  generic(
       PWM_RES : POSITIVE := 8
  );
  port (
       CE : in STD_LOGIC;
       CLK : in STD_LOGIC;
       DATA : in STD_LOGIC_VECTOR(PWM_RES-1 downto 0);
       LD : in STD_LOGIC;
       RES : in STD_LOGIC;
       PWM : out STD_LOGIC
  );
end component;
component BPM_CLK_div
  port (
       i_clk : in STD_LOGIC;
       i_clk_divider : in STD_LOGIC_VECTOR(25 downto 0);
       i_rst : in STD_LOGIC;
       o_clk : out STD_LOGIC
  );
end component;
component BPM_Setter
  port (
       BPM_DOWN : in STD_LOGIC;
       BPM_UP : in STD_LOGIC;
       CLK : in STD_LOGIC;
--       CE : in STD_LOGIC;
       RST : in STD_LOGIC;
       BPM_OUT : out STD_LOGIC_VECTOR(25 downto 0);
       BPM_OUT_LCD : out STD_LOGIC_VECTOR(7 downto 0)
  );
end component;
--component Crash
--  port (
--       CE : in STD_LOGIC;
--       CLK : in STD_LOGIC;
--       PLAY : in STD_LOGIC;
--       RST : in STD_LOGIC;
--       SAMPLE_OUT : out SIGNED(7 downto 0)
--  );
--end component;
component HHat
  port (
       CE : in STD_LOGIC;
       CLK : in STD_LOGIC;
       PLAY : in STD_LOGIC;
       RST : in STD_LOGIC;
       SAMPLE_OUT : out SIGNED(7 downto 0)
  );
end component;
component Kick
  port (
       CE : in STD_LOGIC;
       CLK : in STD_LOGIC;
       PLAY : in STD_LOGIC;
       RST : in STD_LOGIC;
       KICK_SAMP_O : out SIGNED(7 downto 0)
  );
end component;
component led_driver
  port (
       CLK : in STD_LOGIC;
       Number : in STD_LOGIC_VECTOR(7 downto 0);
       RST : in STD_LOGIC;
       Anode_Activate : out STD_LOGIC_VECTOR(7 downto 0);
       LED_out : out STD_LOGIC_VECTOR(6 downto 0)
  );
end component;
component Prescaler
  port (
       CLK : in STD_LOGIC;
       RST : in STD_LOGIC;
       CLK_100k : out STD_LOGIC;
       CLK_1k : out STD_LOGIC;
       CLK_25M : out STD_LOGIC
  );
end component;
--component Ride
--  port (
--       CE : in STD_LOGIC;
--       CLK : in STD_LOGIC;
--       PLAY : in STD_LOGIC;
--       RST : in STD_LOGIC;
--       SAMPLE_OUT : out SIGNED(7 downto 0)
--  );
--end component;
component Sequencer
  port (
       CE : in STD_LOGIC;
       CLEAR : in STD_LOGIC;
       CLK : in STD_LOGIC;
       MODE : in STD_LOGIC;
       RST : in STD_LOGIC;
       SOUNDS_IN : in STD_LOGIC_VECTOR(7 downto 0);
       SOUNDS_OUT : out STD_LOGIC_VECTOR(7 downto 0)
  );
end component;
component Snare
  port (
       CE : in STD_LOGIC;
       CLK : in STD_LOGIC;
       PLAY : in STD_LOGIC;
       RST : in STD_LOGIC;
       SNARE_SAMP_O : out SIGNED(7 downto 0)
  );
end component;
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
       SAMPLE_OUT : out STD_LOGIC_VECTOR(7 downto 0)
  );
end component;
-- ---------------------------------------------------------------------------------------------------------------

----     Constants     -----
constant DANGLING_INPUT_CONSTANT : STD_LOGIC := '0';

---- Signal declarations used on the diagram ----

signal CLK_100k : STD_LOGIC;
signal CLK_1k : STD_LOGIC;
signal CLK_25M : STD_LOGIC;
signal NET133 : STD_LOGIC;
signal NET263 : STD_LOGIC;
signal BUS113 : STD_LOGIC_VECTOR(25 downto 0);
signal BUS201 : STD_LOGIC_VECTOR(7 downto 0);
signal BUS211 : SIGNED(7 downto 0);
signal BUS219 : SIGNED(7 downto 0);
signal BUS227 : SIGNED(7 downto 0);
signal BUS235 : SIGNED(7 downto 0);
signal BUS243 : SIGNED(7 downto 0);
signal BUS271 : STD_LOGIC_VECTOR(7 downto 0);
signal Sounds_out : STD_LOGIC_VECTOR(7 downto 0);

---- Declaration for Dangling input ----
signal Dangling_Input_Signal : STD_LOGIC;
signal Dangling_Input_Signal_SIGNED : SIGNED(0 downto 0) := "0";
signal Dangling_Input_Signal_SIGNED_vec : SIGNED(7 downto 0) := x"00";

begin

----  Component instantiations  ----

U1 : audio_PWM
  port map(
       CE => CLK_25M,
       CLK => CLK,
       DATA => BUS271(7 downto 0),
       LD => NET263,
       PWM => PDM,
       RES => RST
  );

U10 : SumSounds
  port map(
       CE => CLK_100k,
       CLK => CLK,
       CRASH_IN(0) => Dangling_Input_Signal_SIGNED(0),
                     CRASH_IN(1) => Dangling_Input_Signal_SIGNED(0),
                     CRASH_IN(2) => Dangling_Input_Signal_SIGNED(0),
                     CRASH_IN(3) => Dangling_Input_Signal_SIGNED(0),
                     CRASH_IN(4) => Dangling_Input_Signal_SIGNED(0),
                     CRASH_IN(5) => Dangling_Input_Signal_SIGNED(0),
                     CRASH_IN(6) => Dangling_Input_Signal_SIGNED(0),
                     CRASH_IN(7) => Dangling_Input_Signal_SIGNED(0),
       HAT_IN => BUS227,
       KICK_IN => BUS211,
       RIDE_IN(0) => Dangling_Input_Signal_SIGNED(0),
              RIDE_IN(1) => Dangling_Input_Signal_SIGNED(0),
              RIDE_IN(2) => Dangling_Input_Signal_SIGNED(0),
              RIDE_IN(3) => Dangling_Input_Signal_SIGNED(0),
              RIDE_IN(4) => Dangling_Input_Signal_SIGNED(0),
              RIDE_IN(5) => Dangling_Input_Signal_SIGNED(0),
              RIDE_IN(6) => Dangling_Input_Signal_SIGNED(0),
              RIDE_IN(7) => Dangling_Input_Signal_SIGNED(0),
       RST => RST,
       SAMPLE_AV => NET263,
       SAMPLE_OUT => BUS271,
       SNARE_IN => BUS219,
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

U11 : Snare
  port map(
       CE => CLK_100k,
       CLK => CLK,
       PLAY => Sounds_out(6),
       RST => RST,
       SNARE_SAMP_O => BUS219
  );

U12 : Sequencer
  port map(
       CE => NET133,
--       CE => CLK_1k,       
       CLEAR => CLEAR,
       CLK => CLK,
       MODE => MODE,
       RST => RST,
       SOUNDS_IN => SOUNDS_IN,
       SOUNDS_OUT => Sounds_out
  );

U2 : BPM_CLK_div
  port map(
       i_clk => CLK,
       i_clk_divider => BUS113,
       i_rst => RST,
       o_clk => NET133
  );

U3 : BPM_Setter
  port map(
       BPM_DOWN => BPM_DOWN,
       BPM_OUT => BUS113,
       BPM_OUT_LCD => BUS201,
       BPM_UP => BPM_UP,
       CLK => CLK,
--       CE => CLK_1k,
       RST => RST
  );

--U4 : Crash
--  port map(
--       CE => CLK_100k,
--       CLK => CLK,
--       PLAY => Sounds_out(4),
--       RST => RST,
--       SAMPLE_OUT => BUS235
--  );

U5 : HHat
  port map(
       CE => CLK_100k,
       CLK => CLK,
       PLAY => Sounds_out(5),
       RST => RST,
       SAMPLE_OUT => BUS227
  );

U6 : Kick
  port map(
       CE => CLK_100k,
       CLK => CLK,
       KICK_SAMP_O => BUS211,
       PLAY => Sounds_out(7),
       RST => RST
  );

U7 : led_driver
  port map(
       Anode_Activate => Anode_Activate,
       CLK => CLK,
       LED_out => LED_out,
       Number => BUS201,
       RST => RST
  );

U8 : Prescaler
  port map(
       CLK => CLK,
       CLK_100k => CLK_100k,
       CLK_1k => CLK_1k,
       CLK_25M => CLK_25M,
       RST => RST
  );

--U9 : Ride
--  port map(
--       CE => CLK_100k,
--       CLK => CLK,
--       PLAY => Sounds_out(3),
--       RST => RST,
--       SAMPLE_OUT => BUS243
--  );

---- Dangling input signal assignment ----

Dangling_Input_Signal <= DANGLING_INPUT_CONSTANT;

AUD_SD <= '1';
WAVE <= BUS271;
BPM_LED <= NET133;

end top;
