// Generated by stratus_hls 23.01-s004  (99406.080430)
// Sat Feb  1 22:51:48 2025
// from qkt_macro_handler_unit.cc

`timescale 1ps / 1ps


module qkt_macro_handler_unit_LeftShift_64U_112_1( in1, out1 );

    input [5:0] in1;
    output [63:0] out1;

    
    // rtl_process:qkt_macro_handler_unit_LeftShift_64U_112_1/qkt_macro_handler_unit_LeftShift_64U_112_1_thread_1
    assign out1 = 64'd00000000000000000001 << in1;

endmodule

