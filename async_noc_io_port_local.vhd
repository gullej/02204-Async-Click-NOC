----------------------------------------------------------------------------------
-- Async router io port implementation
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.defs.ALL;

ENTITY asyncoc_io_port_local_arc IS
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
        rx_internal_c_dat_in  : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);   
        rx_internal_c_ack_out : OUT STD_LOGIC;

        -- from internal d
        rx_internal_d_req_in  : IN STD_LOGIC;
        rx_internal_d_dat_in  : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);   
        rx_internal_d_ack_out : OUT STD_LOGIC;

        rx_internal_e_req_in  : IN STD_LOGIC;
        rx_internal_e_dat_in  : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);   
        rx_internal_e_ack_out : OUT STD_LOGIC;

        rx_internal_f_req_in  : IN STD_LOGIC;
        rx_internal_f_dat_in  : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);   
        rx_internal_f_ack_out : OUT STD_LOGIC;

        rx_internal_g_req_in  : IN STD_LOGIC;
        rx_internal_g_dat_in  : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);   
        rx_internal_g_ack_out : OUT STD_LOGIC;
        
        -- from external
        rx_external_req_in  : IN  STD_LOGIC;
        rx_external_ack_out : OUT STD_LOGIC;
        rx_external_dat_in  : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- Control from external
        rx_external_ctrl_req_in  : IN  STD_LOGIC;
        rx_external_ctrl_dat_in  : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        rx_external_ctrl_ack_out : OUT STD_LOGIC;

        -- to external
        tx_external_req_in  : OUT STD_LOGIC;
        tx_external_ack_out : IN  STD_LOGIC;
        tx_external_dat_in  : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- to internal 0
        tx_internal_0_req_in  : OUT STD_LOGIC;
        tx_internal_0_ack_out : IN  STD_LOGIC;
        tx_internal_0_dat_in  : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- to internal 1
        tx_internal_1_req_in  : OUT STD_LOGIC;
        tx_internal_1_ack_out : IN  STD_LOGIC;
        tx_internal_1_dat_in  : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- to internal 2
        tx_internal_2_req_in  : OUT STD_LOGIC;
        tx_internal_2_ack_out : IN  STD_LOGIC;
        tx_internal_2_dat_in  : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- to internal 3
        tx_internal_3_req_in  : OUT STD_LOGIC;
        tx_internal_3_ack_out : IN  STD_LOGIC;
        tx_internal_3_dat_in  : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- to internal 4
        tx_internal_4_req_in  : OUT STD_LOGIC;
        tx_internal_4_ack_out : IN  STD_LOGIC;
        tx_internal_4_dat_in  : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- to internal 5
        tx_internal_5_req_in  : OUT STD_LOGIC;
        tx_internal_5_ack_out : IN  STD_LOGIC;
        tx_internal_5_dat_in  : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- to internal 6
        tx_internal_6_req_in  : OUT STD_LOGIC;
        tx_internal_6_ack_out : IN  STD_LOGIC;
        tx_internal_6_dat_in  : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- to internal 7
        tx_internal_7_req_in  : OUT STD_LOGIC;
        tx_internal_7_ack_out : IN  STD_LOGIC;
        tx_internal_7_dat_in  : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END asyncoc_io_port_local_arc;

ARCHITECTURE asyncoc_io_port_straight_arc OF asyncoc_io_port_local_arc IS

    SIGNAL arbiter_a_req_in : STD_LOGIC;
    SIGNAL arbiter_a_ack_out : STD_LOGIC;
    SIGNAL arbiter_a_dat_in : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL arbiter_b_req_in : STD_LOGIC;
    SIGNAL arbiter_b_ack_out : STD_LOGIC;
    SIGNAL arbiter_b_dat_in : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL arbiter_c_req_in : STD_LOGIC;
    SIGNAL arbiter_c_ack_out : STD_LOGIC;
    SIGNAL arbiter_c_dat_in : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

    SIGNAL arbiter_d_req_in : STD_LOGIC;
    SIGNAL arbiter_d_dat_in : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL arbiter_d_ack_out : STD_LOGIC;
    SIGNAL arbiter_e_req_in : STD_LOGIC;
    SIGNAL arbiter_e_dat_in : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL arbiter_e_ack_out : STD_LOGIC;
    SIGNAL arbiter_f_req_in : STD_LOGIC;
    SIGNAL arbiter_f_dat_in : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL arbiter_f_ack_out : STD_LOGIC;

BEGIN

