----------------------------------------------------------------------------------
-- DEMUX_eight
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.defs.ALL;

entity arbiter is
    generic(
      PHASE_INIT_A        : std_logic := '0';
      PHASE_INIT_B        : std_logic := '0';
      PHASE_INIT_C  : std_logic := '0');
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
    SIGNAL req1, req2 : STD_LOGIC;

    signal mergeAckA, mergeAckB : std_logic;

begin

    -- MUTEX  
    mid1 <= inA_req nand mid2 after AND2_DELAY + NOT1_DELAY;
    -- set the second one slightly out of phase with the first,
    -- this will resolve "metastability" that cannot be simulated
    mid2 <= inB_req nand mid1 after AND2_DELAY + NOT1_DELAY + 1 ns; 
    grant1 <= ((not mid1) and mid2) after AND2_DELAY + NOT1_DELAY;
    grant2 <= ((not mid2) and mid1) after AND2_DELAY + NOT1_DELAY;
    
    req1 <= grant1 and (not mergeAckB) after AND2_DELAY + NOT1_DELAY;
    req2 <= grant2 and (not mergeAckA) after AND2_DELAY + NOT1_DELAY;

    inA_ack <= mergeAckA;
    inB_ack <= mergeAckB;

    -- MERGE
    merge : ENTITY work.merge 
    GENERIC MAP(
        PHASE_INIT_A => PHASE_INIT_A,
        PHASE_INIT_B => PHASE_INIT_B,
        PHASE_INIT_C => PHASE_INIT_C
    )
    PORT MAP(
        rst   => rst,
        --Input channel 1
        inA_req   => req1,
        inA_ack   => mergeAckA,
        inA_data  => inA_data,
        -- Input channel 2
        inB_req   => req2,
        inB_ack   => mergeAckB,
        inB_data  => inB_data,
        -- Output channel
        outC_req  => outC_req,
        outC_data => outC_data,
        outC_ack  => outC_ack
    );

end Behavioral;
