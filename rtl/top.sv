// author Mace

module SNAX_DIMC # (
    parameter int unsigned NarrowDataWidth = 64,
    parameter int unsigned WideDataWidth   = 512,
    parameter int unsigned RegAddrWidth    = 32,
    parameter int unsigned RegDataWidth    = 32
)(
    clk_i, rst_ni,
    acc2stream_0_data_o, acc2stream_0_valid_o, acc2stream_0_ready_i,
    stream2acc_0_data_i, stream2acc_0_valid_i, stream2acc_0_ready_o,
    stream2acc_1_data_i, stream2acc_1_valid_i, stream2acc_1_ready_o,
    stream2acc_2_data_i, stream2acc_2_valid_i, stream2acc_2_ready_o,
    stream2acc_3_data_i, stream2acc_3_valid_i, stream2acc_3_ready_o,
    csr_req_addr_i, csr_req_data_i, csr_req_write_i, csr_req_valid_i, csr_req_ready_o,
    csr_rsp_data_o, csr_rsp_valid_o, csr_rsp_ready_i
);

/**************************************************************************/
// Clock and reset
/**************************************************************************/
input  logic                       clk_i;
input  logic                       rst_ni;

/**************************************************************************/
// Accelerator ports
/**************************************************************************/
// Ports from accelerator to streamer by writer data movers
output logic [WideDataWidth-1:0]   acc2stream_0_data_o;
output logic                       acc2stream_0_valid_o;
input  logic                       acc2stream_0_ready_i;
    
// Ports from streamer to accelerator by reader data movers
input  logic [WideDataWidth-1:0]   stream2acc_0_data_i;
input  logic                       stream2acc_0_valid_i;
output logic                       stream2acc_0_ready_o;

input  logic [WideDataWidth-1:0]   stream2acc_1_data_i;
input  logic                       stream2acc_1_valid_i;
output logic                       stream2acc_1_ready_o;

input  logic [WideDataWidth-1:0]   stream2acc_2_data_i;
input  logic                       stream2acc_2_valid_i;
output logic                       stream2acc_2_ready_o;

input  logic [WideDataWidth-1:0]   stream2acc_3_data_i;
input  logic                       stream2acc_3_valid_i;
output logic                       stream2acc_3_ready_o;


/**************************************************************************/
// CSR control ports
/**************************************************************************/
// Request
input  logic [   RegAddrWidth-1:0] csr_req_addr_i;
input  logic [   RegDataWidth-1:0] csr_req_data_i;
input  logic                       csr_req_write_i;
input  logic                       csr_req_valid_i;
output logic                       csr_req_ready_o;
// Response
output logic [   RegDataWidth-1:0] csr_rsp_data_o;
output logic                       csr_rsp_valid_o;
input  logic                       csr_rsp_ready_i;
/**************************************************************************/

// Internal signals

wire rst;

wire [191:0] result_QKV_0, result_QKV_1, result_QKV_2, result_QKV_3, result_QKV_4, result_QKV_5, result_QKV_6, result_QKV_7, result_QKV_8, result_QKV_9, result_QKV_10, result_QKV_11, result_QKV_12, result_QKV_13, result_QKV_14, result_QKV_15,
             result_QKV_16, result_QKV_17, result_QKV_18, result_QKV_19, result_QKV_20, result_QKV_21, result_QKV_22, result_QKV_23, result_QKV_24, result_QKV_25, result_QKV_26, result_QKV_27, result_QKV_28, result_QKV_29, result_QKV_30, result_QKV_31
             result_QKT_0, result_QKT_1, result_QKT_2, result_QKT_3;

wire [63:0] WL_QKV_0, WL_QKV_1, WL_QKV_2, WL_QKV_3, WL_QKV_4, WL_QKV_5, WL_QKV_6, WL_QKV_7, WL_QKV_8, WL_QKV_9, WL_QKV_10, WL_QKV_11, WL_QKV_12, WL_QKV_13, WL_QKV_14, WL_QKV_15,
            WL_QKV_16, WL_QKV_17, WL_QKV_18, WL_QKV_19, WL_QKV_20, WL_QKV_21, WL_QKV_22, WL_QKV_23, WL_QKV_24, WL_QKV_25, WL_QKV_26, WL_QKV_27, WL_QKV_28, WL_QKV_29, WL_QKV_30, WL_QKV_31,
            WL_QKT_0, WL_QKT_1, WL_QKT_2, WL_QKT_3;

