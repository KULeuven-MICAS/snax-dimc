// Generated by stratus_hls 23.01-s004  (99406.080430)
// Sat Feb  1 16:21:30 2025
// from dimc_detail_model.cc

`timescale 1ps / 1ps


module dimc_macro_N_Mux_6_2_45_4( in2, ctrl1, out1 );

    input [5:0] in2;
    input ctrl1;
    output [5:0] out1;
    reg [5:0] out1;

    
    // rtl_process:dimc_macro_N_Mux_6_2_45_4/dimc_macro_N_Mux_6_2_45_4_thread_1
    always @*
      begin : dimc_macro_N_Mux_6_2_45_4_thread_1
        case (ctrl1) 
          1'b1: 
            begin
              out1 = 6'd00;
            end
          default: 
            begin
              out1 = in2;
            end
        endcase
      end

endmodule


