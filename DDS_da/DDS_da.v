


module DDS_da(

	clk ;
	rst_n ;
	dac_mode ;
	dac_clka ;
	dac_da    ;
	dac_wra  ;
	dac_sleep 

	); 

//parameter  ma = 8 ;

input  clk ;
input  rst_n ;
output dac_mode ;
output dac_sleep ;
output dac_wra ;
output [8-1:0]dac_da ;
output dac_clka;


reg [4:0] cnt0 ;
wire      add_cnt0 ;
wire 	  end_cnt0 ;

reg [7:0] cnt1 ;
wire      add_cnt1 ;
wire 	  end_cnt1 ;

reg [2;0] cnt2 ;
wire 	  add_cnt2 ;
wire 	  end_cnt2 ;

reg [3:0] cnt3 ;
wire 	  add_cnt3 ;
wire 	  end_cnt3 ;

reg [1:0]  x ;
reg [7:0]  y ;

reg [6:0] addr ;
reg [7:0] sin_data ;

reg [7:0] dac_da ;
wire      dac_wra ;
wire 	  dac_clka ;
wire 	  dac_mode ;



always @(posedge clk or negedge rst) begin
	if (!rst) begin
		
	   cnt0 <= 0 ;
		
	end
	else if (add_cnt0) begin
	if (end_cnt0) 
		cnt0 <= 0 ;
	else
		cnt0 <= cnt0 + 1 ; 
	end
	end

	assign add_cnt0  = 1 ;
	assign end_cnt0 = add_cnt0 && cnt0 == x - 1;


always @(posedge clk or negedge rst) begin
	if (!rst) begin
		
	   cnt1<= 0 ;
		
	end
	else if (add_cnt1) begin
	if (end_cnt1) 
		cnt1 <= 0 ;
	else
		cnt1 <= cnt1 + 1 ; 
	end
	end

	assign add_cnt1  = add_cnt0 ;
	assign end_cnt1 = add_cnt1 && cnt1 == y - 1;

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		
	   cnt2<= 0 ;
		
	end
	else if (add_cnt2) begin
	if (end_cnt2) 
		cnt2 <= 0 ;
	else
		cnt2 <= cnt2 + 1 ; 
	end
	end

	assign add_cnt2  = end_cnt1 ;
	assign end_cnt2 = add_cnt2 && cnt2 == 2 - 1;


always @(posedge clk or negedge rst) begin
	if (!rst) begin
		
	   cnt3<= 0 ;
		
	end
	else if (add_cnt3) begin
	if (end_cnt3) 
		cnt3 <= 0 ;
	else
		cnt3 <= cnt3 + 1 ; 
	end
	end

	assign add_cnt3  = end_cnt2 ;
	assign end_cnt3 = add_cnt3 && cnt3 == 6 - 1;


always @(*)begin
	if(cnt3 == 0) begin
		x = 1 ;
		y = 8 ;
	end
	else if(cnt3 == 1 ) begin
		x = 1 ;
		y = 16 ;
	end
	else if(cnt3 == 2 ) begin
		x = 1 ;
		y = 32;
	end
	else if(cnt3 == 3) begin
		x = 1 ;
		y = 64 ;
	end
	else if(cnt3 == 4 ) begin
		x = 1 ;
		y = 128 ;
	end
	else  begin
		x = 2 ;
		y = 128 ;
	end
end

always @(posedge clk or negedge rst) begin
	if (rst==1'b0) begin
	 dac_da <= 0 ;
	end
	else  begin
	  dac_da <= 255-sin_data
	end
end


always @(*) begin
	case(addr)
	0 : sin_data = 8'h7f ;
	1 : sin_data = 8'h85 ;
	2 : sin_data = 8'h8c ;
end




always @(*) begin
	if(cnt3 == 0)
	addr = cnt1 * 16 ;
	else if(cnt3 == 1)
	addr = cnt1 * 8;
	else if(cnt3 == 2)
	addr = cnt1 * 4 ;
	else if (cnt4 ==3)
	addr = cnt1 * 2 ;
	else if (cnt3==4)
	addr = cnt1 * 1 ;
	else 
	addr = cnt1 * 1 ;
	end



	assign dac_sleep = 0 ;
	assign dac_wra = dac_clka ;
	assign dac_clka = ~clk ;
	assign dac_mode = 1 ;



	endmodule 