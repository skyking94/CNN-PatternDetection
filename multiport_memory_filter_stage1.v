`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:56:34 04/26/2017 
// Design Name: 
// Module Name:    multiport_memory_filter_stage1 
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
module multiport_memory_filter_stage1(
    clk,
    rst,
    addrin,
    dataout1,
    dataout2,
    dataout3,
    dataout4,
    dataout5,
    dataout6,
    dataout7,
    dataout8,
    dataout9,
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
input			[9:0]		addrin, inputmat_col, inputmat_row;
input			[0:0]		datain;
output reg	[0:0]			dataout1, dataout2, dataout3, dataout4, dataout5, dataout6, dataout7, dataout8, dataout9;
output	reg				ack;

//Wire and registers declaration
reg	[9:0]	first_addr;
reg				rd_in, wr_in, ena_in, sel_in;
wire	[9:0]	secnd_addr, third_addr, forth_addr, fifth_addr, sixth_addr, seven_addr, eight_addr, ninth_addr;
reg	[0:0]		out1, out2, out3, out4, out5, out6, out7, out8, out9;
wire				wr_rd;
wire	[9:0]	col_check;
reg				sel, offset_en;
reg	[9:0]	addr_offset;
wire	[9:0]	var;
reg			check;

//determining memory
reg [0:0] sample_image [0:809];

	initial
		begin
			$readmemh ("grey_filter.txt",sample_image);
		end

parameter last_addr = 10'h329;


//determining first address and taking input
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

//generating address for 9 outputs

assign wr_rd = rd_in & ~wr_in;


assign secnd_addr = first_addr + 1;
assign third_addr = secnd_addr + 1;
assign forth_addr = first_addr + 27;//inputmat_col;//) : (third_addr + inputmat_row);
assign fifth_addr = forth_addr + 1;
assign sixth_addr = fifth_addr + 1;
assign seven_addr = first_addr + 54;//inputmat_col;//) : (sixth_addr + inputmat_row);
assign eight_addr = first_addr + 55;
assign ninth_addr = first_addr + 56;


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
		sample_image[first_addr] = datain[0:0];
		/*sample_image[secnd_addr] = datain[15:8];
		sample_image[third_addr] = datain[23:16];
		sample_image[forth_addr] = datain[31:24];
		sample_image[fifth_addr] = datain[39:32];
		sample_image[sixth_addr] = datain[47:40];
		sample_image[seven_addr] = datain[55:48];
		sample_image[eight_addr] = datain[63:56];
		sample_image[ninth_addr] = datain[71:64];*/
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

always @ (posedge clk)
	begin
		if (sel)
			begin
				out1	<=	sample_image[first_addr + addr_offset];
				out2	<=	sample_image[secnd_addr + addr_offset];
				out3	<=	sample_image[third_addr + addr_offset];
				out4	<=	sample_image[forth_addr + addr_offset];
				out5	<=	sample_image[fifth_addr + addr_offset];
				out6	<=	sample_image[sixth_addr + addr_offset];
				out7	<=	sample_image[seven_addr + addr_offset];
				out8	<=	sample_image[eight_addr + addr_offset];
				out9	<=	sample_image[ninth_addr + addr_offset];
			end
		else
			begin
				out1	<=	0;
				out2	<=	0;
				out3	<=	0;
				out4	<=	0;
				out5	<=	0;
				out6	<=	0;
				out7	<=	0;
				out8	<=	0;
				out9	<=	0;
			end
	end
	

//output data declaration
/*assign out1 = sel ? sample_image[first_addr] : sample_image[first_addr + addr_offset];
assign out2 = sel ? sample_image[secnd_addr] : sample_image[secnd_addr + addr_offset];
assign out3 = sel ? sample_image[third_addr] : sample_image[third_addr + addr_offset];
assign out4 = sel ? sample_image[forth_addr] : sample_image[forth_addr + addr_offset];
assign out5 = sel ? sample_image[fifth_addr] : sample_image[fifth_addr + addr_offset];
assign out6 = sel ? sample_image[sixth_addr] : sample_image[sixth_addr + addr_offset];
assign out7 = sel ? sample_image[seven_addr] : sample_image[seven_addr + addr_offset];
assign out8 = sel ? sample_image[eight_addr] : sample_image[eight_addr + addr_offset];
assign out9 = sel ? sample_image[ninth_addr] : sample_image[ninth_addr + addr_offset];*/

//always block to generate 'sel' logic and also control 'addr_offset' value

assign	var		=	check?	var+25	:	var;
assign col_check	=	inputmat_row	+	var;

always @ (*)
	begin
		if (col_check	==	addrin)
			begin
				sel <= 1;
				offset_en <= 1;
				check	<=	1;
			end
		else
			begin
				sel <= 1;
				offset_en <= 0;
				check	<=	0;
			end
	end

//address offset generation
always @ (*)
	begin
		if (rst)
			addr_offset <= 0;
		else	if (offset_en)
			addr_offset <= addr_offset + 2;
		else
			addr_offset <= addr_offset;
	end

always @ (posedge clk)
	begin
		if (last_addr == ninth_addr)
			begin
				ack	<=	1;
			end
	end

endmodule //multiport memory for filter of Stage 1

