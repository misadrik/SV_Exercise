//`include "uvm_macros.svh"//env������UVM��֤ƽ̨�Ĵ�����
`include "ring_scoreboard.sv"
`include "reference_model.sv"
//import uvm_pkg::*;

class ring_env extends uvm_env;
    ring_agent input_agt;//������DUT����������ʵ�����У�����ΪACTIVEģʽ
    ring_agent output_agt;//������DUT�������ݣ�����ΪPASSIVEģʽ 
    ring_model my_ring_model;//ʵ����model��scoreboard
    ring_scoreboard my_ring_scb;
//����������fifo����������scoreboard�������ӿں�reference model��һ���ӿ�
    uvm_tlm_analysis_fifo #(ring_transaction) agt_scb_fifo;//o_agt<==>scb
    uvm_tlm_analysis_fifo #(ring_transaction) agt_mdl_fifo;//i_agt<==>ref
    uvm_tlm_analysis_fifo #(ring_transaction) mdl_scb_fifo;//ref  <==>scb

    extern function new(string name,uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
    `uvm_component_utils(ring_env)

endclass

function ring_env::new(string name,uvm_component parent);
    super.new(name,parent);
endfunction

function void ring_env::build_phase(uvm_phase phase);
    super.build_phase(phase);
    input_agt = new("input_agt",this);
    output_agt = new("output_agt",this);
    input_agt.is_active = UVM_ACTIVE;//����input_agentΪACTIVEģʽ
    output_agt.is_active = UVM_PASSIVE;//����output_agentΪPASSIVEģʽ
    my_ring_model = new("my_ring_model",this);
    my_ring_scb = new ("my_ring_scb",this);
    agt_scb_fifo = new ("agt_scb_fifo",this);
    agt_mdl_fifo = new ("agt_mdl_fifo",this);
    mdl_scb_fifo = new ("mdl_scb_fifo",this);
endfunction

function void ring_env::connect_phase(uvm_phase phase);
    super.build_phase(phase);
    input_agt.ap.connect(agt_mdl_fifo.analysis_export);//i_agt=>fifo
    my_ring_model.port.connect(agt_mdl_fifo.blocking_get_export);//fifo=>reference_model
    my_ring_model.ap.connect(mdl_scb_fifo.analysis_export);//reference_model=>fifo
    my_ring_scb.exp_port.connect(mdl_scb_fifo.blocking_get_export);//fifo=>scoreboard
    output_agt.ap.connect(agt_scb_fifo.analysis_export);//o_agt=>fifo
    my_ring_scb.act_port.connect(agt_scb_fifo.blocking_get_export);//fifo=>scoreboard
endfunction