wire [127:0] wdata_QKV_0, wdata_QKV_1, wdata_QKV_2, wdata_QKV_3, wdata_QKV_4, wdata_QKV_5, wdata_QKV_6, wdata_QKV_7, wdata_QKV_8, wdata_QKV_9, wdata_QKV_10, wdata_QKV_11, wdata_QKV_12, wdata_QKV_13, wdata_QKV_14, wdata_QKV_15,
             wdata_QKV_16, wdata_QKV_17, wdata_QKV_18, wdata_QKV_19, wdata_QKV_20, wdata_QKV_21, wdata_QKV_22, wdata_QKV_23, wdata_QKV_24, wdata_QKV_25, wdata_QKV_26, wdata_QKV_27, wdata_QKV_28, wdata_QKV_29, wdata_QKV_30, wdata_QKV_31,
             wdata_QKT_0, wdata_QKT_1, wdata_QKT_2, wdata_QKT_3;

wire [63:0] ai_QKV_0, ai_QKV_1, ai_QKV_2, ai_QKV_3, ai_QKV_4, ai_QKV_5, ai_QKV_6, ai_QKV_7, ai_QKV_8, ai_QKV_9, ai_QKV_10, ai_QKV_11, ai_QKV_12, ai_QKV_13, ai_QKV_14, ai_QKV_15,
            ai_QKV_16, ai_QKV_17, ai_QKV_18, ai_QKV_19, ai_QKV_20, ai_QKV_21, ai_QKV_22, ai_QKV_23, ai_QKV_24, ai_QKV_25, ai_QKV_26, ai_QKV_27, ai_QKV_28, ai_QKV_29, ai_QKV_30, ai_QKV_31,
            ai_QKT_0, ai_QKT_1, ai_QKT_2, ai_QKT_3;

wire RE_QKV__0, RE_QKV__1, RE_QKV__2, RE_QKV__3, RE_QKV__4, RE_QKV__5, RE_QKV__6, RE_QKV__7, RE_QKV__8, RE_QKV__9, RE_QKV__10, RE_QKV__11, RE_QKV__12, RE_QKV__13, RE_QKV__14, RE_QKV__15,
     RE_QKV__16, RE_QKV__17, RE_QKV__18, RE_QKV__19, RE_QKV__20, RE_QKV__21, RE_QKV__22, RE_QKV__23, RE_QKV__24, RE_QKV__25, RE_QKV__26, RE_QKV__27, RE_QKV__28, RE_QKV__29, RE_QKV__30, RE_QKV__31,
     RE_QKT__0, RE_QKT__1, RE_QKT__2, RE_QKT__3;

wire PREC_QKV_0, PREC_QKV_1, PREC_QKV_2, PREC_QKV_3, PREC_QKV_4, PREC_QKV_5, PREC_QKV_6, PREC_QKV_7, PREC_QKV_8, PREC_QKV_9, PREC_QKV_10, PREC_QKV_11, PREC_QKV_12, PREC_QKV_13, PREC_QKV_14, PREC_QKV_15,
     PREC_QKV_16, PREC_QKV_17, PREC_QKV_18, PREC_QKV_19, PREC_QKV_20, PREC_QKV_21, PREC_QKV_22, PREC_QKV_23, PREC_QKV_24, PREC_QKV_25, PREC_QKV_26, PREC_QKV_27, PREC_QKV_28, PREC_QKV_29, PREC_QKV_30, PREC_QKV_31,
     PREC_QKT_0, PREC_QKT_1, PREC_QKT_2, PREC_QKT_3;

wire PREC_QKV__0, PREC_QKV__1, PREC_QKV__2, PREC_QKV__3, PREC_QKV__4, PREC_QKV__5, PREC_QKV__6, PREC_QKV__7, PREC_QKV__8, PREC_QKV__9, PREC_QKV__10, PREC_QKV__11, PREC_QKV__12, PREC_QKV__13, PREC_QKV__14, PREC_QKV__15,
     PREC_QKV__16, PREC_QKV__17, PREC_QKV__18, PREC_QKV__19, PREC_QKV__20, PREC_QKV__21, PREC_QKV__22, PREC_QKV__23, PREC_QKV__24, PREC_QKV__25, PREC_QKV__26, PREC_QKV__27, PREC_QKV__28, PREC_QKV__29, PREC_QKV__30, PREC_QKV__31,
     PREC_QKT__0, PREC_QKT__1, PREC_QKT__2, PREC_QKT__3;

snax_interfaces i_snax_interfaces(
    .clk(clk_i),
    .rst(rst_ni),

    .snax_acc_req_valid(csr_req_valid_i),
    .snax_acc_req_data_addr(csr_req_addr_i),
    .snax_acc_req_data_wen(csr_req_write_i),
    .snax_acc_req_data_data(csr_req_data_i),
    .snax_acc_req_ready(csr_req_ready_o),

    .acc_snax_rsp_valid(csr_rsp_valid_o),
    .acc_snax_rsp_data_data(csr_rsp_data_o),
    .acc_snax_rsp_ready(csr_rsp_ready_i),

    .stream_acc_port_0_valid(stream2acc_0_valid_i),
    .stream_acc_port_0_data(stream2acc_0_data_i),
    .stream_acc_port_0_ready(stream2acc_0_ready_o),

    .stream_acc_port_1_valid(stream2acc_1_valid_i),
    .stream_acc_port_1_data(stream2acc_1_data_i),
    .stream_acc_port_1_ready(stream2acc_1_ready_o),

    .stream_acc_port_2_valid(stream2acc_2_valid_i),
    .stream_acc_port_2_data(stream2acc_2_data_i),
    .stream_acc_port_2_ready(stream2acc_2_ready_o),

    .stream_acc_port_3_valid(stream2acc_3_valid_i),
    .stream_acc_port_3_data(stream2acc_3_data_i),
    .stream_acc_port_3_ready(stream2acc_3_ready_o),

    .acc_stream_port_valid(acc2stream_0_valid_o),
    .acc_stream_port_data(acc2stream_0_data_o),
    .acc_stream_port_ready(acc2stream_0_ready_i),

    .result_QKV_0(result_QKV_0), .result_QKV_1(result_QKV_1), .result_QKV_2(result_QKV_2), .result_QKV_3(result_QKV_3), .result_QKV_4(result_QKV_4), .result_QKV_5(result_QKV_5), .result_QKV_6(result_QKV_6), .result_QKV_7(result_QKV_7), .result_QKV_8(result_QKV_8), .result_QKV_9(result_QKV_9), .result_QKV_10(result_QKV_10), .result_QKV_11(result_QKV_11), .result_QKV_12(result_QKV_12), .result_QKV_13(result_QKV_13), .result_QKV_14(result_QKV_14), .result_QKV_15(result_QKV_15),
    .result_QKV_16(result_QKV_16), .result_QKV_17(result_QKV_17), .result_QKV_18(result_QKV_18), .result_QKV_19(result_QKV_19), .result_QKV_20(result_QKV_20), .result_QKV_21(result_QKV_21), .result_QKV_22(result_QKV_22), .result_QKV_23(result_QKV_23), .result_QKV_24(result_QKV_24), .result_QKV_25(result_QKV_25), .result_QKV_26(result_QKV_26), .result_QKV_27(result_QKV_27), .result_QKV_28(result_QKV_28), .result_QKV_29(result_QKV_29), .result_QKV_30(result_QKV_30), .result_QKV_31(result_QKV_31),
    .result_QKT_0(result_QKT_0), .result_QKT_1(result_QKT_1), .result_QKT_2(result_QKT_2), .result_QKT_3(result_QKT_3),

    .WL_QKV_0(WL_QKV_0), .WL_QKV_1(WL_QKV_1), .WL_QKV_2(WL_QKV_2), .WL_QKV_3(WL_QKV_3), .WL_QKV_4(WL_QKV_4), .WL_QKV_5(WL_QKV_5), .WL_QKV_6(WL_QKV_6), .WL_QKV_7(WL_QKV_7), .WL_QKV_8(WL_QKV_8), .WL_QKV_9(WL_QKV_9), .WL_QKV_10(WL_QKV_10), .WL_QKV_11(WL_QKV_11), .WL_QKV_12(WL_QKV_12), .WL_QKV_13(WL_QKV_13), .WL_QKV_14(WL_QKV_14), .WL_QKV_15(WL_QKV_15),
    .WL_QKV_16(WL_QKV_16), .WL_QKV_17(WL_QKV_17), .WL_QKV_18(WL_QKV_18), .WL_QKV_19(WL_QKV_19), .WL_QKV_20(WL_QKV_20), .WL_QKV_21(WL_QKV_21), .WL_QKV_22(WL_QKV_22), .WL_QKV_23(WL_QKV_23), .WL_QKV_24(WL_QKV_24), .WL_QKV_25(WL_QKV_25), .WL_QKV_26(WL_QKV_26), .WL_QKV_27(WL_QKV_27), .WL_QKV_28(WL_QKV_28), .WL_QKV_29(WL_QKV_29), .WL_QKV_30(WL_QKV_30), .WL_QKV_31(WL_QKV_31),
    .WL_QKT_0(WL_QKT_0), .WL_QKT_1(WL_QKT_1), .WL_QKT_2(WL_QKT_2), .WL_QKT_3(WL_QKT_3),

    .wdata_QKV_0(wdata_QKV_0), .wdata_QKV_1(wdata_QKV_1), .wdata_QKV_2(wdata_QKV_2), .wdata_QKV_3(wdata_QKV_3), .wdata_QKV_4(wdata_QKV_4), .wdata_QKV_5(wdata_QKV_5), .wdata_QKV_6(wdata_QKV_6), .wdata_QKV_7(wdata_QKV_7), .wdata_QKV_8(wdata_QKV_8), .wdata_QKV_9(wdata_QKV_9), .wdata_QKV_10(wdata_QKV_10), .wdata_QKV_11(wdata_QKV_11), .wdata_QKV_12(wdata_QKV_12), .wdata_QKV_13(wdata_QKV_13), .wdata_QKV_14(wdata_QKV_14), .wdata_QKV_15(wdata_QKV_15),
    .wdata_QKV_16(wdata_QKV_16), .wdata_QKV_17(wdata_QKV_17), .wdata_QKV_18(wdata_QKV_18), .wdata_QKV_19(wdata_QKV_19), .wdata_QKV_20(wdata_QKV_20), .wdata_QKV_21(wdata_QKV_21), .wdata_QKV_22(wdata_QKV_22), .wdata_QKV_23(wdata_QKV_23), .wdata_QKV_24(wdata_QKV_24), .wdata_QKV_25(wdata_QKV_25), .wdata_QKV_26(wdata_QKV_26), .wdata_QKV_27(wdata_QKV_27), .wdata_QKV_28(wdata_QKV_28), .wdata_QKV_29(wdata_QKV_29), .wdata_QKV_30(wdata_QKV_30), .wdata_QKV_31(wdata_QKV_31),
    .wdata_QKT_0(wdata_QKT_0), .wdata_QKT_1(wdata_QKT_1), .wdata_QKT_2(wdata_QKT_2), .wdata_QKT_3(wdata_QKT_3),

    .ai_QKV_0(ai_QKV_0), .ai_QKV_1(ai_QKV_1), .ai_QKV_2(ai_QKV_2), .ai_QKV_3(ai_QKV_3), .ai_QKV_4(ai_QKV_4), .ai_QKV_5(ai_QKV_5), .ai_QKV_6(ai_QKV_6), .ai_QKV_7(ai_QKV_7), .ai_QKV_8(ai_QKV_8), .ai_QKV_9(ai_QKV_9), .ai_QKV_10(ai_QKV_10), .ai_QKV_11(ai_QKV_11), .ai_QKV_12(ai_QKV_12), .ai_QKV_13(ai_QKV_13), .ai_QKV_14(ai_QKV_14), .ai_QKV_15(ai_QKV_15),
    .ai_QKV_16(ai_QKV_16), .ai_QKV_17(ai_QKV_17), .ai_QKV_18(ai_QKV_18), .ai_QKV_19(ai_QKV_19), .ai_QKV_20(ai_QKV_20), .ai_QKV_21(ai_QKV_21), .ai_QKV_22(ai_QKV_22), .ai_QKV_23(ai_QKV_23), .ai_QKV_24(ai_QKV_24), .ai_QKV_25(ai_QKV_25), .ai_QKV_26(ai_QKV_26), .ai_QKV_27(ai_QKV_27), .ai_QKV_28(ai_QKV_28), .ai_QKV_29(ai_QKV_29), .ai_QKV_30(ai_QKV_30), .ai_QKV_31(ai_QKV_31),
    .ai_QKT_0(ai_QKT_0), .ai_QKT_1(ai_QKT_1), .ai_QKT_2(ai_QKT_2), .ai_QKT_3(ai_QKT_3),

    .RE_QKV__0(RE_QKV__0), .RE_QKV__1(RE_QKV__1), .RE_QKV__2(RE_QKV__2), .RE_QKV__3(RE_QKV__3), .RE_QKV__4(RE_QKV__4), .RE_QKV__5(RE_QKV__5), .RE_QKV__6(RE_QKV__6), .RE_QKV__7(RE_QKV__7), .RE_QKV__8(RE_QKV__8), .RE_QKV__9(RE_QKV__9), .RE_QKV__10(RE_QKV__10), .RE_QKV__11(RE_QKV__11), .RE_QKV__12(RE_QKV__12), .RE_QKV__13(RE_QKV__13), .RE_QKV__14(RE_QKV__14), .RE_QKV__15(RE_QKV__15),
    .RE_QKV__16(RE_QKV__16), .RE_QKV__17(RE_QKV__17), .RE_QKV__18(RE_QKV__18), .RE_QKV__19(RE_QKV__19), .RE_QKV__20(RE_QKV__20), .RE_QKV__21(RE_QKV__21), .RE_QKV__22(RE_QKV__22), .RE_QKV__23(RE_QKV__23), .RE_QKV__24(RE_QKV__24), .RE_QKV__25(RE_QKV__25), .RE_QKV__26(RE_QKV__26), .RE_QKV__27(RE_QKV__27), .RE_QKV__28(RE_QKV__28), .RE_QKV__29(RE_QKV__29), .RE_QKV__30(RE_QKV__30), .RE_QKV__31(RE_QKV__31),
    .RE_QKT__0(RE_QKT__0), .RE_QKT__1(RE_QKT__1), .RE_QKT__2(RE_QKT__2), .RE_QKT__3(RE_QKT__3),

    .PREC_QKV_0(PREC_QKV_0), .PREC_QKV_1(PREC_QKV_1), .PREC_QKV_2(PREC_QKV_2), .PREC_QKV_3(PREC_QKV_3), .PREC_QKV_4(PREC_QKV_4), .PREC_QKV_5(PREC_QKV_5), .PREC_QKV_6(PREC_QKV_6), .PREC_QKV_7(PREC_QKV_7), .PREC_QKV_8(PREC_QKV_8), .PREC_QKV_9(PREC_QKV_9), .PREC_QKV_10(PREC_QKV_10), .PREC_QKV_11(PREC_QKV_11), .PREC_QKV_12(PREC_QKV_12), .PREC_QKV_13(PREC_QKV_13), .PREC_QKV_14(PREC_QKV_14), .PREC_QKV_15(PREC_QKV_15),
    .PREC_QKV_16(PREC_QKV_16), .PREC_QKV_17(PREC_QKV_17), .PREC_QKV_18(PREC_QKV_18), .PREC_QKV_19(PREC_QKV_19), .PREC_QKV_20(PREC_QKV_20), .PREC_QKV_21(PREC_QKV_21), .PREC_QKV_22(PREC_QKV_22), .PREC_QKV_23(PREC_QKV_23), .PREC_QKV_24(PREC_QKV_24), .PREC_QKV_25(PREC_QKV_25), .PREC_QKV_26(PREC_QKV_26), .PREC_QKV_27(PREC_QKV_27), .PREC_QKV_28(PREC_QKV_28), .PREC_QKV_29(PREC_QKV_29), .PREC_QKV_30(PREC_QKV_30), .PREC_QKV_31(PREC_QKV_31),
    .PREC_QKT_0(PREC_QKT_0), .PREC_QKT_1(PREC_QKT_1), .PREC_QKT_2(PREC_QKT_2), .PREC_QKT_3(PREC_QKT_3),

    .PREC_QKV__0(PREC_QKV__0), .PREC_QKV__1(PREC_QKV__1), .PREC_QKV__2(PREC_QKV__2), .PREC_QKV__3(PREC_QKV__3), .PREC_QKV__4(PREC_QKV__4), .PREC_QKV__5(PREC_QKV__5), .PREC_QKV__6(PREC_QKV__6), .PREC_QKV__7(PREC_QKV__7), .PREC_QKV__8(PREC_QKV__8), .PREC_QKV__9(PREC_QKV__9), .PREC_QKV__10(PREC_QKV__10), .PREC_QKV__11(PREC_QKV__11), .PREC_QKV__12(PREC_QKV__12), .PREC_QKV__13(PREC_QKV__13), .PREC_QKV__14(PREC_QKV__14), .PREC_QKV__15(PREC_QKV__15),
    .PREC_QKV__16(PREC_QKV__16), .PREC_QKV__17(PREC_QKV__17), .PREC_QKV__18(PREC_QKV__18), .PREC_QKV__19(PREC_QKV__19), .PREC_QKV__20(PREC_QKV__20), .PREC_QKV__21(PREC_QKV__21), .PREC_QKV__22(PREC_QKV__22), .PREC_QKV__23(PREC_QKV__23), .PREC_QKV__24(PREC_QKV__24), .PREC_QKV__25(PREC_QKV__25), .PREC_QKV__26(PREC_QKV__26), .PREC_QKV__27(PREC_QKV__27), .PREC_QKV__28(PREC_QKV__28), .PREC_QKV__29(PREC_QKV__29), .PREC_QKV__30(PREC_QKV__30), .PREC_QKV__31(PREC_QKV__31),
    .PREC_QKT__0(PREC_QKT__0), .PREC_QKT__1(PREC_QKT__1), .PREC_QKT__2(PREC_QKT__2), .PREC_QKT__3(PREC_QKT__3)
);

