----------------------------------------------------------------------------------
-- Async router circuit implementation
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.defs.ALL;

ENTITY async_noc_router IS
    PORT (
        -- control
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;

        -- north direction
        rx_req_in_dem_N  : IN  STD_LOGIC;
        rx_ack_out_dem_N : OUT STD_LOGIC;
        rx_dat_in_N      : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        tx_ack_in_arb_N  : IN  STD_LOGIC;
        tx_req_out_arb_N : OUT STD_LOGIC;
        tx_dat_out_N     : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- north east direction
        rx_req_in_dem_NE  : IN  STD_LOGIC;
        rx_ack_out_dem_NE : OUT STD_LOGIC;
        rx_dat_in_NE      : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        tx_ack_in_arb_NE  : IN  STD_LOGIC;
        tx_req_out_arb_NE : OUT STD_LOGIC;
        tx_dat_out_NE     : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- east direction
        rx_req_in_dem_E  : IN  STD_LOGIC;
        rx_ack_out_dem_E : OUT STD_LOGIC;
        rx_dat_in_E      : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        tx_ack_in_arb_E  : IN  STD_LOGIC;
        tx_req_out_arb_E : OUT STD_LOGIC;
        tx_dat_out_E     : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- south east direction
        rx_req_in_dem_SE  : IN  STD_LOGIC;
        rx_ack_out_dem_SE : OUT STD_LOGIC;
        rx_dat_in_SE      : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        tx_ack_in_arb_SE  : IN  STD_LOGIC;
        tx_req_out_arb_SE : OUT STD_LOGIC;
        tx_dat_out_SE     : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- south direction
        rx_req_in_dem_S  : IN  STD_LOGIC;
        rx_ack_out_dem_S : OUT STD_LOGIC;
        rx_dat_in_S      : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        tx_ack_in_arb_S : IN STD_LOGIC;
        tx_req_out_arb_S : OUT STD_LOGIC;
        tx_dat_out_S : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- south west direction
        rx_req_in_dem_SW  : IN  STD_LOGIC;
        rx_ack_out_dem_SW : OUT STD_LOGIC;
        rx_dat_in_SW      : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        tx_ack_in_arb_SW  : IN  STD_LOGIC;
        tx_req_out_arb_SW : OUT STD_LOGIC;
        tx_dat_out_SW     : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- west direction
        rx_req_in_dem_W  : IN  STD_LOGIC;
        rx_ack_out_dem_W : OUT STD_LOGIC;
        rx_dat_in_W      : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        tx_ack_in_arb_W  : IN  STD_LOGIC;
        tx_req_out_arb_W : OUT STD_LOGIC;
        tx_dat_out_W     : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- north west direction
        rx_req_in_dem_NW  : IN  STD_LOGIC;
        rx_ack_out_dem_NW : OUT STD_LOGIC;
        rx_dat_in_NW      : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        tx_ack_in_arb_NW  : IN  STD_LOGIC;
        tx_req_out_arb_NW : OUT STD_LOGIC;
        tx_dat_out_NW     : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        -- local direction
        tx_req_in_dem_L  : IN  STD_LOGIC;
        tx_ack_out_dem_L : OUT STD_LOGIC;
        tx_dat_in_L      : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        rx_ack_in_arb_L  : IN  STD_LOGIC;
        rx_req_out_arb_L : OUT STD_LOGIC;
        rx_dat_out_L     : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END async_noc_router;

ARCHITECTURE async_noc_router_arc OF async_noc_router IS

BEGIN

 STRAIGHT_PORT : entity work.
 GENERIC (
    LOCATION_X                    =>  1,
    LOCATION_Y                    =>  1,
    ADDR_WIDTH                    =>  2,
  );
  PORT (
      -- control
      reset                        =>  reset, 
      -- from local
      rx_local_req_in              =>  , 
      rx_local_ack_out             =>  , 
      rx_local_dat_in              =>  , 
      -- from internal a
      rx_internal_a_req_in         =>  , 
      rx_internal_a_ack_out        =>  , 
      rx_internal_a_dat_in         =>  , 
      -- from internal b
      rx_internal_b_req_in         =>  , 
      rx_internal_b_ack_out        =>  , 
      rx_internal_b_dat_in         =>  , 
      -- from internal c
      rx_internal_c_req_in         =>  , 
      rx_internal_c_ack_out        =>  , 
      rx_internal_c_dat_in         =>  , 
      
      -- from external
      rx_external_req_in           =>  , 
      rx_external_ack_out          =>  , 
      rx_external_dat_in           =>  , 
      -- to external
      tx_external_req_in           =>  , 
      tx_external_ack_out          =>  , 
      tx_external_dat_in           =>  , 
      -- to internal local
      tx_internal_local_req_in     =>  , 
      tx_internal_local_ack_out    =>  , 
      tx_internal_local_dat_in     =>  , 
      -- to internal straight
      tx_internal_across_req_in    =>  , 
      tx_internal_across_ack_out   =>  , 
      tx_internal_across_dat_in    =>  , 
  );

 LOCAL_PORT : entity work.asyncoc_io_port_local
   GENERIC MAP (
      LOCATION_X                      =>  1,
      LOCATION_Y                      =>  1,
      ADDR_WIDTH                      =>  2,
  );
  PORT MAP (
      -- control
      reset                           =>  ,
      start                           =>  ,
      -- from local i.e H
      rx_local_req_in                 =>  ,
      rx_local_ack_out                =>  ,
      rx_local_dat_in                 =>  ,
      -- from internal a
      rx_internal_a_req_in            =>  ,
      rx_internal_a_ack_out           =>  ,
      rx_internal_a_dat_in            =>  ,
      -- from internal b
      rx_internal_b_req_in            =>  ,
      rx_internal_b_ack_out           =>  ,
      rx_internal_b_dat_in            =>  ,
      -- from internal c
      rx_internal_c_req_in            =>  ,
      rx_internal_c_dat_in            =>  ,
      rx_internal_c_ack_out           =>  ,
      -- from internal d
      rx_internal_d_req_in            =>  ,
      rx_internal_d_dat_in            =>  ,
      rx_internal_d_ack_out           =>  ,
      -- from internal e
      rx_internal_e_req_in            =>  ,
      rx_internal_e_dat_in            =>  ,
      rx_internal_e_ack_out           =>  ,
      -- from internal f
      rx_internal_f_req_in            =>  ,
      rx_internal_f_dat_in            =>  ,
      rx_internal_f_ack_out           =>  ,
      -- from internal g
      rx_internal_g_req_in            =>  ,
      rx_internal_g_dat_in            =>  ,
      rx_internal_g_ack_out           =>  ,
      
      -- from external
      rx_external_req_in              =>  tx_req_in_dem_L,
      rx_external_ack_out             =>  tx_ack_out_dem_L,
      rx_external_dat_in              =>  tx_dat_in_L,
      -- to external
      tx_external_req_in              =>  rx_ack_in_arb_L,
      tx_external_dat_in              =>  rx_req_out_arb_L,
      tx_external_ack_out             =>  rx_dat_out_L,
      -- to internal north west
      tx_internal_north_west_req_in   =>  ,
      tx_internal_north_west_dat_in   =>  ,
      tx_internal_north_west_ack_out  =>  ,
      -- to internal west  
      tx_internal_west_req_in         =>  ,
      tx_internal_west_dat_in         =>  ,
      tx_internal_west_ack_out        =>  ,
      -- to internal south west
      tx_internal_south_west_req_in   =>  ,
      tx_internal_south_west_dat_in   =>  ,
      tx_internal_south_west_ack_out  =>  ,
      -- to internal south
      tx_internal_south_req_in        =>  ,
      tx_internal_south_dat_in        =>  ,
      tx_internal_south_ack_out       =>  ,
      -- to internal south east
      tx_internal_south_east_req_in   =>  ,
      tx_internal_south_east_dat_in   =>  ,
      tx_internal_south_east_ack_out  =>  ,
      -- to internal east
      tx_internal_east_req_in         =>  ,
      tx_internal_east_dat_in         =>  ,
      tx_internal_east_ack_out        =>  ,
      -- to internal north east 
      tx_internal_north_east_req_in   =>  ,
      tx_internal_north_east_dat_in   =>  ,
      tx_internal_north_east_ack_out  =>  ,
      -- to internal north
      tx_internal_north_req_in        =>  ,
      tx_internal_north_dat_in        =>  ,
      tx_internal_north_ack_out       =>  
  );

END async_noc_router_arc;