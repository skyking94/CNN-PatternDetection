`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    18:03:46 04/26/2017
// Design Name:
// Module Name:    convolution_stage2
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
module convolution_stage2 (
          in1,
          in2,
          in3,
          in4,
          in5,
          in6,
          in7,
          in8,
          clk,
          rst,
          start,
          conv_out
  );

//Input and Output declaration
input [99:0] in1, in2, in3, in4, in5, in6, in7, in8;
input         clk, rst, start;
output reg [7:0] conv_out;

//Internal registers and wires declaration
wire  [3:0]  in1_1, in1_2, in1_3, in1_4, in1_5, in1_6, in1_7, in1_8, in1_9, in1_10, in1_11, in1_12, in1_13;
wire [3:0]   in1_14, in1_15, in1_16, in1_17, in1_18, in1_19, in1_20, in1_21, in1_22, in1_23, in1_24, in1_25;
wire  [3:0]  in2_1, in2_2, in2_3, in2_4, in2_5, in2_6, in2_7, in2_8, in2_9, in2_10, in2_11, in2_12, in2_13;
wire [3:0]   in2_14, in2_15, in2_16, in2_17, in2_18, in2_19, in2_20, in2_21, in2_22, in2_23, in2_24, in2_25;
wire  [3:0]  in3_1, in3_2, in3_3, in3_4, in3_5, in3_6, in3_7, in3_8, in3_9, in3_10, in3_11, in3_12, in3_13;
wire [3:0]   in3_14, in3_15, in3_16, in3_17, in3_18, in3_19, in3_20, in3_21, in3_22, in3_23, in3_24, in3_25;
wire  [3:0]  in4_1, in4_2, in4_3, in4_4, in4_5, in4_6, in4_7, in4_8, in4_9, in4_10, in4_11, in4_12, in4_13;
wire [3:0]   in4_14, in4_15, in4_16, in4_17, in4_18, in4_19, in4_20, in4_21, in4_22, in4_23, in4_24, in4_25;
wire  [3:0]  in5_1, in5_2, in5_3, in5_4, in5_5, in5_6, in5_7, in5_8, in5_9, in5_10, in5_11, in5_12, in5_13;
wire [3:0]   in5_14, in5_15, in5_16, in5_17, in5_18, in5_19, in5_20, in5_21, in5_22, in5_23, in5_24, in5_25;
wire  [3:0]  in6_1, in6_2, in6_3, in6_4, in6_5, in6_6, in6_7, in6_8, in6_9, in6_10, in6_11, in6_12, in6_13;
wire [3:0]   in6_14, in6_15, in6_16, in6_17, in6_18, in6_19, in6_20, in6_21, in6_22, in6_23, in6_24, in6_25;
wire  [3:0]  in7_1, in7_2, in7_3, in7_4, in7_5, in7_6, in7_7, in7_8, in7_9, in7_10, in7_11, in7_12, in7_13;
wire [3:0]   in7_14, in7_15, in7_16, in7_17, in7_18, in7_19, in7_20, in7_21, in7_22, in7_23, in7_24, in7_25;
wire  [3:0]  in8_1, in8_2, in8_3, in8_4, in8_5, in8_6, in8_7, in8_8, in8_9, in8_10, in8_11, in8_12, in8_13;
wire [3:0]   in8_14, in8_15, in8_16, in8_17, in8_18, in8_19, in8_20, in8_21, in8_22, in8_23, in8_24, in8_25;
wire [8:0]   sum1, sum2, sum3, sum4;
wire  [7:0]  mul1_1, mul1_2, mul1_3, mul1_4, mul1_5, mul1_6, mul1_7, mul1_8, mul1_9, mul1_10, mul1_11, mul1_12, mul1_13;
wire [7:0]   mul1_14, mul1_15, mul1_16, mul1_17, mul1_18, mul1_19, mul1_20, mul1_21, mul1_22, mul1_23, mul1_24, mul1_25;
wire  [7:0]  mul2_1, mul2_2, mul2_3, mul2_4, mul2_5, mul2_6, mul2_7, mul2_8, mul2_9, mul2_10, mul2_11, mul2_12, mul2_13;
wire [7:0]   mul2_14, mul2_15, mul2_16, mul2_17, mul2_18, mul2_19, mul2_20, mul2_21, mul2_22, mul2_23, mul2_24, mul2_25;
wire  [7:0]  mul3_1, mul3_2, mul3_3, mul3_4, mul3_5, mul3_6, mul3_7, mul3_8, mul3_9, mul3_10, mul3_11, mul3_12, mul3_13;
wire [7:0]   mul3_14, mul3_15, mul3_16, mul3_17, mul3_18, mul3_19, mul3_20, mul3_21, mul3_22, mul3_23, mul3_24, mul3_25;
wire  [7:0]  mul4_1, mul4_2, mul4_3, mul4_4, mul4_5, mul4_6, mul4_7, mul4_8, mul4_9, mul4_10, mul4_11, mul4_12, mul4_13;
wire [7:0]   mul4_14, mul4_15, mul4_16, mul4_17, mul4_18, mul4_19, mul4_20, mul4_21, mul4_22, mul4_23, mul4_24, mul4_25;
wire [8:0]   temp_out;


//Top to bottom logic flow

//output logic
always @ ( posedge clk ) begin
  if (rst) begin
  conv_out  <=  0;
  end
  else
    begin
      conv_out <= temp_out[7:0];
    end
end


//determining input to multipliers from the module inputs

assign in1_1 	= (start) ? in1[99:96]   	: 4'h0;
assign in1_2 	= (start) ? in1[95:92]   	: 4'h0;
assign in1_3 	= (start) ? in1[91:88]   	: 4'h0;
assign in1_4 	= (start) ? in1[87:84]   	: 4'h0;
assign in1_5 	= (start) ? in1[83:80]   	: 4'h0;
assign in1_6 	= (start) ? in1[79:76]   	: 4'h0;
assign in1_7 	= (start) ? in1[75:72]   	: 4'h0;
assign in1_8 	= (start) ? in1[71:68]   	: 4'h0;
assign in1_9 	= (start) ? in1[67:64]   	: 4'h0;
assign in1_10 	= (start) ? in1[63:60]  	: 4'h0;
assign in1_11 	= (start) ? in1[59:56]  	: 4'h0;
assign in1_12 	= (start) ? in1[55:52]  	: 4'h0;
assign in1_13 	= (start) ? in1[51:48]  	: 4'h0;
assign in1_14	= (start) ? in1[47:44]  	: 4'h0;
assign in1_15 	= (start) ? in1[43:40]  	: 4'h0;
assign in1_16 	= (start) ? in1[39:36]  	: 4'h0;
assign in1_17 	= (start) ? in1[35:32]  	: 4'h0;
assign in1_18 	= (start) ? in1[31:28]  	: 4'h0;
assign in1_19 	= (start) ? in1[27:24]  	: 4'h0;
assign in1_20 	= (start) ? in1[23:20]  	: 4'h0;
assign in1_21 	= (start) ? in1[19:16]  	: 4'h0;
assign in1_22 	= (start) ? in1[15:12]  	: 4'h0;
assign in1_23 	= (start) ? in1[11:8]   	: 4'h0;
assign in1_24 	= (start) ? in1[7:4]    	: 4'h0;
assign in1_25 	= (start) ? in1[3:0]   		: 4'h0;

assign in2_1 	= (start) ? in2[99:96]   	: 4'h0;
assign in2_2 	= (start) ? in2[95:92]   	: 4'h0;
assign in2_3 	= (start) ? in2[91:88]   	: 4'h0;
assign in2_4 	= (start) ? in2[87:84]   	: 4'h0;
assign in2_5 	= (start) ? in2[83:80]   	: 4'h0;
assign in2_6 	= (start) ? in2[79:76]   	: 4'h0;
assign in2_7 	= (start) ? in2[75:72]   	: 4'h0;
assign in2_8 	= (start) ? in2[71:68]   	: 4'h0;
assign in2_9 	= (start) ? in2[67:64]   	: 4'h0;
assign in2_10 	= (start) ? in2[63:60]  	: 4'h0;
assign in2_11 	= (start) ? in2[59:56]  	: 4'h0;
assign in2_12 	= (start) ? in2[55:52]  	: 4'h0;
assign in2_13 	= (start) ? in2[51:48]  	: 4'h0;
assign in2_14	= (start) ? in2[47:44]  	: 4'h0;
assign in2_15 	= (start) ? in2[43:40]  	: 4'h0;
assign in2_16 	= (start) ? in2[39:36]  	: 4'h0;
assign in2_17 	= (start) ? in2[35:32]  	: 4'h0;
assign in2_18 	= (start) ? in2[31:28]  	: 4'h0;
assign in2_19 	= (start) ? in2[27:24]  	: 4'h0;
assign in2_20 	= (start) ? in2[23:20]  	: 4'h0;
assign in2_21 	= (start) ? in2[19:16]  	: 4'h0;
assign in2_22 	= (start) ? in2[15:12]  	: 4'h0;
assign in2_23 	= (start) ? in2[11:8]   	: 4'h0;
assign in2_24 	= (start) ? in2[7:4]    	: 4'h0;
assign in2_25 	= (start) ? in2[3:0]   		: 4'h0;

assign in3_1 	= (start) ? in1[99:96]   	: 4'h0;
assign in3_2 	= (start) ? in1[95:92]   	: 4'h0;
assign in3_3 	= (start) ? in1[91:88]   	: 4'h0;
assign in3_4 	= (start) ? in1[87:84]   	: 4'h0;
assign in3_5 	= (start) ? in1[83:80]   	: 4'h0;
assign in3_6 	= (start) ? in1[79:76]   	: 4'h0;
assign in3_7 	= (start) ? in1[75:72]   	: 4'h0;
assign in3_8 	= (start) ? in1[71:68]   	: 4'h0;
assign in3_9 	= (start) ? in1[67:64]   	: 4'h0;
assign in3_10 	= (start) ? in1[63:60]  	: 4'h0;
assign in3_11 	= (start) ? in1[59:56]  	: 4'h0;
assign in3_12 	= (start) ? in1[55:52]  	: 4'h0;
assign in3_13 	= (start) ? in1[51:48]  	: 4'h0;
assign in3_14	= (start) ? in1[47:44]  	: 4'h0;
assign in3_15 	= (start) ? in1[43:40]  	: 4'h0;
assign in3_16 	= (start) ? in1[39:36]  	: 4'h0;
assign in3_17 	= (start) ? in1[35:32]  	: 4'h0;
assign in3_18 	= (start) ? in1[31:28]  	: 4'h0;
assign in3_19 	= (start) ? in1[27:24]  	: 4'h0;
assign in3_20 	= (start) ? in1[23:20]  	: 4'h0;
assign in3_21 	= (start) ? in1[19:16]  	: 4'h0;
assign in3_22 	= (start) ? in1[15:12]  	: 4'h0;
assign in3_23 	= (start) ? in1[11:8]   	: 4'h0;
assign in3_24 	= (start) ? in1[7:4]    	: 4'h0;
assign in3_25 	= (start) ? in1[3:0]   		: 4'h0;

assign in4_1 	= (start) ? in1[99:96]   	: 4'h0;
assign in4_2 	= (start) ? in1[95:92]   	: 4'h0;
assign in4_3 	= (start) ? in1[91:88]   	: 4'h0;
assign in4_4 	= (start) ? in1[87:84]   	: 4'h0;
assign in4_5 	= (start) ? in1[83:80]   	: 4'h0;
assign in4_6 	= (start) ? in1[79:76]   	: 4'h0;
assign in4_7 	= (start) ? in1[75:72]   	: 4'h0;
assign in4_8 	= (start) ? in1[71:68]   	: 4'h0;
assign in4_9 	= (start) ? in1[67:64]   	: 4'h0;
assign in4_10 	= (start) ? in1[63:60]  	: 4'h0;
assign in4_11 	= (start) ? in1[59:56]  	: 4'h0;
assign in4_12 	= (start) ? in1[55:52]  	: 4'h0;
assign in4_13 	= (start) ? in1[51:48]  	: 4'h0;
assign in4_14	= (start) ? in1[47:44]  	: 4'h0;
assign in4_15 	= (start) ? in1[43:40]  	: 4'h0;
assign in4_16 	= (start) ? in1[39:36]  	: 4'h0;
assign in4_17 	= (start) ? in1[35:32]  	: 4'h0;
assign in4_18 	= (start) ? in1[31:28]  	: 4'h0;
assign in4_19 	= (start) ? in1[27:24]  	: 4'h0;
assign in4_20 	= (start) ? in1[23:20]  	: 4'h0;
assign in4_21 	= (start) ? in1[19:16]  	: 4'h0;
assign in4_22 	= (start) ? in1[15:12]  	: 4'h0;
assign in4_23 	= (start) ? in1[11:8]   	: 4'h0;
assign in4_24 	= (start) ? in1[7:4]    	: 4'h0;
assign in4_25 	= (start) ? in1[3:0]   		: 4'h0;

assign in5_1 	= (start) ? in1[99:96]   	: 4'h0;
assign in5_2 	= (start) ? in1[95:92]   	: 4'h0;
assign in5_3 	= (start) ? in1[91:88]   	: 4'h0;
assign in5_4 	= (start) ? in1[87:84]   	: 4'h0;
assign in5_5 	= (start) ? in1[83:80]   	: 4'h0;
assign in5_6 	= (start) ? in1[79:76]   	: 4'h0;
assign in5_7 	= (start) ? in1[75:72]   	: 4'h0;
assign in5_8 	= (start) ? in1[71:68]   	: 4'h0;
assign in5_9 	= (start) ? in1[67:64]   	: 4'h0;
assign in5_10 	= (start) ? in1[63:60]  	: 4'h0;
assign in5_11 	= (start) ? in1[59:56]  	: 4'h0;
assign in5_12 	= (start) ? in1[55:52]  	: 4'h0;
assign in5_13 	= (start) ? in1[51:48]  	: 4'h0;
assign in5_14	= (start) ? in1[47:44]  	: 4'h0;
assign in5_15 	= (start) ? in1[43:40]  	: 4'h0;
assign in5_16 	= (start) ? in1[39:36]  	: 4'h0;
assign in5_17 	= (start) ? in1[35:32]  	: 4'h0;
assign in5_18 	= (start) ? in1[31:28]  	: 4'h0;
assign in5_19 	= (start) ? in1[27:24]  	: 4'h0;
assign in5_20 	= (start) ? in1[23:20]  	: 4'h0;
assign in5_21 	= (start) ? in1[19:16]  	: 4'h0;
assign in5_22 	= (start) ? in1[15:12]  	: 4'h0;
assign in5_23 	= (start) ? in1[11:8]   	: 4'h0;
assign in5_24 	= (start) ? in1[7:4]    	: 4'h0;
assign in5_25 	= (start) ? in1[3:0]   		: 4'h0;

assign in6_1 	= (start) ? in1[99:96]   	: 4'h0;
assign in6_2 	= (start) ? in1[95:92]   	: 4'h0;
assign in6_3 	= (start) ? in1[91:88]   	: 4'h0;
assign in6_4 	= (start) ? in1[87:84]   	: 4'h0;
assign in6_5 	= (start) ? in1[83:80]   	: 4'h0;
assign in6_6 	= (start) ? in1[79:76]   	: 4'h0;
assign in6_7 	= (start) ? in1[75:72]   	: 4'h0;
assign in6_8 	= (start) ? in1[71:68]   	: 4'h0;
assign in6_9 	= (start) ? in1[67:64]   	: 4'h0;
assign in6_10 	= (start) ? in1[63:60]  	: 4'h0;
assign in6_11 	= (start) ? in1[59:56]  	: 4'h0;
assign in6_12 	= (start) ? in1[55:52]  	: 4'h0;
assign in6_13 	= (start) ? in1[51:48]  	: 4'h0;
assign in6_14	= (start) ? in1[47:44]  	: 4'h0;
assign in6_15 	= (start) ? in1[43:40]  	: 4'h0;
assign in6_16 	= (start) ? in1[39:36]  	: 4'h0;
assign in6_17 	= (start) ? in1[35:32]  	: 4'h0;
assign in6_18 	= (start) ? in1[31:28]  	: 4'h0;
assign in6_19 	= (start) ? in1[27:24]  	: 4'h0;
assign in6_20 	= (start) ? in1[23:20]  	: 4'h0;
assign in6_21 	= (start) ? in1[19:16]  	: 4'h0;
assign in6_22 	= (start) ? in1[15:12]  	: 4'h0;
assign in6_23 	= (start) ? in1[11:8]   	: 4'h0;
assign in6_24 	= (start) ? in1[7:4]    	: 4'h0;
assign in6_25 	= (start) ? in1[3:0]   		: 4'h0;

assign in7_1 	= (start) ? in1[99:96]   	: 4'h0;
assign in7_2 	= (start) ? in1[95:92]   	: 4'h0;
assign in7_3 	= (start) ? in1[91:88]   	: 4'h0;
assign in7_4 	= (start) ? in1[87:84]   	: 4'h0;
assign in7_5 	= (start) ? in1[83:80]   	: 4'h0;
assign in7_6 	= (start) ? in1[79:76]   	: 4'h0;
assign in7_7 	= (start) ? in1[75:72]   	: 4'h0;
assign in7_8 	= (start) ? in1[71:68]   	: 4'h0;
assign in7_9 	= (start) ? in1[67:64]   	: 4'h0;
assign in7_10 	= (start) ? in1[63:60]  	: 4'h0;
assign in7_11 	= (start) ? in1[59:56]  	: 4'h0;
assign in7_12 	= (start) ? in1[55:52]  	: 4'h0;
assign in7_13 	= (start) ? in1[51:48]  	: 4'h0;
assign in7_14	= (start) ? in1[47:44]  	: 4'h0;
assign in7_15 	= (start) ? in1[43:40]  	: 4'h0;
assign in7_16 	= (start) ? in1[39:36]  	: 4'h0;
assign in7_17 	= (start) ? in1[35:32]  	: 4'h0;
assign in7_18 	= (start) ? in1[31:28]  	: 4'h0;
assign in7_19 	= (start) ? in1[27:24]  	: 4'h0;
assign in7_20 	= (start) ? in1[23:20]  	: 4'h0;
assign in7_21 	= (start) ? in1[19:16]  	: 4'h0;
assign in7_22 	= (start) ? in1[15:12]  	: 4'h0;
assign in7_23 	= (start) ? in1[11:8]   	: 4'h0;
assign in7_24 	= (start) ? in1[7:4]    	: 4'h0;
assign in7_25 	= (start) ? in1[3:0]   		: 4'h0;

assign in8_1 	= (start) ? in1[99:96]   	: 4'h0;
assign in8_2 	= (start) ? in1[95:92]   	: 4'h0;
assign in8_3 	= (start) ? in1[91:88]   	: 4'h0;
assign in8_4 	= (start) ? in1[87:84]   	: 4'h0;
assign in8_5 	= (start) ? in1[83:80]   	: 4'h0;
assign in8_6 	= (start) ? in1[79:76]   	: 4'h0;
assign in8_7 	= (start) ? in1[75:72]   	: 4'h0;
assign in8_8 	= (start) ? in1[71:68]   	: 4'h0;
assign in8_9 	= (start) ? in1[67:64]   	: 4'h0;
assign in8_10 	= (start) ? in1[63:60]  	: 4'h0;
assign in8_11 	= (start) ? in1[59:56]  	: 4'h0;
assign in8_12 	= (start) ? in1[55:52]  	: 4'h0;
assign in8_13 	= (start) ? in1[51:48]  	: 4'h0;
assign in8_14	= (start) ? in1[47:44]  	: 4'h0;
assign in8_15 	= (start) ? in1[43:40]  	: 4'h0;
assign in8_16 	= (start) ? in1[39:36]  	: 4'h0;
assign in8_17 	= (start) ? in1[35:32]  	: 4'h0;
assign in8_18 	= (start) ? in1[31:28]  	: 4'h0;
assign in8_19 	= (start) ? in1[27:24]  	: 4'h0;
assign in8_20 	= (start) ? in1[23:20]  	: 4'h0;
assign in8_21 	= (start) ? in1[19:16]  	: 4'h0;
assign in8_22 	= (start) ? in1[15:12]  	: 4'h0;
assign in8_23 	= (start) ? in1[11:8]   	: 4'h0;
assign in8_24 	= (start) ? in1[7:4]    	: 4'h0;
assign in8_25 	= (start) ? in1[3:0]   		: 4'h0;


//generating all multiplications

assign mul1_1 = (start) ? (in1_1 * in5_1) : 8'h00;
assign mul1_2 = (start) ? (in1_2 * in5_2) : 8'h00;
assign mul1_3 = (start) ? (in1_3 * in5_3) : 8'h00;
assign mul1_4 = (start) ? (in1_4 * in5_4) : 8'h00;
assign mul1_5 = (start) ? (in1_5 * in5_5) : 8'h00;
assign mul1_6 = (start) ? (in1_6 * in5_6) : 8'h00;
assign mul1_7 = (start) ? (in1_7 * in5_7) : 8'h00;
assign mul1_8 = (start) ? (in1_8 * in5_8) : 8'h00;
assign mul1_9 = (start) ? (in1_9 * in5_9) : 8'h00;
assign mul1_10 = (start) ? (in1_10 * in5_10) : 8'h00;
assign mul1_11 = (start) ? (in1_11 * in5_11) : 8'h00;
assign mul1_12 = (start) ? (in1_12 * in5_12) : 8'h00;
assign mul1_13 = (start) ? (in1_13 * in5_13) : 8'h00;
assign mul1_14 = (start) ? (in1_14 * in5_14) : 8'h00;
assign mul1_15 = (start) ? (in1_15 * in5_15) : 8'h00;
assign mul1_16 = (start) ? (in1_16 * in5_16) : 8'h00;
assign mul1_17 = (start) ? (in1_17 * in5_17) : 8'h00;
assign mul1_18 = (start) ? (in1_18 * in5_18) : 8'h00;
assign mul1_19 = (start) ? (in1_19 * in5_19) : 8'h00;
assign mul1_20 = (start) ? (in1_20 * in5_20) : 8'h00;
assign mul1_21 = (start) ? (in1_21 * in5_21) : 8'h00;
assign mul1_22 = (start) ? (in1_22 * in5_22) : 8'h00;
assign mul1_23 = (start) ? (in1_23 * in5_23) : 8'h00;
assign mul1_24 = (start) ? (in1_24 * in5_24) : 8'h00;
assign mul1_25 = (start) ? (in1_25 * in5_25) : 8'h00;

assign mul2_1 = (start) ? (in2_1 * in6_1) : 8'h00;
assign mul2_2 = (start) ? (in2_2 * in6_2) : 8'h00;
assign mul2_3 = (start) ? (in2_3 * in6_3) : 8'h00;
assign mul2_4 = (start) ? (in2_4 * in6_4) : 8'h00;
assign mul2_5 = (start) ? (in2_5 * in6_5) : 8'h00;
assign mul2_6 = (start) ? (in2_6 * in6_6) : 8'h00;
assign mul2_7 = (start) ? (in2_7 * in6_7) : 8'h00;
assign mul2_8 = (start) ? (in2_8 * in6_8) : 8'h00;
assign mul2_9 = (start) ? (in2_9 * in6_9) : 8'h00;
assign mul2_10 = (start) ? (in2_10 * in6_10) : 8'h00;
assign mul2_11 = (start) ? (in2_11 * in6_11) : 8'h00;
assign mul2_12 = (start) ? (in2_12 * in6_12) : 8'h00;
assign mul2_13 = (start) ? (in2_13 * in6_13) : 8'h00;
assign mul2_14 = (start) ? (in2_14 * in6_14) : 8'h00;
assign mul2_15 = (start) ? (in2_15 * in6_15) : 8'h00;
assign mul2_16 = (start) ? (in2_16 * in6_16) : 8'h00;
assign mul2_17 = (start) ? (in2_17 * in6_17) : 8'h00;
assign mul2_18 = (start) ? (in2_18 * in6_18) : 8'h00;
assign mul2_19 = (start) ? (in2_19 * in6_19) : 8'h00;
assign mul2_20 = (start) ? (in2_20 * in6_20) : 8'h00;
assign mul2_21 = (start) ? (in2_21 * in6_21) : 8'h00;
assign mul2_22 = (start) ? (in2_22 * in6_22) : 8'h00;
assign mul2_23 = (start) ? (in2_23 * in6_23) : 8'h00;
assign mul2_24 = (start) ? (in2_24 * in6_24) : 8'h00;
assign mul2_25 = (start) ? (in2_25 * in6_25) : 8'h00;

assign mul3_1 = (start) ? (in3_1 * in7_1) : 8'h00;
assign mul3_2 = (start) ? (in3_2 * in7_2) : 8'h00;
assign mul3_3 = (start) ? (in3_3 * in7_3) : 8'h00;
assign mul3_4 = (start) ? (in3_4 * in7_4) : 8'h00;
assign mul3_5 = (start) ? (in3_5 * in7_5) : 8'h00;
assign mul3_6 = (start) ? (in3_6 * in7_6) : 8'h00;
assign mul3_7 = (start) ? (in3_7 * in7_7) : 8'h00;
assign mul3_8 = (start) ? (in3_8 * in7_8) : 8'h00;
assign mul3_9 = (start) ? (in3_9 * in7_9) : 8'h00;
assign mul3_10 = (start) ? (in3_10 * in7_10) : 8'h00;
assign mul3_11 = (start) ? (in3_11 * in7_11) : 8'h00;
assign mul3_12 = (start) ? (in3_12 * in7_12) : 8'h00;
assign mul3_13 = (start) ? (in3_13 * in7_13) : 8'h00;
assign mul3_14 = (start) ? (in3_14 * in7_14) : 8'h00;
assign mul3_15 = (start) ? (in3_15 * in7_15) : 8'h00;
assign mul3_16 = (start) ? (in3_16 * in7_16) : 8'h00;
assign mul3_17 = (start) ? (in3_17 * in7_17) : 8'h00;
assign mul3_18 = (start) ? (in3_18 * in7_18) : 8'h00;
assign mul3_19 = (start) ? (in3_19 * in7_19) : 8'h00;
assign mul3_20 = (start) ? (in3_20 * in7_20) : 8'h00;
assign mul3_21 = (start) ? (in3_21 * in7_21) : 8'h00;
assign mul3_22 = (start) ? (in3_22 * in7_22) : 8'h00;
assign mul3_23 = (start) ? (in3_23 * in7_23) : 8'h00;
assign mul3_24 = (start) ? (in3_24 * in7_24) : 8'h00;
assign mul3_25 = (start) ? (in3_25 * in7_25) : 8'h00;

assign mul4_1 = (start) ? (in4_1 * in8_1) : 8'h00;
assign mul4_2 = (start) ? (in4_2 * in8_2) : 8'h00;
assign mul4_3 = (start) ? (in4_3 * in8_3) : 8'h00;
assign mul4_4 = (start) ? (in4_4 * in8_4) : 8'h00;
assign mul4_5 = (start) ? (in4_5 * in8_5) : 8'h00;
assign mul4_6 = (start) ? (in4_6 * in8_6) : 8'h00;
assign mul4_7 = (start) ? (in4_7 * in8_7) : 8'h00;
assign mul4_8 = (start) ? (in4_8 * in8_8) : 8'h00;
assign mul4_9 = (start) ? (in4_9 * in8_9) : 8'h00;
assign mul4_10 = (start) ? (in4_10 * in8_10) : 8'h00;
assign mul4_11 = (start) ? (in4_11 * in8_11) : 8'h00;
assign mul4_12 = (start) ? (in4_12 * in8_12) : 8'h00;
assign mul4_13 = (start) ? (in4_13 * in8_13) : 8'h00;
assign mul4_14 = (start) ? (in4_14 * in8_14) : 8'h00;
assign mul4_15 = (start) ? (in4_15 * in8_15) : 8'h00;
assign mul4_16 = (start) ? (in4_16 * in8_16) : 8'h00;
assign mul4_17 = (start) ? (in4_17 * in8_17) : 8'h00;
assign mul4_18 = (start) ? (in4_18 * in8_18) : 8'h00;
assign mul4_19 = (start) ? (in4_19 * in8_19) : 8'h00;
assign mul4_20 = (start) ? (in4_20 * in8_20) : 8'h00;
assign mul4_21 = (start) ? (in4_21 * in8_21) : 8'h00;
assign mul4_22 = (start) ? (in4_22 * in8_22) : 8'h00;
assign mul4_23 = (start) ? (in4_23 * in8_23) : 8'h00;
assign mul4_24 = (start) ? (in4_24 * in8_24) : 8'h00;
assign mul4_25 = (start) ? (in4_25 * in8_25) : 8'h00;

//generating all summation of multiplications

assign sum1 = mul1_1 + mul1_2 + mul1_3 + mul1_4 + mul1_5 + mul1_6 + mul1_7 + mul1_8 + mul1_9 + mul1_10 + mul1_11 + mul1_12 + mul1_13 + mul1_14 +
              mul1_15 + mul1_16 + mul1_17 + mul1_18 + mul1_19 + mul1_20 + mul1_21 + mul1_22 + mul1_23 + mul1_24 + mul1_25;
assign sum2 = mul2_1 + mul2_2 + mul2_3 + mul2_4 + mul2_5 + mul2_6 + mul2_7 + mul2_8 + mul2_9 + mul2_10 + mul2_11 + mul2_12 + mul2_13 + mul2_14 +
              mul2_15 + mul2_16 + mul2_17 + mul2_18 + mul2_19 + mul2_20 + mul2_21 + mul2_22 + mul2_23 + mul2_24 + mul2_25;
assign sum3 = mul3_1 + mul3_2 + mul3_3 + mul3_4 + mul3_5 + mul3_6 + mul3_7 + mul3_8 + mul3_9 + mul3_10 + mul3_11 + mul3_12 + mul3_13 + mul3_14 +
              mul3_15 + mul3_16 + mul3_17 + mul3_18 + mul3_19 + mul3_20 + mul3_21 + mul3_22 + mul3_23 + mul3_24 + mul3_25;
assign sum4 = mul4_1 + mul4_2 + mul4_3 + mul4_4 + mul4_5 + mul4_6 + mul4_7 + mul4_8 + mul4_9 + mul4_10 + mul4_11 + mul4_12 + mul4_13 + mul4_14 +
              mul4_15 + mul4_16 + mul4_17 + mul4_18 + mul4_19 + mul4_20 + mul4_21 + mul4_22 + mul4_23 + mul4_24 + mul4_25;

//generating output from summation of all multiplications
assign temp_out = sum1  + sum3 + sum2  + sum3  + sum4;


endmodule //convolution_stage2
