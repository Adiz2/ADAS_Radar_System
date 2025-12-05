// nco_lut.v - Fully Synchronous NCO Core Logic for Radar Chirp

module nco_lut #(
    // Parameter for Output Address Width 
    parameter WA = 4
) (
    // -- Synchronous System Ports (REQUIRED FOR VIVADO) --
    input clk,  
    input reset,
    
    // -- Original LUT I/O Ports --
    input  [WA + 2: 0] phase, 
    output [WA - 1: 0] addr,
    output wire re_sig, im_sig, sel
);

    // --- Internal Declarations and Parameter Definitions ---
    
    // Explicitly declare ports internally (Vivado requirement)
    wire clk, reset;
    
    // The Register that holds the phase value and generates the sweep
    reg [21:0] phase_accumulator; 

    // Define the Phase Increment (The Step Size)
    localparam PHASE_INCREMENT = 10000; 
    
    // Internal wires used by the original LUT indexing logic:
    wire [2:0] a0; 
    wire [WA - 1 : 0] a1; 
    
    // --- 1. Synchronous Phase Accumulator Logic (The Counter) ---
    // Corrected always block structure to resolve the syntax error
    always @(posedge clk) begin
        if (reset) begin
            // Reset logic: Clear the accumulator
            phase_accumulator <= 22'b0;
        end else begin
            // Accumulation: Phase_new = Phase_old + Increment
            phase_accumulator <= phase_accumulator + PHASE_INCREMENT;
        end
    end

    // --- 2. LUT Indexing Logic (Original Functionality) ---
    // This logic takes the current phase_accumulator value and calculates the LUT address and sign bits.
    
    // Assign the accumulator output bits to the two internal wires
    assign {a0, a1} = phase_accumulator[WA + 2: 0]; 
    
    // --- 3. Combinational Output Assignments ---
    
    // Address assignment logic
    assign addr = a0[0] ? (~a1) : a1; 

    // Sign bit assignments
    assign re_sig = ^a0[2:1];
    assign im_sig = a0[2];
    assign sel = ^a0[1:0];

endmodule