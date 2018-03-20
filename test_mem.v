`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:12:43 05/05/2017 
// Design Name: 
// Module Name:    test_mem 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module test_mem(
			datain,
			clk,
			rst,
			en,
			wr,
			addrin
    );

input 		clk, rst, en, wr;
input		[31:0]	datain;
input		[16:0]	addrin;


reg	[31:0]	test_memory	[0 : 129053];

always @ (posedge clk)
	begin
		if (en && wr)
		test_memory[addrin]	<=	datain;
		else
		test_memory[addrin]	<=	0;
	end

endmodule
