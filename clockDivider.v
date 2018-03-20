////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   21:55:45 02/22/2017
// Design Name:   clockDiv
// Module Name:
// Project Name:  vga_2
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: clockDiv
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////
module clockDiv(input clk,
					 input [31:0]div,
					 output reg out);

reg [31:0] count;
reg inc;
reg max;

// All Always blocks run in parallel don't get confused

always begin 				// This block will execute continuously and will update 'inc'

max=div>>1;
inc=(count>max);

end

always@(posedge clk) begin
	case(inc)
	1:begin
		count=0;
		out=~out;
		end
	0:begin
		count=count+1;
		end
	endcase
end


endmodule
