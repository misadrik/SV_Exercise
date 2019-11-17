//通过rxd接收数据，再通过txd发送出去
//rx_dv和tx_dv是接收和发送数据的有效指示
module dut(clk,
           rxd,
           rx_dv,
           txd,
           tx_en);
    input clk;
    input [7:0] rxd;
    input rx_dv;
    output [7:0] txd;
    output tx_en;
    reg [7:0] txd;
    reg tx_en;
    
    always @(posedge clk)begin
        txd <= rxd;
        tx_en <= rx_dv;
    end
endmodule
