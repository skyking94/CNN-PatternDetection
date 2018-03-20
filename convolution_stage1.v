`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:58:27 04/27/2017 
// Design Name: 
// Module Name:    convolution_stage1 
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
module convolution_stage1(
					in1,
					in2, 
					in3,
					in4,
					in5,
					in6,
					in7,
					in8,
					in9,
					out
					);

input		[0:0]		in1, in2, in3, in4, in5, in6, in7, in8, in9;
output 	[3:0]		out;

assign out	=	(4*in4) - in2 - in4 - in6 - in8;


endmodule