dimc_macro i_dimc_macro_0(.clk(clk_i),
                          .WL(WL_QKV_0), 
                          .wdata(wdata_QKV_0), 
                          .ai(ai_QKV_0), 
                          .RE_(RE_QKV__0), 
                          .PREC(PREC_QKV_0),
                          .PREC_(PREC_QKV__0),
                          .result(result_QKV_0)
                        );

dimc_macro i_dimc_macro_1(.clk(clk_i),
                          .WL(WL_QKV_1), 
                          .wdata(wdata_QKV_1), 
                          .ai(ai_QKV_1), 
                          .RE_(RE_QKV__1), 
                          .PREC(PREC_QKV_1),
                          .PREC_(PREC_QKV__1),
                          .result(result_QKV_1)
                        );

dimc_macro i_dimc_macro_2(.clk(clk_i),
                          .WL(WL_QKV_2), 
                          .wdata(wdata_QKV_2), 
                          .ai(ai_QKV_2), 
                          .RE_(RE_QKV__2), 
                          .PREC(PREC_QKV_2),
                          .PREC_(PREC_QKV__2),
                          .result(result_QKV_2)
                        );

dimc_macro i_dimc_macro_3(.clk(clk_i),
                          .WL(WL_QKV_3), 
                          .wdata(wdata_QKV_3), 
                          .ai(ai_QKV_3), 
                          .RE_(RE_QKV__3), 
                          .PREC(PREC_QKV_3),
                          .PREC_(PREC_QKV__3),
                          .result(result_QKV_3)
                        );

dimc_macro i_dimc_macro_4(.clk(clk_i),
                          .WL(WL_QKV_4), 
                          .wdata(wdata_QKV_4), 
                          .ai(ai_QKV_4), 
                          .RE_(RE_QKV__4), 
                          .PREC(PREC_QKV_4),
                          .PREC_(PREC_QKV__4),
                          .result(result_QKV_4)
                        );

dimc_macro i_dimc_macro_5(.clk(clk_i),
                          .WL(WL_QKV_5), 
                          .wdata(wdata_QKV_5), 
                          .ai(ai_QKV_5), 
                          .RE_(RE_QKV__5), 
                          .PREC(PREC_QKV_5),
                          .PREC_(PREC_QKV__5),
                          .result(result_QKV_5)
                        );

dimc_macro i_dimc_macro_6(.clk(clk_i),
                          .WL(WL_QKV_6), 
                          .wdata(wdata_QKV_6), 
                          .ai(ai_QKV_6), 
                          .RE_(RE_QKV__6), 
                          .PREC(PREC_QKV_6),
                          .PREC_(PREC_QKV__6),
                          .result(result_QKV_6)
                        );

dimc_macro i_dimc_macro_7(.clk(clk_i),
                          .WL(WL_QKV_7), 
                          .wdata(wdata_QKV_7), 
                          .ai(ai_QKV_7), 
                          .RE_(RE_QKV__7), 
                          .PREC(PREC_QKV_7),
                          .PREC_(PREC_QKV__7),
                          .result(result_QKV_7)
                        );

