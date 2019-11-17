//`include "uvm_macros.svh"
//import uvm_pkg::*;

class hello_transaction extends uvm_sequence_item;
    rand bit [47:0] dmac;
    rand bit [47:0] smac;
    rand bit [15:0] ether_type;
    rand byte pload[];
    rand bit [31:0] crc;//������Ա������pload��ŵ����غ�

    constraint cons_pload_size {
        pload.size >=46;
        pload.size <=1500;
    }
    extern function new (string name = "hello_transaction");
    `uvm_object_utils_begin(hello_transaction)
        `uvm_field_int(dmac,UVM_ALL_ON)
        `uvm_field_int(smac,UVM_ALL_ON)
        `uvm_field_int(ether_type,UVM_ALL_ON)
        `uvm_field_array_int(pload,UVM_ALL_ON)
        `uvm_field_int(crc,UVM_ALL_ON);
    `uvm_object_utils_end//������Ϊ�˼���factoryʵ�֣�����factoryʵ��Ҫʹ�õ�uvm_object_utilsҪʹ�õĺ�
endclass

function hello_transaction::new(string name = "hello_transaction");
    super.new(name);
endfunction
