//`include "uvm_macros.svh"
import uvm_pkg::*;

class hello_driver extends uvm_driver #(hello_transaction);
    virtual hello_if vif;
    uvm_analysis_port #(hello_transaction) ap;

    `uvm_component_utils(hello_driver)

    extern function new(string name ,uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
    extern task drive_one_pkt(hello_transaction req);
    extern task drive_one_byte(bit [7:0] data);

endclass

function hello_driver::new(string name,uvm_component parent);
    super.new(name,parent);
endfunction

function void hello_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual hello_if)::get(this,"","hello_if",vif))
        `uvm_fatal("hello_driver","Error in Geting interface");
    ap = new ("ap",this);
endfunction
task hello_driver::main_phase(uvm_phase phase);
    hello_transaction req;
    super.main_phase(phase);//���ø����main_phase,
    vif.drv_cb.rxd <= 0;
    vif.drv_cb.rx_dv <= 1'b0;//�����г�ʼ��
    while(1) begin
        seq_item_port.get_next_item(req);//��req_item_port����õ�һ��hello_transaction���͵�item��
//seq_item_port,��������driver��sequencer��һ���˿ڣ�driver��Ҫ��������Ҫ�Ӹ�
//�˿ڻ�ã�sequencer��������ݽ���driver��ҲҪͨ���ö˿��͸�driver��
//������˿���������Ҫ��������˿ڵ�get_next_item�������������������ʱ��Ҫͨ������
//item_done����֪����˿ڡ�
        drive_one_pkt(req);//����drive_one_pkt�����item���ͳ�ȥ
        //$display("driver pkt is:");
        //req.print();
        ap.write(req);//�����ͳ�ȥ��item����ap����reference modelһ��
        //$display("driver_send_reference_model pkt is:");
        //req.print();
        seq_item_port.item_done();//��Ӧseq_item_port.get_item(req)
    end
endtask
task hello_driver::drive_one_pkt(hello_transaction req);
    byte unsigned data_q[];
    int data_size;
    data_size=req.pack_bytes(data_q)/8;
    repeat(3)@vif.drv_cb;
    for(int i=0;i<data_size;i++) begin
        drive_one_byte(data_q[i]);//drive data pattern
    end
    @vif.drv_cb;
    vif.drv_cb.rx_dv <=1'b0;
endtask

task hello_driver::drive_one_byte(bit [7:0] data);
    @vif.drv_cb;
    vif.drv_cb.rxd <= data;
    vif.drv_cb.rx_dv <= 1'b1;
endtask