dimc_macro i_dimc_macro_8(.clk(clk_i),
                          .WL(WL_QKV_8), 
                          .wdata(wdata_QKV_8), 
                          .ai(ai_QKV_8), 
                          .RE_(RE_QKV__8), 
                          .PREC(PREC_QKV_8),
                          .PREC_(PREC_QKV__8),
                          .result(result_QKV_8)
                        );

dimc_macro i_dimc_macro_9(.clk(clk_i),
                          .WL(WL_QKV_9), 
                          .wdata(wdata_QKV_9), 
                          .ai(ai_QKV_9), 
                          .RE_(RE_QKV__9), 
                          .PREC(PREC_QKV_9),
                          .PREC_(PREC_QKV__9),
                          .result(result_QKV_9)
                        );

dimc_macro i_dimc_macro_10(.clk(clk_i),
                          .WL(WL_QKV_10), 
                          .wdata(wdata_QKV_10), 
                          .ai(ai_QKV_10), 
                          .RE_(RE_QKV__10), 
                          .PREC(PREC_QKV_10),
                          .PREC_(PREC_QKV__10),
                          .result(result_QKV_10)
                        );

dimc_macro i_dimc_macro_11(.clk(clk_i),
                          .WL(WL_QKV_11), 
                          .wdata(wdata_QKV_11), 
                          .ai(ai_QKV_11), 
                          .RE_(RE_QKV__11), 
                          .PREC(PREC_QKV_11),
                          .PREC_(PREC_QKV__11),
                          .result(result_QKV_11)
                        );

