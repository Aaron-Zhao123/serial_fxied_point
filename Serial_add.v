module Serial_add(
x,
y,
sum,
cout,
clk,
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
reg[1:0] STATE;	
input clk;
input asyn_reset;
input data_x_vld, data_y_vld;
output data_x_rdy, data_y_rdy;
reg data_x_rdy, data_y_rdy;
input d_out_rdy;
output d_out_vld;
reg d_out_vld;
input[width-1:0] x, y;
output[width-1:0] sum;
output cout;
reg cout;
reg cout_bit;
reg sum_bit;
reg cin, x_bit, y_bit;
reg[width-1 : 0] x_operand, y_operand, sum, sum_operand;
reg finish;
reg en_add;
reg[width-1 :0] counter;
// handshake protocool
reg hd_x, hd_y, hd_z;
reg addition_op;

initial begin
	hd_x <= 0;
	hd_y <= 0;
	hd_z <= 0;
end

	
//buliding handshake mechanism with other moduels
// hd FSM, state transitions
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
					sum_operand <= 0;

				end
				if (data_x_rdy && data_x_vld) begin
					hd_x <= 1;
					x_operand <= x;
				end
				if (data_y_rdy && data_y_vld) begin
					hd_y <= 1;
					y_operand <= 0 - y;
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
			d_out_vld <=0;
			addition_op <= 0;
		end
		COMP: begin
			addition_op <= 1;
			data_x_rdy <= 0;
			data_y_rdy <= 0;
			d_out_vld <= 0;
		end
		END: begin
			addition_op <= 0;
			data_x_rdy <= 0;
			data_y_rdy <= 0;
			d_out_vld <= 1;
		end
		default: begin
			addition_op <= 0;
			data_x_rdy <= 0;
			data_y_rdy <= 0;
			d_out_vld<= 0;
		end
	endcase
end
// adder with enable
always @ (*) begin
	if (en_add) begin
		{cout_bit,sum_bit} = x_bit + y_bit + cin;
	end
	else begin
		cout_bit <= 0;
		sum_bit<= 0;
	end

end
// counter set up
always @ (posedge clk or posedge asyn_reset)begin
	if (asyn_reset == 1) begin
		counter <= 0;
	end
	else begin
		if (addition_op == 1)begin
			counter <= counter + 1;
		end
		else begin
			counter <= 0;
		end

	end

end



always @ (posedge clk or posedge asyn_reset) begin
	if (asyn_reset == 1)begin
		x_operand <= 0; 
		y_operand <= 0;
		sum_operand <= 0;
	end
	else begin
		case (STATE) 
			START : begin
				cin <= 0;
				cout <= 0;
			end
			COMP : begin
				x_operand <= {1'b0,x_operand[width-1:1]};
				y_operand <= {1'b0,y_operand[width-1:1]};
				sum_operand <= {sum_bit,sum_operand [width-1:1]};
				cin <= cout_bit;
				cout <= cout_bit;
			end
			END : begin
			end
		endcase	
	end
end

always @ (*) begin
	case (STATE) 
		START: begin
			sum <= sum_operand;
			x_bit <= 0;
			y_bit <= 0;
			finish <= 0;
			en_add <= 0;
		end
		COMP: begin
			if (addition_op == 1) begin
				x_bit <= x_operand[0];
				y_bit <= y_operand[0];
				sum <= sum_operand;
				en_add <= 1;
				if (counter == width-1)begin
					finish <= 1;
				end
				else begin
					finish <= 0;
				end
			end
			else begin
				sum <= sum_operand;
				x_bit <= 0;
				y_bit <= 0;
				finish <= 0;
				en_add <= 0;
			end
		end
		END: begin
			sum <= sum_operand;
			x_bit <= 0;
			y_bit <= 0;
			finish <= 0;
			en_add <= 0;
		end
	endcase
end

endmodule

