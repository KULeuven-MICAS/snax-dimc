// Generated by stratus_hls 23.01-s004  (99406.080430)
// Wed Nov 20 14:29:55 2024
// from snax_req_handler.cc

`timescale 1ps / 1ps


module snax_req_handler_N_Mux_8_3_51_4( in3, in2, ctrl1, out1 );

    input [7:0] in3;
    input in2;
    input [31:0] ctrl1;
    output [7:0] out1;
    reg [7:0] out1;

    
    // rtl_process:snax_req_handler_N_Mux_8_3_51_4/snax_req_handler_N_Mux_8_3_51_4_thread_1
    always @*
      begin : snax_req_handler_N_Mux_8_3_51_4_thread_1
        case (ctrl1) 
          32'd0000000027: 
            begin
              out1 = in3;
            end
          32'd0000000026: 
            begin
              out1 = {7'b0000000, in2};
            end
          default: 
            begin
              out1 = 8'd000;
            end
        endcase
      end

endmodule




