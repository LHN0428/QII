
module uart(

    clk       ,
    rst_n     ,
    rx_uart   ,
    led 
);

input         clk      ;
input         rst_n    ;
input         rx_uart  ;
output [7:0]  led      ;
reg    [7:0]  led      ;    


//5280计数器端口定义
reg [12:0] cnt0        ;
wire       add_cnt0    ;
wire       end_cnt0    ;


//记录位数端口定义
reg [3:0]  cnt1         ;
wire       add_cnt1     ;
wire       end_cnt1     ;

//辅助信号flag_add定义
reg        flag_add     ;


//打两个节拍同步信号的定义
reg        rx_uart_ff0  ;
reg        rx_uart_ff1  ;
reg        rx_uart_ff2  ;


//波特率设置为9600，1bit指的是每秒传输1bit
//则每位的持续时间是1s/9600 = 104166ns
//开发板的晶振时钟是50MZ 
//104166/20 = 5208 个时钟周期
//这只是一个大概的时钟周期，实际会有偏差
//
//添加了一个辅助信号flag_add,来判断cnt0和cnt1是否开始计数
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt0 <= 0;
    end
    else if(add_cnt0)begin
        if(end_cnt0)
            cnt0 <= 0;
        else
            cnt0 <= cnt + 1;
    end
end

assign add_cnt0 =flag_add ;       
assign end_cnt0 = add_cnt0 && cnt0 == 5280-1 ; 


//此计数器计数传输了多少bit
//当数到5280时计数器就加一，
//一共可以数到九位
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt1 <= 0;
    end
    else if(add_cnt)begin
        if(end_cnt1)
            cnt1 <= 0;
        else
            cnt1 <= cnt1 + 1;
    end
end

assign add_cnt1 = end_cnt0;       
assign end_cnt1 = add_cnt1 && cnt1== 9-1 ;   



//flag_add 是由rx_uart的边沿来确定

//边沿检测电路
/*
always @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0) begin
        tri_ff0 <= 0;
    end
    else begin 
        tri_ff0 <= tigger ;
    end
end
// 先1后0 neg_edge 是下降沿的标志位
// 先0后1 pos_edge 是上升沿的标志位
assign neg_edge = trigger ==0 && tri_ff0==1 ;
assign pos_edge = trigger ==1 && tri_ff0==0 ;
*/


//异步时钟同化，通过打两拍的方式实现信号的同步化
//通过打一拍的方式实现边沿检测，
always @(poedge clk or negedge rst_n) begin 
    if(rst_n ==1'b0) begin 
        rx_uart_ff0 <= 1 ;
        rx_uart_ff1 <= 1 ;
        rx_uart_ff2 <= 1 ;
    end
    else begin 
        rx_uart_ff0 <= rx_uart     ;
        rx_uart_ff1 <= rx_uart_ffo ;
        rx_uart_ff2 <= rx_uart_ff1 ;
    end
end

always @(posedge clk or negedge rst_n)begin
    if(rst_n ==1'b0)begin
        flag_add <= 0 ;
    end
    else if(rx_uart_ff1==0&&rx_uart_ff2==1) begin
        flag_add <= 1 ;
    end
    else if(end_cnt1) begin
        flag_add <= 0 ;
    end
end


always @(posedge clk or negedge rst_n) begin 
     if(rst_n == 1'b0) begin 
         led <= 8'hff ;
     end
     else if(add_cnt0 && cnt0 ==5208/2-1)begin
          if(cnt1=1)
              led[0] <= rx_uart_ff1 ; 
          else if(cnt1=2)
              led[1] <= rx_uart_ff1 ;
          else if(cnt1=3)
              led[2] <= rx_uart_ff1 ;
          else if(cnt1=4)
              led[3] <= rx_uart_ff1 ;
          else if(cnt1=5)
              led[4] <= rx_uart_ff1 ;
          else if(cnt1=6)
              led[5] <= rx_uart_ff1 ;
          else if(cnt1=7)
              led[6] <= rx_uart_ff1 ;
          else
              led[7] <= rx_uart_ff1 ;
      end
  end

//此代码是上面一段代码的优化 
/*  always@(posedge clk or negedge rst_n) begin
      if(rst_n ==1'b0) begin
          led <= 0 ;
      end
      else if(add_cnt0 && cnt0=5208/2-1&&cnt1>=1&&cnt1<=9)
           begin 
           led[cnt1-1] <= rx_uart_ff1 ;
       end
   end
   
*/

endmodule 

 






































