----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.01.2019 13:41:33
-- Design Name: 
-- Module Name: BPM_CLK_div - Behavioral
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
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.ALL;

entity BPM_CLK_div is
port(
  i_clk         : in  std_logic;
  i_rst         : in  std_logic;
  i_clk_divider : in  std_logic_vector(25 downto 0);
  o_clk         : out std_logic);
end BPM_CLK_div;

architecture Behavioral of BPM_CLK_div is

signal r_clk_counter        : unsigned(25 downto 0);
signal r_clk_divider        : unsigned(25 downto 0);
signal r_clk_divider_half   : unsigned(25 downto 0);

begin

p_clk_divider: process(i_rst,i_clk)
begin
    if(i_rst='1') then
        r_clk_counter       <= (others=>'0');
        r_clk_divider       <= (others=>'0');
        r_clk_divider_half  <= (others=>'0');
        o_clk               <= '0';
    elsif(rising_edge(i_clk)) then
        r_clk_divider       <= unsigned(i_clk_divider)-1;
        r_clk_divider_half  <= unsigned('0'&i_clk_divider(25 downto 1)); -- half
        if(r_clk_counter < r_clk_divider_half) then 
            r_clk_counter   <= r_clk_counter + 1;
            o_clk           <= '0';
        elsif(r_clk_counter = r_clk_divider) then
            r_clk_counter   <= (others=>'0');
            o_clk           <= '1';
        else
            r_clk_counter   <= r_clk_counter + 1;
            o_clk           <= '0';
        end if;
    end if;    
end process p_clk_divider;
										

end Behavioral;
