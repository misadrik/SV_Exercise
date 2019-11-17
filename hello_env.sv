//`include "uvm_macros.svh"//env������UVM��֤ƽ̨�Ĵ�����
`include "hello_scoreboard.sv"
`include "reference_model.sv"
//import uvm_pkg::*;

class hello_env extends uvm_env;
    hello_agent input_agt;//������DUT����������ʵ�����У�����ΪACTIVEģʽ
    hello_agent output_agt;//������DUT�������ݣ�����ΪPASSIVEģʽ 
    hello_model my_hello_model;//ʵ����model��scoreboard
    hello_scoreboard my_hello_scb;
//����������fifo����������scoreboard�������ӿں�reference model��һ���ӿ�
    uvm_tlm_analysis_fifo #(hello_transaction) agt_scb_fifo;//o_agt<==>scb
    uvm_tlm_analysis_fifo #(hello_transaction) agt_mdl_fifo;//i_agt<==>ref
    uvm_tlm_analysis_fifo #(hello_transaction) mdl_scb_fifo;//ref  <==>scb

    extern function new(string name,uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
    `uvm_component_utils(hello_env)

endclass

function hello_env::new(string name,uvm_component parent);
    super.new(name,parent);
endfunction

function void hello_env::build_phase(uvm_phase phase);
    super.build_phase(phase);
    input_agt = new("input_agt",this);
    output_agt = new("output_agt",this);
    input_agt.is_active = UVM_ACTIVE;//����input_agentΪACTIVEģʽ
    output_agt.is_active = UVM_PASSIVE;//����output_agentΪPASSIVEģʽ
    my_hello_model = new("my_hello_model",this);
    my_hello_scb = new ("my_hello_scb",this);
    agt_scb_fifo = new ("agt_scb_fifo",this);
    agt_mdl_fifo = new ("agt_mdl_fifo",this);
    mdl_scb_fifo = new ("mdl_scb_fifo",this);
endfunction

function void hello_env::connect_phase(uvm_phase phase);
    super.build_phase(phase);
    input_agt.ap.connect(agt_mdl_fifo.analysis_export);//i_agt=>fifo
    my_hello_model.port.connect(agt_mdl_fifo.blocking_get_export);//fifo=>reference_model
    my_hello_model.ap.connect(mdl_scb_fifo.analysis_export);//reference_model=>fifo
    my_hello_scb.exp_port.connect(mdl_scb_fifo.blocking_get_export);//fifo=>scoreboard
    output_agt.ap.connect(agt_scb_fifo.analysis_export);//o_agt=>fifo
    my_hello_scb.act_port.connect(agt_scb_fifo.blocking_get_export);//fifo=>scoreboard
endfunction