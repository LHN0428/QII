//模块说明，这是一个四位的呼吸灯设计
//
module huxiled(
	 
	 clk ,
	 rst_n ,
	 led0 ,
	 led1 ,
	 led2,
	 led3

);

//端口定义
input           clk      ;
input           rst_n    ;
output          led0     ;
output          led1     ;
output          led2     ;
output          led3     ;

//输出端口寄存器定义
reg             led0     ;
reg             led1     ;
reg             led2     ;
reg             led3     ;


//计数器1s模块定义
reg   [25:0]    cnt0     ;
wire            add_cnt0 ;
wire            end_cnt0 ;

//计数器14s模块定义
reg   [3:0]     cnt1     ;
wire            add_cnt1 ;
wire            end_cnt1 ;


//  此模块是一个1s的计数器
//  主频为50M，周期是20ns 
//  1s = 2X10^9 ns
//  当计数器计数到50_000_000时认为1s到了

always@(posedge clk or negedge rst_n)
begin
    if(!rst_n) begin 
        cnt0 <= 0 ;
    end
    else if(add_cnt0) begin 
        if(end_cnt0)
            cnt0 <= 0 ;
        else 
            cnt0 <= cnt0 + 1 ;
    end
end

assign add_cnt0 = 1 ;
assign end_cnt0 = add_cnt0 && cnt0 == 50_000_000 -1 ;


//此模块是一个14s的计数器
//和上面的加操作是不一样的，当1s模块到了之后才进行加14s的操作
//相当于两个模块套在一起使用
always @(posedge clk or negedge rst_n) 
begin
    if(!rst_n) begin 
        cnt1<= 0 ;
    end 
    else if (add_cnt1) begin
         if(end_cnt1)
             cnt1 <= 0 ;
         else 
             cnt1 <= cnt1 + 1 ;
     end
end
//end_cnt0当计数为1时才进行加1操作
assign add_cnt1 = end_cnt0 ;               
assign end_cnt1 = add_cnt1 && cnt1 == 14 - 1 ;


//LED0 在第1s的灭，第2s亮
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        led0 <= 0;
    end
    else if(add_cnt1 && cnt1==1-1)begin
        led0 <= 1;
    end
    else if(add_cnt1 && cnt1==2-1)begin
        led0 <= 0;
    end
end

//LED1 在第3秒亮 第5s灭

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        led1 <= 0;
    end
    else if(add_cnt1 && cnt1==3-1)begin
        led1 <= 1;
    end
    else if(add_cnt1 && cnt1==5-1)begin
        led1 <= 0;
    end
end

//LED2 在第6秒亮 第9s灭
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        led2 <= 0;
    end
    else if(add_cnt1 && cnt1==6-1)begin
        led2 <= 1;
    end
    else if(add_cnt1 && cnt1==9-1)begin
        led2 <= 0;
    end
end

//LED3 在第10秒亮 第14s灭
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        led3 <= 0;
    end
    else if(add_cnt1 && cnt1==10-1)begin
        led3 <= 1;
    end
    else if(end_cnt1)begin    //  end_cnt1 = add_cnt1 && cnt1 == 14 - 1 
        led3 <= 0;
    end
end


endmodule























