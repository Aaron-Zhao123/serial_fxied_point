module newton(
clk,
asyn_reset,
x_value_one, x_value_two, x_value_three, x_value_four, x_value_five,
b_value_one, b_value_two, b_value_three, b_value_four, b_value_five,
res
);

parameter width = 128;

input clk;
input asyn_reset;
input[1:0] x_value_one, x_value_two, x_value_three, x_value_four, x_value_five;
input[1:0] b_value_one, b_value_two, b_value_three, b_value_four, b_value_five;
output [1:0] res;

reg [width-1 : 0] mul_one_op_one, mul_one_op_two;
wire [2*width-1 :0] product_one;
reg data_x_mul_one_vld,data_y_mul_one_vld,d_out_mul_one_rdy;
wire data_x_mul_one_rdy,data_y_mul_one_rdy,d_out_mul_one_vld;
// multiplier one hd signals
reg [width-1 : 0] add_one_op_one, add_one_op_two;
wire [width-1 :0] sum_one;
wire cout_one;
reg data_x_add_one_vld,data_y_add_one_vld,d_out_add_one_rdy;
wire data_x_add_one_rdy,data_y_add_one_rdy,d_out_add_one_vld;

reg [width-1 : 0] mul_two_op_one, mul_two_op_two;
wire [2*width-1 :0] product_two;
reg data_x_mul_two_vld,data_y_mul_two_vld,d_out_mul_two_rdy;
wire data_x_mul_two_rdy,data_y_mul_two_rdy,d_out_mul_two_vld;

reg [width-1 : 0] div_one_op_one, div_one_op_two;
wire [2*width-1 :0] quotient_one;
reg data_x_div_one_vld,data_y_div_one_vld,d_out_div_one_rdy;
wire data_x_div_one_rdy,data_y_div_one_rdy,d_out_div_one_vld;

reg [width-1 : 0] add_two_op_one, add_two_op_two;
wire [width-1 :0] sum_two;
wire cout_two;
reg data_x_add_two_vld,data_y_add_two_vld,d_out_add_two_rdy;
wire data_x_add_two_rdy,data_y_add_two_rdy,d_out_add_two_vld;


reg [width-1 : 0] mul_three_op_one, mul_three_op_two;
wire [2*width-1 :0] product_three;
reg data_x_mul_three_vld,data_y_mul_three_vld,d_out_mul_three_rdy;
wire data_x_mul_three_rdy,data_y_mul_three_rdy,d_out_mul_three_vld;

reg [width-1 : 0] add_three_op_one, add_three_op_two;
wire [width-1 :0] sum_three;
wire cout_three;
reg data_x_add_three_vld,data_y_add_three_vld,d_out_add_three_rdy;
wire data_x_add_three_rdy,data_y_add_three_rdy,d_out_add_three_vld;

reg [width-1 : 0] mul_four_op_one, mul_four_op_two;
wire [2*width-1 :0] product_four;
reg data_x_mul_four_vld,data_y_mul_four_vld,d_out_mul_four_rdy;
wire data_x_mul_four_rdy,data_y_mul_four_rdy,d_out_mul_four_vld;

reg [width-1 : 0] div_two_op_one, div_two_op_two;
wire [2*width-1 :0] quotient_two;
reg data_x_div_two_vld,data_y_div_two_vld,d_out_div_two_rdy;
wire data_x_div_two_rdy,data_y_div_two_rdy,d_out_div_two_vld;

reg [width-1 : 0] add_four_op_one, add_four_op_two;
wire [width-1 :0] sum_four;
wire cout_four;
reg data_x_add_four_vld,data_y_add_four_vld,d_out_add_four_rdy;
wire data_x_add_four_rdy,data_y_add_four_rdy,d_out_add_four_vld;

reg [width-1 : 0] mul_five_op_one, mul_five_op_two;
wire [2*width-1 :0] product_five;
reg data_x_mul_five_vld,data_y_mul_five_vld,d_out_mul_five_rdy;
wire data_x_mul_five_rdy,data_y_mul_five_rdy,d_out_mul_five_vld;

