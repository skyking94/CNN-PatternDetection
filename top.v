`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    07:54:30 05/15/2017
// Design Name:
// Module Name:    top
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
module top(
				clk,
				rst,
				switch,
				r,
				g,
				b,
				HS,
				VS,
				vFree,
				hFree,
				stage1,
				stage2,
				stage3,
				stage4,
				stage5
    );

//io declaration
input								clk, rst, switch;
output	reg	[3:0]			r,g,b;
output							HS, VS, hFree, vFree;
output	reg					stage1, stage2, stage3, stage4, stage5;
//input								start;

//wire and reg declaration
reg				[3:0]			free;
wire				[9:0]		x,y;
wire								pixelClk;
reg				[7:0]			red_out, green_out, blue_out;
wire				[7:0]			bw_r, bw_g, bw_b;
reg				[13:0]		addr_count;
reg				[6:0]			h,v;
reg				[13:0]		addrout;

//wires and registers for FSM
reg				[2:0]			current_vga, next_vga;
reg								go, disp;
reg								ena_display, read_display;
reg				[16:0]		addr_display;
wire				[16:0]		addrout_vga;
wire								extra, done;
wire								led1, led2, led3, led4, led5;
wire								dout_display;
reg								inc_disp_addr;

parameter	START		=	3'h0,
				GO			=	3'h1,
				WAIT		=	3'h2,
				DISPLAY	=	3'h3,
				BUFFER	=	3'h4;

always @ (posedge clk)
	begin
		if (rst)
			begin
				current_vga		<=		START;
			end
		else
			begin
				current_vga		<=		next_vga;
			end
	end

always @ ( * )
	begin
		case (current_vga)
			START		:	begin
								next_vga		=		GO;
							end
			GO			:	begin
								next_vga		=		WAIT;
							end
			WAIT		:	begin
								if (done && stage5)
									begin
										next_vga		=		DISPLAY;
									end
								else
									begin
										next_vga		=		WAIT;
									end
							end
			DISPLAY	:	begin
								next_vga		=		BUFFER;
							end
			BUFFER	:	begin
									next_vga	=		DISPLAY;
								end
		endcase
	end

always @ ( * )
	begin
		case (current_vga)
			GO			:	begin
								go			=		1;
							end
			DISPLAY	:	begin
								disp		=		1;
								ena_display	=	1;
								read_display	=	1;
								inc_disp_addr	=	0;
							end
			BUFFER	:	begin
									read_display	=	0;
									inc_disp_addr	=	1;
								end
		endcase
	end
/*
//Instantiate the CNN module of pattern detection
main CNN_module (
    .clk(clk),
    .rst(rst),
    .stage1(led1),
    .stage2(led2),
    .stage3(led3),
    .stage4(led4),
    .stage5(led5),
    .go(switch),
    .done(done),
    .extra(extra),
    .ena_display(ena_display),
    .read_display(read_display),
	 .addr_display(addr_display),
    .dout_display(dout_display)
    );


//vga code instantiate
vgaPulse Horizontal(.clk(pixelClk),
						  .stage1(22'd96),					// See reference manual for values
						  .stage2(22'd144),
						  .stage3(22'd784),
						  .endStage(22'd800),
						  .syncPulse(HS),
						  .free(hFree),			// Can display on screen
						  .position(x)//,
						  //.en(disp)
						  );				// Instantiate module vgaPulse


vgaPulse Vertical(.clk(HS),
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
*/


//address calculation

always @ (posedge clk)
	begin
		if (rst)
			begin
				addr_display	<=	0;
			end
		else	if (inc_disp_addr)
			begin
				addr_display	<=		addr_display	+	1;
			end
		else
			begin
				addr_display	<=		addr_display;
			end
	end
				

/*
always @ (posedge pixelClk)
	begin
		if ((x==0+h) && (y==0+v) && (v<411) && disp)
			begin
				h <= h+1;
			end
		end

always @ (posedge pixelClk)
	begin
		if ((x==0+h) && (y==0+v) && (h==313) && disp)
			begin
				v <= v+1;
			end
	end
*/
//assign addrout_vga	=	v + h;
/*
always @ (posedge pixelClk)
	begin
		if (disp)
			begin
				addr_display	<=		addrout_vga;
			end
		else
			begin
				addr_display	<=		0;
			end
	end
*/
always @ (posedge clk)
	begin
		stage1	<=		led1;
		stage2	<=		led2;
		stage3	<=		led3;
		stage4	<=		led4;
		stage5	<=		led5;
	end

/*//get values from rgb image and send it for conversion
always @ *
	begin
		red_out 		= red[{h,v}];
		green_out 	= green[{h,v}];
		blue_out 	= blue[{h,v}];
	end*/

//Instantiate rgb to bw conversion code
//image_RGB2BW u1 (.R(red_out), .G(green_out), .B(blue_out), .newR(bw_r), .newG(bw_g), .newB(bw_b), .clk(pixelClk));
//rgbtobw u1 (.Rin(red_out), .Gin(green_out),	.Bin(blue_out), .BWout(bw_r));
/*
//VGA output
always @ (posedge pixelClk)
begin

free[0]=hFree&&vFree&&(x<315)&&(x>0)&&(y<412)&&(y>0)&&disp;				// value of 'x' and 'hfree' obtained from vgaPulse Horizontal
free[1]=hFree&&vFree&&(x<315)&&(x>0)&&(y<412)&&(y>0)&&disp;				// value of 'y' and 'vfree' obtained from vgaPulse Vertical
free[2]=hFree&&vFree&&(x<315)&&(x>0)&&(y<412)&&(y>0)&&disp;
free[3]=hFree&&vFree&&(x<315)&&(x>0)&&(y<412)&&(y>0)&&disp;

r = {4{dout_display}};//bw_r[7:4];
g = {4{dout_display}};
b = {4{dout_display}};

end
*/
	wire [12:0] coordinate;
	assign coordinate = (y-199)*62 + (x-289);

	always @(posedge clk) begin
		//If statement sets vga to equal 0, or print black, when x or y is not within specified area
		if ((x<351)&&(x>=289)&&(y<281)&&(y>=199)&&(led5))
			//vga <= vga_pool[coordinate];
			begin
				r <= {4{dout_display}};//bw_r[7:4];
				g <= {4{dout_display}};
				b <= {4{dout_display}};
			end
		else
		begin
				r <= 0;//{4{dout_display}};//bw_r[7:4];
				g <= 0;//{4{dout_display}};
				b <= 0;//{4{dout_display}};		

			//vga <= 0; 
		end
		
	end


endmodule
