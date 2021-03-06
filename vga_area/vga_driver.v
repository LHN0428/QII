
module vga_driver (
	
		rst 		 ,
		clk 		 ,
		hys			 ,
		vys 		 ,
		lcd_rgb 

);

input   clk 	       ;
input   rst 		   ;
output  hys            ;
output  vys			   ;
output  [15:0] lcd_rgb ;

//信号模块设计
reg [9:0] 	h_cnt 	   ;
wire 		add_h_cnt  ;
wire 		end_h_cnt  ;

reg [9:0]   v_cnt      ;
wire 		add_v_cnt  ;
wire 		end_v_cnt  ;

reg [15:0]  lcd_rgb    ;

reg 		hys 		;
reg         vys  		;

reg [19:0]  diatance    ;
reg         vaild_area  ;
reg 		rom_area    ;

reg [12:0]  rom_addr 	;



//产生一个800周期的clk时钟

always @(posedge clk or negedge rst) begin
	if (rst==1'b0) begin
		h_cnt <= 0 ;
	end
	else if (add_h_cnt) begin
		 if(end_h_cnt)
		 h_cnt <= 0 ;
		 else 
		 h_cnt <= h_cnt + 1 ;
	end
end
assign add_h_cnt = 1 ;
assign end_h_cnt = add_h_cnt && h_cnt == 800 - 1    ;



//
always @(posedge clk or negedge rst) begin
	if (rst==1'b0) begin
		hys <= 0 ;
	end
	else if (add_h_cnt && h_cnt ==96 -1) begin
	    hys <= 1 ;
	end
	else if(end_h_cnt) begin 
		hys <= 0 ;
    end
end


 //  时钟v_cnt 的一个基准时钟
 //  计数行的计数器

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		v_cnt <= 0 ;
	end
	else if (add_v_cnt) begin 
		 if(end_v_cnt)
		 v_cnt <= 0 ;
		 else 
		 v_cnt <= v_cnt + 1 ; 
	end
end

assign  add_v_cnt = 1 ;
assign  end_v_cnt =  add_v_cnt && v_cnt == 525 - 1 ;


// vys信号通过计数器v_cnt时钟

always @(posedge clk or negedge rst) begin
	if (!rst) begin
		vys <= 1'b0 ;
	end
	else if (add_v_cnt && v_cnt == 2 - 1) begin
		vys <= 1'b1 ;
		end
		else if(end_v_cnt)begin 
		vys <= 1'b0 ;
	end
end


// lcd_rgb信号，显示红色，需要在显示区域的时候才能开始赋值16'b11111_00000_0000
//场同步信号和行同步信号都处在显示区域c的阶段，
// 通过时序图知道h_cnt大于(96+48)并且小于（96+48+640）
// v_cnt大于(2+33)并且小于(2+33+480),
//添加一个信号red_area ，当为高电平时候就表示为此区域

always @(*) begin
	distance <=  (h_cnt -(96+48+320) * (h_cnt -(96+48+320)) +
	(v_cnt -(2+33+240)*(v_cnt-(2+33+240)) ;

end

always @(*) begin
	
	green_area = diatance < 2500 ;
end


always @(*) begin
	
	vaild_area = h_cnt>=(96+48) &&h_cnt<(86+48+640)&&v_cnt>=(2+33)&&v_cnt <(2+33+480)

end


always @(posedge clk or negedge rst) begin
	if (!rst) begin
		lcd_rgb <= 16'h0 ;
	end
	else if (vaild_area) begin 
		 if(green_area) begin
		 lcd_rgb <= 16'hfc0 ;
		 end
		 else begin
		 lcd_rgb <= 16'hfff ; 
		 end
	end
	else begin
		lcd_rgb <= 0 ;
	end
end





endmodule 


