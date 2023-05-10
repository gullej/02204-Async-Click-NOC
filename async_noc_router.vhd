----------------------------------------------------------------------------------
-- Async router circuit implementation
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.defs.ALL;

ENTITY async_noc_router IS
    GENERIC (
        LOCATION_X        :  integer;
        LOCATION_Y        :  integer;
        ADDR_WIDTH        :  integer
        );
    PORT (
        -- control
        reset : IN STD_LOGIC;

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

        tx_ack_in_arb_S   : IN STD_LOGIC;
        tx_req_out_arb_S  : OUT STD_LOGIC;
        tx_dat_out_S      : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

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

---------------------------------- |
--      TO LOCAL SIGNALS        -- |
---------------------------------- v
-- North demux to local arbiter
signal north_to_local_req   :  std_logic;
signal north_to_local_ack   :  std_logic;
signal north_to_local_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
-- North-east demux to local arbiter
signal northeast_to_local_req   :  std_logic;
signal northeast_to_local_ack   :  std_logic;
signal northeast_to_local_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
-- East demux to local arbiter
signal east_to_local_req   :  std_logic;
signal east_to_local_ack   :  std_logic;
signal east_to_local_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
-- South-east demux to local arbiter
signal southeast_to_local_req   :  std_logic;
signal southeast_to_local_ack   :  std_logic;
signal southeast_to_local_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
-- South demux to local arbiter
signal south_to_local_req   :  std_logic;
signal south_to_local_ack   :  std_logic;
signal south_to_local_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
-- South-west demux to local arbiter
signal southwest_to_local_req   :  std_logic;
signal southwest_to_local_ack   :  std_logic;
signal southwest_to_local_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
-- West demux to local arbiter
signal west_to_local_req   :  std_logic;
signal west_to_local_ack   :  std_logic;
signal west_to_local_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
-- North-west demux to local arbiter
signal northwest_to_local_req   :  std_logic;
signal northwest_to_local_ack   :  std_logic;
signal northwest_to_local_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

---------------------------------- |
--      TO NORTH LOCAL SIGNALS  -- |
---------------------------------- v
-- local demux to north arbiter
signal local_to_north_req   :  std_logic;
signal local_to_north_ack   :  std_logic;
signal local_to_north_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

signal south_to_north_req   :  std_logic;
signal south_to_north_ack   :  std_logic;
signal south_to_north_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

signal southeast_to_north_req   :  std_logic;
signal southeast_to_north_ack   :  std_logic;
signal southeast_to_north_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

signal southwest_to_north_req   :  std_logic;
signal southwest_to_north_ack   :  std_logic;
signal southwest_to_north_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

---------------------------------- |
-- TO NORTH-EAST LOCAL SIGNALS  -- |
---------------------------------- v
-- local demux to north-east arbiter
signal local_to_northeast_req   :  std_logic;
signal local_to_northeast_ack   :  std_logic;
signal local_to_northeast_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

signal southwest_to_northeast_req   :  std_logic;
signal southwest_to_northeast_ack   :  std_logic;
signal southwest_to_northeast_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

---------------------------------- |
--      TO EAST LOCAL SIGNALS   -- |
---------------------------------- v
-- local demux to north arbiter
signal local_to_east_req   :  std_logic;
signal local_to_east_ack   :  std_logic;
signal local_to_east_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

signal west_to_east_req   :  std_logic;
signal west_to_east_ack   :  std_logic;
signal west_to_east_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

signal southwest_to_east_req   :  std_logic;
signal southwest_to_east_ack   :  std_logic;
signal southwest_to_east_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

signal northwest_to_east_req   :  std_logic;
signal northwest_to_east_ack   :  std_logic;
signal northwest_to_east_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

---------------------------------- |
-- TO SOUTH-EAST LOCAL SIGNALS  -- |
---------------------------------- v

signal local_to_southeast_req   :  std_logic;
signal local_to_southeast_ack   :  std_logic;
signal local_to_southeast_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

signal northwest_to_southeast_req   :  std_logic;
signal northwest_to_southeast_ack   :  std_logic;
signal northwest_to_southeast_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

---------------------------------- |
--      TO SOUTH LOCAL SIGNALS  -- |
---------------------------------- v
-- local demux to north arbiter
signal local_to_south_req   :  std_logic;
signal local_to_south_ack   :  std_logic;
signal local_to_south_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

signal north_to_south_req   :  std_logic;
signal north_to_south_ack   :  std_logic;
signal north_to_south_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

signal northeast_to_south_req   :  std_logic;
signal northeast_to_south_ack   :  std_logic;
signal northeast_to_south_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

signal northwest_to_south_req   :  std_logic;
signal northwest_to_south_ack   :  std_logic;
signal northwest_to_south_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

---------------------------------- |
-- TO SOUTH-WEST LOCAL SIGNALS  -- |
---------------------------------- v

signal local_to_southwest_req   :  std_logic;
signal local_to_southwest_ack   :  std_logic;
signal local_to_southwest_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

signal northeast_to_southwest_req   :  std_logic;
signal northeast_to_southwest_ack   :  std_logic;
signal northeast_to_southwest_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

---------------------------------- |
--      TO WEST LOCAL SIGNALS   -- |
---------------------------------- v
-- local demux to north arbiter
signal local_to_west_req   :  std_logic;
signal local_to_west_ack   :  std_logic;
signal local_to_west_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

signal east_to_west_req   :  std_logic;
signal east_to_west_ack   :  std_logic;
signal east_to_west_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

signal southeast_to_west_req   :  std_logic;
signal southeast_to_west_ack   :  std_logic;
signal southeast_to_west_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

signal northeast_to_west_req   :  std_logic;
signal northeast_to_west_ack   :  std_logic;
signal northeast_to_west_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

---------------------------------- |
-- TO NORTH-WEST LOCAL SIGNALS  -- |
---------------------------------- v

signal local_to_northwest_req   :  std_logic;
signal local_to_northwest_ack   :  std_logic;
signal local_to_northwest_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

signal southeast_to_northwest_req   :  std_logic;
signal southeast_to_northwest_ack   :  std_logic;
signal southeast_to_northwest_data  :  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

BEGIN

 PORT_NORTH : entity work.async_noc_io_port_straight
 GENERIC MAP (
    LOCATION_X                    =>  LOCATION_X,
    LOCATION_Y                    =>  LOCATION_Y ,
    ADDR_WIDTH                    =>  ADDR_WIDTH
  )
  PORT MAP (
      -- control
      reset                        =>  reset, 
      ---------------------------- |
      --        ARBITER INPUTS  -- |
      ---------------------------- V
      -- from local
     rx_local_req_in             =>  local_to_north_req , 
     rx_local_ack_out            =>  local_to_north_ack , 
     rx_local_dat_in             =>  local_to_north_data, 
      -- from SOUTH EAST
      rx_internal_a_req_in         =>  southeast_to_north_req , 
      rx_internal_a_ack_out        =>  southeast_to_north_ack , 
      rx_internal_a_dat_in         =>  southeast_to_north_data, 
      -- from SOUTH
      rx_internal_b_req_in         =>  south_to_north_req , 
      rx_internal_b_ack_out        =>  south_to_north_ack , 
      rx_internal_b_dat_in         =>  south_to_north_data, 
      -- from SOUTH WEST
      rx_internal_c_req_in         =>  southwest_to_north_req , 
      rx_internal_c_ack_out        =>  southwest_to_north_ack , 
      rx_internal_c_dat_in         =>  southwest_to_north_data, 

      ---------------------------- |
      --        LOCAL PORTS     -- |
      ---------------------------- V
      -- from external
      rx_external_req_in           =>  rx_req_in_dem_N ,
      rx_external_ack_out          =>  rx_ack_out_dem_N,
      rx_external_dat_in           =>  rx_dat_in_N     ,
      -- to external
      tx_external_req_in           =>  tx_req_out_arb_N ,
      tx_external_ack_out          =>  tx_ack_in_arb_N,
      tx_external_dat_in           =>  tx_dat_out_N    ,

      ---------------------------- |
      --        DEMUX  OUTPUTS  -- |
      ---------------------------- V
      -- to internal local
      tx_internal_local_req_in     =>  north_to_local_req, 
      tx_internal_local_ack_out    =>  north_to_local_ack, 
      tx_internal_local_dat_in     =>  north_to_local_data, 
      -- to internal straight
      tx_internal_across_req_in    =>  north_to_south_req , 
      tx_internal_across_ack_out   =>  north_to_south_ack , 
      tx_internal_across_dat_in    =>  north_to_south_data
  );

  PORT_NORTH_EAST : entity work.async_noc_io_port_diagonal
  GENERIC MAP (
    LOCATION_X                      =>  LOCATION_X,
    LOCATION_Y                      =>  LOCATION_Y ,
    ADDR_WIDTH                      =>  ADDR_WIDTH
  )
  PORT MAP (
      -- control
      reset                           =>  reset,
      -- from local
      rx_local_req_in                    =>  local_to_northeast_req,
      rx_local_ack_out                   =>  local_to_northeast_ack,
      rx_local_dat_in                    =>  local_to_northeast_data,
      -- from South west
      rx_internal_req_in              =>  southwest_to_northeast_req ,
      rx_internal_ack_out             =>  southwest_to_northeast_ack ,
      rx_internal_dat_in              =>  southwest_to_northeast_data,
      -- from external
      rx_external_req_in              =>  rx_req_in_dem_NE ,
      rx_external_ack_out             =>  rx_ack_out_dem_NE,
      rx_external_dat_in              =>  rx_dat_in_NE     ,
      -- to external
      tx_external_req_in              =>  tx_req_out_arb_NE ,
      tx_external_ack_out             =>  tx_ack_in_arb_NE,
      tx_external_dat_in              =>  tx_dat_out_NE    ,
      -- to internal diagonal port
      tx_internal_diag_req_in         =>  northeast_to_southwest_req ,
      tx_internal_diag_ack_out        =>  northeast_to_southwest_ack ,
      tx_internal_diag_dat_in         =>  northeast_to_southwest_data,
      -- to internal y-direction port
      tx_internal_ydir_req_in         =>  northeast_to_south_req ,
      tx_internal_ydir_ack_out        =>  northeast_to_south_ack ,
      tx_internal_ydir_dat_in         =>  northeast_to_south_data,
      -- to internal x-direction port
      tx_internal_xdir_req_in         =>  northeast_to_west_req,
      tx_internal_xdir_ack_out        =>  northeast_to_west_ack,
      tx_internal_xdir_dat_in         =>  northeast_to_west_data,
      -- to internal local
      tx_internal_local_req_in        =>  northeast_to_local_req,
      tx_internal_local_ack_out       =>  northeast_to_local_ack,
      tx_internal_local_dat_in        =>  northeast_to_local_data
  );

  PORT_EAST : entity work.async_noc_io_port_straight
  GENERIC MAP (
     LOCATION_X                    =>  LOCATION_X,
     LOCATION_Y                    =>  LOCATION_Y ,
     ADDR_WIDTH                    =>  ADDR_WIDTH
   )
   PORT MAP (
       -- control
       reset                        =>  reset, 
       ---------------------------- |
       --        ARBITER INPUTS  -- |
       ---------------------------- V
       -- from local
      rx_local_req_in                 =>  local_to_east_req , 
      rx_local_ack_out                =>  local_to_east_ack , 
      rx_local_dat_in                 =>  local_to_east_data, 
       -- from SOUTH WEST
       rx_internal_a_req_in         =>  southwest_to_east_req, 
       rx_internal_a_ack_out        =>  southwest_to_east_ack, 
       rx_internal_a_dat_in         =>  southwest_to_east_data, 
       -- from WEST
       rx_internal_b_req_in         =>  west_to_east_req , 
       rx_internal_b_ack_out        =>  west_to_east_ack , 
       rx_internal_b_dat_in         =>  west_to_east_data, 
       -- from NORTH WEST
       rx_internal_c_req_in         =>  northwest_to_east_req, 
       rx_internal_c_ack_out        =>  northwest_to_east_ack, 
       rx_internal_c_dat_in         =>  northwest_to_east_data, 
       
       ---------------------------- |
       --        LOCAL PORTS     -- |
       ---------------------------- V
       -- from external
       rx_external_req_in           =>  rx_req_in_dem_E , 
       rx_external_ack_out          =>  rx_ack_out_dem_E, 
       rx_external_dat_in           =>  rx_dat_in_E     , 
       -- to external
       tx_external_req_in           =>  tx_req_out_arb_E , 
       tx_external_ack_out          =>  tx_ack_in_arb_E, 
       tx_external_dat_in           =>  tx_dat_out_E    , 

       ---------------------------- |
       --        DEMUX  OUTPUTS  -- |
       ---------------------------- V
       -- to internal local
       tx_internal_local_req_in     =>  east_to_local_req , 
       tx_internal_local_ack_out    =>  east_to_local_ack , 
       tx_internal_local_dat_in     =>  east_to_local_data, 
       -- to internal straight
       tx_internal_across_req_in    =>  east_to_west_req , 
       tx_internal_across_ack_out   =>  east_to_west_ack , 
       tx_internal_across_dat_in    =>  east_to_west_data
   );

   PORT_SOUTH_EAST : entity work.async_noc_io_port_diagonal
  GENERIC MAP (
    LOCATION_X                      =>  LOCATION_X,
    LOCATION_Y                      =>  LOCATION_Y ,
    ADDR_WIDTH                      =>  ADDR_WIDTH
  )
  PORT MAP (
      -- control
      reset                           =>  reset,
      -- from local
      rx_local_req_in                 =>  local_to_southeast_req ,
      rx_local_ack_out                =>  local_to_southeast_ack ,
      rx_local_dat_in                 =>  local_to_southeast_data,
      -- from internal
      rx_internal_req_in              =>  northwest_to_southeast_req ,
      rx_internal_ack_out             =>  northwest_to_southeast_ack ,
      rx_internal_dat_in              =>  northwest_to_southeast_data,
      -- from external
      rx_external_req_in              =>  rx_req_in_dem_SE ,
      rx_external_ack_out             =>  rx_ack_out_dem_SE,
      rx_external_dat_in              =>  rx_dat_in_SE     ,
      -- to external
      tx_external_req_in              =>  tx_req_out_arb_SE ,
      tx_external_ack_out             =>  tx_ack_in_arb_SE,
      tx_external_dat_in              =>  tx_dat_out_SE    ,
      -- to internal diagonal port
      tx_internal_diag_req_in         =>  southeast_to_northwest_req,
      tx_internal_diag_ack_out        =>  southeast_to_northwest_ack,
      tx_internal_diag_dat_in         =>  southeast_to_northwest_data,
      -- to internal y-direction port
      tx_internal_ydir_req_in         =>  southeast_to_north_req ,
      tx_internal_ydir_ack_out        =>  southeast_to_north_ack ,
      tx_internal_ydir_dat_in         =>  southeast_to_north_data,
      -- to internal x-direction port
      tx_internal_xdir_req_in         =>  southeast_to_west_req,
      tx_internal_xdir_ack_out        =>  southeast_to_west_ack,
      tx_internal_xdir_dat_in         =>  southeast_to_west_data,
      -- to internal local
      tx_internal_local_req_in        =>  southeast_to_local_req,
      tx_internal_local_ack_out       =>  southeast_to_local_ack,
      tx_internal_local_dat_in        =>  southeast_to_local_data
  );

   PORT_SOUTH : entity work.async_noc_io_port_straight
   GENERIC MAP (
      LOCATION_X                    =>  LOCATION_X,
      LOCATION_Y                    =>  LOCATION_Y ,
      ADDR_WIDTH                    =>  ADDR_WIDTH
    )
    PORT MAP (
        -- control
        reset                        =>  reset, 
        ---------------------------- |
        --        ARBITER INPUTS  -- |
        ---------------------------- V
        -- from local
        rx_local_req_in                  =>  local_to_south_req , 
        rx_local_ack_out                 =>  local_to_south_ack , 
        rx_local_dat_in                  =>  local_to_south_data, 
        -- from NORTH EAST
        rx_internal_a_req_in         =>  northeast_to_south_req , 
        rx_internal_a_ack_out        =>  northeast_to_south_ack , 
        rx_internal_a_dat_in         =>  northeast_to_south_data, 
        -- from NORTH
        rx_internal_b_req_in         =>  north_to_south_req , 
        rx_internal_b_ack_out        =>  north_to_south_ack , 
        rx_internal_b_dat_in         =>  north_to_south_data, 
        -- from NORTH WEST
        rx_internal_c_req_in         =>  northwest_to_south_req , 
        rx_internal_c_ack_out        =>  northwest_to_south_ack , 
        rx_internal_c_dat_in         =>  northwest_to_south_data, 

        ---------------------------- |
        --        LOCAL PORTS     -- |
        ---------------------------- V
        -- from external
        rx_external_req_in           =>  rx_req_in_dem_S, 
        rx_external_ack_out          =>  rx_ack_out_dem_S, 
        rx_external_dat_in           =>  rx_dat_in_S, 
        -- to external
        tx_external_req_in           =>  tx_req_out_arb_S, 
        tx_external_ack_out          =>  tx_ack_in_arb_S, 
        tx_external_dat_in           =>  tx_dat_out_S, 

        ---------------------------- |
        --        DEMUX  OUTPUTS  -- |
        ---------------------------- V
        -- to internal local
        tx_internal_local_req_in     =>  south_to_local_req , 
        tx_internal_local_ack_out    =>  south_to_local_ack , 
        tx_internal_local_dat_in     =>  south_to_local_data, 
        -- to internal straight
        tx_internal_across_req_in    =>  south_to_north_req , 
        tx_internal_across_ack_out   =>  south_to_north_ack , 
        tx_internal_across_dat_in    =>  south_to_north_data
    );

PORT_SOUTH_WEST : entity work.async_noc_io_port_diagonal
  GENERIC MAP (
    LOCATION_X                      =>  LOCATION_X,
    LOCATION_Y                      =>  LOCATION_Y ,
    ADDR_WIDTH                      =>  ADDR_WIDTH
  )
  PORT MAP (
    -- control
    reset                           =>  reset,
    -- from local
    rx_local_req_in                    =>  local_to_southwest_req ,
    rx_local_ack_out                   =>  local_to_southwest_ack ,
    rx_local_dat_in                    =>  local_to_southwest_data,
    -- from internal
    rx_internal_req_in              =>  northeast_to_southwest_req ,
    rx_internal_ack_out             =>  northeast_to_southwest_ack ,
    rx_internal_dat_in              =>  northeast_to_southwest_data,
    -- from external
    rx_external_req_in              =>  rx_req_in_dem_SW ,
    rx_external_ack_out             =>  rx_ack_out_dem_SW,
    rx_external_dat_in              =>  rx_dat_in_SW     ,
    -- to external
    tx_external_req_in              =>   tx_req_out_arb_SW,
    tx_external_ack_out             =>  tx_ack_in_arb_SW,
    tx_external_dat_in              =>  tx_dat_out_SW    ,
    -- to internal diagonal port
    tx_internal_diag_req_in         =>  southwest_to_northeast_req ,
    tx_internal_diag_ack_out        =>  southwest_to_northeast_ack ,
    tx_internal_diag_dat_in         =>  southwest_to_northeast_data,
    -- to internal y-direction port
    tx_internal_ydir_req_in         =>  southwest_to_north_req ,
    tx_internal_ydir_ack_out        =>  southwest_to_north_ack ,
    tx_internal_ydir_dat_in         =>  southwest_to_north_data,
    -- to internal x-direction port
    tx_internal_xdir_req_in         =>  southwest_to_east_req,
    tx_internal_xdir_ack_out        =>  southwest_to_east_ack,
    tx_internal_xdir_dat_in         =>  southwest_to_east_data,
    -- to internal local
    tx_internal_local_req_in        =>  southwest_to_local_req,
    tx_internal_local_ack_out       =>  southwest_to_local_ack,
    tx_internal_local_dat_in        =>  southwest_to_local_data
  );

    PORT_WEST : entity work.async_noc_io_port_straight
    GENERIC MAP (
       LOCATION_X                    =>  LOCATION_X,
       LOCATION_Y                    =>  LOCATION_Y ,
       ADDR_WIDTH                    =>  ADDR_WIDTH
     )
     PORT MAP (
         -- control
         reset                        =>  reset, 
         ---------------------------- |
         --        ARBITER INPUTS  -- |
         ---------------------------- V
         -- from local
        rx_local_req_in             =>  local_to_west_req , 
        rx_local_ack_out            =>  local_to_west_ack , 
        rx_local_dat_in             =>  local_to_west_data, 
         -- from SOUTH EAST
         rx_internal_a_req_in         =>  southeast_to_west_req, 
         rx_internal_a_ack_out        =>  southeast_to_west_ack, 
         rx_internal_a_dat_in         =>  southeast_to_west_data, 
         -- from EAST
         rx_internal_b_req_in         =>  east_to_west_req , 
         rx_internal_b_ack_out        =>  east_to_west_ack , 
         rx_internal_b_dat_in         =>  east_to_west_data, 
         -- from NORTH EAST
         rx_internal_c_req_in         =>  northeast_to_west_req, 
         rx_internal_c_ack_out        =>  northeast_to_west_ack, 
         rx_internal_c_dat_in         =>  northeast_to_west_data, 
         
         ---------------------------- |
         --        LOCAL PORTS     -- |
         ---------------------------- V
         -- from external
         rx_external_req_in           =>  rx_req_in_dem_W, 
         rx_external_ack_out          =>  rx_ack_out_dem_W, 
         rx_external_dat_in           =>  rx_dat_in_W, 
         -- to external
         tx_external_req_in           =>  tx_req_out_arb_W, 
         tx_external_ack_out          =>  tx_ack_in_arb_W, 
         tx_external_dat_in           =>  tx_dat_out_W, 

         ---------------------------- |
         --        DEMUX  OUTPUTS  -- |
         ---------------------------- V
         -- to internal local
         tx_internal_local_req_in     =>  west_to_local_req, 
         tx_internal_local_ack_out    =>  west_to_local_ack, 
         tx_internal_local_dat_in     =>  west_to_local_data, 
         -- to internal straight
         tx_internal_across_req_in    =>  west_to_east_req , 
         tx_internal_across_ack_out   =>  west_to_east_ack , 
         tx_internal_across_dat_in    =>  west_to_east_data
     );

  PORT_NORTH_WEST : entity work.async_noc_io_port_diagonal
    GENERIC MAP (
      LOCATION_X                      =>  LOCATION_X,
      LOCATION_Y                      =>  LOCATION_Y ,
      ADDR_WIDTH                      =>  ADDR_WIDTH
    )
    PORT MAP (
      -- control
      reset                           =>  reset,
      -- from local
      rx_local_req_in                    =>  local_to_northwest_req,
      rx_local_ack_out                   =>  local_to_northwest_ack,
      rx_local_dat_in                    =>  local_to_northwest_data,
      -- from internal
      rx_internal_req_in              =>  southeast_to_northwest_req,
      rx_internal_ack_out             =>  southeast_to_northwest_ack,
      rx_internal_dat_in              =>  southeast_to_northwest_data,
      -- from external
      rx_external_req_in              =>  rx_req_in_dem_NW ,
      rx_external_ack_out             =>  rx_ack_out_dem_NW,
      rx_external_dat_in              =>  rx_dat_in_NW     ,
      -- to external
      tx_external_req_in              =>  tx_req_out_arb_NW,
      tx_external_ack_out             =>  tx_ack_in_arb_NW,
      tx_external_dat_in              =>  tx_dat_out_NW    ,
      -- to internal diagonal port
      tx_internal_diag_req_in         =>  northwest_to_southeast_req ,
      tx_internal_diag_ack_out        =>  northwest_to_southeast_ack ,
      tx_internal_diag_dat_in         =>  northwest_to_southeast_data,
      -- to internal y-direction port
      tx_internal_ydir_req_in         =>  northwest_to_south_req ,
      tx_internal_ydir_ack_out        =>  northwest_to_south_ack ,
      tx_internal_ydir_dat_in         =>  northwest_to_south_data,
      -- to internal x-direction port
      tx_internal_xdir_req_in         =>  northwest_to_east_req,
      tx_internal_xdir_ack_out        =>  northwest_to_east_ack,
      tx_internal_xdir_dat_in         =>  northwest_to_east_data,
      -- to internal local
      tx_internal_local_req_in        =>  northwest_to_local_req,
      tx_internal_local_ack_out       =>  northwest_to_local_ack,
      tx_internal_local_dat_in        =>  northwest_to_local_data
    );

 LOCAL_PORT : entity work.async_noc_io_port_local
   GENERIC MAP (
      LOCATION_X                      =>  LOCATION_X,
      LOCATION_Y                      =>  LOCATION_Y ,
      ADDR_WIDTH                      =>  ADDR_WIDTH
  )
  PORT MAP (
      -- control
      reset                           =>  reset,
      -- from NORTH
      rx_internal_h_req_in                 =>  north_to_local_req ,
      rx_internal_h_ack_out                =>  north_to_local_ack ,
      rx_internal_h_dat_in                 =>  north_to_local_data,
      -- from internal NORTH EAST
      rx_internal_a_req_in            =>  northeast_to_local_req,
      rx_internal_a_ack_out           =>  northeast_to_local_ack,
      rx_internal_a_dat_in            =>  northeast_to_local_data,
      -- from internal EAST
      rx_internal_b_req_in            =>  east_to_local_req ,
      rx_internal_b_ack_out           =>  east_to_local_ack ,
      rx_internal_b_dat_in            =>  east_to_local_data,
      -- from internal SOUTH EAST
      rx_internal_c_req_in            =>  southeast_to_local_req,
      rx_internal_c_dat_in            =>  southeast_to_local_data,
      rx_internal_c_ack_out           =>  southeast_to_local_ack,
      -- from internal SOUTH
      rx_internal_d_req_in            =>  south_to_local_req ,
      rx_internal_d_dat_in            =>   south_to_local_data,
      rx_internal_d_ack_out           =>  south_to_local_ack,
      -- from internal SOUTH WEST
      rx_internal_e_req_in            =>  southwest_to_local_req,
      rx_internal_e_dat_in            =>  southwest_to_local_data,
      rx_internal_e_ack_out           =>  southwest_to_local_ack,
      -- from internal WEST
      rx_internal_f_req_in            =>  west_to_local_req ,
      rx_internal_f_dat_in            =>  west_to_local_data  ,
      rx_internal_f_ack_out           =>  west_to_local_ack,
      -- from internal NORTH WEST
      rx_internal_g_req_in            =>  northwest_to_local_req,
      rx_internal_g_dat_in            =>  northwest_to_local_data,
      rx_internal_g_ack_out           =>  northwest_to_local_ack,
      
      -- from external
      rx_external_req_in              =>  tx_req_in_dem_L,
      rx_external_ack_out             =>  tx_ack_out_dem_L,
      rx_external_dat_in              =>  tx_dat_in_L,
      -- to external
      tx_external_req_in              =>  rx_req_out_arb_L,
      tx_external_dat_in              =>  rx_dat_out_L,
      tx_external_ack_out             =>  rx_ack_in_arb_L,
      -- to internal north west
      tx_internal_north_west_req_in   =>  local_to_northwest_req,
      tx_internal_north_west_dat_in   =>  local_to_northwest_data,
      tx_internal_north_west_ack_out  =>  local_to_northwest_ack,
      -- to internal west  
      tx_internal_west_req_in         =>  local_to_west_req ,
      tx_internal_west_dat_in         =>  local_to_west_data ,
      tx_internal_west_ack_out        =>  local_to_west_ack,
      -- to internal south west
      tx_internal_south_west_req_in   =>  local_to_southwest_req ,
      tx_internal_south_west_dat_in   =>  local_to_southwest_data ,
      tx_internal_south_west_ack_out  =>  local_to_southwest_ack,
      -- to internal south
      tx_internal_south_req_in        =>  local_to_south_req ,
      tx_internal_south_dat_in        =>  local_to_south_data ,
      tx_internal_south_ack_out       =>  local_to_south_ack,
      -- to internal south east
      tx_internal_south_east_req_in   =>  local_to_southeast_req ,
      tx_internal_south_east_dat_in   =>  local_to_southeast_data ,
      tx_internal_south_east_ack_out  =>  local_to_southeast_ack,
      -- to internal east
      tx_internal_east_req_in         =>  local_to_east_req ,
      tx_internal_east_dat_in         =>   local_to_east_data,
      tx_internal_east_ack_out        =>  local_to_east_ack,
      -- to internal north east 
      tx_internal_north_east_req_in   =>  local_to_northeast_req,
      tx_internal_north_east_dat_in   =>  local_to_northeast_data,
      tx_internal_north_east_ack_out  =>  local_to_northeast_ack,
      -- to internal north
      tx_internal_north_req_in        =>  local_to_north_req ,
      tx_internal_north_dat_in        =>   local_to_north_data,
      tx_internal_north_ack_out       =>  local_to_north_ack
  );

END async_noc_router_arc;