reg [width-1 : 0] add_five_op_one, add_five_op_two;
wire [width-1 :0] sum_five;
wire cout_five;
reg data_x_add_five_vld,data_y_add_five_vld,d_out_add_five_rdy;
wire data_x_add_five_rdy,data_y_add_five_rdy,d_out_add_five_vld;

reg [width-1 : 0] mul_six_op_one, mul_six_op_two;
wire [2*width-1 :0] product_six;
reg data_x_mul_six_vld,data_y_mul_six_vld,d_out_mul_six_rdy;
wire data_x_mul_six_rdy,data_y_mul_six_rdy,d_out_mul_six_vld;

reg [width-1 : 0] div_three_op_one, div_three_op_two;
wire [2*width-1 :0] quotient_three;
reg data_x_div_three_vld,data_y_div_three_vld,d_out_div_three_rdy;
wire data_x_div_three_rdy,data_y_div_three_rdy,d_out_div_three_vld;

reg [width-1 : 0] add_six_op_one, add_six_op_two;
wire [width-1 :0] sum_six;
wire cout_six;
reg data_x_add_six_vld,data_y_add_six_vld,d_out_add_six_rdy;
wire data_x_add_six_rdy,data_y_add_six_rdy,d_out_add_six_vld;

reg [width-1 : 0] mul_seven_op_one, mul_seven_op_two;
wire [2*width-1 :0] product_seven;
reg data_x_mul_seven_vld,data_y_mul_seven_vld,d_out_mul_seven_rdy;
wire data_x_mul_seven_rdy,data_y_mul_seven_rdy,d_out_mul_seven_vld;

reg [width-1 : 0] add_seven_op_one, add_seven_op_two;
wire [width-1 :0] sum_seven;
wire cout_seven;
reg data_x_add_seven_vld,data_y_add_seven_vld,d_out_add_seven_rdy;
wire data_x_add_seven_rdy,data_y_add_seven_rdy,d_out_add_seven_vld;

reg [width-1 : 0] mul_eight_op_one, mul_eight_op_two;
wire [2*width-1 :0] product_eight;
reg data_x_mul_eight_vld,data_y_mul_eight_vld,d_out_mul_eight_rdy;
wire data_x_mul_eight_rdy,data_y_mul_eight_rdy,d_out_mul_eight_vld;

reg [width-1 : 0] div_four_op_one, div_four_op_two;
wire [2*width-1 :0] quotient_four;
reg data_x_div_four_vld,data_y_div_four_vld,d_out_div_four_rdy;
wire data_x_div_four_rdy,data_y_div_four_rdy,d_out_div_four_vld;

reg [width-1 : 0] add_eight_op_one, add_eight_op_two;
wire [width-1 :0] sum_eight;
wire cout_eight;
reg data_x_add_eight_vld,data_y_add_eight_vld,d_out_add_eight_rdy;
wire data_x_add_eight_rdy,data_y_add_eight_rdy,d_out_add_eight_vld;

reg [width-1 : 0] mul_nine_op_one, mul_nine_op_two;
wire [2*width-1 :0] product_nine;
reg data_x_mul_nine_vld,data_y_mul_nine_vld,d_out_mul_nine_rdy;
wire data_x_mul_nine_rdy,data_y_mul_nine_rdy,d_out_mul_nine_vld;

reg [width-1 : 0] add_nine_op_one, add_nine_op_two;
wire [width-1 :0] sum_nine;
wire cout_nine;
reg data_x_add_nine_vld,data_y_add_nine_vld,d_out_add_nine_rdy;
wire data_x_add_nine_rdy,data_y_add_nine_rdy,d_out_add_nine_vld;

reg [width-1 : 0] mul_ten_op_one, mul_ten_op_two;
wire [2*width-1 :0] product_ten;
reg data_x_mul_ten_vld,data_y_mul_ten_vld,d_out_mul_ten_rdy;
wire data_x_mul_ten_rdy,data_y_mul_ten_rdy,d_out_mul_ten_vld;

