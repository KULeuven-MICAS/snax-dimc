// Generated by stratus_hls 23.01-s004  (99406.080430)
// Wed Nov 20 15:38:09 2024
// from qkv_macro_handler_unit.cc

`timescale 1ps / 1ps


module qkv_macro_handler_unit_Add_32Sx18S_32S_4( in2, in1, out1 );

    input [31:0] in2;
    input [17:0] in1;
    output [31:0] out1;

    
    // rtl_process:qkv_macro_handler_unit_Add_32Sx18S_32S_4/qkv_macro_handler_unit_Add_32Sx18S_32S_4_thread_1
    assign out1 = in2 + {{ 14 {in1[17]}}, in1};

endmodule




