//ͨ��rxd�������ݣ���ͨ��txd���ͳ�ȥ
//rx_dv��tx_dv�ǽ��պͷ������ݵ���Чָʾ
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
