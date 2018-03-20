`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    06:33:54 04/22/2017
// Design Name:
// Module Name:    main
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
module main(
					clk,
					rst,
					stage1,
					stage2,
					stage3,
					stage4,
					stage5,
					go,
					done,
					extra,
					HS,
					VS,
					red,
					green,
					blue,
					hFree,
					vFree
    );

//==================================================================================================================
//															Input & Output Declarations
//==================================================================================================================
input									clk, rst, extra, go;
//input									ena_display, read_display;
//input				[16:0]			addr_display;
output	reg						stage1, stage2, stage3, stage4, stage5;
output 	reg						done;
//output	reg						dout_display;
output								HS, VS, hFree, vFree;
output	reg		[3:0]				red, green, blue;



//===================================================================================================================
//															Registers & Wires Declaration
//===================================================================================================================
reg		[17:0]			addrin_s1_sample;
reg		[9:0]				addrin_s1_filter;
reg		[17:0]			addrin_s2_sample_stage1cntrl, addrin_s2_sample_stage2cntrl;
reg		[9:0]				addrin_s2_filter_stage1cntrl, addrin_s2_filter_stage2cntrl;
wire 	[17:0]			addrin_s2_sample;
wire 	[9:0]				addrin_s2_filter;


wire							dataout1_sample, dataout2_sample, dataout3_sample, dataout4_sample, dataout5_sample;
wire							dataout6_sample, dataout7_sample, dataout8_sample, dataout9_sample;
wire							dataout1_filter, dataout2_filter, dataout3_filter, dataout4_filter, dataout5_filter;
wire							dataout6_filter, dataout7_filter, dataout8_filter, dataout9_filter;
reg							wr_sample, rd_sample, ena_sample, wr_filter, rd_filter, ena_filter;
reg							wr_s2_sample_s1cntrl, rd_s2_sample_s1cntrl, ena_s2_sample_s1cntrl, wr_s2_filter_s1cntrl, rd_s2_filter_s1cntrl, ena_s2_filter_s1cntrl;
reg 							wr_s2_sample_s2cntrl, rd_s2_sample_s2cntrl, ena_s2_sample_s2cntrl, wr_s2_filter_s2cntrl, rd_s2_filter_s2cntrl, ena_s2_filter_s2cntrl;
wire 							wr_s2_sample, rd_s2_sample, ena_s2_sample, wr_s2_filter, rd_s2_filter, ena_s2_filter;
wire							ack_sample, ack_filter, ack_s2_filter, ack_s2_sample;
wire		[99:0]			dataout1_s2_filter, dataout2_s2_filter, dataout3_s2_filter, dataout4_s2_filter;//, dataout5_s2_filter;
//wire		[15:0]			dataout9_s2_filter, dataout8_s2_filter, dataout7_s2_filter, dataout6_s2_filter;
wire		[99:0]			dataout1_s2_sample, dataout2_s2_sample, dataout3_s2_sample, dataout4_s2_sample;//, dataout5_s2_sample;
//wire		[15:0]			dataout6_s2_sample, dataout7_s2_sample, dataout1_s8_sample, dataout9_s2_sample;
wire		[31:0]			temp_conv_out;
wire [15:0]				stage1_conv_out;
reg [2:0]		adder_address_in;
reg inc_adder_address;
reg ena_adder;
reg get_adder_out;
reg store_conv_out;
reg [7:0] adder_out;

reg	ena_display, rst_disp_mem_addr, display_en, inc_display_mem_s5;
reg	[16:0]	addr_display;


//-------------------------------------Register & wire declaration for Stage I FSM-----------------------------------

reg		[3:0]			current_s1, next_s1;
reg						get_filter_data_s1, get_sample_data_s1, get_filter_data_s2, get_sample_data_s2;
reg						process_filter_s1, process_sample_s1;
reg						store_sample_conv_s1, store_filter_conv_s1;
reg						sample_addr_inc_s1, filter_addr_inc_s1, sample_addr_inc_s2, filter_addr_inc_s2;
wire 						conv_in1, conv_in2, conv_in3, conv_in4, conv_in5, conv_in6, conv_in7, conv_in8, conv_in9;
wire 	[3:0]				conv_out;
reg 	[0:0]				temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9;
reg 	[15:0]			temp_out;
reg	[3:0]				datain_s2_filter, datain_s2_sample;
reg [99:0]				conv_in1_s2, conv_in2_s2, conv_in3_s2, conv_in4_s2, conv_in5_s2, conv_in6_s2, conv_in7_s2, conv_in8_s2;
reg 						inc_addr_fil_s2, inc_addr_sam_s2, en_conv_stage2, start_conv_s2, store_result_s2, inc_addr_test;
reg [16:0]				addrin_test_s2;
wire [16:0] 			addrin_test;
wire						finalmem_access;
wire [7:0]				dataout_final;

wire  ena_test, wr_test;
reg ena_test_s2, wr_test_s2;

reg						reset_stage_2_fil_addr_s1, reset_stage_2_fil_addr_s2, reset_stage_2_sam_addr;


reg ena_in, wr_in;
wire [7:0] in1, in2, in3, in4, in5, in6, in7;
wire [8:0] result;


//-------------------------------------------------------------------------------------------------------------------
//---------------------------------------Registers and Wires for FSM-------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------

reg							s1_ack, s2_ack, s3_ack, s4_ack, s5_ack;
reg							led1, led2, led3, led4, led5;
reg		[2:0]				current_main, next_main;

parameter		initial_main	=	3'b000,
					s1_main			=	3'b001,
					s2_main			=	3'b010,
					s3_main			=	3'b011,
					s4_main			=	3'b100,
					s5_main			=	3'b101;


//------------------------------------------Main FSM begin-------------------------------------------------------------
//On-reset next state logic
always @ (posedge clk)
	begin
		if (rst)
			begin
				current_main	<=		initial_main;
			end
		else
			begin
				current_main	<=		next_main;
			end
	end

//next state logic for Main FSM
always @ (*)
	begin
		case (current_main)
			initial_main	:		begin
											if (go)
												begin
													next_main <= s1_main;
												end
											else
												begin
													next_main <=	initial_main;
												end
										end
			s1_main			:		begin
											if (s1_ack)
												begin
													next_main	<=	s2_main;
												end
											else
												begin
													next_main	<=	s1_main;
												end
										end
			s2_main			:		begin
											if (s2_ack)
												begin
													next_main	<=	s3_main;
												end
											else
												begin
													next_main	<=	s2_main;
												end
										end
			s3_main			:		begin
											if (s3_ack)
												begin
													next_main	<=	s4_main;
												end
											else
												begin
													next_main	<=	s3_main;
												end
										end
			s4_main			:		begin
											if (s4_ack)
												begin
													next_main	<=	s5_main;
												end
											else
												begin
													next_main	<=	s4_main;
												end
										end
			s5_main			:		begin
											if (s5_ack)
												begin
													next_main	<=	initial_main;
												end
											else
												begin
													next_main	<=	s5_main;
												end
										end
		endcase
	end


//output logic for main FSM
always @ (*)
	begin
		case (current_main)
			initial_main	:	begin
										led1	=	0;
										led2	=	0;
										led3	=	0;
										led4	=	0;
										led5	=	0;
									end
			s1_main			:	begin
										led1	=	1;
									end
			s2_main			:	begin
										led2	=	1;
										//led1	=	1;
									end
			s3_main			:	begin
										led3	=	1;
										//led2	=	0;
									end
			s4_main			:	begin
										led4	=	1;
										//led3	=	0;
									end
			s5_main			:	begin
										led5	=	1;
										//led4	=	0;
									end
		endcase
	end
//------------------------------------Main FSM end-------------------------------------------------------------------

//---------------------------------------always block to register LED outputs----------------------------------------
always @ (posedge clk)
	begin
		stage1 <= led1;
		stage2 <= led2;
		stage3 <= led3;
		stage4 <= led4;
		stage5 <= led5;
	end


//===================================================================================================================
//															Stage I : First stage Convolution
//===================================================================================================================
//stage 1 led on
//declare two multiport memory and then use their values to convolute and store new values in another memory
//writing all 9 memory blocks in one cycle


//------------------------------------------SAMPLE MEMORY---------------------------------------------------
multiport_memory sample_image (
    .clk(clk),
    .rst(rst),
    .addrin(addrin_s1_sample),
    .dataout1(dataout1_sample),
    .dataout2(dataout2_sample),
    .dataout3(dataout3_sample),
    .dataout4(dataout4_sample),
    .dataout5(dataout5_sample),
    .dataout6(dataout6_sample),
    .dataout7(dataout7_sample),
    .dataout8(dataout8_sample),
    .dataout9(dataout9_sample),
    .datain(datain),
    .inputmat_row(18'h00151),
    .inputmat_col(18'h00154),
    .ena(ena_sample),
    .wr(wr_sample),
    .rd(rd_sample),
    .ack(ack_sample)
    );


//-----------------------------------------------FILTER MEMORY------------------------------------------------
multiport_memory_filter_stage1 filter_image (
    .clk(clk),
    .rst(rst),
    .addrin(addrin_s1_filter),
    .dataout1(dataout1_filter),
    .dataout2(dataout2_filter),
    .dataout3(dataout3_filter),
    .dataout4(dataout4_filter),
    .dataout5(dataout5_filter),
    .dataout6(dataout6_filter),
    .dataout7(dataout7_filter),
    .dataout8(dataout8_filter),
    .dataout9(dataout9_filter),
    .datain(datain_filter),
    .inputmat_row(10'h018),
    .inputmat_col(10'h01b),
    .ena(ena_filter),
    .wr(wr_filter),
    .rd(rd_filter),
    .ack(ack_filter)
    );

wire	[0:0]	temp_fil1, temp_fil2, temp_fil3, temp_fil4, temp_fil5, temp_fil6, temp_fil7, temp_fil8, temp_fil9;
wire	[0:0]	temp_sam1, temp_sam2, temp_sam3, temp_sam4, temp_sam5, temp_sam6, temp_sam7, temp_sam8, temp_sam9;

assign	temp_fil1	=	dataout1_filter;
assign	temp_fil2 	=	dataout2_filter;
assign	temp_fil3	=	dataout3_filter;
assign	temp_fil4	=	dataout4_filter;
assign	temp_fil5	=	dataout5_filter;
assign	temp_fil6	=	dataout6_filter;
assign	temp_fil7	=	dataout7_filter;
assign	temp_fil8	=	dataout8_filter;
assign	temp_fil9	=	dataout9_filter;

assign	temp_sam1	=	dataout1_sample;
assign	temp_sam2	=	dataout2_sample;
assign	temp_sam3	=	dataout3_sample;
assign	temp_sam4	=	dataout4_sample;
assign	temp_sam5	=	dataout5_sample;
assign	temp_sam6	=	dataout6_sample;
assign	temp_sam7	=	dataout7_sample;
assign	temp_sam8	=	dataout8_sample;
assign	temp_sam9	=	dataout9_sample;


//-------------------------------------------------------------------------------------------------------------------
//--------------------------------------FSM for First Stage Convolution----------------------------------------------
//-------------------------------------------------------------------------------------------------------------------






parameter	init					=		4'h00,
				get_filter			=		4'h01,
				process_filter		=		4'h02,
				store_filter		=		4'h03,
				check_filter		=		4'h04,
				done_filter			=		4'h05,
				get_sample			=		4'h06,
				process_sample		=		4'h07,
				store_sample		=		4'h08,
				check_sample		=		4'h09,
				done_sample			=		4'h0a,
				stage1_done			=		4'h0b;


//--------------------------------------------------FSM Begins-------------------------------------------------------------
//On reset logic
always @ (posedge clk)
	begin
		if (rst)
			begin
				current_s1	<=		init;
			end
		else
			begin
				current_s1	<=		next_s1;
			end
	end

//Next state logic
always @ (posedge clk)
	begin
		case (current_s1)
			init				:	begin
										if (led1)
											next_s1	<=		get_filter;
										else
											next_s1	<=		init;
									end
			get_filter		:	begin
											next_s1	<=		process_filter;
									end
			process_filter	:	begin
											next_s1	<=		store_filter;
									end
			store_filter	:	begin
											next_s1	<=		check_filter;
									end
			check_filter	:	begin
										if (addrin_s1_filter == 10'h2bc & ack_filter)
											next_s1	<=		done_filter;
										else
											next_s1	<=		get_filter;
									end
			done_filter		:	begin
											next_s1	<=		get_sample;
									end
			get_sample		:	begin
											next_s1	<=		process_sample;
									end
			process_sample	:	begin
											next_s1	<=		store_sample;
									end
			store_sample	:	begin
											next_s1	<=		check_sample;
									end
			check_sample	:	begin
										if(addrin_s1_sample==18'h24633 | ack_sample)
											next_s1	<=		done_sample;
										else
											next_s1	<=		get_sample;
									end
			done_sample		:	begin
											next_s1	<=		stage1_done;
									end
			stage1_done		:	begin
											next_s1	<=		init;
									end
		endcase
	end

//-------------------------------------------output logic for s1 FSM-------------------------------------------------
always @ (*)
	begin
		case (current_s1)
			init				:	begin
											s1_ack	=		0;//.......................................indicataes the start of Stage I FSM
									end
			get_filter		:	begin
											rd_filter	= 1;
											ena_filter	= 1;
											get_filter_data_s1 = 1;
											filter_addr_inc_s1	=	0;
											filter_addr_inc_s2	=	0;
									end
			process_filter	:	begin
											process_filter_s1	=	1;
									end
			store_filter	:	begin
											ena_s2_filter_s1cntrl	=	1;
											wr_s2_filter_s1cntrl	=	1;
											store_filter_conv_s1	=	1;
											//filter_addr_inc_s2	=	1;
									end
			check_filter	:	begin
											filter_addr_inc_s1	=	1;
											filter_addr_inc_s2	=	1;
									end
			done_filter		:	begin
											rd_filter	=	0;
											ena_filter	=	0;
											get_filter_data_s1	=	0;
											process_filter_s1		=	0;
											ena_s2_filter_s1cntrl			=	0;
											wr_s2_filter_s1cntrl			=	0;
											store_filter_conv_s1	=	0;
											filter_addr_inc_s1	=	0;
											reset_stage_2_fil_addr_s1	=	1;
									end
			get_sample		:	begin
											rd_sample	= 1;
											ena_sample	= 1;
											get_sample_data_s1 = 1;
											sample_addr_inc_s1	=	0;
											sample_addr_inc_s2	=	0;
											reset_stage_2_fil_addr_s1	=	0;
									end
			process_sample	:	begin
											process_sample_s1	=	1;
									end
			store_sample	:	begin
											ena_s2_sample_s1cntrl	=	1;
											wr_s2_sample_s1cntrl	=	1;
											store_sample_conv_s1	=	1;
											//sample_addr_inc_s2	=	1;
									end
			check_sample	:	begin
											sample_addr_inc_s1	=	1;
											sample_addr_inc_s2	=	1;
									end
			done_sample		:	begin
											rd_sample	=	0;
											ena_sample	=	0;
											get_sample_data_s1	=	0;
											process_sample_s1		=	0;
											ena_s2_sample_s1cntrl			=	0;
											wr_s2_sample_s1cntrl			=	0;
											store_sample_conv_s1	=	0;
											sample_addr_inc_s1	=	0;
											reset_stage_2_sam_addr	=	1;
									end
			stage1_done		:	begin
											s1_ack					=	1;
											reset_stage_2_sam_addr	=	0;
									end
		endcase
	end //------------------------------------------------------FSM ends------------------------------------------------

//-------------------------------------All always block controlled by the above state machine--------------------------

//always block to get data from filter memory at stage I
always @ ( * ) begin
	if (get_filter_data_s1) begin
		temp1 = temp_fil1;
		temp2	=	temp_fil2;
		temp3	=	temp_fil3;
		temp4	=	temp_fil4;
		temp5	=	temp_fil5;
		temp6	=	temp_fil6;
		temp7	=	temp_fil7;
		temp8	=	temp_fil8;
		temp9	=	temp_fil9;
		end
	else if (get_sample_data_s1) begin
		temp1 = temp_sam1;
		temp2	=	temp_sam2;
		temp3	=	temp_sam3;
		temp4	=	temp_sam4;
		temp5	=	temp_sam5;
		temp6	=	temp_sam6;
		temp7	=	temp_sam7;
		temp8	=	temp_sam8;
		temp9	=	temp_sam9;
	end
end

//always block to process / perform convolution on data from filter memory
assign	conv_in1	=	(process_filter_s1 | process_sample_s1) ? temp1 : 0;
assign	conv_in2	=	(process_filter_s1 | process_sample_s1) ? temp2 : 0;
assign	conv_in3	=	(process_filter_s1 | process_sample_s1) ? temp3 : 0;
assign	conv_in4	=	(process_filter_s1 | process_sample_s1) ? temp4 : 0;
assign	conv_in5	=	(process_filter_s1 | process_sample_s1) ? temp5 : 0;
assign	conv_in6	=	(process_filter_s1 | process_sample_s1) ? temp6 : 0;
assign	conv_in7	=	(process_filter_s1 | process_sample_s1) ? temp7 : 0;
assign	conv_in8	=	(process_filter_s1 | process_sample_s1) ? temp8 : 0;
assign	conv_in9	=	(process_filter_s1 | process_sample_s1) ? temp9 : 0;


//always block to store the processed data
always @ ( * ) begin
	if (store_filter_conv_s1) begin
		datain_s2_filter = stage1_conv_out;
	end
end

//always block to increment the address of the memory
always @ ( * ) begin
	if	(rst)	begin
		addrin_s1_filter	=	0;
		end
	else if (filter_addr_inc_s1) begin
		addrin_s1_filter = addrin_s1_filter + 1;
	end
end



//always block to store the processed data
always @ ( * ) begin
	if (store_sample_conv_s1) begin
		datain_s2_sample = stage1_conv_out;
	end
end

//always block to check how many times convolution is done
always @ ( * ) begin
	if	(rst)	begin
		addrin_s1_sample  = 0;
		end
	else if (sample_addr_inc_s1) begin
		addrin_s1_sample = addrin_s1_sample + 1;
	end
end

//always block to check how many times convolution is done
always @ ( * ) begin
	if	(rst | reset_stage_2_sam_addr)	begin
		addrin_s2_sample_stage1cntrl  = 0;
		end
	else if (sample_addr_inc_s2) begin
		addrin_s2_sample_stage1cntrl = addrin_s2_sample_stage1cntrl + 1;
	end
end

//always block to check how many times convolution is done
always @ ( * ) begin
	if	(rst | reset_stage_2_fil_addr_s1)	begin
		addrin_s2_filter_stage1cntrl  = 0;
		end
	else if (filter_addr_inc_s2) begin
		addrin_s2_filter_stage1cntrl = addrin_s2_filter_stage1cntrl + 1;
	end
end

//--------------------------------------------Convolution Block Instantiation----------------------------------------
convolution_stage1 conv_s1 (
    .in1(conv_in1), .in2(conv_in2), .in3(conv_in3), .in4(conv_in4), .in5(conv_in5), .in6(conv_in6), .in7(conv_in7),
    .in8(conv_in8), .in9(conv_in9), .out(conv_out)
    );
//--------------------------------------------Convolution Block ends--------------------------------------------------

assign stage1_conv_out = conv_out;


//===================================================================================================================
//															Stage II : Second stage Convolution
//===================================================================================================================
//stage 2 led on
//reading from two memories

//--------------------------------------------CONVOLUTED FILTER MEMORY------------------------------------------------
filter_convoluted_memory convoluted_filter (
    .clk(clk),
    .rst(rst),
    .addrin(addrin_s2_filter),
    .dataout1(dataout1_s2_filter),
    .dataout2(dataout2_s2_filter),
    .dataout3(dataout3_s2_filter),
    .dataout4(dataout4_s2_filter),
    .datain(datain_s2_filter),
    .inputmat_row(10'h1),
    .inputmat_col(10'h19),
    .ena(ena_s2_filter),
    .wr(wr_s2_filter),
    .rd(rd_s2_filter),
    .ack(ack_s2_filter)
    );

//----------------------------------------------CONVOLUTED SAMPLE MEMORY-------------------------------------------------
sample_convoluted_memory convoluted_sample (
    .clk(clk),
    .rst(rst),
    .addrin(addrin_s2_sample),
    .dataout1(dataout1_s2_sample),
    .dataout2(dataout2_s2_sample),
    .dataout3(dataout3_s2_sample),
    .dataout4(dataout4_s2_sample),
    .datain(datain_s2_sample),
    .inputmat_row(18'h00001),
    .inputmat_col(18'h00152),
    .ena(ena_s2_sample),
    .wr(wr_s2_sample),
    .rd(rd_s2_sample),
    .ack(ack_s2_sample)
    );
//---------------------------Intermediate address control logic between stage 1  and stage 2------------------------------------------
assign addrin_s2_sample	=	addrin_s2_sample_stage1cntrl | addrin_s2_sample_stage2cntrl;
assign addrin_s2_filter	=	addrin_s2_filter_stage1cntrl | addrin_s2_filter_stage2cntrl;
assign wr_s2_sample			=	wr_s2_sample_s1cntrl	| wr_s2_sample_s2cntrl;
assign rd_s2_sample 		= rd_s2_sample_s1cntrl	|	rd_s2_sample_s2cntrl;
assign ena_s2_sample		= ena_s2_sample_s1cntrl	|	ena_s2_sample_s2cntrl;
assign wr_s2_filter 		= wr_s2_filter_s1cntrl	|	wr_s2_filter_s2cntrl;
assign rd_s2_filter 		= rd_s2_filter_s1cntrl	|	rd_s2_filter_s2cntrl;
assign ena_s2_filter 		= ena_s2_filter_s1cntrl	|	ena_s2_filter_s2cntrl;
//----------------------------------------------logic ends---------------------------------------------------------------------------

//--------------------------------------------FSM for Stage II Begins-----------------------------------------------------------------
reg 	[3:0]		current_s2, next_s2;

parameter 		INITIAL_s2 		=	4'h0,
					GET_SAMPLE_s2	=	4'h1,
					GET_FILTER_s2	=	4'h2,
					PROCESS_s2		=	4'h3,
					QUEUE_s2			=	4'h4,
					INC_ADD_S2		=	4'h5,
					CHECK_ADDER		=	4'h6,
					STORE_s2			=	4'h7,
					CHECK_s2			=	4'h8,
					DONE_stage2		=	4'h9;


//ON RESET logic
always @ (posedge clk) begin
	if (rst) begin
		current_s2	<=	INITIAL_s2;
	end
	else
		begin
			current_s2	<=	next_s2;
		end
end

//next state logic
always @ (*) begin
	case (current_s2)
		INITIAL_s2:	begin
		 							if (led2) begin
		 								next_s2	<=	GET_SAMPLE_s2;
		 							end
									else
										begin
											next_s2	<=	INITIAL_s2;
										end
								end
		GET_SAMPLE_s2	:	begin
											next_s2	<=	GET_FILTER_s2;
										end
		GET_FILTER_s2	:	begin
											next_s2	<=	PROCESS_s2;
										end
		PROCESS_s2		:	begin
											next_s2	<=	QUEUE_s2;
										end
		QUEUE_s2			:	begin
											next_s2	<=	INC_ADD_S2;
										end
		INC_ADD_S2		:	begin
											next_s2	<=	CHECK_ADDER;
										end
		CHECK_ADDER		:	begin
											if (adder_address_in==3'h7) begin
												next_s2	<=	STORE_s2;
											end
											else
												next_s2	<=	GET_SAMPLE_s2;
											end
		STORE_s2			:	begin
											next_s2	<=	CHECK_s2;
										end
		CHECK_s2			:	begin
											if (addrin_test_s2==17'h1f81f)// | ack_s2_sample | ack_s2_filter)
											begin
												next_s2	<=	DONE_stage2;
											end
											else
												begin
													next_s2	<=	GET_SAMPLE_s2	;
												end
										end
		DONE_stage2		:	begin
									next_s2	<=	INITIAL_s2;
								end
		default				: next_s2	<=	INITIAL_s2;
	endcase
end

//output logic or control signals
always @ ( * ) begin
	case (current_s2)
		INITIAL_s2		: begin
											s2_ack	=	0;
										end
		GET_SAMPLE_s2	:	begin
											ena_s2_sample_s2cntrl	=	1;

											//get_conv_sample_s2		=	1;
											inc_addr_sam_s2				=	0;
											inc_addr_fil_s2				=	0;
											ena_test_s2							=	1;
											wr_test_s2								=	0;
											inc_addr_test					=	0;
											get_adder_out					=	0;
											
										end
		GET_FILTER_s2	:	begin
											ena_s2_filter_s2cntrl	=	1;
											rd_s2_sample_s2cntrl	=	1;
											//get_conv_filter_s2		=	1;
										end
		PROCESS_s2		:	begin
											en_conv_stage2				=	1;
											start_conv_s2					=	1;
											rd_s2_filter_s2cntrl	=	1;
										end
		QUEUE_s2			:	begin
											ena_adder							=	1;
											//store_conv_out				=	1;
										end
		INC_ADD_S2		:	begin
											store_conv_out				=	1;
											inc_adder_address			=	1;
										end
		CHECK_ADDER		:	begin
											inc_adder_address			=	0;
											store_conv_out				=	0;
											inc_addr_sam_s2				=	1;
											inc_addr_fil_s2				=	1;
										end
		STORE_s2			:	begin
											get_adder_out					=	1;
											//store_conv_out				=	1;
											ena_test_s2							=	1;
											wr_test_s2								=	1;
											rd_s2_sample_s2cntrl		=	0;
										end
		CHECK_s2			:	begin
											//store_conv_out				=	0;
											inc_addr_test					=	1;
											//rd_s2_sample_s2cntrl		=	0;
											ena_s2_sample_s2cntrl	=	0;
											ena_s2_filter_s2cntrl	=	0;
											rd_s2_filter_s2cntrl			=	0;
										end
	  DONE_stage2		:	begin
											s2_ack	=	1;
											inc_addr_sam_s2				=	0;
											inc_addr_fil_s2				=	0;
											ena_s2_sample_s2cntrl		=	0;
											rd_s2_sample_s2cntrl			=	0;
											ena_s2_filter_s2cntrl		=	0;
											rd_s2_filter_s2cntrl			=	0;
											ena_test_s2							=	0;
											wr_test_s2							=	0;
											inc_addr_test					=	0;
										end
		default				: begin
											inc_addr_sam_s2				=	0;
											inc_addr_fil_s2				=	0;
											ena_s2_sample_s2cntrl		=	0;
											rd_s2_sample_s2cntrl			=	0;
											ena_s2_filter_s2cntrl		=	0;
											rd_s2_filter_s2cntrl			=	0;
											ena_test_s2							=	0;
											wr_test_s2							=	0;
										end
	endcase
end



//--------------------all blocks to control the data transfer----------------------

//always block to increment address from sample_convoluted_memory & from filter_convoluted_memory
always @ (posedge clk) begin
	if (rst) begin
		addrin_s2_sample_stage2cntrl	<=	0;
		//addrin_s2_filter_stage2cntrl	<=	0;
	end
	else if (inc_addr_sam_s2) begin
		addrin_s2_sample_stage2cntrl	<=	addrin_s2_sample_stage2cntrl	+	1;
	end
	else
		begin
			//addrin_s2_filter_stage2cntrl	<=	addrin_s2_filter_stage2cntrl;
			addrin_s2_sample_stage2cntrl	<=	addrin_s2_sample_stage2cntrl;
		end
end

always @ (posedge clk) begin
	if (rst | ack_s2_filter) begin
		//addrin_s2_sample_stage2cntrl	<=	0;
		addrin_s2_filter_stage2cntrl	<=	0;
	end
	else if (inc_addr_fil_s2) begin
		addrin_s2_filter_stage2cntrl	<=	addrin_s2_filter_stage2cntrl	+	1;
	end
	else
		begin
			addrin_s2_filter_stage2cntrl	<=	addrin_s2_filter_stage2cntrl;
			//addrin_s2_sample_stage2cntrl	<=	addrin_s2_sample_stage2cntrl;
		end
end

//always block to get data
always @ (posedge clk) begin
	if (rst) begin
		conv_in1_s2	<=	0;
		conv_in2_s2	<=	0;
		conv_in3_s2	<=	0;
		conv_in4_s2	<=	0;
		conv_in5_s2	<=	0;
		conv_in6_s2	<=	0;
		conv_in7_s2	<=	0;
		conv_in8_s2	<=	0;
	end
	else  begin
	conv_in1_s2	<=	dataout1_s2_filter;
	conv_in2_s2	<=	dataout2_s2_filter;
	conv_in3_s2	<=	dataout3_s2_filter;
	conv_in4_s2	<=	dataout4_s2_filter;
	conv_in5_s2	<=	dataout1_s2_sample;
	conv_in6_s2	<=	dataout2_s2_sample;
	conv_in7_s2	<=	dataout3_s2_sample;
	conv_in8_s2	<=	dataout4_s2_sample;
	end
end

//always block to send & receive data from convolution stage Ii
//convolution block stage 2 Instantiation----->>>>
convolution_stage2 conv_s2 (
    .in1(conv_in1_s2),   .in2(conv_in2_s2),   .in3(conv_in3_s2),   .in4(conv_in4_s2),   .in5(conv_in5_s2),   .in6(conv_in6_s2),   .in7(conv_in7_s2),  .in8(conv_in8_s2),
    .clk(clk),   .rst(rst),   .start(start_conv_s2),   .conv_out(temp_conv_out)
    );

//always block to add seven convolution stage 2 outputs
always @ ( posedge clk ) begin
	if (rst) begin
		adder_address_in	<=	0;
	end
	else	if (inc_adder_address) begin
		adder_address_in	<=	adder_address_in	+	1;
	end
	else
		begin
			adder_address_in	<=	adder_address_in;
		end
end




/*
sever_adder conv_adder (
    .address_in(adder_address_in), .datain(temp_conv_out),  .en(ena_adder),  .clk(clk),  .rst(rst),
    .wr(store_conv_out), .output_en(get_adder_out), .out(adder_out)
    );
*/

always @ (posedge clk) begin
	if (rst | reset_addrin_test) begin
		addrin_test_s2	<=	0;
	end
	else if (inc_addr_test) begin
		addrin_test_s2	<=	addrin_test_s2	+ 1;
	end
	else
		begin
			addrin_test_s2	<=	addrin_test_s2;
		end
end



assign in1 = (adder_address_in==3'h0 && store_conv_out && ena_adder)? temp_conv_out : in1;
assign in2 = (adder_address_in==3'h1 && store_conv_out && ena_adder)? temp_conv_out : in2;
assign in3 = (adder_address_in==3'h2 && store_conv_out && ena_adder)? temp_conv_out : in3;
assign in4 = (adder_address_in==3'h3 && store_conv_out && ena_adder)? temp_conv_out : in4;
assign in5 = (adder_address_in==3'h4 && store_conv_out && ena_adder)? temp_conv_out : in5;
assign in6 = (adder_address_in==3'h5 && store_conv_out && ena_adder)? temp_conv_out : in6;
assign in7 = (adder_address_in==3'h6 && store_conv_out && ena_adder)? temp_conv_out : in7;


assign result = in1 + in2 + in3 + in4 + in5 + in6 + in7;


//always block to store the data
//IP Core Instantiation-------------------->>>>


always @ ( posedge clk ) begin
  if (rst) begin
    adder_out <= 0;
  end
  else if (ena_adder && get_adder_out && adder_address_in==3'h7) begin
    adder_out <=  result;
  end
  else
    begin
      adder_out <=  adder_out;
    end
end

assign addrin_test = addrin_test_s2 | finalmem_addr;
assign ena_test  = ena_test_s2 | ena_finalmem_stage4_control;
assign wr_test = wr_test_s2;
assign finalmem_access	=	wr_test | rd_finalmem_stage4_control;

/*
test_mem testing (
    .datain(adder_out),
    .clk(clk),
    .rst(rst),
    .en(ena_test),
    .wr(wr_test),
    .addrin(addrin_test)
    );
*/
/*
created_image finalmem (
  .clka(clk), // input clka
  .ena(ena_test), // input ena
  .wea(finalmem_access), // input [0 : 0] wea
  .addra(addrin_test), // input [16 : 0] addra
  .dina(adder_out), // input [31 : 0] dina
  .douta(dataout_final) // output [31 : 0] douta
);
*/

//----------->>>>>>> new IP Core memory needed

finalmemory finalmem (
  .clka(clk), // input clka
  .ena(ena_test), // input ena
  .wea(finalmem_access), // input [0 : 0] wea
  .addra(addrin_test), // input [16 : 0] addra
  .dina(adder_out), // input [7 : 0] dina
  .douta(dataout_final) // output [7 : 0] douta
);

//===================================================================================================================
//															Stage III : Maxpool Layer
//===================================================================================================================
//stage 3 led on

reg [7:0]	temp_greater, max_value;
wire [7:0] input_data;
reg greater;
wire [7:0] maxpool;
wire [7:0] data_from_finalmem;

assign input_data	=	adder_out;

always @ (posedge clk) begin
	if (rst) begin
		max_value <= 0;
	end
	else
	begin
			max_value	<=	temp_greater;
	end
end

always @ ( * ) begin
	if (rst) begin
		greater	=	0;
	end
	else if (input_data[7]==1) begin
		greater = 0;
	end
	else if (input_data[7]==0 && (temp_greater > input_data)) begin
		greater = 0;
	end
	else if (input_data[7]==0 && (temp_greater < input_data)) begin
		greater = 1;
	end
	else
		begin
			greater = 0;
		end
end

always @ ( * ) begin
if (rst) begin
		temp_greater	<=	0;
end
	else if (greater) begin
		temp_greater <= input_data;
	end
	else
		begin
			temp_greater	<=	temp_greater;
		end
end

assign maxpool	=	((max_value>>1) + (max_value>>2));// >> 1);


//===================================================================================================================
//															Stage IV : Comparison and Storage
//===================================================================================================================
//stage 4 led on

parameter INIT_stage4		=		3'h0,
				INTERMEDIATE	=		3'h1,
					READ					=		3'h2,
					COMPARE				=		3'h3,
					CHECK_S4			=		3'h4,
					INC_ADDR_S4		=		3'h5,
					DONE_STAGE4		=		3'h6;

reg rd_finalmem_stage4_control, ena_finalmem_stage4_control, inc_addr_finalmem_s4control;
reg wr_displaymem, ena_displaymem, inc_adder_displaymem;
reg [16:0] displaymem_addr, finalmem_addr;
reg start_compare;
reg [2:0]	current_s4, next_s4;
reg reset_addrin_test, rst_display_addr;
reg	displaymem_din;
wire	display_out;


//reg [0:0] displaymem [0:129054];



always @ (posedge clk) begin
	if (rst) begin
		current_s4	<=	INIT_stage4;
	end
	else
		begin
			current_s4	<=	next_s4;
		end
end

always @ ( * ) begin
	case (current_s4)
		INIT_stage4		:	begin
											if (addrin_test==31'h1f820 & led3) begin
												next_s4	=	INTERMEDIATE;
											end
											else begin
												next_s4	=	INIT_stage4;
											end
										end
		INTERMEDIATE		:	begin
											next_s4	=	READ;	
									end
		READ					:	begin
											next_s4	=	COMPARE	;
										end
		COMPARE				:	begin
											next_s4	=	CHECK_S4;
										end
		CHECK_S4			:	begin
											if (displaymem_addr==32'h1f81f) begin
														next_s4	=	DONE_STAGE4;
											end
												else
												begin
													next_s4	=	INC_ADDR_S4;
												end
										end
		INC_ADDR_S4		:	begin
											next_s4	=	READ;
										end
		DONE_STAGE4		:	begin
											next_s4	=	INIT_stage4;
										end
		default: 			next_s4	=	INIT_stage4;
	endcase
end

always @ ( * ) begin
	case (current_s4)
						INIT_stage4	:	begin
														s3_ack	=	0;
														s4_ack	=	0;
														reset_addrin_test	=	0;
													end
						INTERMEDIATE	:	begin
													reset_addrin_test	=	1;
												end
						READ				:	begin
														s3_ack	=	1;
														reset_addrin_test	=	0;
														rd_finalmem_stage4_control	=	0;
														ena_finalmem_stage4_control	=	1;
														inc_adder_displaymem	=	0;
														inc_addr_finalmem_s4control	=	0;
													end
						COMPARE			:	begin
														start_compare		=	1;
														rd_finalmem_stage4_control	=	0;
													end
						CHECK_S4		:	begin
														wr_displaymem		=	1;
														ena_displaymem	=	1;
													end
						INC_ADDR_S4	:	begin
														inc_addr_finalmem_s4control	=	1;
														inc_adder_displaymem	=	1;
														wr_displaymem	=	0;
													end
						DONE_STAGE4	:	begin
														s4_ack	=	1;
														wr_displaymem	=	0;
														ena_displaymem	=	0;
														ena_finalmem_stage4_control	=	0;
														done		=	1;
														rst_display_addr	=	1;
													end
	endcase
end

wire comparator_bit;

assign comparator_bit = (dataout_final > maxpool);
assign data_from_finalmem	=	dataout_final;

always @ ( * ) begin
	if (data_from_finalmem[7]==1 && wr_displaymem && ena_displaymem) begin
		displaymem_din	=	1;
	end
	else if (data_from_finalmem[7]==0 && wr_displaymem && ena_displaymem && comparator_bit) begin
		displaymem_din	=	0;
	end
	else if (data_from_finalmem[7]==0 && wr_displaymem && ena_displaymem && ~comparator_bit) begin
		displaymem_din	=	1;
	end
	else
		begin
			displaymem_din	=	1;
		end
end

/*
always @ ( * ) begin
	if (data_from_finalmem[7]==1 && wr_displaymem && ena_displaymem) begin
		displaymem[displaymem_addr]	=	0;
	end
	else if (data_from_finalmem[7]==0 && wr_displaymem && ena_displaymem && comparator_bit) begin
		displaymem[displaymem_addr]	=	1;
	end
	else if (data_from_finalmem[7]==0 && wr_displaymem && ena_displaymem && ~comparator_bit) begin
		displaymem[displaymem_addr]	=	0;
	end
	else
		begin
			displaymem[displaymem_addr]	=	0;
		end
end*/

always @ ( * ) begin
	if (rst | rst_display_addr) begin
		displaymem_addr	=	0;
	end
	else if (inc_adder_displaymem) begin
		displaymem_addr	=	displaymem_addr	+	1;
	end
	else
		begin
			displaymem_addr	=	displaymem_addr;
		end
end


/*
wire		full, empty;

finalmem_fifo displaymem (
  .rst(rst), // input rst
  .wr_clk(wr_displaymem), // input wr_clk
  .rd_clk(read_display), // input rd_clk
  .din(displaymem_din), // input [0 : 0] din
  .wr_en(ena_displaymem), // input wr_en
  .rd_en(ena_display), // input rd_en
  .dout(display_out), // output [0 : 0] dout
  .full(full), // output full
  .empty(empty) // output empty
);*/

final_memory display (
  .clka(clk), // input clka
  .ena(ena_displaymem | ena_display), // input ena
  .wea(wr_displaymem), // input [0 : 0] wea
  .addra(displaymem_addr | addr_display), // input [16 : 0] addra
  .dina(displaymem_din), // input [0 : 0] dina
  .douta(display_out) // output [0 : 0] douta
);

always @ ( * ) begin
	if (rst | reset_addrin_test) begin
		finalmem_addr	=	0;
	end
	else if (inc_addr_finalmem_s4control) begin
		finalmem_addr	=	finalmem_addr	+	1;
	end
	else
		begin
			finalmem_addr	=	finalmem_addr;
		end
end



//===================================================================================================================
//															Stage V : VGA Module and Final output
//===================================================================================================================
//stage 5 led on
//wire and reg declaration

always @ (posedge clk)
	begin
		if (ena_display)// && read_display)
			begin
				dout_display	<=		display_out;
			end
		else
			begin
				dout_display	<=		0;
			end
	end



reg				[3:0]			free;
wire				[10:0]		x,y;
wire								pixelClk;
//reg				[7:0]			red_out, green_out, blue_out;
//wire				[7:0]			bw_r, bw_g, bw_b;
//reg				[13:0]		addr_count;
//reg				[9:0]			h,v;
//reg								display_out;
reg			[2:0]			current_s5, next_s5;
//reg							en_horz, en_vert;
reg							dout_display;

parameter		S5_init	=	3'h0,
					S5_read	=	3'h1,
					S5_disp	=	3'h2,
					S5_inc	=	3'h3,
					S5_check	=	3'h4,
					S5_done	=	3'h5;

always @ (posedge clk)
	begin
		if (rst)
			begin
				current_s5	<=	S5_init;
			end
		else
			begin
				current_s5	<=	next_s5;
			end
	end
	
always @ *
	begin
		case (current_s5)
			S5_init	:	begin
								if (led5)
									begin
										next_s5	=	S5_read;
									end
								else
									begin
										next_s5	=	S5_init;
									end
							end
			S5_read	:	begin
										next_s5	=	S5_disp;
									end
			S5_disp	:	begin
								next_s5		=		S5_inc;
							end
			S5_inc	:	begin
								next_s5		=		S5_check;
							end
			S5_check	:	begin
								if (addr_display==17'h1f81f)
									begin
										next_s5	=	S5_done;
									end
								else
									begin
										next_s5	=	S5_read;
									end
							end
			S5_done	:	begin
								next_s5	=	S5_read;
							end								
			default	:	next_s5	=	S5_init;
		endcase
	end

always @ *
	begin
		case (current_s5)
			S5_init	:	begin
								s5_ack	=	0;
							end
			S5_read	:	begin
								ena_display	=	1;
								rst_disp_mem_addr	=	0;
							end
			S5_disp	:	begin
								display_en	=	1;
							end
			S5_inc	:	begin
								inc_display_mem_s5	=	1;
							end
			S5_check	:	begin
								inc_display_mem_s5	=	0;
							end
			S5_done	:	begin
								rst_disp_mem_addr	=	1;
								ena_display	=	0;
								display_en	=	0;
							end
		endcase
	end



always @ (posedge clk)
	begin
		if (rst | rst_disp_mem_addr)	
			begin
				addr_display	<=		0;
			end
		else	if (inc_display_mem_s5)
			begin
				addr_display	<=		addr_display	+	1;
			end
		else
			begin
				addr_display	<=	addr_display;
			end
	end

		


//vga code instantiate
vgaPulse Horizontal_new(.clk(pixelClk),
						  .stage1(22'd96),					// See reference manual for values
						  .stage2(22'd144),
						  .stage3(22'd784),
						  .endStage(22'd800),
						  .syncPulse(HS),
						  .free(hFree),			// Can display on screen
						  .position(x)//,
						  //.en(disp)
						  );				// Instantiate module vgaPulse


vgaPulse Vertical_new(.clk(HS),
						.stage1(22'd2),			// See reference manual for values
						.stage2(22'd35),
						.stage3(22'd515),
						.endStage(22'd525),
						.syncPulse(VS),
						.free(vFree),			// Can display on screen
						.position(y)//,
						//.en(disp)
						);				// Instantiate module vgaPulse


clockDiv pixel(.clk(clk),
					.div(32'd4),			// We need 25Mhz but system clock runs at 100Mhz
					.out(pixelClk)			// clock at 25Mhz
					);			// Instantiate module clockDiv



//==========================<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>====================================//

always @ (posedge clk) 
	begin
		//If statement sets vga to equal 0, or print black, when x or y is not within specified area
		if ((x<351)&&(x>=289)&&(y<281)&&(y>=199)&&(display_en))
			//vga <= vga_pool[coordinate];
			begin
				red <= {4{dout_display}};//bw_r[7:4];
				green <= {4{dout_display}};
				blue <= {4{dout_display}};
			end
		else
			begin
				red <= 0;//{4{dout_display}};//bw_r[7:4];
				green <= 0;//{4{dout_display}};
				blue <= 0;//{4{dout_display}};		

			//vga <= 0; 
			end
	end


endmodule
