`include "ring_pkg.sv"
`include "./design/gold_ring.v"// DUT
`include "./design/output_ctrl.v"
`include "./design/path_input_ctrl.v"
`include "./design/router_input_ctrl.v"
`include "./design/router_node.v"
`include "./design/nic.v"
`include "ring_if.sv"//Interface
`include "./tc/ring_case.sv"// Testcase

module ring_tb_top;
    import uvm_pkg::*;
    import ring_pkg::*;
    reg clk;
    reg reset;
    ring_if U_ring_if(clk,clk);//instantiation
    gold_ring U_GOLD_RING(    
    .clk(clk),
    .reset(reset),

    .node0_pesi(U_ring_if.node0_pesi),
    .node0_pedi(U_ring_if.node0_pedi),
    .node0_peri(U_ring_if.node0_peri),
    .node0_pero(U_ring_if.node0_pero),
    .node0_peso(U_ring_if.node0_peso),
    .node0_pedo(U_ring_if.node0_pedo),
    .node0_polarity(U_ring_if.node0_polarity),

    .node1_pesi(U_ring_if.node1_pesi),
    .node1_pedi(U_ring_if.node1_pedi),
    .node1_peri(U_ring_if.node1_peri),
    .node1_pero(U_ring_if.node1_pero),
    .node1_peso(U_ring_if.node1_peso),
    .node1_pedo(U_ring_if.node1_pedo),
    .node1_polarity(U_ring_if.node1_polarity),

    .node2_pesi(U_ring_if.node2_pesi),
    .node2_pedi(U_ring_if.node2_pedi),
    .node2_peri(U_ring_if.node2_peri),
    .node2_pero(U_ring_if.node2_pero),
    .node2_peso(U_ring_if.node2_peso),
    .node2_pedo(U_ring_if.node2_pedo),
    .node2_polarity(U_ring_if.node2_polarity),

    .node3_pesi(U_ring_if.node3_pesi),
    .node3_pedi(U_ring_if.node3_pedi),
    .node3_peri(U_ring_if.node3_peri),
    .node3_pero(U_ring_if.node3_pero),
    .node3_peso(U_ring_if.node3_peso),
    .node3_pedo(U_ring_if.node3_pedo),
    .node3_polarity(U_ring_if.node3_polarity));

    initial begin// generate clock
        clk = 0;
        reset = 1;
        forever begin
            #10;clk = ~clk;
        end

        #30 reset = 0;
    end
    
    initial begin//use config_db's set to inform interface to driver and moniter
        // so that driver and monitor can communicate with DUT
        uvm_config_db#(virtual ring_if)::set(null,"uvm_test_top.env.input_agt.drv","ring_if",U_ring_if);
        uvm_config_db#(virtual ring_if)::set(null,"uvm_test_top.env.output_agt.mon","ring_if",U_ring_if);
        run_test();//run uvm
    end
endmodule
