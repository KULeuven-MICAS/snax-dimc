// Generated by stratus_hls 23.01-s004  (99406.080430)
// Sat Feb  1 22:31:18 2025
// from qkv_macro_handler_unit.cc

`timescale 1ps / 1ps


module qkv_macro_handler_unit_Or_12Ux8U_12U_4( in2, in1, out1 );

    input [11:0] in2;
    input [7:0] in1;
    output [11:0] out1;

    
    // rtl_process:qkv_macro_handler_unit_Or_12Ux8U_12U_4/qkv_macro_handler_unit_Or_12Ux8U_12U_4_thread_1
    assign out1 = in2 | {4'b0000, in1};

endmodule


