`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:17:47 05/15/2017
// Design Name:   main
// Module Name:   C:/Aakash/CMPE650/finalproject_onebitin/tb_main_stage5.v
// Project Name:  finalproject_onebitin
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_main_stage5;

	// Inputs
	reg clk;
	reg rst;
	reg go;
	reg extra;
	reg ena_display;
	reg read_display;
	reg [16:0] addr_display;

	// Outputs
	wire stage1;
	wire stage2;
	wire stage3;
	wire stage4;
	wire stage5;
	wire done;
	wire dout_display;

	// Instantiate the Unit Under Test (UUT)
	main uut (
		.clk(clk), 
		.rst(rst), 
		.stage1(stage1), 
		.stage2(stage2), 
		.stage3(stage3), 
		.stage4(stage4), 
		.stage5(stage5), 
		.go(go), 
		.done(done), 
		.extra(extra), 
		.ena_display(ena_display), 
		.read_display(read_display), 
		//.addr_display(addr_display), 
		.dout_display(dout_display)
	);

always 
	begin
		#10 clk	=	~clk;
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		go = 0;
		extra = 0;
		ena_display = 0;
		read_display = 0;
		addr_display = 0;

		// Wait 100 ns for global reset to finish
		#100;
      rst	=	1;
		#100;
		rst	=	0;
		go		=	1;
		#100;
		//go	=	0;
		// Add stimulus here
		
		if (done && stage5)
			begin
				ena_display	=	1;
				read_display	=	1;
			end
			
		
	end
      
endmodule

