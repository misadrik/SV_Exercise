//`include "uvm_macros.svh"
//import uvm_pkg::*;

class ring_sequencer extends uvm_sequencer #(ring_transaction);
    //Component
    extern function new (string name, uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    //extern task ring_sequencer::main_phase(uvm_phase phase);

    //Register
    `uvm_component_utils(ring_sequencer)
endclass

function ring_sequencer::new(string name , uvm_component parent);
    super.new(name,parent);
endfunction
/*task ring_sequencer::main_phase(uvm_phase phase);//sequenceͨ�����·�ʽ����
    ring_sequence my_seq;//ʵ����һ��sequence
    super.main_phase(phase);
    my_seq = new("my_seq");//����my_seq��start����������Ĳ�����input_agt.sqr,
    //��Ҫָ�����sequence�����Ǹ�sequencer�������ݣ�
    my_seq.starting_phase = phase;
    my_seq.start(this);//my_seq��body��ʼִ��
endtask*/
function void ring_sequencer::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction
//ring_sequencer��һ�����������࣬�������ring_transaction,���ڱ������
//sequencerֻ�ܲ���ring_transaction���͵�����
