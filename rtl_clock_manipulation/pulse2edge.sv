// date 2024-10-09
// author Mace
// description: convert a pulse signal (fast clock domain) to a edge (slow domain)
//              that is to extend the pulse width to 2x the width of the fast clock

module pulse2edge(
    input clk, // in fast clock domain
    input rst,
    input pulse,
    output edge
);

    reg count;
    reg pulse_ff;

    always @(posedge clk) begin
        if (rst) count <= 0;
        else if (count == 1) count <= 0;
        else count <= count + 1;
    end

endmodule