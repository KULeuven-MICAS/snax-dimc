// Generated by stratus_hls 23.01-s004  (99406.080430)
// Thu Feb  6 10:35:34 2025
// from streamer_handler.cc

`timescale 1ps / 1ps


module streamer_handler_LessThan_1U_13_1( in1, out1 );

    input [3:0] in1;
    output out1;

    
    // rtl_process:streamer_handler_LessThan_1U_13_1/streamer_handler_LessThan_1U_13_1_thread_1
    assign out1 = (in1[3] ^ in1 < 4'd04);

endmodule


