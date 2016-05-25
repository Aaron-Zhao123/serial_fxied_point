module Serial_div(
x,
y,
quotient,
clk,
asyn_reset,
data_x_vld,
data_x_rdy,
data_y_vld,
data_y_rdy,
d_out_vld,
d_out_rdy
);

parameter width = 128;
parameter START=2'd0;
parameter COMP=2'd1;
parameter END=2'd2;
reg[1:0] STATE;	
input [width -1 :0] x,y;
output [width -1 :0] quotient;
reg [2*width -1 :0] quotient;
input clk;
input asyn_reset;
input data_x_vld, data_y_vld;
output data_x_rdy, data_y_rdy;
reg data_x_rdy, data_y_rdy;
input d_out_rdy;
output d_out_vld;
reg d_out_vld;


reg [width-1 :0] tmp;
reg [width -1 :0] x_operand, y_operand;
reg [width -1 :0] remainder, quotient_reg;
reg [width -1 :0] counter;
reg counter_enable;
reg shift_enable;
reg finish;
reg computing_q;
reg test_flag;

reg hd_x, hd_y, hd_z;
//buliding handshake mechanism with other moduels
// hd FSM, state transitions
initial begin
	hd_x <= 0;
	hd_y <= 0;
	hd_z <= 0;
	quotient_reg <= 0;
	remainder <= 0;
	tmp <= 0;
end

always @ (posedge clk or posedge asyn_reset) begin
	if (asyn_reset == 1) begin 
		STATE <= START;
		hd_x <= 0;
		hd_y <= 0;
		hd_z <= 0;
		data_x_rdy <= 0;
		data_y_rdy <= 0;
		d_out_vld<= 0;
		x_operand <= 0;
		y_operand <= 0;	
	end
	else begin
		case (STATE)
			START: begin
				// if both hd happen 
				if (hd_x == 1 && hd_y == 1) begin
					STATE <= COMP;
					hd_x <= 0;
					hd_y <= 0;
				end
				if (data_x_rdy && data_x_vld) begin
					hd_x <= 1;
					x_operand <= x;
				end
				if (data_y_rdy && data_y_vld) begin
					hd_y <= 1;
					y_operand <= y;
				end
			end
			COMP: begin
				if (finish == 1) begin
					STATE <= END;
				end
			end
			END: begin
				if (hd_z == 1) begin 
					STATE <= START;
					hd_z <= 0;
				end
				if (d_out_vld&&d_out_rdy) begin
					hd_z <= 1;
					d_out_vld <= 0;
				end
				shift_enable <= 0;
			end
			default: begin
				STATE <= START;
			end
		endcase
	end
end
	
//output signals are data_x_rdy,data_y_rdy,data_out_vld;
always @ (*) begin
	case (STATE)
		START: begin
			if (hd_x == 0) begin
				data_x_rdy <= 1;
			end
			else begin 
				data_x_rdy <= 0;
			end
			if (hd_y == 0) begin
				data_y_rdy <= 1;
			end
			else begin
				data_y_rdy <= 0;
			end	
			if (hd_x == 1 && hd_y == 1) begin
				shift_enable <= 1;
			end
			else begin
				shift_enable <= 0;
			end

			d_out_vld <=0;
			counter_enable <= 0;
			computing_q <= 0;
		end
		COMP: begin
			data_x_rdy <= 0;
			data_y_rdy <= 0;
			d_out_vld <= 0;
			counter_enable <= 1;
			computing_q <= 1;
			shift_enable <= 1;
		end
		END: begin
			data_x_rdy <= 0;
			data_y_rdy <= 0;
			d_out_vld <= 1;
			counter_enable <= 0;
			computing_q <= 0;
			shift_enable <= 0; 
		end
		default: begin
			data_x_rdy <= 0;
			data_y_rdy <= 0;
			d_out_vld<= 0;
			counter_enable <= 0;
			computing_q <= 0;
			shift_enable <= 0;
		end
	endcase
end

always @ (posedge clk or posedge asyn_reset) begin
	if (asyn_reset == 1) begin
		counter <= 0;
	end
	else begin
		if (counter_enable && STATE == COMP) begin
			counter <= counter + 1;
		end
		else if (STATE == START) begin
			counter <= 0; //refreshing value 
		end

	end
end

always @ (*) begin
	if (counter == 4*width) begin
		finish <= 1;
	end
	else begin
		finish <= 0;
	
	end
end
always @(posedge clk or posedge asyn_reset) begin
	if (asyn_reset == 1) begin
		quotient <= 0;
	end
	else begin
		if (finish == 1) begin
			quotient <= quotient_reg;	
		end
		else if (STATE == START) begin
			quotient <= 0;
		end
	end
end


reg step_one, step_two;

always @ (posedge clk or posedge asyn_reset) begin
	if (asyn_reset == 1) begin
		remainder = 0;
		tmp = 0;
		step_one <= 0;
		step_two <= 0;
		remainder <= 0;
	end
	else begin
		if (STATE == START) begin
			step_one <= 1;
			step_two <= 0;
		end

		if (shift_enable == 1 && step_one == 1) begin
			remainder <= {tmp[width-2 :0],x_operand[width-1]};
			x_operand <= {x_operand[width -2 :0],1'b0};
			step_one <= 0;
			step_two <= 1;

		end
		else begin
		end
	end
end
always @ (posedge clk or posedge asyn_reset) begin
	if (asyn_reset == 1) begin
		quotient_reg <= 0;
		tmp <= 0;
	end
	else begin
		if (step_two == 1 && computing_q == 1 ) begin
			if (remainder >= y_operand) begin
				tmp <= remainder - y_operand;
				quotient_reg <= {quotient_reg[width-2:0],1'b1};
			end
			else begin
				tmp <= remainder;
				quotient_reg <= {quotient_reg[width-2:0],1'b0};
			end
			step_two <= 0;
			step_one <= 1;

		end
	end
end

endmodule

