module Serial_mul(
x,
y,
clk,
product,
asyn_reset,
data_x_vld,
data_x_rdy,
data_y_vld,
data_y_rdy,
d_out_vld,
d_out_rdy
);

parameter width = 64;
parameter START=2'd0;
parameter COMP=2'd1;
parameter END=2'd2;

input[width - 1 : 0] x, y;
input clk;
input asyn_reset;
input data_x_vld, data_y_vld;
input d_out_rdy;
output d_out_vld;
output [2*width -1 : 0] product;
output data_x_rdy, data_y_rdy;

reg data_x_rdy, data_y_rdy;
reg d_out_vld;
reg[1:0] STATE;
reg [width-1 : 0] x_operand, y_operand;
reg finish;
reg product_bit;
reg [2*width -1 : 0] product;
reg [width - 1 : 0] product_lower, product_higher;

//adder
reg[width-1 : 0] sum_op, add_op_one, add_op_two;
reg cin, cout;
reg add_enable;

// select and inversion, performing on add_op_one
reg select_enable;

// shifting bits
reg shift_enable;
reg mul_bit; 

// add_op_two prodcution, adder_control
reg control_enable;

// counter
reg counter_enable;
reg [width-1 :0] count;


// handshake protocool
reg hd_x, hd_y, hd_z;

	
//buliding handshake mechanism with other moduels
// hd FSM, state transitions
initial begin
	hd_x <= 0;
	hd_y <= 0;
	hd_z <= 0;
	d_out_vld <= 0;
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
		finish <= 0;
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
				finish <= 0;
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
				finish <= 0;
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
			if (hd_x == 1 && hd_y == 1)begin
				control_enable <= 1;
				counter_enable <= 1;
				shift_enable <= 1;
				select_enable <= 1;
			end
			else begin
				control_enable <= 0;
				counter_enable <= 0;
				shift_enable <= 0;
				select_enable <= 0;
			end
			d_out_vld <=0;
			add_enable <= 0;
		end
		COMP: begin
			data_x_rdy <= 0;
			data_y_rdy <= 0;
			d_out_vld <= 0;
			add_enable <= 1;
			control_enable <= 1;
			counter_enable <= 1;
			select_enable <= 1;
			shift_enable <= 1;
		end
		END: begin
			data_x_rdy <= 0;
			data_y_rdy <= 0;
			d_out_vld <= 1;
			add_enable <= 0;
			control_enable <= 0;
			counter_enable <= 0;
			select_enable <= 0;
			shift_enable <= 0;
		end
		default: begin
			data_x_rdy <= 0;
			data_y_rdy <= 0;
			d_out_vld<= 0;
			control_enable <= 0;
			add_enable <= 0;
			counter_enable <= 0;
			select_enable <= 0;
		end
	endcase
end

//product_reg
always @ (posedge clk or posedge asyn_reset) begin
	if (asyn_reset == 1) begin
		product_lower <= 0;
	end
	else begin
		if (STATE == START ) begin
			product_lower <= 0;
		end
		else if (STATE == COMP) begin
			product_lower <= {product_bit,product_lower[width-1:1]};
		end
	end
end


// adder 
always @ (*) begin
	if (add_enable) begin
		{cout, sum_op} = add_op_one + add_op_two + cin;
		product_bit <= sum_op[0];
	end
	else begin
		cout <= 0;
		sum_op <= 0;
		product_bit <= 0;
	end
end
// select add_op_one
always @ (*) begin
	if (select_enable && mul_bit) begin
		add_op_one <= x_operand;
	end
	else begin
		add_op_one <= 0;
	end
end
//shifting 
always @(posedge clk or posedge asyn_reset) begin
	if (asyn_reset == 1) begin
		mul_bit <= 0;
	end
	else begin
		if (shift_enable == 1) begin
			mul_bit <= y_operand[0];
			y_operand <= {1'b0,y_operand[width-1:1]};
		end
		else begin 
			mul_bit <= 0;
		end
	end
end
// counter
always @ (posedge clk or posedge asyn_reset) begin
	if (asyn_reset == 1) begin
		count <= 0;
	end
	else begin
		if (counter_enable == 1) begin
			count <= count + 1;
		end
		else begin
			count <= 0;
		end
	end
end

always @ (*) begin
	if (count == width + 1) begin
		finish <= 1;
	end
	else begin
		finish <= 0;
	end
end

always @ (posedge clk or posedge asyn_reset) begin
	if (asyn_reset == 1) begin
		product_higher <= 0;
		product <= 0;
	end
	else begin
		if (finish == 1 && STATE == COMP) begin
			product_higher <= sum_op;
			product <= {cout,sum_op, product_lower};
		end
		else if (STATE == START) begin
			product_higher <= 0;
			product <= 0;
		end
	end


end


// control logic
always @ (posedge clk or posedge asyn_reset) begin
	if (asyn_reset == 1) begin 
		cin <= 0;
		add_op_two <= 0;
	end
	else begin
		if (control_enable) begin
			cin <= cout;
			if (STATE == START) begin
				add_op_two <= 0;
			end
			else begin
				add_op_two <= {cout,sum_op[width-1:1]};
			end
		end
		else begin
			cin <= 0;
			add_op_two <= 0;
		end
	end
end


endmodule
	
