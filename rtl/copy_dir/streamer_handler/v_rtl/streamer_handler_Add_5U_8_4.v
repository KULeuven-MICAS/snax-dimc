// Generated by stratus_hls 23.01-s004  (99406.080430)
// Sat Feb  1 21:15:24 2025
// from streamer_handler.cc

`timescale 1ps / 1ps


module streamer_handler_Add_5U_8_4( in1, out1 );

    input [3:0] in1;
    output [4:0] out1;

    
    // rtl_process:streamer_handler_Add_5U_8_4/streamer_handler_Add_5U_8_4_thread_1
    assign out1 = {1'b0, in1} + 5'd01;

endmodule


