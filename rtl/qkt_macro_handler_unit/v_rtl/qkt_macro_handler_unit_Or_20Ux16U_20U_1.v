// Generated by stratus_hls 23.01-s004  (99406.080430)
// Tue Oct  1 17:48:07 2024
// from qkt_macro_handler_unit.cc

`timescale 1ps / 1ps


module qkt_macro_handler_unit_Or_20Ux16U_20U_1( in2, in1, out1 );

    input [19:0] in2;
    input [15:0] in1;
    output [19:0] out1;

    
    // rtl_process:qkt_macro_handler_unit_Or_20Ux16U_20U_1/qkt_macro_handler_unit_Or_20Ux16U_20U_1_thread_1
    assign out1 = in2 | {4'b0000, in1};

endmodule

