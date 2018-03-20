`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:17:01 04/27/2017
// Design Name:   main
// Module Name:   C:/Aakash/CMPE650/projectCMPE650/tb_main_stage1_only.v
// Project Name:  projectCMPE650
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

module tb_main_stage1_only;

	// Inputs
	reg clk;
	reg rst;
	reg extra;

	// Outputs
	wire stage1;
	wire stage2;
	wire stage3;
	wire stage4;
	wire stage5;
	wire HS;
	wire VS;
	wire [3:0] red;
	wire [3:0] green;
	wire [3:0] blue;
	wire hfree;
	wire vfree;
	wire done;
	reg go;

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
		.extra(extra)
	);

always
	begin
		#10 clk = ~clk;
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		extra = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 1;
		#100;
		rst = 0;
		//#200000000;
      go = 1; 
		// Add stimulus here
		//$stop;
	end
      
endmodule

