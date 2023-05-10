----------------------------------------------------------------------------------
-- Async router io port implementation
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.defs.ALL;

ENTITY async_noc_io_port_local IS
    GENERIC (
        LOCATION_X                       :  integer;
        LOCATION_Y                       :  integer;
        ADDR_WIDTH                       :  integer
    );
    PORT (
        -- control
        reset                            : IN STD_LOGIC;
        start                            : IN STD_LOGIC;

        -- from local i.e H
        rx_local_req_in                  : IN  STD_LOGIC;
        rx_local_ack_out                 : OUT STD_LOGIC;
        rx_local_dat_in                  : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- from internal a
        rx_internal_a_req_in             : IN STD_LOGIC;
        rx_internal_a_ack_out            : OUT STD_LOGIC;
        rx_internal_a_dat_in             : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- from internal b
        rx_internal_b_req_in             : IN STD_LOGIC;
        rx_internal_b_ack_out            : OUT STD_LOGIC;
        rx_internal_b_dat_in             : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- from internal c
        rx_internal_c_req_in             : IN STD_LOGIC;
        rx_internal_c_dat_in             : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);   
        rx_internal_c_ack_out            : OUT STD_LOGIC;

        -- from internal d
        rx_internal_d_req_in             : IN STD_LOGIC;
        rx_internal_d_dat_in             : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);   
        rx_internal_d_ack_out            : OUT STD_LOGIC;

        -- from internal e
        rx_internal_e_req_in             : IN STD_LOGIC;
        rx_internal_e_dat_in             : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);   
        rx_internal_e_ack_out            : OUT STD_LOGIC;

        -- from internal f
        rx_internal_f_req_in             : IN STD_LOGIC;
        rx_internal_f_dat_in             : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);   
        rx_internal_f_ack_out            : OUT STD_LOGIC;

        -- from internal g
        rx_internal_g_req_in             : IN STD_LOGIC;
        rx_internal_g_dat_in             : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);   
        rx_internal_g_ack_out            : OUT STD_LOGIC;
        
        -- from internal h
        rx_internal_h_req_in     : IN  STD_LOGIC;
        rx_internal_h_ack_out    : OUT STD_LOGIC;
        rx_internal_h_dat_in     : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- from external
        rx_external_req_in               : IN  STD_LOGIC;
        rx_external_ack_out              : OUT STD_LOGIC;
        rx_external_dat_in               : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- to external
        tx_external_req_in               : OUT STD_LOGIC;
        tx_external_dat_in               : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        tx_external_ack_out              : IN  STD_LOGIC;

        -- to internal north west
        tx_internal_north_west_req_in    : OUT STD_LOGIC;
        tx_internal_north_west_dat_in    : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        tx_internal_north_west_ack_out   : IN  STD_LOGIC;
  
        -- to internal west  
        tx_internal_west_req_in         : OUT STD_LOGIC;
        tx_internal_west_dat_in         : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        tx_internal_west_ack_out        : IN  STD_LOGIC;

        -- to internal south west
        tx_internal_south_west_req_in   : OUT STD_LOGIC;
        tx_internal_south_west_dat_in   : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        tx_internal_south_west_ack_out  : IN  STD_LOGIC;

        -- to internal south
        tx_internal_south_req_in        : OUT STD_LOGIC;
        tx_internal_south_dat_in        : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        tx_internal_south_ack_out       : IN  STD_LOGIC;

        -- to internal south east
        tx_internal_south_east_req_in   : OUT STD_LOGIC;
        tx_internal_south_east_dat_in   : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        tx_internal_south_east_ack_out  : IN  STD_LOGIC;

        -- to internal east
        tx_internal_east_req_in         : OUT STD_LOGIC;
        tx_internal_east_dat_in         : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        tx_internal_east_ack_out        : IN  STD_LOGIC;

        -- to internal north east 
        tx_internal_north_east_req_in   : OUT STD_LOGIC;
        tx_internal_north_east_dat_in   : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        tx_internal_north_east_ack_out  : IN  STD_LOGIC;

        -- to internal north
        tx_internal_north_req_in        : OUT STD_LOGIC;
        tx_internal_north_dat_in        : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        tx_internal_north_ack_out       : IN  STD_LOGIC
    );
END async_noc_io_port_local;

ARCHITECTURE asyncoc_io_port_straight_arc OF async_noc_io_port_local IS

    CONSTANT ROUTER_LOCATION_X  :  STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0) := STD_LOGIC_VECTOR(to_unsigned(LOCATION_X,ADDR_WIDTH));
    CONSTANT ROUTER_LOCATION_Y  :  STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0) := STD_LOGIC_VECTOR(to_unsigned(LOCATION_y,ADDR_WIDTH));


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

    SIGNAL fork_outB_req   :  STD_LOGIC;
    SIGNAL fork_outB_data  :  STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
    SIGNAL fork_outB_ack   :  STD_LOGIC;

    SIGNAL fork_outC_req   :  STD_LOGIC;
    SIGNAL fork_outC_data  :  STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
    SIGNAL fork_outC_ack   :  STD_LOGIC;

    SIGNAL mux_sel_req   :  STD_LOGIC;
    SIGNAL mux_sel_data  :  STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL mux_sel_ack   :  STD_LOGIC;

    SIGNAL x_dest  :  STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0); 
    SIGNAL y_dest  :  STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0); 

