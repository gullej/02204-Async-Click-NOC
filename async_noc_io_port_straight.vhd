----------------------------------------------------------------------------------
-- Async router io port implementation
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.defs.ALL;

ENTITY asyncoc_io_port_straight IS
    PORT (
        -- control
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;

        -- from local
        rx_local_req_in     : IN  STD_LOGIC;
        rx_local_ack_out    : OUT STD_LOGIC;
        rx_local_dat_in     : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- from internal a
        rx_internal_a_req_in  : IN STD_LOGIC;
        rx_internal_a_ack_out : OUT STD_LOGIC;
        rx_internal_a_dat_in  : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- from internal b
        rx_internal_b_req_in  : IN STD_LOGIC;
        rx_internal_b_ack_out : OUT STD_LOGIC;
        rx_internal_b_dat_in  : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- from internal c
        rx_internal_c_req_in  : IN STD_LOGIC;
        rx_internal_c_ack_out : OUT STD_LOGIC;
        rx_internal_c_dat_in  : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);   
        
        -- from external
        rx_external_req_in  : IN  STD_LOGIC;
        rx_external_ack_out : OUT STD_LOGIC;
        rx_external_dat_in  : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- to external
        tx_external_req_in  : OUT STD_LOGIC;
        tx_external_ack_out : IN  STD_LOGIC;
        tx_external_dat_in  : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- to local
        tx_local_req_in  : OUT STD_LOGIC;
        tx_local_ack_out : IN  STD_LOGIC;
        tx_local_dat_in  : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- to internal 1
        tx_internal_0_req_in  : OUT STD_LOGIC;
        tx_internal_0_ack_out : IN  STD_LOGIC;
        tx_internal_0_dat_in  : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END asyncoc_io_port_straight;

ARCHITECTURE asyncoc_io_port_straight_arc OF asyncoc_io_port_straight IS

    SIGNAL arbiter_a_req_in : STD_LOGIC;
    SIGNAL arbiter_a_ack_out : STD_LOGIC;
    SIGNAL arbiter_a_dat_in : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL arbiter_b_req_in : STD_LOGIC;
    SIGNAL arbiter_b_ack_out : STD_LOGIC;
    SIGNAL arbiter_b_dat_in : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

BEGIN


arbiter_a : entity work.arbiter
PORT MAP(
    rst           => reset,
    -- Input channel from local
    inA_req       => rx_local_req_in,
    inA_data      => rx_local_dat_in,
    inA_ack       => rx_local_ack_out,
    -- Input channel from internal a
    inB_req       => rx_internal_a_req_in,
    inB_data      => rx_internal_a_dat_in,
    inB_ack       => rx_internal_a_ack_out,
    -- Output channel to arbiter_out
    outC_req      => arbiter_a_req_in,
    outC_data     => arbiter_a_dat_in,
    outC_ack      => arbiter_a_ack_out
);

arbiter_b : entity work.arbiter
PORT MAP(
    rst           => reset,
    -- Input channel from internal b
    inA_req       => rx_internal_b_req_in,
    inA_data      => rx_internal_b_dat_in,
    inA_ack       => rx_internal_b_ack_out,
    -- Input channel from internal c
    inB_req       => rx_internal_c_req_in,
    inB_data      => rx_internal_c_dat_in,
    inB_ack       => rx_internal_c_ack_out,
    -- Output channel to arbiter_out
    outC_req      => arbiter_b_req_in,
    outC_data     => arbiter_b_dat_in,
    outC_ack      => arbiter_b_ack_out
);

arbiter_out : entity work.arbiter
PORT MAP(
    rst           => reset,
    -- Input channel from arbiter a
    inA_req       => arbiter_a_req_in,
    inA_data      => arbiter_a_dat_in,
    inA_ack       => arbiter_a_ack_out,
    -- Input channel from arbiter b
    inB_req       => arbiter_b_req_in,
    inB_data      => arbiter_b_dat_in,
    inB_ack       => arbiter_b_ack_out,
    -- Output channel
    outC_req      => tx_external_req_in,
    outC_data     => tx_external_dat_in,
    outC_ack      => tx_external_ack_out
);

demux_in : entity work.DEMUX
PORT MAP(
    rst => reset,
    
    -- Input port
    inA_req  =>  rx_external_req_in,    
    inA_data =>  rx_external_dat_in,    
    inA_ack  =>  rx_external_ack_out,    
    -- Select port
    inSel_req   => open,  
    inSel_ack   => open,  
    selector    => open,  
    -- Output chan
    outB_req  =>  tx_local_req_in,   
    outB_data =>  tx_local_dat_in,   
    outB_ack  =>  tx_local_ack_out,   
    -- Output chan
    outC_req   => tx_internal_0_req_in,  
    outC_data  => tx_internal_0_dat_in,  
    outC_ack   => tx_internal_0_ack_out    
);

END asyncoc_io_port_straight_arc;