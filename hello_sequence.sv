//`include "uvm_mocras.svh"
//import uvm_pkg::*;

class hello_sequence extends uvm_sequence #(hello_transaction);
    hello_transaction m_trans;

    extern function new(string name ="hello_sequence");
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

    `uvm_object_utils(hello_sequence)
endclass

function hello_sequence::new(string name = "hello_sequence");
    super.new(name);
endfunction
