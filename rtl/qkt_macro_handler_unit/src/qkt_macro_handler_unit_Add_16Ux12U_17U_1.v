// Generated by stratus_hls 23.01-s004  (99406.080430)
// Wed Nov 20 15:39:26 2024
// from qkv_macro_handler_unit.cc

`timescale 1ps / 1ps


module qkt_macro_handler_unit_Add_16Ux12U_17U_1( in2, in1, out1 );

    input [15:0] in2;
    input [11:0] in1;
    output [16:0] out1;

    
    // rtl_process:qkv_macro_handler_unit_Add_16Ux12U_17U_1/qkv_macro_handler_unit_Add_16Ux12U_17U_1_thread_1
    assign out1 = {1'b0, in2} + {5'b00000, in1};

endmodule




