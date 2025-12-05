#floorplan_fix.tcl - Fixes the timing violation by reducing routing congestion and delay
# 1. Create a PBlock (Physical Block) named pblock_nco_core
create_pblock pblock_nco_core
# 2. Assign the physical location of the PBlock
#This tells Vivado to restrict the placement of these cells to this small area (X10Y10 to X20Y20)
resize_pblock [get_pblocks pblock_nco_core] -add {SLICE_X10Y10:SLICE_X20Y20}
# 3. Assign your core logic to the PBlock
#This forces the synthesizer to place all logic related to NCO core inside the defined area
add_cells_to_pblock [get_pblocks pblock_nco_core] -add [get_cells -hierarchical *nco_lut_0*]