BEGIN

mux_sel_req  <=  fork_outC_req after XOR_DELAY + OR2_DELAY*ADDR_WIDTH + AND2_DELAY + NOT1_DELAY;

x_dest  <=  fork_outC_data(DATA_WIDTH-1 DOWNTO DATA_WIDTH-ADDR_WIDTH);
y_dest  <=  fork_outC_data(DATA_WIDTH-ADDR_WIDTH-1 DOWNTO DATA_WIDTH-ADDR_WIDTH*2);

mux_sel_data(7) <=  '1' when ((x_dest = ROUTER_LOCATION_X) and (y_dest > ROUTER_LOCATION_Y)) else '0'; -- will go north
mux_sel_data(6) <=  '1' when ((x_dest > ROUTER_LOCATION_X) and (y_dest > ROUTER_LOCATION_Y)) else '0'; -- will go north east
mux_sel_data(5) <=  '1' when ((x_dest > ROUTER_LOCATION_X) and (y_dest = ROUTER_LOCATION_Y)) else '0'; -- will go east
mux_sel_data(4) <=  '1' when ((x_dest > ROUTER_LOCATION_X) and (y_dest < ROUTER_LOCATION_Y)) else '0'; -- will go south east
mux_sel_data(3) <=  '1' when ((x_dest = ROUTER_LOCATION_X) and (y_dest < ROUTER_LOCATION_Y)) else '0'; -- will go south
mux_sel_data(2) <=  '1' when ((x_dest < ROUTER_LOCATION_X) and (y_dest < ROUTER_LOCATION_Y)) else '0'; -- will go south west
mux_sel_data(1) <=  '1' when ((x_dest < ROUTER_LOCATION_X) and (y_dest = ROUTER_LOCATION_Y)) else '0'; -- will go west
mux_sel_data(0) <=  '1' when ((x_dest < ROUTER_LOCATION_X) and (y_dest > ROUTER_LOCATION_Y)) else '0'; -- will go nort west
                        
fork_outC_ack  <=  mux_sel_ack;

fork_in : entity work.reg_fork
Port map (
  rst         =>  reset,
  --Input channnel
  inA_req     =>  rx_external_req_in ,
  inA_data    =>  rx_external_dat_in,
  inA_ack     =>  rx_external_ack_out,
  --Output channel
  outB_req    =>  fork_outB_req ,
  outB_data   =>  fork_outB_data,
  outB_ack    =>  fork_outB_ack ,
  --Output channel
  outC_req    =>  fork_outC_req ,
  outC_data   =>  fork_outC_data,
  outC_ack    =>  fork_outC_ack 
  );

demux8_in : entity work.DEMUX_eight
PORT MAP(
    -- Control
    rst               =>  reset,
    -- Input port
    rx_req_in_A       => fork_outB_req ,
    rx_data_in_A      => fork_outB_data,
    rx_ack_out_A      => fork_outB_ack ,
    -- Select port
    ctrl_req_in_sel   =>  mux_sel_req ,
    ctrl_data_in_sel  =>  mux_sel_data,
    ctrl_ack_out_sel  =>  mux_sel_ack ,

    -- will go north           mux_sel_data(7)
-- will go north east       mux_sel_data(6)
-- will go east       mux_sel_data(5)
-- will go south east       mux_sel_data(4)
-- will go south       mux_sel_data(3)
-- will go south west       mux_sel_data(2)
-- will go west       mux_sel_data(1)
-- will go nort west       mux_sel_data(0)


    -- Output channel 1, chosen by ctrl_data_in_sel(0)
    tx_req_out_B      =>  tx_internal_north_west_req_in ,
    tx_data_out_B     =>  tx_internal_north_west_dat_in ,
    tx_ack_in_B       =>  tx_internal_north_west_ack_out,
    -- Output channel 2, chosen by ctrl_data_in_sel(1)
    tx_req_out_C      =>  tx_internal_west_req_in ,
    tx_data_out_C     =>  tx_internal_west_dat_in ,
    tx_ack_in_C       =>  tx_internal_west_ack_out,
    -- Output channel 3, chosen by ctrl_data_in_sel(2)
    tx_req_out_D      =>  tx_internal_south_west_req_in ,
    tx_data_out_D     =>  tx_internal_south_west_dat_in ,
    tx_ack_in_D       =>  tx_internal_south_west_ack_out,
    -- Output channel 4, chosen by ctrl_data_in_sel(3)
    tx_req_out_E      =>  tx_internal_south_req_in ,
    tx_data_out_E     =>  tx_internal_south_dat_in ,
    tx_ack_in_E       =>  tx_internal_south_ack_out,
    -- Output channel 5, chosen by ctrl_data_in_sel(4)
    tx_req_out_F      =>  tx_internal_south_east_req_in ,
    tx_data_out_F     =>  tx_internal_south_east_dat_in ,
    tx_ack_in_F       =>  tx_internal_south_east_ack_out,
    -- Output channel 6, chosen by ctrl_data_in_sel(5)
    tx_req_out_G      =>  tx_internal_east_req_in ,
    tx_data_out_G     =>  tx_internal_east_dat_in ,
    tx_ack_in_G       =>  tx_internal_east_ack_out,
    -- Output channel 7, chosen by ctrl_data_in_sel(6)
    tx_req_out_H      =>  tx_internal_north_east_req_in ,
    tx_data_out_H     =>  tx_internal_north_east_dat_in ,
    tx_ack_in_H       =>  tx_internal_north_east_ack_out,
    -- Output channel 8, chosen by ctrl_data_in_sel(7)
    tx_req_out_I      =>  tx_internal_north_req_in ,
    tx_data_out_I     =>  tx_internal_north_dat_in ,
    tx_ack_in_I       =>  tx_internal_north_ack_out
);

