----------------------------------------------------------------------------------
-- Async router io port implementation
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.defs.ALL;

ENTITY asyncoc_io_port_straight IS
    GENERIC (
        LOCATION_X            :  integer;
        LOCATION_Y            :  integer;
        ADDR_WIDTH            :  integer
    );
    PORT (
        -- control
        reset                  : IN STD_LOGIC;

        -- from local
        rx_local_req_in        : IN  STD_LOGIC;
        rx_local_ack_out       : OUT STD_LOGIC;
        rx_local_dat_in        : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- from internal a
        rx_internal_a_req_in   : IN STD_LOGIC;
        rx_internal_a_ack_out  : OUT STD_LOGIC;
        rx_internal_a_dat_in   : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- from internal b
        rx_internal_b_req_in   : IN STD_LOGIC;
        rx_internal_b_ack_out  : OUT STD_LOGIC;
        rx_internal_b_dat_in   : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- from internal c
        rx_internal_c_req_in   : IN STD_LOGIC;
        rx_internal_c_ack_out  : OUT STD_LOGIC;
        rx_internal_c_dat_in   : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);   
        
        -- from external
        rx_external_req_in     : IN  STD_LOGIC;
        rx_external_ack_out    : OUT STD_LOGIC;
        rx_external_dat_in     : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- to external
        tx_external_req_in     : OUT STD_LOGIC;
        tx_external_ack_out    : IN  STD_LOGIC;
        tx_external_dat_in     : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- to local
        tx_local_req_in       : OUT STD_LOGIC;
        tx_local_ack_out      : IN  STD_LOGIC;
        tx_local_dat_in       : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- to internal straight
        tx_internal_0_req_in  : OUT STD_LOGIC;
        tx_internal_0_ack_out : IN  STD_LOGIC;
        tx_internal_0_dat_in  : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END asyncoc_io_port_straight;

ARCHITECTURE asyncoc_io_port_straight_arc OF asyncoc_io_port_straight IS

    CONSTANT ROUTER_LOCATION_X  :  STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0) := STD_LOGIC_VECTOR(to_unsigned(LOCATION_X,ADDR_WIDTH));
    CONSTANT ROUTER_LOCATION_Y  :  STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0) := STD_LOGIC_VECTOR(to_unsigned(LOCATION_y,ADDR_WIDTH)); 

    SIGNAL arbiter_a_req_in : STD_LOGIC;
    SIGNAL arbiter_a_ack_out : STD_LOGIC;
    SIGNAL arbiter_a_dat_in : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL arbiter_b_req_in : STD_LOGIC;
    SIGNAL arbiter_b_ack_out : STD_LOGIC;
    SIGNAL arbiter_b_dat_in : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

    SIGNAL fork_outB_req   :  STD_LOGIC;
    SIGNAL fork_outB_data  :  STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
    SIGNAL fork_outB_ack   :  STD_LOGIC;

    SIGNAL fork_outC_req   :  STD_LOGIC;
    SIGNAL fork_outC_data  :  STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
    SIGNAL fork_outC_ack   :  STD_LOGIC;

    SIGNAL mux_sel_req   :  STD_LOGIC;
    SIGNAL mux_sel_data  :  STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL mux_sel_ack   :  STD_LOGIC;

    SIGNAL x : STD_LOGIC;
    SIGNAL y : STD_LOGIC;

    SIGNAL x_dest  :  STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0); 
    SIGNAL y_dest  :  STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0); 

BEGIN

mux_sel_req  <=  fork_outC_req after XOR_DELAY + OR2_DELAY*ADDR_WIDTH + AND2_DELAY + NOT1_DELAY;

x_dest  <=  fork_outC_data(DATA_WIDTH-1 DOWNTO DATA_WIDTH-ADDR_WIDTH);
y_dest  <=  fork_outC_data(DATA_WIDTH-ADDR_WIDTH-1 DOWNTO DATA_WIDTH-ADDR_WIDTH*2);

x <= or(x_dest xor ROUTER_LOCATION_X) AFTER XOR_DELAY + OR2_DELAY*ADDR_WIDTH;
y <= or(y_dest xor ROUTER_LOCATION_Y) AFTER XOR_DELAY + OR2_DELAY*ADDR_WIDTH;

mux_sel_data(0) <= (not x) and (not y)  AFTER AND2_DELAY + NOT1_DELAY;

fork_outC_ack  <=  mux_sel_ack;


fork_in : entity work.reg_fork
Port map (
  rst         =>  reset,
  --Input chan
  inA_req     =>  rx_external_req_in ,
  inA_data    =>  rx_external_dat_in,
  inA_ack     =>  rx_external_ack_out,
  --Output cha
  outB_req    =>  fork_outB_req ,
  outB_data   =>  fork_outB_data,
  outB_ack    =>  fork_outB_ack ,
  --Output cha
  outC_req    =>  fork_outC_req ,
  outC_data   =>  fork_outC_data,
  outC_ack    =>  fork_outC_ack 
  );

arbiter_a : entity work.ARBITER
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

arbiter_b : entity work.ARBITER
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

arbiter_out : entity work.ARBITER
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
    inA_req  =>  fork_outB_req , 
    inA_data =>  fork_outB_data, 
    inA_ack  =>  fork_outB_ack ,  
    -- Select port
    inSel_req   => mux_sel_req,
    inSel_ack   => mux_sel_ack,
    selector    => mux_sel_data(0),
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