dimc_macro i_dimc_macro_12(.clk(clk_i),
                          .WL(WL_QKV_12), 
                          .wdata(wdata_QKV_12), 
                          .ai(ai_QKV_12), 
                          .RE_(RE_QKV__12), 
                          .PREC(PREC_QKV_12),
                          .PREC_(PREC_QKV__12),
                          .result(result_QKV_12)
                        );

dimc_macro i_dimc_macro_13(.clk(clk_i),
                          .WL(WL_QKV_13), 
                          .wdata(wdata_QKV_13), 
                          .ai(ai_QKV_13), 
                          .RE_(RE_QKV__13), 
                          .PREC(PREC_QKV_13),
                          .PREC_(PREC_QKV__13),
                          .result(result_QKV_13)
                        );

dimc_macro i_dimc_macro_14(.clk(clk_i),
                          .WL(WL_QKV_14), 
                          .wdata(wdata_QKV_14), 
                          .ai(ai_QKV_14), 
                          .RE_(RE_QKV__14), 
                          .PREC(PREC_QKV_14),
                          .PREC_(PREC_QKV__14),
                          .result(result_QKV_14)
                        );

dimc_macro i_dimc_macro_15(.clk(clk_i),
                          .WL(WL_QKV_15), 
                          .wdata(wdata_QKV_15), 
                          .ai(ai_QKV_15), 
                          .RE_(RE_QKV__15), 
                          .PREC(PREC_QKV_15),
                          .PREC_(PREC_QKV__15),
                          .result(result_QKV_15)
                        );

dimc_macro i_dimc_macro_16(.clk(clk_i),
                          .WL(WL_QKV_16), 
                          .wdata(wdata_QKV_16), 
                          .ai(ai_QKV_16), 
                          .RE_(RE_QKV__16), 
                          .PREC(PREC_QKV_16),
                          .PREC_(PREC_QKV__16),
                          .result(result_QKV_16)
                        );

dimc_macro i_dimc_macro_17(.clk(clk_i),
                          .WL(WL_QKV_17), 
                          .wdata(wdata_QKV_17), 
                          .ai(ai_QKV_17), 
                          .RE_(RE_QKV__17), 
                          .PREC(PREC_QKV_17),
                          .PREC_(PREC_QKV__17),
                          .result(result_QKV_17)
                        );

dimc_macro i_dimc_macro_18(.clk(clk_i),
                          .WL(WL_QKV_18), 
                          .wdata(wdata_QKV_18), 
                          .ai(ai_QKV_18), 
                          .RE_(RE_QKV__18), 
                          .PREC(PREC_QKV_18),
                          .PREC_(PREC_QKV__18),
                          .result(result_QKV_18)
                        );

dimc_macro i_dimc_macro_19(.clk(clk_i),
                          .WL(WL_QKV_19), 
                          .wdata(wdata_QKV_19), 
                          .ai(ai_QKV_19), 
                          .RE_(RE_QKV__19), 
                          .PREC(PREC_QKV_19),
                          .PREC_(PREC_QKV__19),
                          .result(result_QKV_19)
                        );

dimc_macro i_dimc_macro_20(.clk(clk_i),
                          .WL(WL_QKV_20), 
                          .wdata(wdata_QKV_20), 
                          .ai(ai_QKV_20), 
                          .RE_(RE_QKV__20), 
                          .PREC(PREC_QKV_20),
                          .PREC_(PREC_QKV__20),
                          .result(result_QKV_20)
                        );

dimc_macro i_dimc_macro_21(.clk(clk_i),
                          .WL(WL_QKV_21), 
                          .wdata(wdata_QKV_21), 
                          .ai(ai_QKV_21), 
                          .RE_(RE_QKV__21), 
                          .PREC(PREC_QKV_21),
                          .PREC_(PREC_QKV__21),
                          .result(result_QKV_21)
                        );

dimc_macro i_dimc_macro_22(.clk(clk_i),
                          .WL(WL_QKV_22), 
                          .wdata(wdata_QKV_22), 
                          .ai(ai_QKV_22), 
                          .RE_(RE_QKV__22), 
                          .PREC(PREC_QKV_22),
                          .PREC_(PREC_QKV__22),
                          .result(result_QKV_22)
                        );

dimc_macro i_dimc_macro_23(.clk(clk_i),
                          .WL(WL_QKV_23), 
                          .wdata(wdata_QKV_23), 
                          .ai(ai_QKV_23), 
                          .RE_(RE_QKV__23), 
                          .PREC(PREC_QKV_23),
                          .PREC_(PREC_QKV__23),
                          .result(result_QKV_23)
                        );

