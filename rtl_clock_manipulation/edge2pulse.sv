// date 2024-10-09
// author Mace
// description: convert a edge signal (slow clock domain) to a pulse (fast domain)

module edge2pulse(
    input clk, // in fast clock domain
    input rst,
    input edge,
    output pulse
);

    reg edge_ff;
    
    always @(posedge clk) begin
        if(rst) begin
            edge_ff <= 1'b0;
        end
        else begin
            edge_ff <= edge;
        end
    end

    assign pulse = edge & ~(edge_ff);
    
endmodule