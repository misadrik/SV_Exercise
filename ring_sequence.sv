//`include "uvm_mocras.svh"
//import uvm_pkg::*;

class ring_sequence extends uvm_sequence #(ring_transaction);
    ring_transaction m_trans;

    extern function new(string name ="ring_sequence");
    virtual task body();
        if(starting_phase != null)
            starting_phase.raise_objection(this);
        repeat(100) begin
            `uvm_do(m_trans)//向sequencer发送1个数据
         end
        #100;
        if(starting_phase != null)
            starting_phase.drop_objection(this);
    endtask

    `uvm_object_utils(ring_sequence)
endclass

function ring_sequence::new(string name = "ring_sequence");
    super.new(name);
endfunction