dimc_macro i_dimc_macro_24(.clk(clk_i),
                          .WL(WL_QKV_24), 
                          .wdata(wdata_QKV_24), 
                          .ai(ai_QKV_24), 
                          .RE_(RE_QKV__24), 
                          .PREC(PREC_QKV_24),
                          .PREC_(PREC_QKV__24),
                          .result(result_QKV_24)
                        );

dimc_macro i_dimc_macro_25(.clk(clk_i),
                          .WL(WL_QKV_25), 
                          .wdata(wdata_QKV_25), 
                          .ai(ai_QKV_25), 
                          .RE_(RE_QKV__25), 
                          .PREC(PREC_QKV_25),
                          .PREC_(PREC_QKV__25),
                          .result(result_QKV_25)
                        );

dimc_macro i_dimc_macro_26(.clk(clk_i),
                          .WL(WL_QKV_26), 
                          .wdata(wdata_QKV_26), 
                          .ai(ai_QKV_26), 
                          .RE_(RE_QKV__26), 
                          .PREC(PREC_QKV_26),
                          .PREC_(PREC_QKV__26),
                          .result(result_QKV_26)
                        );

dimc_macro i_dimc_macro_27(.clk(clk_i),
                          .WL(WL_QKV_27), 
                          .wdata(wdata_QKV_27), 
                          .ai(ai_QKV_27), 
                          .RE_(RE_QKV__27), 
                          .PREC(PREC_QKV_27),
                          .PREC_(PREC_QKV__27),
                          .result(result_QKV_27)
                        );

dimc_macro i_dimc_macro_28(.clk(clk_i),
                          .WL(WL_QKV_28), 
                          .wdata(wdata_QKV_28), 
                          .ai(ai_QKV_28), 
                          .RE_(RE_QKV__28), 
                          .PREC(PREC_QKV_28),
                          .PREC_(PREC_QKV__28),
                          .result(result_QKV_28)
                        );

dimc_macro i_dimc_macro_29(.clk(clk_i),
                          .WL(WL_QKV_29), 
                          .wdata(wdata_QKV_29), 
                          .ai(ai_QKV_29), 
                          .RE_(RE_QKV__29), 
                          .PREC(PREC_QKV_29),
                          .PREC_(PREC_QKV__29),
                          .result(result_QKV_29)
                        );

dimc_macro i_dimc_macro_30(.clk(clk_i),
                          .WL(WL_QKV_30), 
                          .wdata(wdata_QKV_30), 
                          .ai(ai_QKV_30), 
                          .RE_(RE_QKV__30), 
                          .PREC(PREC_QKV_30),
                          .PREC_(PREC_QKV__30),
                          .result(result_QKV_30)
                        );

dimc_macro i_dimc_macro_31(.clk(clk_i),
                          .WL(WL_QKV_31), 
                          .wdata(wdata_QKV_31), 
                          .ai(ai_QKV_31), 
                          .RE_(RE_QKV__31), 
                          .PREC(PREC_QKV_31),
                          .PREC_(PREC_QKV__31),
                          .result(result_QKV_31)
                        );

dimc_macro i_dimc_macro_32(.clk(clk_i),
                          .WL(WL_QKT_0), 
                          .wdata(wdata_QKT_0), 
                          .ai(ai_QKT_0), 
                          .RE_(RE_QKT__0), 
                          .PREC(PREC_QKT_0),
                          .PREC_(PREC_QKT__0),
                          .result(result_QKT_0)
                        );

dimc_macro i_dimc_macro_33(.clk(clk_i),
                          .WL(WL_QKT_1), 
                          .wdata(wdata_QKT_1), 
                          .ai(ai_QKT_1), 
                          .RE_(RE_QKT__1), 
                          .PREC(PREC_QKT_1),
                          .PREC_(PREC_QKT__1),
                          .result(result_QKT_1)
                        );

dimc_macro i_dimc_macro_34(.clk(clk_i),
                          .WL(WL_QKT_2), 
                          .wdata(wdata_QKT_2), 
                          .ai(ai_QKT_2), 
                          .RE_(RE_QKT__2), 
                          .PREC(PREC_QKT_2),
                          .PREC_(PREC_QKT__2),
                          .result(result_QKT_2)
                        );

dimc_macro i_dimc_macro_35(.clk(clk_i),
                          .WL(WL_QKT_3), 
                          .wdata(wdata_QKT_3), 
                          .ai(ai_QKT_3), 
                          .RE_(RE_QKT__3), 
                          .PREC(PREC_QKT_3),
                          .PREC_(PREC_QKT__3),
                          .result(result_QKT_3)
                        );

endmodule
