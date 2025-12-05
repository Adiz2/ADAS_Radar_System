# ADAS Radar Controller Board with Hardware and Software Co-design
# Project Overview 
  This project implements a complete embedded system for an ADAS Radar Controller with Frequency Modulated Continuous Wave (FMCW) as an input signal. This project demonstartes a full-cycle engineering workflow,    
  bridging the gap between DSP algorithms, RTL Design, Physical Design (Timing Closure) and Board Layout.
This system generates a precise frequecy sweep (Chirp) used in automotive ADAS systems for distance and velocity measurement integrated on a Xilinx Zynq-7000 SoC.
# Key Technical Achievements
  1. Register Transfer Level (RTL) Design and Digital Signal Processing (DSP):-
     Designed a custom Numerically Controlled Oscillator (NCO) core in Verilog to generate precise linear frequency chirps. Implemented a synchronous Phase Accumulator and Look-Up Table (LUT) architecture for
     digital architecture for digital waveform synthesis.
     Source Code: rtl/lut.v
  2. Verification (SystemVerilog):-
     Developed a self-checking SystemVerilog testbench to verify the phase accumulation logic before synthesis. Validated the digital output by comparing the quantised phase steps against an ideal mathematical
     model.
     Source Code: sim/radar_chirp_tb.sv
  3. Physical Design and Timing Closure:-
     Performed Static Timing Analysis (STA) on a high-speed 1GHz clock domain to simulate high-performance requirements.
     Challenge: Encountered a critical timing violation Worst Negative Slack (WNS) = -0.669ns.
     Solution: Developed a Tcl Floorplanning script to manually constrain logic cell placement (Pblocks), reducing routing delay.
     Result: Successfully closed timing with a final WNS of 2.527ns, Worst Hold Slack (WHS) as 0.118ns and Worst Pulse Width Slack (WPWS) as 3.000ns.
     Script: constraints/floorplan_fix.tcl
  4. Hardware Design:
     Designed a custom 4-layer carrier board in Altium Designer for the XC7Z020 FPGA.
     Features:
       Routed high-speed DDR3 memory interface with length matching.
       Designed a complete power regulation network (1.0V, 1.5V, 1.8V, 3.3V) from a 5V USB source.
       Implemented JTAG Configuration and System Clock Infrastructure.
     Schematic: hardware/FPGA_Top.pdf
  5. Embedded Software
     Integrated the custom hardware into a MicroBlaze embedded processor system via the AXI4-Lite bus. Dveloped bare-metal C drivers to write frequency control words and read back status registers via memory
     mapped-I/O.
     Source Code: software/main.c
# Real World Applications:
  This technology is the fundamental building block for:
  1. Automotive ADAS: Adaptive Cruise Control and Collision Avoidance
  2. Altimeters: Precision height measurement for drones,aircrafts etc.
  3. Weather Radar: Doppler frequency shift analysis.
# Tools Used
  FPGA: Xilinx Vivado, Vitis IDE, SystemVerilog, Tcl Scripting
  Hardware: Altium Designer - PCB & Schematic
  Simulation: MATLAB Simulink, Vitis Model Composer

** Designed and Verified by B.S. Aditya Meher
