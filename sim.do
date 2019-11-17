#Time: 2019-11-16  
#By  : MISaD  
  
quit -sim  
  
cd G:/UVMProject/hello
  
set  UVM_DPI_HOME   C:/MySoftware/QuestaSim-64/uvm-1.1d/win64  
if [file exists work] {  
  vdel -all  
}  
vlib work  
vlog  -L mtiAvm -L mtiOvm -L mtiUvm -L mtiUPF  G:/UVMProject/hello/ring_tb_top.sv  

add wave *
add wave /ring_tb_top/U_ring_if/

vsim  -c -sv_lib $UVM_DPI_HOME/uvm_dpi   work.ring_tb_top 
run -a 