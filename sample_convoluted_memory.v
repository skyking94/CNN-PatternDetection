`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    20:46:02 04/26/2017
// Design Name:
// Module Name:    sample_convoluted_memory
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
module sample_convoluted_memory(
    clk,
    rst,
    addrin,
    dataout1,
    dataout2,
    dataout3,
    dataout4,
  /*  dataout5,
    dataout6,
    dataout7,
    dataout8,
    dataout9,*/
	 datain,
    inputmat_row,
    inputmat_col,
    ena,
    wr,
    rd,
	 ack
  );


//Input and output declaration
input							clk, rst, ena, wr, rd;
input			[17:0]		addrin, inputmat_col, inputmat_row;
input			[3:0]		datain;
output reg	[99:0]			dataout1, dataout2, dataout3, dataout4;//, dataout5, dataout6, dataout7, dataout8, dataout9;
output	reg				ack;

//Wire and registers declaration
reg	[17:0]	first_addr;
reg				rd_in, wr_in, ena_in, sel_in;
wire	[17:0]		secnd_addr, third_addr, forth_addr, fifth_addr, sixth_addr, seven_addr, eight_addr, ninth_addr;
wire	[99:0]		out1, out2, out3, out4;//, out5, out6, out7, out8, out9;
wire				wr_rd;
wire	[17:0]	col_check;
reg				sel, offset_en;
reg	[17:0]	addr_offset;
reg [17:0] var;
reg  [3:0]  out1_1, out1_2, out1_3, out1_4, out1_5, out1_6, out1_7, out1_8, out1_9, out1_10, out1_11, out1_12, out1_13;
reg [3:0]   out1_14, out1_15, out1_16, out1_17, out1_18, out1_19, out1_20, out1_21, out1_22, out1_23, out1_24, out1_25;
reg  [3:0]  out2_1, out2_2, out2_3, out2_4, out2_5, out2_6, out2_7, out2_8, out2_9, out2_10, out2_11, out2_12, out2_13;
reg [3:0]   out2_14, out2_15, out2_16, out2_17, out2_18, out2_19, out2_20, out2_21, out2_22, out2_23, out2_24, out2_25;
reg  [3:0]  out3_1, out3_2, out3_3, out3_4, out3_5, out3_6, out3_7, out3_8, out3_9, out3_10, out3_11, out3_12, out3_13;
reg [3:0]   out3_14, out3_15, out3_16, out3_17, out3_18, out3_19, out3_20, out3_21, out3_22, out3_23, out3_24, out3_25;
reg  [3:0]  out4_1, out4_2, out4_3, out4_4, out4_5, out4_6, out4_7, out4_8, out4_9, out4_10, out4_11, out4_12, out4_13;
reg [3:0]   out4_14, out4_15, out4_16, out4_17, out4_18, out4_19, out4_20, out4_21, out4_22, out4_23, out4_24, out4_25;
wire  [17:0]  addr1_1, addr1_2, addr1_3, addr1_4, addr1_5, addr1_6, addr1_7, addr1_8, addr1_9, addr1_10, addr1_11, addr1_12, addr1_13;
wire [17:0]   addr1_14, addr1_15, addr1_16, addr1_17, addr1_18, addr1_19, addr1_20, addr1_21, addr1_22, addr1_23, addr1_24, addr1_25;
wire  [17:0]  addr2_1, addr2_2, addr2_3, addr2_4, addr2_5, addr2_6, addr2_7, addr2_8, addr2_9, addr2_10, addr2_11, addr2_12, addr2_13;
wire [17:0]   addr2_14, addr2_15, addr2_16, addr2_17, addr2_18, addr2_19, addr2_20, addr2_21, addr2_22, addr2_23, addr2_24, addr2_25;
wire  [17:0]  addr3_1, addr3_2, addr3_3, addr3_4, addr3_5, addr3_6, addr3_7, addr3_8, addr3_9, addr3_10, addr3_11, addr3_12, addr3_13;
wire [17:0]   addr3_14, addr3_15, addr3_16, addr3_17, addr3_18, addr3_19, addr3_20, addr3_21, addr3_22, addr3_23, addr3_24, addr3_25;
wire  [17:0]  addr4_1, addr4_2, addr4_3, addr4_4, addr4_5, addr4_6, addr4_7, addr4_8, addr4_9, addr4_10, addr4_11, addr4_12, addr4_13;
wire [17:0]   addr4_14, addr4_15, addr4_16, addr4_17, addr4_18, addr4_19, addr4_20, addr4_21, addr4_22, addr4_23, addr4_24, addr4_25;

//determining memory
reg [3:0] sample_conv_image [0:148043];


//generating 100 addresses
assign addr1_1 = first_addr + addr_offset;
assign addr1_2 = first_addr + 1 + addr_offset;
assign addr1_3 = first_addr + 2 + addr_offset;
assign addr1_4 = first_addr + 3 + addr_offset;
assign addr1_5 = first_addr + 4 + addr_offset;
assign addr1_6 = first_addr + 5 + addr_offset;
assign addr1_7 = first_addr + 6 + addr_offset;
assign addr1_8 = first_addr + 7 + addr_offset;
assign addr1_9 = first_addr + 8 + addr_offset;
assign addr1_10 = first_addr + 9 +  addr_offset;
assign addr1_11 = first_addr + 10 + addr_offset;
assign addr1_12 = first_addr + 11 + addr_offset;
assign addr1_13 = first_addr + 12 + addr_offset;
assign addr1_14 = first_addr + 13 + addr_offset;
assign addr1_15 = first_addr + 14 + addr_offset;
assign addr1_16 = first_addr + 15 + addr_offset;
assign addr1_17 = first_addr + 16 + addr_offset;
assign addr1_18 = first_addr + 17 + addr_offset;
assign addr1_19 = first_addr + 18 + addr_offset;
assign addr1_20 = first_addr + 19 + addr_offset;
assign addr1_21 = first_addr + 20 + addr_offset;
assign addr1_22 = first_addr + 21 + addr_offset;
assign addr1_23 = first_addr + 22 + addr_offset;
assign addr1_24 = first_addr + 23 + addr_offset;
assign addr1_25 = first_addr + 24 + addr_offset;

assign addr2_1 = first_addr + 338 + addr_offset;
assign addr2_2 = first_addr + 339 + addr_offset;
assign addr2_3 = first_addr + 340 + addr_offset;
assign addr2_4 = first_addr + 341 + addr_offset;
assign addr2_5 = first_addr + 342 + addr_offset;
assign addr2_6 = first_addr + 343 + addr_offset;
assign addr2_7 = first_addr + 344 + addr_offset;
assign addr2_8 = first_addr + 345 + addr_offset;
assign addr2_9 = first_addr + 346 + addr_offset;
assign addr2_10 = first_addr + 347 +  addr_offset;
assign addr2_11 = first_addr + 348 + addr_offset;
assign addr2_12 = first_addr + 349 + addr_offset;
assign addr2_13 = first_addr + 350 + addr_offset;
assign addr2_14 = first_addr + 351 + addr_offset;
assign addr2_15 = first_addr + 352 + addr_offset;
assign addr2_16 = first_addr + 353 + addr_offset;
assign addr2_17 = first_addr + 354 + addr_offset;
assign addr2_18 = first_addr + 355 + addr_offset;
assign addr2_19 = first_addr + 356 + addr_offset;
assign addr2_20 = first_addr + 357 + addr_offset;
assign addr2_21 = first_addr + 358 + addr_offset;
assign addr2_22 = first_addr + 359 + addr_offset;
assign addr2_23 = first_addr + 360 + addr_offset;
assign addr2_24 = first_addr + 361 + addr_offset;
assign addr2_25 = first_addr + 362 + addr_offset;

assign addr3_1 = first_addr + 676 + addr_offset;
assign addr3_2 = first_addr + 677 + addr_offset;
assign addr3_3 = first_addr + 678 + addr_offset;
assign addr3_4 = first_addr + 679 + addr_offset;
assign addr3_5 = first_addr + 680 + addr_offset;
assign addr3_6 = first_addr + 681 + addr_offset;
assign addr3_7 = first_addr + 682 + addr_offset;
assign addr3_8 = first_addr + 683 + addr_offset;
assign addr3_9 = first_addr + 684 + addr_offset;
assign addr3_10 = first_addr + 685 +  addr_offset;
assign addr3_11 = first_addr + 686 + addr_offset;
assign addr3_12 = first_addr + 687 + addr_offset;
assign addr3_13 = first_addr + 688 + addr_offset;
assign addr3_14 = first_addr + 689 + addr_offset;
assign addr3_15 = first_addr + 690 + addr_offset;
assign addr3_16 = first_addr + 691 + addr_offset;
assign addr3_17 = first_addr + 692 + addr_offset;
assign addr3_18 = first_addr + 693 + addr_offset;
assign addr3_19 = first_addr + 694 + addr_offset;
assign addr3_20 = first_addr + 695 + addr_offset;
assign addr3_21 = first_addr + 696 + addr_offset;
assign addr3_22 = first_addr + 697 + addr_offset;
assign addr3_23 = first_addr + 698 + addr_offset;
assign addr3_24 = first_addr + 699 + addr_offset;
assign addr3_25 = first_addr + 700 + addr_offset;

assign addr4_1 = first_addr + 1014 + addr_offset;
assign addr4_2 = first_addr + 1015 + addr_offset;
assign addr4_3 = first_addr + 1016 + addr_offset;
assign addr4_4 = first_addr + 1017 + addr_offset;
assign addr4_5 = first_addr + 1018 + addr_offset;
assign addr4_6 = first_addr + 1019 + addr_offset;
assign addr4_7 = first_addr + 1020 + addr_offset;
assign addr4_8 = first_addr + 1021 + addr_offset;
assign addr4_9 = first_addr + 1022 + addr_offset;
assign addr4_10 = first_addr + 1023 +  addr_offset;
assign addr4_11 = first_addr + 1024 + addr_offset;
assign addr4_12 = first_addr + 1025 + addr_offset;
assign addr4_13 = first_addr + 1026 + addr_offset;
assign addr4_14 = first_addr + 1027 + addr_offset;
assign addr4_15 = first_addr + 1028 + addr_offset;
assign addr4_16 = first_addr + 1029 + addr_offset;
assign addr4_17 = first_addr + 1030 + addr_offset;
assign addr4_18 = first_addr + 1031 + addr_offset;
assign addr4_19 = first_addr + 1032 + addr_offset;
assign addr4_20 = first_addr + 1033 + addr_offset;
assign addr4_21 = first_addr + 1034 + addr_offset;
assign addr4_22 = first_addr + 1035 + addr_offset;
assign addr4_23 = first_addr + 1036 + addr_offset;
assign addr4_24 = first_addr + 1037 + addr_offset;
assign addr4_25 = first_addr + 1038 + addr_offset;

//
always @ (posedge clk)
	begin
		if (rd_in)
			begin
				out1_1 	<= sample_conv_image[addr1_1];
 				out1_2 	<= sample_conv_image[addr1_2];
 				out1_3 	<= sample_conv_image[addr1_3];
 				out1_4 	<= sample_conv_image[addr1_4];
 				out1_5 	<= sample_conv_image[addr1_5];
 				out1_6 	<= sample_conv_image[addr1_6];
 				out1_7 	<= sample_conv_image[addr1_7];
 				out1_8 	<= sample_conv_image[addr1_8];
 				out1_9 	<= sample_conv_image[addr1_9];
 				out1_10 <=  sample_conv_image[addr1_10];
				out1_11 <= sample_conv_image[addr1_11];
				out1_12 <= sample_conv_image[addr1_12];
				out1_13 <= sample_conv_image[addr1_13];
				out1_14 <= sample_conv_image[addr1_14];
				out1_15 <= sample_conv_image[addr1_15];
				out1_16 <= sample_conv_image[addr1_16];
				out1_17 <= sample_conv_image[addr1_17];
				out1_18 <= sample_conv_image[addr1_18];
				out1_19 <= sample_conv_image[addr1_19];
				out1_20 <= sample_conv_image[addr1_20];
				out1_21 <= sample_conv_image[addr1_21];
				out1_22 <= sample_conv_image[addr1_22];
				out1_23 <= sample_conv_image[addr1_23];
				out1_24 <= sample_conv_image[addr1_24];
				out1_25 <= sample_conv_image[addr1_25];
				out2_1 <= sample_conv_image[addr2_1];
				out2_2 <= sample_conv_image[addr2_2];
				out2_3 <= sample_conv_image[addr2_3];
				out2_4 <= sample_conv_image[addr2_4];
				out2_5 <= sample_conv_image[addr2_5];
				out2_6 <= sample_conv_image[addr2_6];
				out2_7 <= sample_conv_image[addr2_7];
				out2_8 <= sample_conv_image[addr2_8];
				out2_9 <= sample_conv_image[addr2_9];
				out2_10 <= sample_conv_image[addr2_10];
				out2_11 <= sample_conv_image[addr2_11];
				out2_12 <= sample_conv_image[addr2_12];
				out2_13 <= sample_conv_image[addr2_13];
				out2_14 <= sample_conv_image[addr2_14];
				out2_15 <= sample_conv_image[addr2_15];
				out2_16 <= sample_conv_image[addr2_16];
				out2_17 <= sample_conv_image[addr2_17];
				out2_18 <= sample_conv_image[addr2_18];
				out2_19 <= sample_conv_image[addr2_19];
				out2_20 <= sample_conv_image[addr2_20];
				out2_21 <= sample_conv_image[addr2_21];
				out2_22 <= sample_conv_image[addr2_22];
				out2_23 <= sample_conv_image[addr2_23];
				out2_24 <= sample_conv_image[addr2_24];
				out2_25 <= sample_conv_image[addr2_25];

				out3_1 	<= sample_conv_image[addr3_1];
				out3_2 	<= sample_conv_image[addr3_2];
				out3_3 	<= sample_conv_image[addr3_3];
				out3_4 	<= sample_conv_image[addr3_4];
				out3_5 	<= sample_conv_image[addr3_5];
				out3_6 	<= sample_conv_image[addr3_6];
				out3_7 	<= sample_conv_image[addr3_7];
				out3_8 	<= sample_conv_image[addr3_8];
				out3_9 	<= sample_conv_image[addr3_9]; 	
				out3_10 <= sample_conv_image[addr3_10];
				out3_11 <= sample_conv_image[addr3_11];
				out3_12 <= sample_conv_image[addr3_12];
				out3_13 <= sample_conv_image[addr3_13];
				out3_14 <= sample_conv_image[addr3_14];
				out3_15 <= sample_conv_image[addr3_15];
				out3_16 <= sample_conv_image[addr3_16];
				out3_17 <= sample_conv_image[addr3_17];
				out3_18 <= sample_conv_image[addr3_18];
				out3_19 <= sample_conv_image[addr3_19];
				out3_20 <= sample_conv_image[addr3_20];
				out3_21 <= sample_conv_image[addr3_21];
				out3_22 <= sample_conv_image[addr3_22];
				out3_23 <= sample_conv_image[addr3_23];
				out3_24 <= sample_conv_image[addr3_24];
				out3_25 <= sample_conv_image[addr3_25]; 	

				out4_1 <= sample_conv_image[addr4_1]; 	
				out4_2 <= sample_conv_image[addr4_2]; 	
				out4_3 <= sample_conv_image[addr4_3]; 	
				out4_4 <= sample_conv_image[addr4_4]; 	
				out4_5 <= sample_conv_image[addr4_5]; 	
				out4_6 <= sample_conv_image[addr4_6]; 	
				out4_7 <= sample_conv_image[addr4_7]; 	
				out4_8 <= sample_conv_image[addr4_8]; 	
				out4_9 <= sample_conv_image[addr4_9]; 	
				out4_10 <= sample_conv_image[addr4_10];
				out4_11 <= sample_conv_image[addr4_11];
				out4_12 <= sample_conv_image[addr4_12];
				out4_13 <= sample_conv_image[addr4_13];
				out4_14 <= sample_conv_image[addr4_14];
				out4_15 <= sample_conv_image[addr4_15];
				out4_16 <= sample_conv_image[addr4_16];
				out4_17 <= sample_conv_image[addr4_17];
				out4_18 <= sample_conv_image[addr4_18];
				out4_19 <= sample_conv_image[addr4_19];
				out4_20 <= sample_conv_image[addr4_20];
				out4_21 <= sample_conv_image[addr4_21];
				out4_22 <= sample_conv_image[addr4_22];
				out4_23 <= sample_conv_image[addr4_23];
				out4_24 <= sample_conv_image[addr4_24];
				out4_25 <= sample_conv_image[addr4_25];
			end
	end
	
/*	

assign out1_1 = (rd_in) ? sample_conv_image[addr1_1] : 4'h0;
assign out1_2 = (rd_in) ? sample_conv_image[addr1_2] : 4'h0;
assign out1_3 = (rd_in) ? sample_conv_image[addr1_3] : 4'h0;
assign out1_4 = (rd_in) ? sample_conv_image[addr1_4] : 4'h0;
assign out1_5 = (rd_in) ? sample_conv_image[addr1_5] : 4'h0;
assign out1_6 = (rd_in) ? sample_conv_image[addr1_6] : 4'h0;
assign out1_7 = (rd_in) ? sample_conv_image[addr1_7] : 4'h0;
assign out1_8 = (rd_in) ? sample_conv_image[addr1_8] : 4'h0;
assign out1_9 = (rd_in) ? sample_conv_image[addr1_9] : 4'h0;
assign out1_10 = (rd_in) ? sample_conv_image[addr1_10] : 4'h0;
assign out1_11 = (rd_in) ? sample_conv_image[addr1_11] : 4'h0;
assign out1_12 = (rd_in) ? sample_conv_image[addr1_12] : 4'h0;
assign out1_13 = (rd_in) ? sample_conv_image[addr1_13] : 4'h0;
assign out1_14 = (rd_in) ? sample_conv_image[addr1_14] : 4'h0;
assign out1_15 = (rd_in) ? sample_conv_image[addr1_15] : 4'h0;
assign out1_16 = (rd_in) ? sample_conv_image[addr1_16] : 4'h0;
assign out1_17 = (rd_in) ? sample_conv_image[addr1_17] : 4'h0;
assign out1_18 = (rd_in) ? sample_conv_image[addr1_18] : 4'h0;
assign out1_19 = (rd_in) ? sample_conv_image[addr1_19] : 4'h0;
assign out1_20 = (rd_in) ? sample_conv_image[addr1_20] : 4'h0;
assign out1_21 = (rd_in) ? sample_conv_image[addr1_21] : 4'h0;
assign out1_22 = (rd_in) ? sample_conv_image[addr1_22] : 4'h0;
assign out1_23 = (rd_in) ? sample_conv_image[addr1_23] : 4'h0;
assign out1_24 = (rd_in) ? sample_conv_image[addr1_24] : 4'h0;
assign out1_25 = (rd_in) ? sample_conv_image[addr1_25] : 4'h0;

assign out2_1 = (rd_in) ? sample_conv_image[addr2_1] : 4'h0;
assign out2_2 = (rd_in) ? sample_conv_image[addr2_2] : 4'h0;
assign out2_3 = (rd_in) ? sample_conv_image[addr2_3] : 4'h0;
assign out2_4 = (rd_in) ? sample_conv_image[addr2_4] : 4'h0;
assign out2_5 = (rd_in) ? sample_conv_image[addr2_5] : 4'h0;
assign out2_6 = (rd_in) ? sample_conv_image[addr2_6] : 4'h0;
assign out2_7 = (rd_in) ? sample_conv_image[addr2_7] : 4'h0;
assign out2_8 = (rd_in) ? sample_conv_image[addr2_8] : 4'h0;
assign out2_9 = (rd_in) ? sample_conv_image[addr2_9] : 4'h0;
assign out2_10 = (rd_in) ? sample_conv_image[addr2_10] : 4'h0;
assign out2_11 = (rd_in) ? sample_conv_image[addr2_11] : 4'h0;
assign out2_12 = (rd_in) ? sample_conv_image[addr2_12] : 4'h0;
assign out2_13 = (rd_in) ? sample_conv_image[addr2_13] : 4'h0;
assign out2_14 = (rd_in) ? sample_conv_image[addr2_14] : 4'h0;
assign out2_15 = (rd_in) ? sample_conv_image[addr2_15] : 4'h0;
assign out2_16 = (rd_in) ? sample_conv_image[addr2_16] : 4'h0;
assign out2_17 = (rd_in) ? sample_conv_image[addr2_17] : 4'h0;
assign out2_18 = (rd_in) ? sample_conv_image[addr2_18] : 4'h0;
assign out2_19 = (rd_in) ? sample_conv_image[addr2_19] : 4'h0;
assign out2_20 = (rd_in) ? sample_conv_image[addr2_20] : 4'h0;
assign out2_21 = (rd_in) ? sample_conv_image[addr2_21] : 4'h0;
assign out2_22 = (rd_in) ? sample_conv_image[addr2_22] : 4'h0;
assign out2_23 = (rd_in) ? sample_conv_image[addr2_23] : 4'h0;
assign out2_24 = (rd_in) ? sample_conv_image[addr2_24] : 4'h0;
assign out2_25 = (rd_in) ? sample_conv_image[addr2_25] : 4'h0;

assign out3_1 = (rd_in) ? sample_conv_image[addr3_1] : 4'h0;
assign out3_2 = (rd_in) ? sample_conv_image[addr3_2] : 4'h0;
assign out3_3 = (rd_in) ? sample_conv_image[addr3_3] : 4'h0;
assign out3_4 = (rd_in) ? sample_conv_image[addr3_4] : 4'h0;
assign out3_5 = (rd_in) ? sample_conv_image[addr3_5] : 4'h0;
assign out3_6 = (rd_in) ? sample_conv_image[addr3_6] : 4'h0;
assign out3_7 = (rd_in) ? sample_conv_image[addr3_7] : 4'h0;
assign out3_8 = (rd_in) ? sample_conv_image[addr3_8] : 4'h0;
assign out3_9 = (rd_in) ? sample_conv_image[addr3_9] : 4'h0;
assign out3_10 = (rd_in) ? sample_conv_image[addr3_10] : 4'h0;
assign out3_11 = (rd_in) ? sample_conv_image[addr3_11] : 4'h0;
assign out3_12 = (rd_in) ? sample_conv_image[addr3_12] : 4'h0;
assign out3_13 = (rd_in) ? sample_conv_image[addr3_13] : 4'h0;
assign out3_14 = (rd_in) ? sample_conv_image[addr3_14] : 4'h0;
assign out3_15 = (rd_in) ? sample_conv_image[addr3_15] : 4'h0;
assign out3_16 = (rd_in) ? sample_conv_image[addr3_16] : 4'h0;
assign out3_17 = (rd_in) ? sample_conv_image[addr3_17] : 4'h0;
assign out3_18 = (rd_in) ? sample_conv_image[addr3_18] : 4'h0;
assign out3_19 = (rd_in) ? sample_conv_image[addr3_19] : 4'h0;
assign out3_20 = (rd_in) ? sample_conv_image[addr3_20] : 4'h0;
assign out3_21 = (rd_in) ? sample_conv_image[addr3_21] : 4'h0;
assign out3_22 = (rd_in) ? sample_conv_image[addr3_22] : 4'h0;
assign out3_23 = (rd_in) ? sample_conv_image[addr3_23] : 4'h0;
assign out3_24 = (rd_in) ? sample_conv_image[addr3_24] : 4'h0;
assign out3_25 = (rd_in) ? sample_conv_image[addr3_25] : 4'h0;

assign out4_1 = (rd_in) ? sample_conv_image[addr4_1] : 4'h0;
assign out4_2 = (rd_in) ? sample_conv_image[addr4_2] : 4'h0;
assign out4_3 = (rd_in) ? sample_conv_image[addr4_3] : 4'h0;
assign out4_4 = (rd_in) ? sample_conv_image[addr4_4] : 4'h0;
assign out4_5 = (rd_in) ? sample_conv_image[addr4_5] : 4'h0;
assign out4_6 = (rd_in) ? sample_conv_image[addr4_6] : 4'h0;
assign out4_7 = (rd_in) ? sample_conv_image[addr4_7] : 4'h0;
assign out4_8 = (rd_in) ? sample_conv_image[addr4_8] : 4'h0;
assign out4_9 = (rd_in) ? sample_conv_image[addr4_9] : 4'h0;
assign out4_10 = (rd_in) ? sample_conv_image[addr4_10] : 4'h0;
assign out4_11 = (rd_in) ? sample_conv_image[addr4_11] : 4'h0;
assign out4_12 = (rd_in) ? sample_conv_image[addr4_12] : 4'h0;
assign out4_13 = (rd_in) ? sample_conv_image[addr4_13] : 4'h0;
assign out4_14 = (rd_in) ? sample_conv_image[addr4_14] : 4'h0;
assign out4_15 = (rd_in) ? sample_conv_image[addr4_15] : 4'h0;
assign out4_16 = (rd_in) ? sample_conv_image[addr4_16] : 4'h0;
assign out4_17 = (rd_in) ? sample_conv_image[addr4_17] : 4'h0;
assign out4_18 = (rd_in) ? sample_conv_image[addr4_18] : 4'h0;
assign out4_19 = (rd_in) ? sample_conv_image[addr4_19] : 4'h0;
assign out4_20 = (rd_in) ? sample_conv_image[addr4_20] : 4'h0;
assign out4_21 = (rd_in) ? sample_conv_image[addr4_21] : 4'h0;
assign out4_22 = (rd_in) ? sample_conv_image[addr4_22] : 4'h0;
assign out4_23 = (rd_in) ? sample_conv_image[addr4_23] : 4'h0;
assign out4_24 = (rd_in) ? sample_conv_image[addr4_24] : 4'h0;
assign out4_25 = (rd_in) ? sample_conv_image[addr4_25] : 4'h0;
*/
//output data logic

assign out4 = {out4_1,out4_2,out4_3,out4_4,out4_5,out4_6,out4_7,out4_8,out4_9,out4_10,out4_11,out4_12,out4_13
                ,out4_14,out4_15,out4_16,out4_17,out4_18,out4_19,out4_20,out4_21,out4_22,out4_23,out4_24,out4_25};
assign out3 = {out3_1,out3_2,out3_3,out3_4,out3_5,out3_6,out3_7,out3_8,out3_9,out3_10,out3_11,out3_12,out3_13
                ,out3_14,out3_15,out3_16,out3_17,out3_18,out3_19,out3_20,out3_21,out3_22,out3_23,out3_24,out3_25};
assign out2 = {out2_1,out2_2,out2_3,out2_4,out2_5,out2_6,out2_7,out2_8,out2_9,out2_10,out2_11,out2_12,out2_13
                ,out2_14,out2_15,out2_16,out2_17,out2_18,out2_19,out2_20,out2_21,out2_22,out2_23,out2_24,out2_25};
assign out1 = {out1_1,out1_2,out1_3,out1_4,out1_5,out1_6,out1_7,out1_8,out1_9,out1_10,out1_11,out1_12,out1_13
                ,out1_14,out1_15,out1_16,out1_17,out1_18,out1_19,out1_20,out1_21,out1_22,out1_23,out1_24,out1_25};



//determining first address and taking input

parameter last_addr = 18'h24633;

always @ ( posedge clk ) begin
  if (rst) begin
    first_addr <= 0;
  end
  else
    begin
      first_addr <= addrin;
      rd_in <= rd;
      wr_in <= wr;
      ena_in <= ena;
    end
end

always @ ( posedge clk ) begin
  if (rst) begin
    dataout1  <=  0;
    dataout2  <=  0;
    dataout3  <=  0;
    dataout4  <=  0;
  end
  else if (ena_in && wr_in) begin
    sample_conv_image[first_addr]  <=  datain;
  end
  else if (ena_in && rd_in) begin
    dataout1  <=  out1;
    dataout2  <=  out2;
    dataout3  <=  out3;
    dataout4  <=  out4;
  end
  else
    begin
      dataout1  <=  0;
      dataout2  <=  0;
      dataout3  <=  0;
      dataout4  <=  0;
    end
end



//always block to generate 'sel' logic and also control 'addr_offset' value

//assign  var = offset_en?  var+inputmat_col : var;
assign col_check	=	addrin - var;

always @ (*)
	begin
		if (rst)
			begin
				var <= 0;
			end
		else if (offset_en)
			begin
				var <= var + inputmat_col;
			end
		else
			begin	
				var <= var;
			end
	end

always @ (*)
	begin
		if (col_check > 0)
			begin
				sel <= 1;
				offset_en <= 0;
			end
		else if (col_check == 0)
			begin
				sel <= 1;
				offset_en <= 0;
			end
		else
			begin
				sel <= 0;
				offset_en <= 1;
			end
	end

//address offset generation
always @ (*)
	begin
		if (rst)
			addr_offset <= 0;
		else	if (offset_en)
			addr_offset <= addr_offset + 338;
		else
			addr_offset <= addr_offset;
	end

always @ (posedge clk)
	begin
		if (last_addr == addr4_25)
			begin
				ack	<=	1;
			end
    else
      begin
        ack<= 0;
      end
	end

endmodule //multiport memory for convoluted sample for Stage II

/*
//generating address for 9 outputs

assign wr_rd = rd_in & ~wr_in;

assign secnd_addr = first_addr + 1;
assign third_addr = secnd_addr + 1;
assign forth_addr = first_addr + inputmat_col;//) : (first_addr + inputmat_row);
assign fifth_addr = forth_addr + 1;
assign sixth_addr = fifth_addr + 1;
assign seven_addr = forth_addr + inputmat_col;//) : (forth_addr + inputmat_row);
assign eigth_addr = seven_addr + 1;
assign ninth_addr = eight_addr + 1;


//always block for output logic
always @ ( posedge clk ) begin
  if (rst)
	begin
		dataout1 <= 0;
		dataout2 <= 0;
		dataout3 <= 0;
		dataout4 <= 0;
		dataout5 <= 0;
		dataout6 <= 0;
		dataout7 <= 0;
		dataout8 <= 0;
		dataout9 <= 0;
	end
  else if (rd_in & ena_in)
	begin
		dataout1 <= out1;
		dataout2 <= out2;
		dataout3 <= out3;
		dataout4 <= out4;
		dataout5 <= out5;
		dataout6 <= out6;
		dataout7 <= out7;
		dataout8 <= out8;
		dataout9 <= out9;
	end
  else if (wr_in & ena_in)
	begin
		sample_conv_image[first_addr] = datain[7:0];
		sample_conv_image[secnd_addr] = datain[15:8];
		sample_conv_image[third_addr] = datain[23:16];
		sample_conv_image[forth_addr] = datain[31:24];
		sample_conv_image[fifth_addr] = datain[39:32];
		sample_conv_image[sixth_addr] = datain[47:40];
		sample_conv_image[seven_addr] = datain[55:48];
		sample_conv_image[eight_addr] = datain[63:56];
		sample_conv_image[ninth_addr] = datain[71:64];
	end
  else
	begin
		dataout1 <= 0;
		dataout2 <= 0;
		dataout3 <= 0;
		dataout4 <= 0;
		dataout5 <= 0;
		dataout6 <= 0;
		dataout7 <= 0;
		dataout8 <= 0;
		dataout9 <= 0;
	end
end

//output data declaration
assign out1 = sel ? sample_conv_image[first_addr] : sample_conv_image[first_addr + addr_offset];
assign out2 = sel ? sample_conv_image[secnd_addr] : sample_conv_image[secnd_addr + addr_offset];
assign out3 = sel ? sample_conv_image[third_addr] : sample_conv_image[third_addr + addr_offset];
assign out4 = sel ? sample_conv_image[forth_addr] : sample_conv_image[forth_addr + addr_offset];
assign out5 = sel ? sample_conv_image[fifth_addr] : sample_conv_image[fifth_addr + addr_offset];
assign out6 = sel ? sample_conv_image[sixth_addr] : sample_conv_image[sixth_addr + addr_offset];
assign out7 = sel ? sample_conv_image[seven_addr] : sample_conv_image[seven_addr + addr_offset];
assign out8 = sel ? sample_conv_image[eight_addr] : sample_conv_image[eight_addr + addr_offset];
assign out9 = sel ? sample_conv_image[ninth_addr] : sample_conv_image[ninth_addr + addr_offset];





*/
