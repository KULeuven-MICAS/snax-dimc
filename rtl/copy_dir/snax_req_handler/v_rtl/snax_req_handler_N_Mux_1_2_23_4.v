// Generated by stratus_hls 23.01-s004  (99406.080430)
// Sat Feb  1 21:14:49 2025
// from snax_req_handler.cc

`timescale 1ps / 1ps


module snax_req_handler_N_Mux_1_2_23_4( in3, in2, ctrl1, out1 );

    input in3;
    input in2;
    input ctrl1;
    output out1;
    reg out1;

    
    // rtl_process:snax_req_handler_N_Mux_1_2_23_4/snax_req_handler_N_Mux_1_2_23_4_thread_1
    always @*
      begin : snax_req_handler_N_Mux_1_2_23_4_thread_1
        case (ctrl1) 
          1'b1: 
            begin
              out1 = in2;
            end
          default: 
            begin
              out1 = in3;
            end
        endcase
      end

endmodule