reg [width-1 : 0] div_five_op_one, div_five_op_two;
wire [2*width-1 :0] quotient_five;
reg data_x_div_five_vld,data_y_div_five_vld,d_out_div_five_rdy;
wire data_x_div_five_rdy,data_y_div_five_rdy,d_out_div_five_vld;


reg [width-1 : 0] add_ten_op_one, add_ten_op_two;
wire [width-1 :0] sum_ten;
wire cout_ten;
reg data_x_add_ten_vld,data_y_add_ten_vld,d_out_add_ten_rdy;
wire data_x_add_ten_rdy,data_y_add_ten_rdy,d_out_add_ten_vld;

assign res = sum_ten;
reg cnt;
initial begin
	cnt = 0;
end

always @ (posedge clk) begin
	cnt = cnt + 1;
end

	
initial begin
mul_one_op_one = x_value_one;
mul_one_op_two = x_value_two;
mul_two_op_one = x_value_three;
add_two_op_one = x_value_four;
mul_four_op_one = x_value_five;

add_one_op_two = b_value_one;
add_three_op_two = b_value_two;
add_five_op_two = b_value_three;
add_seven_op_two = b_value_four;
add_nine_op_two = b_value_five;
end


always @ (*) begin
	data_x_mul_one_vld <= 1;
	data_y_mul_one_vld <= 1; // scanning from file, always high
	d_out_mul_one_rdy <= data_y_add_one_rdy;
	

	data_x_add_one_vld <= d_out_mul_one_vld;
	data_y_add_one_vld <= 1;
	d_out_add_one_rdy <= data_x_div_one_rdy;

	data_x_mul_two_vld <= 1;
	data_y_mul_two_vld <= 1;
	d_out_mul_two_rdy <= data_y_div_one_rdy;

	data_x_div_one_vld <= d_out_add_one_vld;
	data_y_div_one_vld <= d_out_mul_two_vld;

	d_out_div_one_rdy <= 1;
	
	data_x_add_two_vld <= 1;
	data_y_add_two_vld <= d_out_div_one_vld;
	d_out_div_one_rdy <= data_y_add_two_rdy;

	d_out_add_two_rdy <= data_x_mul_three_rdy;
	data_x_mul_three_vld <= d_out_add_two_vld;
	data_y_mul_three_vld <= d_out_add_two_vld;
	
	d_out_mul_three_rdy <= data_x_add_three_rdy;
	data_x_add_three_vld <= d_out_mul_three_vld;
	data_y_add_three_vld <= 1;
	d_out_add_three_rdy <= data_x_div_two_rdy;

	data_x_mul_four_vld <= 1;
	data_y_mul_four_vld<= d_out_add_two_vld;
	d_out_mul_four_rdy <= data_y_div_two_rdy;

	data_x_div_two_vld <= d_out_add_three_vld;
	data_y_div_two_vld <= d_out_mul_four_vld;
	d_out_div_two_rdy <= data_y_add_four_rdy;

	data_x_add_four_vld <= d_out_add_two_vld;
	data_y_add_four_vld <= d_out_div_two_vld;
	d_out_add_four_rdy <= data_x_mul_five_rdy;

	data_x_mul_five_vld <= d_out_add_four_vld;
	data_y_mul_five_vld <= d_out_add_four_vld;
	d_out_mul_five_rdy <= data_x_add_five_rdy;

	data_x_add_five_vld <= d_out_mul_five_vld;
	data_y_add_five_vld <= 1;
	d_out_add_five_rdy <= data_x_div_three_rdy;

	data_y_mul_six_vld <= 1;
	data_x_mul_six_vld <= d_out_add_five_vld;
	d_out_mul_six_rdy <= data_y_div_three_rdy;

	data_x_div_three_vld <= d_out_add_five_vld;
	data_y_div_three_vld <= d_out_mul_six_vld;
	d_out_div_three_rdy <= data_y_add_six_rdy;

	data_x_add_six_vld <= d_out_add_four_vld;
	data_y_add_six_vld <= d_out_div_three_vld;
	d_out_div_three_rdy <= data_y_add_six_rdy;
	d_out_add_six_rdy <= data_x_mul_seven_rdy;

	data_x_mul_seven_vld <= d_out_add_six_vld;
	data_y_mul_seven_vld <= d_out_add_six_vld;
	d_out_mul_seven_rdy <= data_x_add_seven_rdy;

	data_x_add_seven_vld <= d_out_mul_seven_vld;
	data_y_add_seven_vld <= 1;
	d_out_add_seven_rdy <= data_x_div_four_rdy;

	data_x_mul_eight_vld <= 1;
	data_y_mul_eight_vld <= d_out_add_six_vld;
	d_out_mul_eight_rdy <= data_y_div_four_rdy;

	data_x_div_four_vld <= d_out_add_seven_vld;
	data_y_div_four_vld <= d_out_mul_eight_vld;
	d_out_div_four_rdy <= 1;

	data_x_add_eight_vld <= d_out_add_six_vld;
	data_y_add_eight_vld <= d_out_div_four_vld;
	d_out_add_eight_rdy <= data_x_mul_nine_rdy;

	data_x_mul_nine_vld <= d_out_add_eight_vld;
	data_y_mul_nine_vld <= d_out_add_eight_vld;
	d_out_mul_nine_rdy <= data_x_add_nine_rdy;

	data_x_add_nine_vld <= d_out_mul_nine_vld;
	data_y_add_nine_vld <= 1;
	d_out_add_nine_rdy <= data_x_div_five_rdy;

	data_x_mul_ten_vld <= 1;
	data_y_mul_ten_vld <= d_out_add_eight_vld;
	d_out_mul_ten_rdy <= data_y_div_five_rdy;

	data_x_div_five_vld <= d_out_add_nine_vld;
	data_y_div_five_vld <= d_out_mul_ten_vld;
	d_out_div_five_rdy <= data_y_add_ten_rdy;

	data_x_add_ten_vld <= d_out_add_eight_vld;
	data_y_add_ten_vld <= d_out_div_five_vld;
	d_out_add_ten_rdy <= 1;
