// Generated by stratus_hls 23.01-s004  (99406.080430)
// Sat Feb  1 22:31:18 2025
// from qkv_macro_handler_unit.cc

`timescale 1ps / 1ps


module qkv_macro_handler_unit_N_Mux_26_2_20_4( in3, in2, ctrl1, out1 );

    input [25:0] in3;
    input [25:0] in2;
    input ctrl1;
    output [25:0] out1;
    reg [25:0] out1;

    
    // rtl_process:qkv_macro_handler_unit_N_Mux_26_2_20_4/qkv_macro_handler_unit_N_Mux_26_2_20_4_thread_1
    always @*
      begin : qkv_macro_handler_unit_N_Mux_26_2_20_4_thread_1
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

