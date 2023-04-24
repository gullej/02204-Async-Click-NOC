----------------------------------------------------------------------------------
-- Async router circuit implementation
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.defs.ALL;

ENTITY async_noc_router IS
    GENERIC (
        DATA_WIDTH : INTEGER := 8
    );
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

END async_noc_router_arc;