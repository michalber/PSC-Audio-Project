----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.01.2019 13:43:09
-- Design Name: 
-- Module Name: BPM_CLK_div_tb - Behavioral
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

entity BPM_CLK_div_tb  is
end;

architecture bench of BPM_CLK_div_tb  is

  component BPM_CLK_div
  port(
    i_clk         : in  std_logic;
    i_rst         : in  std_logic;
    i_clk_divider : in  std_logic_vector(25 downto 0);
    o_clk         : out std_logic);
  end component;

  signal i_clk: std_logic := '0';
  signal i_rst: std_logic;
  signal i_clk_divider: std_logic_vector(25 downto 0);
  signal o_clk: std_logic;

  constant clock_period: time := 1 ps;
  signal stop_the_clock: boolean;

begin

  uut: BPM_CLK_div port map ( i_clk         => i_clk,
                            i_rst         => i_rst,
                            i_clk_divider => i_clk_divider,
                            o_clk         => o_clk );

i_clk <= not i_clk after clock_period;

process
begin
    i_rst <= '1';
    wait for 10 ps;
    i_rst <= '0';
    wait for 10 ps;    
    wait;
end process;

process
begin
    i_clk_divider <= b"00_0000_0000_0000_0000_0000_0100";
    wait;
end process;

end;