end
initial begin
	add_one_op_one <= 0;
	data_y_add_one_vld <= 0;
	mul_two_op_two <= 64'd2;
end


always @ (*) begin
	mul_one_op_one = x_value_one;
	mul_one_op_two = x_value_two;
	add_one_op_two = x_value_two;
	mul_two_op_one = x_value_three;
	add_two_op_one = x_value_four;
	add_three_op_two = b_value_two;
	mul_four_op_one = x_value_five;
	add_five_op_two = b_value_three;
	add_seven_op_two = b_value_four;
	add_nine_op_two = b_value_five;
end

always@(negedge clk) begin
	if (asyn_reset) begin
	end
	else begin	
		if (data_x_add_one_vld && data_x_add_one_rdy) begin
			add_one_op_one <= {product_one[2*width-1],product_one[2*width-3:width-1]};
		end
		if (data_x_div_one_rdy && data_x_div_one_vld) begin
			div_one_op_one <= (0 - sum_one);
		end
		if (data_y_div_one_rdy && data_y_div_one_vld) begin
			div_one_op_two <= product_two[width-1:0];
		end
		if (data_y_add_two_vld && data_y_add_two_rdy) begin
			add_two_op_two <= 0 - quotient_one[width:1];	
		end
		if (data_x_mul_three_vld && data_x_mul_three_rdy) begin
			mul_three_op_one <= sum_two;
		end
		if (data_y_mul_three_vld && data_y_mul_three_rdy) begin
			mul_three_op_two <= sum_two;
		end
		if (data_x_add_three_rdy && data_x_add_three_vld) begin
			add_three_op_one <= product_three[2*width-2:width-1];	
		end
		if (data_y_mul_four_vld && data_y_mul_four_rdy) begin
			mul_four_op_two <= 64'd2;
		end
		if (data_x_div_two_vld && data_x_div_two_rdy) begin
			div_two_op_one <= sum_three;
		end
		if (data_y_div_two_vld && data_y_div_two_rdy) begin
			div_two_op_two <= product_four;
		end
		if (data_x_add_four_vld && data_x_add_four_rdy) begin
			add_four_op_one <= sum_two;
		end
		if (data_y_add_four_vld && data_y_add_four_rdy) begin
			add_four_op_two <= quotient_two[width:1];
		end
		if (data_x_mul_five_vld && data_x_mul_five_rdy) begin
			mul_five_op_one <= sum_four;
		end
		if (data_y_mul_five_vld && data_y_mul_five_rdy) begin
			mul_five_op_two <= sum_four;
		end
		if (data_x_add_five_vld && data_x_add_five_rdy) begin
			add_five_op_one <= product_five[2*width-2:width-1];
		end
		if (data_x_mul_six_vld && data_x_mul_six_rdy) begin
			mul_six_op_one <= sum_four;
		end
		if (data_y_mul_six_vld && data_y_mul_six_rdy) begin
			mul_six_op_two <= 64'd2;
		end
		if (data_x_div_three_vld && data_x_div_three_rdy) begin
			div_three_op_one <= 0 - sum_five;
		end
		if (data_y_div_three_vld && data_y_div_three_rdy) begin
			div_three_op_two <= product_six[width-1:0];
		end
		if (data_x_add_six_vld && data_y_add_six_rdy) begin
			add_six_op_one <= sum_four;
		end
		if (data_y_add_six_rdy && data_y_add_six_vld) begin
			add_six_op_two <= 0 - quotient_three[width:1];
		end
		if (data_x_mul_seven_vld && data_x_mul_seven_rdy) begin
			mul_seven_op_one <= sum_six;
		end
		if (data_y_mul_seven_vld && data_y_mul_seven_rdy) begin
			mul_seven_op_two <= sum_six;
		end

		if (data_x_add_seven_rdy && data_x_add_seven_vld) begin
			add_seven_op_one <= product_seven[2*width-2:width-1];
		end
		if (data_y_add_seven_vld && data_y_add_seven_rdy) begin
		end
		if (data_x_mul_eight_vld && data_x_mul_eight_rdy) begin
			mul_eight_op_one <= 64'd2;
		end
		if (data_y_mul_eight_vld && data_y_mul_eight_rdy) begin
			mul_eight_op_two <= sum_six;
		end
		if (data_x_div_four_vld && data_x_div_four_rdy) begin
			div_four_op_one <=  sum_seven;
		end
		if (data_y_div_four_vld && data_y_div_four_rdy) begin
			div_four_op_two <= product_eight [width : 1];
		end
		if (data_x_add_eight_vld && data_x_add_eight_rdy) begin
			add_eight_op_one <= sum_six;
		end
		if (data_y_add_eight_vld && data_y_add_eight_rdy) begin
			add_eight_op_two <= quotient_four [width + 2:2]; 
		end
		if (data_x_mul_nine_vld && data_x_mul_nine_rdy) begin
			mul_nine_op_one <= sum_eight;
		end
		if (data_y_mul_nine_vld && data_y_mul_nine_rdy) begin
			mul_nine_op_two <= sum_eight;
		end
		if (data_x_add_nine_vld && data_x_add_nine_rdy) begin
			add_nine_op_one <= product_nine[2*width-2:width-1];
		end
		if (data_x_mul_ten_rdy && data_x_mul_ten_vld) begin
			mul_ten_op_one <= 64'd2;
		end
		if (data_y_mul_ten_vld && data_y_mul_ten_rdy) begin
			mul_ten_op_two <= sum_eight;
		end
		if (data_x_div_five_vld && data_x_div_five_rdy) begin
			div_five_op_one <=  sum_nine;
		end
		if (data_y_div_five_vld && data_y_div_five_rdy) begin
			div_five_op_two <= product_ten [width : 1];
		end
		if (data_x_add_ten_vld && data_x_add_ten_rdy) begin
			add_ten_op_one <= sum_eight;
		end
		if (data_y_add_ten_vld && data_y_add_ten_rdy) begin
			add_ten_op_two <= quotient_five[width-1:0];
		end
	end


