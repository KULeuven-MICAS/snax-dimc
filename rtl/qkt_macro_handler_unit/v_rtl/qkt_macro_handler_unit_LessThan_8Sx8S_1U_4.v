// Generated by stratus_hls 23.01-s004  (99406.080430)
// Thu Feb  6 10:54:29 2025
// from qkt_macro_handler_unit.cc

`timescale 1ps / 1ps


module qkt_macro_handler_unit_LessThan_8Sx8S_1U_4( in2, in1, out1 );

    input [7:0] in2;
    input [7:0] in1;
    output out1;

    
    // rtl_process:qkt_macro_handler_unit_LessThan_8Sx8S_1U_4/qkt_macro_handler_unit_LessThan_8Sx8S_1U_4_thread_1
    assign out1 = (in2 < in1 ^ (in1[7] ^ in2[7]));

endmodule

