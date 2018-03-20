////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   21:45:23 02/22/2017
// Design Name:   vgaPulse
// Module Name:
// Project Name:  vga_2
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: vgaPulse
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////
module vgaPulse(input clk,
					 input [21:0]stage1,				//96 for Horizontal & 2 for Vertical (Passed from top module)
					 input [21:0]stage2,				//144 for Horizontal & 35 for Vertical (Passed from top module)
					 input [21:0]stage3,				//784 for Horizontal & 515 for Vertical (Passed from top module)
					 input [21:0]endStage,			//800 for Horizontal & 525 for Vertical (Passed from top module)
					 output syncPulse,				// Sync pulse HS or VS
					 output free,						// singla indicating pixel can be passed to VGA port
					 output [10:0]position);			// position of the pixel
					 //input	en);						// enable this module


// Temporary registers
reg [12:0] count;
reg inc;
reg[10:0] posCount;
reg S0,S1,S2,S3;
reg free_reg,sp;

assign position=posCount;
assign free=free_reg;
assign syncPulse=sp;


always @ *
begin

inc<=(count>endStage);

S0<=(((count>22'd0)||(count==22'd0))&&(count<stage1)||(count==endStage));;// && en;
S1<=(((count>stage1)||(count==stage1))&&(count<stage2));// && en;
S2<=(((count>stage2)||(count==stage2))&&(count<stage3));// && en;						// C > 144 or C = 144 && C < 784 --> free to display for 640
S3<=(((count>stage3)||(count==stage3))&&(count<endStage));// && en;
end

always@(negedge clk) begin

free_reg<=S2;							// free at S2 for displaying
sp<=S1||S2||S3;						// Syncpulse if either of S1,S2 or S3 are 1

end

always@(posedge clk) begin						// All always blocks run in parallel so this block will
	case(free)										// check for updated status of free and inc at every posedge
		0:posCount=0;
		1:posCount=posCount+1;
	endcase
	case(inc)
		1:count=0;
		0:count=count+1;
	endcase
end

endmodule
