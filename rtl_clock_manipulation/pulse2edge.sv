// date 2024-10-09
// author Mace
// description: extend the 1-cycle pulse width to 2x the width in the fast clock domain

module pulse2edge(
    input clk, // in fast clock domain
    input rst,
    input pulse_narrow,
    output pulse_wide
);

    reg pulse_reg;  // Register to store the delayed pulse

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pulse_wide <= 1'b0;  // Reset the wide pulse
            pulse_reg <= 1'b0;   // Reset the delay register
        end else begin
            pulse_reg <= pulse_narrow;         // Delay the narrow pulse by one cycle
            pulse_wide <= pulse_narrow | pulse_reg; // Pulse is high if either current or delayed pulse is high
        end
    end

endmodule