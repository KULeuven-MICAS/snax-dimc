// Generated by stratus_hls 23.01-s004  (99406.080430)
// Thu Oct 17 11:14:29 2024
// from streamer_handler.cc

`timescale 1ps / 1ps


module streamer_handler_Add_4Ux1U_5U_4( in2, in1, out1 );

    input [3:0] in2;
    input in1;
    output [4:0] out1;

    
    // rtl_process:streamer_handler_Add_4Ux1U_5U_4/streamer_handler_Add_4Ux1U_5U_4_thread_1
    assign out1 = {1'b0, in2} + {4'b0000, in1};

endmodule

