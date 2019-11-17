//`include "uvm_macros.svh"
//import uvm_pkg::*;

class ring_agent extends uvm_agent;
    ring_sequencer sqr;
    ring_driver drv;
    ring_monitor mon;

    extern function new (string name,uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);

    uvm_analysis_port#(ring_transaction) ap;

    `uvm_component_utils_begin(ring_agent)
        `uvm_field_object(sqr,UVM_ALL_ON)
        `uvm_field_object(drv,UVM_ALL_ON)
        `uvm_field_object(mon,UVM_ALL_ON)
    `uvm_component_utils_end
endclass

function ring_agent::new(string name ,uvm_component parent);
    super.new(name,parent);
endfunction

function void ring_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(is_active == UVM_ACTIVE) begin
        sqr = ring_sequencer::type_id::create("sqr",this);
        drv = ring_driver::type_id::create("drv",this);
    end
    else begin
        mon = ring_monitor::type_id::create("mon",this);
    end
endfunction

function void ring_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(is_active == UVM_ACTIVE) begin
        drv.seq_item_port.connect(sqr.seq_item_export);
        this.ap = drv.ap;
    end
    else begin
        this.ap = mon.ap;
    end
endfunction
