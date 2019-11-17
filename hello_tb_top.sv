`include "hello_pkg.sv"
`include "./design/gold_ring.v"// DUT
`include "hello_if.sv"//Interface
`include "./tc/hello_case.sv"// Testcase

module hello_tb_top;
    import uvm_pkg::*;
    import hello_pkg::*;
    reg clk;
    reg reset;
    hello_if my_hello_if(clk,clk);//ÊµÀý»¯½Ó¿Ú
    gold_ring U_GOLD_RING(    
    .clk(clk),
    .reset(),

    .node0_pesi(),
    .node0_pedi(),
    .node0_peri(),
    .node0_pero(),
    .node0_peso(),
    .node0_pedo(),
    .node0_polarity(),

    .node1_pesi(),
    .node1_pedi(),
    .node1_peri(),
    .node1_pero(),
    .node1_peso(),
    .node1_pedo(),
    .node1_polarity(),

    .node2_pesi(),
    .node2_pedi(),
    .node2_peri(),
    .node2_pero(),
    .node2_peso(),
    .node2_pedo(),
    .node2_polarity(),

    .node3_pesi(),
    .node3_pedi(),
    .node3_peri(),
    .node3_pero(),
    .node3_peso(),
    .node3_pedo(),
    .node3_polarity);//ÊµÀý»¯DUT,²¢½«DUTµÄÊäÈëÊä³ö¶Ë¿ÚºÍmy_hello_ifÁ¬½ÓÔÚÒ»Æð

    initial begin//²úÉúDUTÐèÒªµÄÊ±ÖÓ
        clk = 0;
        forever begin
            #10;clk = ~clk;
        end
    end
    
    initial begin//Í¨¹ýconfig_dbµÄset·½Ê½½«my_ifÍ¨ÖªdriverºÍmonitor
        //´Ó¶øDriverºÍmonitor¿ÉÒÔÖ±½ÓºÍDUTÍ¨ÐÅ¡£
        uvm_config_db#(virtual hello_if)::set(null,"uvm_test_top.env.input_agt.drv","hello_if",my_hello_if);
        uvm_config_db#(virtual hello_if)::set(null,"uvm_test_top.env.output_agt.mon","hello_if",my_hello_if);
        run_test();//Æô¶¯UVM
    end
endmodule
