----------------------------------------------------------------------------------
-- Async router io port implementation
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.defs.ALL;

ENTITY asyncoc_io_port_diagonal IS
    PORT (
        -- control
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;

        -- from local
        rx_local_req_in     : IN  STD_LOGIC;
        rx_local_ack_out    : OUT STD_LOGIC;
        rx_local_dat_in     : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- from internal
        rx_internal_req_in  : IN STD_LOGIC;
        rx_internal_ack_out : OUT STD_LOGIC;
        rx_internal_dat_in  : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

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
        tx_internal_0_dat_in  : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- to internal 1
        tx_internal_1_req_in  : OUT STD_LOGIC;
        tx_internal_1_ack_out : IN  STD_LOGIC;
        tx_internal_1_dat_in  : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- to internal 1
        tx_internal_2_req_in  : OUT STD_LOGIC;
        tx_internal_2_ack_out : IN  STD_LOGIC;
        tx_internal_2_dat_in  : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END asyncoc_io_port_diagonal;

ARCHITECTURE asyncoc_io_port_diagonal_arc OF asyncoc_io_port_diagonal IS


SIGNAL ctrl_req_in_sel, ctrl_ack_out_sel : STD_LOGIC;
SIGNAL ctrl_data_in_sel : STD_LOGIC_VECTOR(3 downto 0);

BEGIN


arbiter_out : entity work.arbiter
PORT MAP(
    rst           => reset,
    -- Input channel from local
    inA_req       => rx_local_req_in,
    inA_data      => rx_local_dat_in,
    inA_ack       => rx_local_ack_out,
    -- Input chann=> -- from internal,
    inB_req       => rx_internal_req_in,
    inB_data      => rx_internal_dat_in,
    inB_ack       => rx_internal_ack_out,
    -- Output chan=> ,
    outC_req      => tx_external_req_in,
    outC_data     => tx_external_dat_in,
    outC_ack      => tx_external_ack_out
);

demux_in : entity work.DEMUX_four 
PORT MAP(
    rst => reset,

    -- Input port
    rx_req_in_A  => rx_external_req_in,
    rx_data_in_A => rx_external_dat_in,
    rx_ack_out_A => rx_external_ack_out,

    -- Select port 
    ctrl_req_in_sel  => open,
    ctrl_data_in_sel => open,
    ctrl_ack_out_sel => open,

    -- Output channel 1
    tx_req_out_B  => tx_local_req_in,
    tx_data_out_B => tx_local_dat_in,
    tx_ack_in_B   => tx_local_ack_out,

    -- Output channel 2
    tx_req_out_C  => tx_internal_0_req_in,
    tx_data_out_C => tx_internal_0_dat_in,
    tx_ack_in_C   => tx_internal_0_ack_out,

    -- Output channel 3
    tx_req_out_D  => tx_internal_1_req_in,
    tx_data_out_D => tx_internal_1_dat_in,
    tx_ack_in_D   => tx_internal_1_ack_out,

    -- Output channel 4
    tx_req_out_E  => tx_internal_2_req_in,
    tx_data_out_E => tx_internal_2_dat_in,
    tx_ack_in_E   => tx_internal_2_ack_out
);

END asyncoc_io_port_diagonal_arc;