----------------------------------------------------------------------------------
-- DEMUX_eight
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.defs.ALL;

entity arbiter is
    port(
      rst           : in  std_logic;
      -- Input channel 1
      inA_req       : in  std_logic;
      inA_data      : in std_logic_vector(DATA_WIDTH-1 downto 0);
      inA_ack       : out std_logic;
      -- Input channel 2
      inB_req      : in  std_logic;
      inB_data     : in std_logic_vector(DATA_WIDTH-1 downto 0);
      inB_ack      : out std_logic;
      -- Output channel
      outC_req      : out std_logic;
      outC_data     : out std_logic_vector(DATA_WIDTH-1 downto 0);
      outC_ack      : in  std_logic
      );
end arbiter;
  
architecture Behavioral of arbiter is

    SIGNAL grant1, grant2 : STD_LOGIC;
    SIGNAL mid1, mid2 : STD_LOGIC;

begin

    -- MUTEX  
    mid1 <= inA_req nand mid2 after AND2_DELAY + NOT1_DELAY;
    mid2 <= inB_req nand mid1 after AND2_DELAY + NOT1_DELAY + 1 ns;
    grant1 <= (not mid1) and mid2 after AND2_DELAY + NOT1_DELAY;
    grant2 <= (not mid2) and mid1 after AND2_DELAY + NOT1_DELAY;

    -- MERGE
    merge : ENTITY work.merge PORT MAP(
        rst   => rst,
        --Input channel 1
        inA_req   => grant1,
        inA_ack   => inA_ack,
        inA_data  => inA_data,
        -- Input channel 2
        inB_req   => grant2,
        inB_ack   => inB_ack,
        inB_data  => inB_data,
        -- Output channel
        outC_req  => outC_req,
        outC_data => outC_data,
        outC_ack  => outC_ack
    );



end Behavioral;