end



Serial_mul mul_one (
mul_one_op_one,
mul_one_op_two,
clk,
product_one,
asyn_reset,
data_x_mul_one_vld,
data_x_mul_one_rdy,
data_y_mul_one_vld,
data_y_mul_one_rdy,
d_out_mul_one_vld,
d_out_mul_one_rdy
);
Serial_add add_one (
add_one_op_one,
add_one_op_two,
sum_one,
cout_one,
clk,
asyn_reset,
data_x_add_one_vld,
data_x_add_one_rdy,
data_y_add_one_vld,
data_y_add_one_rdy,
d_out_add_one_vld,
d_out_add_one_rdy
);
Serial_div div_one(
div_one_op_one,
div_one_op_two,
quotient_one,
clk,
asyn_reset,
data_x_div_one_vld,
data_x_div_one_rdy,
data_y_div_one_vld,
data_y_div_one_rdy,
d_out_div_one_vld,
d_out_div_one_rdy
);
Serial_mul mul_two(
mul_two_op_one,
mul_two_op_two,
clk,
product_two,
asyn_reset,
data_x_mul_two_vld,
data_x_mul_two_rdy,
data_y_mul_two_vld,
data_y_mul_two_rdy,
d_out_mul_two_vld,
d_out_mul_two_rdy
);
Serial_add add_two (
add_two_op_one,
add_two_op_two,
sum_two,
cout_two,
clk,
asyn_reset,
data_x_add_two_vld,
data_x_add_two_rdy,
data_y_add_two_vld,
data_y_add_two_rdy,
d_out_add_two_vld,
d_out_add_two_rdy
);

