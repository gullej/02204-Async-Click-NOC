LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.ALL;
  USE IEEE.NUMERIC_STD.ALL;
  USE IEEE.STD_LOGIC_UNSIGNED.ALL;
  use work.defs.all;

ENTITY async_noc_router_tb IS
END async_noc_router_tb;

ARCHITECTURE testbench OF async_noc_router_tb IS

SIGNAL rst  :  STD_LOGIC;

SIGNAL rx_req_in_dem_N_TB    : STD_LOGIC;
SIGNAL rx_ack_out_dem_N_TB   : STD_LOGIC;
SIGNAL rx_dat_in_N_TB        : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_ack_in_arb_N_TB    : STD_LOGIC;
SIGNAL tx_req_out_arb_N_TB   : STD_LOGIC;
SIGNAL tx_dat_out_N_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL rx_req_in_dem_NE_TB   : STD_LOGIC;
SIGNAL rx_ack_out_dem_NE_TB  : STD_LOGIC;
SIGNAL rx_dat_in_NE_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_ack_in_arb_NE_TB   : STD_LOGIC;
SIGNAL tx_req_out_arb_NE_TB  : STD_LOGIC;
SIGNAL tx_dat_out_NE_TB      : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL rx_req_in_dem_E_TB    : STD_LOGIC;
SIGNAL rx_ack_out_dem_E_TB   : STD_LOGIC;
SIGNAL rx_dat_in_E_TB        : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_ack_in_arb_E_TB    : STD_LOGIC;
SIGNAL tx_req_out_arb_E_TB   : STD_LOGIC;
SIGNAL tx_dat_out_E_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL rx_req_in_dem_SE_TB   : STD_LOGIC;
SIGNAL rx_ack_out_dem_SE_TB  : STD_LOGIC;
SIGNAL rx_dat_in_SE_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_ack_in_arb_SE_TB   : STD_LOGIC;
SIGNAL tx_req_out_arb_SE_TB  : STD_LOGIC;
SIGNAL tx_dat_out_SE_TB      : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL rx_req_in_dem_S_TB    : STD_LOGIC;
SIGNAL rx_ack_out_dem_S_TB   : STD_LOGIC;
SIGNAL rx_dat_in_S_TB        : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_ack_in_arb_S_TB    : STD_LOGIC;
SIGNAL tx_req_out_arb_S_TB   : STD_LOGIC;
SIGNAL tx_dat_out_S_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL rx_req_in_dem_SW_TB   : STD_LOGIC;
SIGNAL rx_ack_out_dem_SW_TB  : STD_LOGIC;
SIGNAL rx_dat_in_SW_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_ack_in_arb_SW_TB   : STD_LOGIC;
SIGNAL tx_req_out_arb_SW_TB  : STD_LOGIC;
SIGNAL tx_dat_out_SW_TB      : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL rx_req_in_dem_W_TB    : STD_LOGIC;
SIGNAL rx_ack_out_dem_W_TB   : STD_LOGIC;
SIGNAL rx_dat_in_W_TB        : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_ack_in_arb_W_TB    : STD_LOGIC;
SIGNAL tx_req_out_arb_W_TB   : STD_LOGIC;
SIGNAL tx_dat_out_W_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL rx_req_in_dem_NW_TB   : STD_LOGIC;
SIGNAL rx_ack_out_dem_NW_TB  : STD_LOGIC;
SIGNAL rx_dat_in_NW_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_ack_in_arb_NW_TB   : STD_LOGIC;
SIGNAL tx_req_out_arb_NW_TB  : STD_LOGIC;
SIGNAL tx_dat_out_NW_TB      : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_req_in_dem_L_TB    : STD_LOGIC;
SIGNAL tx_ack_out_dem_L_TB   : STD_LOGIC;
SIGNAL tx_dat_in_L_TB        : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL rx_ack_in_arb_L_TB    : STD_LOGIC;
SIGNAL rx_req_out_arb_L_TB   : STD_LOGIC;
SIGNAL rx_dat_out_L_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);

ATTRIBUTE dont_touch  :  STRING;
ATTRIBUTE dont_touch of rx_req_in_dem_N_TB  , rx_ack_out_dem_N_TB  : SIGNAL IS "true";   
ATTRIBUTE dont_touch of tx_ack_in_arb_N_TB  , tx_req_out_arb_N_TB  : SIGNAL IS "true";  
ATTRIBUTE dont_touch of rx_req_in_dem_NE_TB , rx_ack_out_dem_NE_TB : SIGNAL IS "true";  
ATTRIBUTE dont_touch of tx_ack_in_arb_NE_TB , tx_req_out_arb_NE_TB : SIGNAL IS "true";  
ATTRIBUTE dont_touch of rx_req_in_dem_E_TB  , rx_ack_out_dem_E_TB  : SIGNAL IS "true";  
ATTRIBUTE dont_touch of tx_ack_in_arb_E_TB  , tx_req_out_arb_E_TB  : SIGNAL IS "true";  
ATTRIBUTE dont_touch of rx_req_in_dem_SE_TB , rx_ack_out_dem_SE_TB : SIGNAL IS "true";  
ATTRIBUTE dont_touch of tx_ack_in_arb_SE_TB , tx_req_out_arb_SE_TB : SIGNAL IS "true";  
ATTRIBUTE dont_touch of rx_req_in_dem_S_TB  , rx_ack_out_dem_S_TB  : SIGNAL IS "true";  
ATTRIBUTE dont_touch of tx_ack_in_arb_S_TB  , tx_req_out_arb_S_TB  : SIGNAL IS "true";  
ATTRIBUTE dont_touch of rx_req_in_dem_SW_TB , rx_ack_out_dem_SW_TB : SIGNAL IS "true";  
ATTRIBUTE dont_touch of tx_ack_in_arb_SW_TB , tx_req_out_arb_SW_TB : SIGNAL IS "true";  
ATTRIBUTE dont_touch of rx_req_in_dem_W_TB  , rx_ack_out_dem_W_TB  : SIGNAL IS "true";  
ATTRIBUTE dont_touch of tx_ack_in_arb_W_TB  , tx_req_out_arb_W_TB  : SIGNAL IS "true";  
ATTRIBUTE dont_touch of rx_req_in_dem_NW_TB , rx_ack_out_dem_NW_TB : SIGNAL IS "true";  
ATTRIBUTE dont_touch of tx_ack_in_arb_NW_TB , tx_req_out_arb_NW_TB : SIGNAL IS "true";  
ATTRIBUTE dont_touch of tx_req_in_dem_L_TB  , tx_ack_out_dem_L_TB  : SIGNAL IS "true";  
ATTRIBUTE dont_touch of rx_ack_in_arb_L_TB  , rx_req_out_arb_L_TB  : SIGNAL IS "true";   

