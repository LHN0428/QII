  * File Name: my_time
  * Author: Vcatus
  * Version: V1.0
  * Date: 2019-5-15
  * Brief: 本文对项目进行详细说明
  * my_shizhong.v文件是时间功能，数码管显示
  
  ******************************************************************************************************
  * 实现功能
    * 平常的闹钟计时功能
    * 因为在平常1s会跑的很慢，所以我调整了计数时间
  ******************************************************************************************************
  * 首先因为数码管是每次只能亮一个，所以做一个2ms的计数器，进行轮循，给人感觉是六个数码管都在亮
  * 需要一个2ms的计数模块，然后每次使能一个
  * 六个数码管通过2ms进行计数，最高为六
  * 当为六是进行片选端端移位
  *
  *******************************************************************************************************
  * 使能一个数码管显示电路，这个可以直接封装好
  * 用case语句进行数码管显示电路
  *
  *******************************************************************************************************
  * 根据数据的选择电路，计数器计到几就对显示第几个，一般来说高位显示小时，低位显示秒
  * 然后将此时的计数值给显示模块进行显示
  * 
  *******************************************************************************************************
  * 设计一个1s的计数器模块
  * 秒的个位根据1s来进行加
  * 秒的十位根据秒的个位加到9时就加
  * 具体设计见代码，很简单的逻辑
  *
   *******************************************************************************************************
   * 最需要注意的是小时数值选择
   * 当小时的十位为2时它的个位最大只能到4
   * 当小时的十位为1时则最大可以到10 ，
   * 这个是需要注意的地方。
   *
