// Generated by stratus_hls 23.01-s004  (99406.080430)
// Sat Feb  1 22:31:20 2025
// from qkv_macro_handler_unit.cc

`timescale 1ps / 1ps


module qkv_macro_handler_unit_Add_18Sx17U_19S_1( in2, in1, out1 );

    input [17:0] in2;
    input [16:0] in1;
    output [18:0] out1;

    
    // rtl_process:qkv_macro_handler_unit_Add_18Sx17U_19S_1/qkv_macro_handler_unit_Add_18Sx17U_19S_1_thread_1
    assign out1 = {in2[17], in2} + {2'b00, in1};

endmodule


