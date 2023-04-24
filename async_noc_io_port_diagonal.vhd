----------------------------------------------------------------------------------
-- Async router io port implementation
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.defs.ALL;

ENTITY async_noc_io_port_diagonal IS
    GENERIC (
        DATA_WIDTH : INTEGER := 8
    );
    PORT (
        -- control
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;

        -- 
        rx_req_in_dem_N  : IN  STD_LOGIC;
        rx_ack_out_dem_N : OUT STD_LOGIC;
        rx_dat_in_N      : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        tx_ack_in_arb_N  : IN  STD_LOGIC;
        tx_req_out_arb_N : OUT STD_LOGIC;
        tx_dat_out_N     : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END async_noc_io_port_diagonal;

ARCHITECTURE async_noc_io_port_diagonal_arc OF async_noc_io_port_diagonal IS

BEGIN

END async_noc_io_port_diagonal_arc;