BEGIN

    stim : PROCESS
    BEGIN
    rst <= '1';
    WAIT FOR 100 ns;
    rst <= '0';
    WAIT FOR 100 ns;

    END PROCESS;

    router_DUT : entity work.async_noc_router
    GENERIC MAP (
        LOCATION_X               =>  1,
        LOCATION_Y               =>  1,
        ADDR_WIDTH               =>  2
    )
    PORT MAP (
        -- control
        reset => rst,
        -- north direction
        rx_req_in_dem_N   => rx_req_in_dem_N_TB,
        rx_ack_out_dem_N  => rx_ack_out_dem_N_TB,
        rx_dat_in_N       => rx_dat_in_N_TB,
        tx_ack_in_arb_N   => tx_ack_in_arb_N_TB,
        tx_req_out_arb_N  => tx_req_out_arb_N_TB,
        tx_dat_out_N      => tx_dat_out_N_TB,
        -- north east direction
        rx_req_in_dem_NE  => rx_req_in_dem_NE_TB,
        rx_ack_out_dem_NE => rx_ack_out_dem_NE_TB,
        rx_dat_in_NE      => rx_dat_in_NE_TB,
        tx_ack_in_arb_NE  => tx_ack_in_arb_NE_TB,
        tx_req_out_arb_NE => tx_req_out_arb_NE_TB,
        tx_dat_out_NE     => tx_dat_out_NE_TB,
        -- east direction
        rx_req_in_dem_E   => rx_req_in_dem_E_TB,
        rx_ack_out_dem_E  => rx_ack_out_dem_E_TB,
        rx_dat_in_E       => rx_dat_in_E_TB,
        tx_ack_in_arb_E   => tx_ack_in_arb_E_TB,
        tx_req_out_arb_E  => tx_req_out_arb_E_TB,
        tx_dat_out_E      => tx_dat_out_E_TB,
        -- south east direction
        rx_req_in_dem_SE  => rx_req_in_dem_SE_TB,
        rx_ack_out_dem_SE => rx_ack_out_dem_SE_TB,
        rx_dat_in_SE      => rx_dat_in_SE_TB,
        tx_ack_in_arb_SE  => tx_ack_in_arb_SE_TB,
        tx_req_out_arb_SE => tx_req_out_arb_SE_TB,
        tx_dat_out_SE     => tx_dat_out_SE_TB,
        -- south direction
        rx_req_in_dem_S   => rx_req_in_dem_S_TB,
        rx_ack_out_dem_S  => rx_ack_out_dem_S_TB,
        rx_dat_in_S       => rx_dat_in_S_TB,
        tx_ack_in_arb_S   => tx_ack_in_arb_S_TB,
        tx_req_out_arb_S  => tx_req_out_arb_S_TB,
        tx_dat_out_S      => tx_dat_out_S_TB,
        -- south west direction
        rx_req_in_dem_SW  => rx_req_in_dem_SW_TB,
        rx_ack_out_dem_SW => rx_ack_out_dem_SW_TB,
        rx_dat_in_SW      => rx_dat_in_SW_TB,
        tx_ack_in_arb_SW  => tx_ack_in_arb_SW_TB,
        tx_req_out_arb_SW => tx_req_out_arb_SW_TB,
        tx_dat_out_SW     => tx_dat_out_SW_TB,
        -- west direction
        rx_req_in_dem_W   => rx_req_in_dem_W_TB,
        rx_ack_out_dem_W  => rx_ack_out_dem_W_TB,
        rx_dat_in_W       => rx_dat_in_W_TB,
        tx_ack_in_arb_W   => tx_ack_in_arb_W_TB,
        tx_req_out_arb_W  => tx_req_out_arb_W_TB,
        tx_dat_out_W      => tx_dat_out_W_TB,
        -- north west direction
        rx_req_in_dem_NW  => rx_req_in_dem_NW_TB,
        rx_ack_out_dem_NW => rx_ack_out_dem_NW_TB,
        rx_dat_in_NW      => rx_dat_in_NW_TB,
        tx_ack_in_arb_NW  => tx_ack_in_arb_NW_TB,
        tx_req_out_arb_NW => tx_req_out_arb_NW_TB,
        tx_dat_out_NW     => tx_dat_out_NW_TB,
        -- local direction
        tx_req_in_dem_L   => tx_req_in_dem_L_TB,
        tx_ack_out_dem_L  => tx_ack_out_dem_L_TB,
        tx_dat_in_L       => tx_dat_in_L_TB,
        rx_ack_in_arb_L   => rx_ack_in_arb_L_TB,
        rx_req_out_arb_L  => rx_req_out_arb_L_TB,
        rx_dat_out_L      => rx_dat_out_L_TB       
    );

END ARCHITECTURE;