//一位LED的PWM呼吸灯

module pwmled (
    clk ,
    rst_n ,
    led 

);

//模块端口定义

input     clk     ;
input     rst_n   ;
output    led     ;
reg       led     ;
//10ms端口定义
//cnt0 500_000 二进制是19位
reg [18:0] cnt0   ;
wire      add_cnt0;
wire      end_cnt0;


//2s模块端口定义
reg [7:0]  cnt1    ;
wire       add_cnt1;
wire       end_cnt1;

//10次计数器模块端口定义
reg [3:0]  cnt2    ;
wire       add_cnt2;
wire       end_cnt2;

//对变量x进行端口说明
//x最大是475_000需要19根线
reg [18:0]        x;




//10ms计数器
//主频50MHZ 周期20ns 
// 10_000_000/20 = 500_000 ;
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt0 <= 0;
    end
    else if(add_cnt0)begin
        if(end_cnt0)
            cnt0 <= 0;
        else
            cnt0 <= cnt0 + 1;
    end
end

assign add_cnt0 = 1 ;       
assign end_cnt0 = add_cnt0 && cnt0== 500_000-1 ;   

// 2s计数器模块
// 两种设计方法
// 主频50MHZ 周期20ns
// 2_000_000_000/20 =100_000_000;
// 以10ms为基础，2_000_000_000/ 10_000_000 = 200
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt1 <= 0;
    end
    else if(add_cnt1)begin
        if(end_cnt1)
            cnt1 <= 0;
        else
            cnt1 <= cnt1 + 1;
    end
end

assign add_cnt1 = end_cnt0 ;       
assign end_cnt1 = add_cnt1 && cnt1== 200-1 ;   

//1-10计数器，每隔2s加1
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt2 <= 0;
    end
    else if(add_cnt2)begin
        if(end_cnt2)
            cnt2 <= 0;
        else
            cnt2 <= cnt2 + 1;
    end
end

assign add_cnt2 = end_cnt1 ;       
assign end_cnt2 = add_cnt2 && cnt2== 10-1 ;   

// 10ms计数器到达时变0 
always @(posedge clk or negedge rst_n)
begin
    if (rst_n ==1'b0)begin
        led <= 0 ;
    end 
    else if(add_cnt0 && cnt0 == x-1) begin 
          led <= 1 ;
      
    end
    else if(end_cnt0) begin
         led <= 0 ;
     end
end


always @(*)
begin 
    if(cnt2 == 0) begin
        x = 475_000 ;
    end 
    else if(cnt2==1)begin
        x =425_000;
    end
    else if (cnt2==2)begin
        x =350_000;
    end
    else if(cnt2==3)begin
        x =250_000;
    end
    else if(cnt2==4)begin
        x = 100_000;
    end
    else if(cnt2==5)begin 
        x = 100_000;
    end
    else if(cnt2==6)begin
        x = 250_000;
    end
    else if(cnt2==7)begin
        x =350_000;
    end
    else if(cnt2==8)begin
        x =425_000;
    end
    else begin
        x =475_000;
    end
end


endmodule






