Serial_mul mul_three (
mul_three_op_one,
mul_three_op_two,
clk,
product_three,
asyn_reset,
data_x_mul_three_vld,
data_x_mul_three_rdy,
data_y_mul_three_vld,
data_y_mul_three_rdy,
d_out_mul_three_vld,
d_out_mul_three_rdy
);
Serial_add add_three (
add_three_op_one,
add_three_op_two,
sum_three,
cout_three,
clk,
asyn_reset,
data_x_add_three_vld,
data_x_add_three_rdy,
data_y_add_three_vld,
data_y_add_three_rdy,
d_out_add_three_vld,
d_out_add_three_rdy
);
Serial_mul mul_four(
mul_four_op_one,
mul_four_op_two,
clk,
product_four,
asyn_reset,
data_x_mul_four_vld,
data_x_mul_four_rdy,
data_y_mul_four_vld,
data_y_mul_four_rdy,
d_out_mul_four_vld,
d_out_mul_four_rdy
);
Serial_div div_two(
div_two_op_one,
div_two_op_two,
quotient_two,
clk,
asyn_reset,
data_x_div_two_vld,
data_x_div_two_rdy,
data_y_div_two_vld,
data_y_div_two_rdy,
d_out_div_two_vld,
d_out_div_two_rdy
);
Serial_add add_four (
add_four_op_one,
add_four_op_two,
sum_four,
cout_four,
clk,
asyn_reset,
data_x_add_four_vld,
data_x_add_four_rdy,
data_y_add_four_vld,
data_y_add_four_rdy,
d_out_add_four_vld,
d_out_add_four_rdy
);
Serial_mul mul_five(
mul_five_op_one,
mul_five_op_two,
clk,
product_five,
asyn_reset,
data_x_mul_five_vld,
data_x_mul_five_rdy,
data_y_mul_five_vld,
data_y_mul_five_rdy,
d_out_mul_five_vld,
d_out_mul_five_rdy
);
Serial_add add_five (
add_five_op_one,
add_five_op_two,
sum_five,
cout_five,
clk,
asyn_reset,
data_x_add_five_vld,
data_x_add_five_rdy,
data_y_add_five_vld,
data_y_add_five_rdy,
d_out_add_five_vld,
d_out_add_five_rdy
);
Serial_mul mul_six(
mul_six_op_one,
mul_six_op_two,
clk,
product_six,
asyn_reset,
data_x_mul_six_vld,
data_x_mul_six_rdy,
data_y_mul_six_vld,
data_y_mul_six_rdy,
d_out_mul_six_vld,
d_out_mul_six_rdy
);
Serial_div div_three(
div_three_op_one,
div_three_op_two,
quotient_three,
clk,
asyn_reset,
data_x_div_three_vld,
data_x_div_three_rdy,
data_y_div_three_vld,
data_y_div_three_rdy,
d_out_div_three_vld,
d_out_div_three_rdy
);
Serial_add add_six (
add_six_op_one,
add_six_op_two,
sum_six,
cout_six,
clk,
asyn_reset,
data_x_add_six_vld,
data_x_add_six_rdy,
data_y_add_six_vld,
data_y_add_six_rdy,
d_out_add_six_vld,
d_out_add_six_rdy
);
Serial_mul mul_seven(
mul_seven_op_one,
mul_seven_op_two,
clk,
product_seven,
asyn_reset,
data_x_mul_seven_vld,
data_x_mul_seven_rdy,
data_y_mul_seven_vld,
data_y_mul_seven_rdy,
d_out_mul_seven_vld,
d_out_mul_seven_rdy
);
Serial_add add_seven (
add_seven_op_one,
add_seven_op_two,
sum_seven,
cout_seven,
clk,
asyn_reset,
data_x_add_seven_vld,
data_x_add_seven_rdy,
data_y_add_seven_vld,
data_y_add_seven_rdy,
d_out_add_seven_vld,
d_out_add_seven_rdy
);
Serial_mul mul_eight(
mul_eight_op_one,
mul_eight_op_two,
clk,
product_eight,
asyn_reset,
data_x_mul_eight_vld,
data_x_mul_eight_rdy,
data_y_mul_eight_vld,
data_y_mul_eight_rdy,
d_out_mul_eight_vld,
d_out_mul_eight_rdy
);
Serial_div div_four(
div_four_op_one,
div_four_op_two,
quotient_four,
clk,
asyn_reset,
data_x_div_four_vld,
data_x_div_four_rdy,
data_y_div_four_vld,
data_y_div_four_rdy,
d_out_div_four_vld,
d_out_div_four_rdy
);
Serial_add add_eight (
add_eight_op_one,
add_eight_op_two,
sum_eight,
cout_eight,
clk,
asyn_reset,
data_x_add_eight_vld,
data_x_add_eight_rdy,
data_y_add_eight_vld,
data_y_add_eight_rdy,
d_out_add_eight_vld,
d_out_add_eight_rdy
);
Serial_mul mul_nine(
mul_nine_op_one,
mul_nine_op_two,
clk,
product_nine,
asyn_reset,
data_x_mul_nine_vld,
data_x_mul_nine_rdy,
data_y_mul_nine_vld,
data_y_mul_nine_rdy,
d_out_mul_nine_vld,
d_out_mul_nine_rdy
);
Serial_add add_nine (
add_nine_op_one,
add_nine_op_two,
sum_nine,
cout_nine,
clk,
asyn_reset,
data_x_add_nine_vld,
data_x_add_nine_rdy,
data_y_add_nine_vld,
data_y_add_nine_rdy,
d_out_add_nine_vld,
d_out_add_nine_rdy
);
Serial_mul mul_ten(
mul_ten_op_one,
mul_ten_op_two,
clk,
product_ten,
asyn_reset,
data_x_mul_ten_vld,
data_x_mul_ten_rdy,
data_y_mul_ten_vld,
data_y_mul_ten_rdy,
d_out_mul_ten_vld,
d_out_mul_ten_rdy
);
Serial_div div_five(
div_five_op_one,
div_five_op_two,
quotient_five,
clk,
asyn_reset,
data_x_div_five_vld,
data_x_div_five_rdy,
data_y_div_five_vld,
data_y_div_five_rdy,
d_out_div_five_vld,
d_out_div_five_rdy
);
Serial_add add_ten (
add_ten_op_one,
add_ten_op_two,
sum_ten,
cout_ten,
clk,
asyn_reset,
data_x_add_ten_vld,
data_x_add_ten_rdy,
data_y_add_ten_vld,
data_y_add_ten_rdy,
d_out_add_ten_vld,
d_out_add_ten_rdy
);
endmodule
