// Generated by stratus_hls 23.01-s004  (99406.080430)
// Sat Feb  1 21:28:02 2025
// from qkt_macro_handler_hub.cc

`timescale 1ps / 1ps


module qkt_macro_handler_hub_Mul_32Sx32S_64S_4( in2, in1, out1 );

    input [31:0] in2;
    input [31:0] in1;
    output [63:0] out1;

    
    // rtl_process:qkt_macro_handler_hub_Mul_32Sx32S_64S_4/qkt_macro_handler_hub_Mul_32Sx32S_64S_4_thread_1
    assign out1 = {{ 32 {in2[31]}}, in2} * {{ 32 {in1[31]}}, in1};

endmodule

