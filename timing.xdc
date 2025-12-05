# --- FINAL I/O CONSTRAINTS (CORRECTED VOLTAGES) ---

# 1. System Inputs (Clock & Reset) - MUST be LVCMOS33 (3.3V)
# These are in Bank 13, which is powered by 3.3V on your board.
set_property PACKAGE_PIN Y9 [get_ports clk_in1]
set_property IOSTANDARD LVCMOS33 [get_ports clk_in1]

set_property PACKAGE_PIN W10 [get_ports reset_rtl_0]
set_property IOSTANDARD LVCMOS33 [get_ports reset_rtl_0]

# 2. NCO Address Bus (Unused outputs - Terminate safely)
set_property PACKAGE_PIN U10 [get_ports {addr[3]}]
set_property PACKAGE_PIN T10 [get_ports {addr[2]}]
set_property PACKAGE_PIN R10 [get_ports {addr[1]}]
set_property PACKAGE_PIN P10 [get_ports {addr[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {addr[*]}]

# 3. Radar Signal Outputs (PL Pins) - Using 3.3V
# C3 is a PS pin (Forbidden). Using N10/M10/L10 which are valid PL pins.
set_property PACKAGE_PIN M19 [get_ports re_sig_0]
set_property PACKAGE_PIN M10 [get_ports im_sig_0]
set_property PACKAGE_PIN L10 [get_ports sel_0]

set_property IOSTANDARD LVCMOS33 [get_ports {re_sig_0 im_sig_0 sel_0}]