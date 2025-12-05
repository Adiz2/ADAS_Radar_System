`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.11.2025 19:33:40
// Design Name: 
// Module Name: radar_chirp_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module radar_chirp_tb;
// 1. Defining core parameters & signals
localparam PHASE_WIDTH = 22; // Accumulator width
localparam STEP_INCREMENT = 100;
// Testbench signals
logic clk;
logic reset;
// Phase Accumulator state: The input for the NCO Core
logic [PHASE_WIDTH - 1 : 0] phase_acc;
// Outputs from the LUT Core
wire [3:0] lut_addr;
wire sine_sign;
wire cosine_sign;
// 2. Instantiate the DUT
nco_lut #(.WA(4)) dut (
.phase(phase_acc),
.addr(lut_addr),
.re_sig(sine_sign),
.im_sig(cosine_sign)
);
// 3. Clock Generation (100MHz Clock - 5ns half-cycle)
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end
// 4. Reset & Accumulator Logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        phase_acc <= '0;
    end else begin
        // Accumulator Loop: Creates the linear phase ramp (Chirp)
        phase_acc <= phase_acc + STEP_INCREMENT;
    end
end
// 5. Stimulus Task
initial begin
    reset = 1'b1;
    #100;
    reset = 1'b0;
    $display("--- Verification Started ---");
    #50000
    $finish;
end
initial begin
    $monitor("Time = %0t, Phase_acc = %h, Addr = %h, Sine_sign = %b, Cos_sign = %b",$time,phase_acc,lut_addr,sine_sign,cosine_sign);
end  
endmodule
