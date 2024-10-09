// date 2024-10-09
// author Mace
// description: This module is used to divide the input clock frequency by 2

module clock_divider(
    input clk,
    input rst,
    output reg clk_out
);

    reg [1:0] count;

    always @(posedge clk) begin
        if(rst) begin
            count <= 2'b00;
            clk_out <= 1'b0;
        end
        else begin
            if(count == 2'b00) begin
                count <= 2'b01;
                clk_out <= 1'b1;
            end
            else if(count == 2'b01) begin
                count <= 2'b10;
                clk_out <= 1'b0;
            end
            else if(count == 2'b10) begin
                count <= 2'b11;
                clk_out <= 1'b1;
            end
            else begin
                count <= 2'b00;
                clk_out <= 1'b0;
            end
        end
    end

endmodule