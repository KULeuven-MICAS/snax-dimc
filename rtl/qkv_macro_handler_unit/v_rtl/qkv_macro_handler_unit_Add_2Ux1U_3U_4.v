// Generated by stratus_hls 23.01-s004  (99406.080430)
// Thu Feb  6 10:44:50 2025
// from qkv_macro_handler_unit.cc

`timescale 1ps / 1ps


module qkv_macro_handler_unit_Add_2Ux1U_3U_4( in2, in1, out1 );

    input [1:0] in2;
    input in1;
    output [2:0] out1;

    
    // rtl_process:qkv_macro_handler_unit_Add_2Ux1U_3U_4/qkv_macro_handler_unit_Add_2Ux1U_3U_4_thread_1
    assign out1 = {1'b0, in2} + {2'b00, in1};

endmodule