demux8_in : entity work.DEMUZ_eight
PORT (
    rst             =>  reset,
    -- Input port
    rx_req_in_A     =>  rx_external_req_in,
    rx_data_in_A    =>  rx_external_dat_in,
    rx_ack_out_A    =>  rx_external_ack_out,
    -- Select port
    ctrl_req_in_se  =>  rx_external_ctrl_req_in ,
    ctrl_data_in_s  =>  rx_external_ctrl_dat_in ,
    ctrl_ack_out_s  =>  rx_external_ctrl_ack_out,
    -- Output chan
    tx_req_out_B    =>  tx_internal_0_req_in ,
    tx_data_out_B   =>  tx_internal_0_dat_in ,
    tx_ack_in_B     =>  tx_internal_0_ack_out,
    -- Output chan
    tx_req_out_C    =>  tx_internal_1_req_in ,
    tx_data_out_C   =>  tx_internal_1_dat_in ,
    tx_ack_in_C     =>  tx_internal_1_ack_out,
    -- Output chan
    tx_req_out_D    =>  tx_internal_2_req_in ,
    tx_data_out_D   =>  tx_internal_2_dat_in ,
    tx_ack_in_D     =>  tx_internal_2_ack_out,
    -- Output chan
    tx_req_out_E    =>  tx_internal_3_req_in ,
    tx_data_out_E   =>  tx_internal_3_dat_in ,
    tx_ack_in_E     =>  tx_internal_3_ack_out,
    -- Output chan
    tx_req_out_F    =>  tx_internal_4_req_in ,
    tx_data_out_F   =>  tx_internal_4_dat_in ,
    tx_ack_in_F     =>  tx_internal_4_ack_out,
    -- Output chan
    tx_req_out_G    =>  tx_internal_5_req_in ,
    tx_data_out_G   =>  tx_internal_5_dat_in ,
    tx_ack_in_G     =>  tx_internal_5_ack_out,
    -- Output chan
    tx_req_out_H    =>  tx_internal_6_req_in ,
    tx_data_out_H   =>  tx_internal_6_dat_in ,
    tx_ack_in_H     =>  tx_internal_6_ack_out,
    -- Output chan
    tx_req_out_I    =>  tx_internal_7_req_in ,
    tx_data_out_I   =>  tx_internal_7_dat_in ,
    tx_ack_in_I     =>  tx_internal_7_ack_out,
);


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

arbiter_c : entity work.arbiter
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
    outC_req      => arbiter_c_req_in,
    outC_data     => arbiter_c_dat_in,
    outC_ack      => arbiter_c_ack_out,
);

--4:1 arbiter

arbiter_d : entity work.arbiter
PORT MAP(
    rst           => reset,
    -- Input channel from local
    inA_req       => rx_internal_d_req_in ,
    inA_data      => rx_internal_d_dat_in ,
    inA_ack       => rx_internal_d_ack_out,
    -- Input channel from internal a
    inB_req       => rx_internal_e_req_in 
    inB_data      => rx_internal_e_dat_in 
    inB_ack       => rx_internal_e_ack_out
    -- Output channel to arbiter_out
    outC_req      => arbiter_d_req_in ,
    outC_data     => arbiter_d_dat_in ,
    outC_ack      => arbiter_d_ack_out,
);

arbiter_e : entity work.arbiter
PORT MAP(
    rst           => reset,
    -- Input channel from internal b
    inA_req       => rx_internal_f_req_in ,
    inA_data      => rx_internal_f_dat_in ,
    inA_ack       => rx_internal_f_ack_out,
    -- Input channel from internal c
    inB_req       => rx_internal_g_req_in ,
    inB_data      => rx_internal_g_dat_in ,
    inB_ack       => rx_internal_g_ack_out,
    -- Output channel to arbiter_out
    outC_req      => arbiter_e_req_in ,
    outC_data     => arbiter_e_dat_in ,
    outC_ack      => arbiter_e_ack_out,
);

arbiter_f : entity work.arbiter
PORT MAP(
    rst           => reset,
    -- Input channel from arbiter a
    inA_req       => arbiter_d_req_in ,
    inA_data      => arbiter_d_dat_in ,
    inA_ack       => arbiter_d_ack_out,
    -- Input channel from arbiter b
    inB_req       => arbiter_e_req_in ,
    inB_data      => arbiter_e_dat_in ,
    inB_ack       => arbiter_e_ack_out,
    -- Output channel
    outC_req      => arbiter_f_req_in,
    outC_data     => arbiter_f_dat_in,
    outC_ack      => arbiter_f_ack_out,
);

--out

arbiter_f : entity work.arbiter
PORT MAP(
    rst           => reset,
    -- Input channel from arbiter a
    inA_req       => arbiter_c_req_in,
    inA_data      => arbiter_c_dat_in,
    inA_ack       => arbiter_c_ack_out,
    -- Input channel from arbiter b
    inB_req       => arbiter_f_req_in,
    inB_data      => arbiter_f_dat_in,
    inB_ack       => arbiter_f_ack_out,
    -- Output channel
    outC_req      => tx_external_req_in,
    outC_data     => tx_external_dat_in,
    outC_ack      => tx_external_ack_out,
);

END asyncoc_io_port_straight_arc;