// Generated by stratus_hls 23.01-s004  (99406.080430)
// Wed Nov 20 15:39:26 2024
// from qkv_macro_handler_unit.cc

`timescale 1ps / 1ps


module qkv_macro_handler_unit_N_Mux_21_2_34_1( in3, in2, ctrl1, out1 );

    input [20:0] in3;
    input [20:0] in2;
    input ctrl1;
    output [20:0] out1;
    reg [20:0] out1;

    
    // rtl_process:qkv_macro_handler_unit_N_Mux_21_2_34_1/qkv_macro_handler_unit_N_Mux_21_2_34_1_thread_1
    always @*
      begin : qkv_macro_handler_unit_N_Mux_21_2_34_1_thread_1
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




