// Generated by stratus_hls 23.01-s004  (99406.080430)
// Sat Feb  1 21:18:00 2025
// from qkv_macro_handler_hub.cc

`timescale 1ps / 1ps


module qkv_macro_handler_hub_Equal_5Ux4U_1U_1( in2, in1, out1 );

    input [4:0] in2;
    input [3:0] in1;
    output out1;

    
    // rtl_process:qkv_macro_handler_hub_Equal_5Ux4U_1U_1/qkv_macro_handler_hub_Equal_5Ux4U_1U_1_thread_1
    assign out1 = in2 == {1'b0, in1};

endmodule

