# CPU-design-verilog
The two projects are complete blocks for pipeline CPU, with base and Pro version
PDF file is the guide book of the development board xilinx ZYNQ-7000.
Both projects are finished using pure verilog code without IP core. It will be easy to transplant to your own FPGA development kit. The development platform I use is vivado 2023.1,
if you have former version, you can refer to sub-folder'CPU_design.srcs' and "add" .v files into your own project
THE DIFFERENCE between 'CPU_design' and 'CPU_desgin_Pro': adding relaatively complex load/store instructions and adding function of driving water-led, arosed by 'add' instruction.
Both projects with full and sufficient test for every instructions. (in tb_cpu.v)

本仓库中PDF文件为xilinx ZYNQ-7000的用户手册
项目包含两个版本的基于纯verilog语言的流水线CPU设计实现,未使用任何IP core,在xlinx vivado 2023.1版本开发，易于用户移植至其他平台
（低版本可能无法打开，可以选择将CPU_design.srcs中文件直接添加到自己的新建工程中）
项目包含CPU完整结构：datapath + control unit 以及CPU每条指定指令的完整测试（tb_cpu.v）
Pro（CPU_desgin_Pro）版本相对于base（CPU_design)版本增加较为复杂的load/store指令并且增加了驱动FPGA开发板上流水灯的功能，将在执行加法指令时触发。

![image](https://github.com/ICscholar/CPU-design-verilog/blob/main/CPU_structure.png)
![image](https://github.com/ICscholar/CPU-design-verilog/blob/main/hierarchy.png)

This is the structure of basic CPU with calculating functions, without an RAM so all instuctions should be input by users in design files, easy to debug and compell.

![image](https://github.com/ICscholar/CPU-design-verilog/blob/main/cpu_structure_pro.png)
![image](https://github.com/ICscholar/CPU-design-verilog/blob/main/hierarchy_pro.png)

This is the sturcture of plus version CPU with RAM. All instruction will be used are in the RAM referred to ram.v
