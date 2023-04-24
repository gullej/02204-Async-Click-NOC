----------------------------------------------------------------------------------
-- Async router io port implementation
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.defs.ALL;

ENTITY asyncoc_io_port_diagonal IS
    GENERIC (
        DATA_WIDTH : INTEGER := 8
    );
    PORT (
        -- control
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;

        -- data
        rx_req_in_dem  : IN  STD_LOGIC;
        rx_ack_out_dem : OUT STD_LOGIC;
        rx_dat_in      : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

        tx_ack_in_arb  : IN  STD_LOGIC;
        tx_req_out_arb : OUT STD_LOGIC;
        tx_dat_out     : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END asyncoc_io_port_diagonal;

ARCHITECTURE asyncoc_io_port_diagonal_arc OF asyncoc_io_port_diagonal IS

BEGIN

END asyncoc_io_port_diagonal_arc;