------
--
--    a  -  ar
--          bit  -  c
--    b  -  er
--
-------

arbiter_leaf_a : entity work.arbiter
PORT MAP(
    -- Control
    rst           => reset,
    -- Input channel from local
    inA_req       => rx_internal_a_req_in,
    inA_data      => rx_internal_a_dat_in,
    inA_ack       => rx_internal_a_ack_out,
    -- Input channel from internal a
    inB_req       => rx_internal_b_req_in,
    inB_data      => rx_internal_b_dat_in,
    inB_ack       => rx_internal_b_ack_out,
    -- Output channel to arbiter_out
    outC_req      => arbiter_a_req_in,
    outC_data     => arbiter_a_dat_in,
    outC_ack      => arbiter_a_ack_out
);

arbiter_leaf_b : entity work.arbiter
PORT MAP(
    -- Control
    rst           => reset,
    -- Input channel from internal b
    inA_req       => rx_internal_c_req_in,
    inA_data      => rx_internal_c_dat_in,
    inA_ack       => rx_internal_c_ack_out,
    -- Input channel from internal c
    inB_req       => rx_internal_d_req_in,
    inB_data      => rx_internal_d_dat_in,
    inB_ack       => rx_internal_d_ack_out,
    -- Output channel to arbiter_out
    outC_req      => arbiter_b_req_in,
    outC_data     => arbiter_b_dat_in,
    outC_ack      => arbiter_b_ack_out
);

arbiter_branch_c : entity work.arbiter
PORT MAP(
    -- Control
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
    outC_ack      => arbiter_c_ack_out
);

------
--
--    d  -  ar
--          bit  -  f
--    e  -  er
--
-------

arbiter_leaf_d : entity work.arbiter
PORT MAP(
    rst           => reset,
    -- Input channel from local
    inA_req       => rx_internal_e_req_in ,
    inA_data      => rx_internal_e_dat_in ,
    inA_ack       => rx_internal_e_ack_out,
    -- Input channel from internal a
    inB_req       => rx_internal_f_req_in ,
    inB_data      => rx_internal_f_dat_in ,
    inB_ack       => rx_internal_f_ack_out,
    -- Output channel to arbiter_out
    outC_req      => arbiter_d_req_in ,
    outC_data     => arbiter_d_dat_in ,
    outC_ack      => arbiter_d_ack_out
);

arbiter_leaf_e : entity work.arbiter
PORT MAP(
    rst           => reset,
    -- Input channel from internal b
    inA_req       => rx_internal_g_req_in ,
    inA_data      => rx_internal_g_dat_in ,
    inA_ack       => rx_internal_g_ack_out,
    -- Input channel from internal c
    inB_req       => rx_internal_h_req_in ,
    inB_data      => rx_internal_h_dat_in ,
    inB_ack       => rx_internal_h_ack_out,
    -- Output channel to arbiter_out
    outC_req      => arbiter_e_req_in ,
    outC_data     => arbiter_e_dat_in ,
    outC_ack      => arbiter_e_ack_out
);

arbiter_branch_f : entity work.arbiter
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
    outC_ack      => arbiter_f_ack_out
);

------
--
--    c  -  ar
--          bit  -  g
--    f  -  er
--
-------

arbiter_trunk_g : entity work.arbiter
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
    outC_ack      => tx_external_ack_out
);

END asyncoc_io_port_straight_arc;