#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"        // Required for Xilinx register Read/Write
#include "xparameters.h"   // Contains hardware base addresses

// --- Define the Base Address for your Custom IP ---
// This address must match what is in your Vivado Address Editor.
// If you are unsure, 0x44A00000 is the standard default for the first AXI peripheral.
#define NCO_LUT_BASE_ADDR 0x44A00000 

int main()
{
    init_platform();

    print("\n\r--- ADAS RADAR CHIRP CONTROLLER STARTING ---\n\r");

    u32 status_val;
    u32 start_command = 0x00000001; // Bit 0 = Start

    // 1. Control Demonstration: Write a 'Start' Command
    // We write the value '1' to the register at Offset 0
    Xil_Out32(NCO_LUT_BASE_ADDR + 0x0, start_command); 
    xil_printf("WROTE Start Command (0x%08x) to Address 0x%08x\n\r", start_command, NCO_LUT_BASE_ADDR);

    // 2. Readback Demonstration: Check Status
    // We read the value from the register at Offset 4 (assuming status is mapped there)
    status_val = Xil_In32(NCO_LUT_BASE_ADDR + 0x4); 
    xil_printf("READ Status Register (Offset 4): 0x%08x\n\r", status_val);

    print("--- SYSTEM CHECK COMPLETE ---\n\r");

    cleanup_platform();
    return 0;
}