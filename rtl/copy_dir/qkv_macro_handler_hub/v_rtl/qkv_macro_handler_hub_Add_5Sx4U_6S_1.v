// Generated by stratus_hls 23.01-s004  (99406.080430)
// Sat Feb  1 21:17:59 2025
// from qkv_macro_handler_hub.cc

`timescale 1ps / 1ps


module qkv_macro_handler_hub_Add_5Sx4U_6S_1( in2, in1, out1 );

    input [4:0] in2;
    input [3:0] in1;
    output [5:0] out1;

    
    // rtl_process:qkv_macro_handler_hub_Add_5Sx4U_6S_1/qkv_macro_handler_hub_Add_5Sx4U_6S_1_thread_1
    assign out1 = {in2[4], in2} + {2'b00, in1};

endmodule

