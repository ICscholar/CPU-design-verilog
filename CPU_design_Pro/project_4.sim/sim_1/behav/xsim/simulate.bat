@echo off
REM ****************************************************************************
REM Vivado (TM) v2023.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Tue Nov 14 18:12:47 +0800 2023
REM SW Build 3865809 on Sun May  7 15:05:29 MDT 2023
REM
REM IP Build 3864474 on Sun May  7 20:36:21 MDT 2023
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
REM simulate design
echo "xsim tb_ram_cpu_behav -key {Behavioral:sim_1:Functional:tb_ram_cpu} -tclbatch tb_ram_cpu.tcl -view D:/Downloads/CPU_design_v8.1/project_4.srcs/sim_1/imports/codes/project_4/tb_cpu_behav.wcfg -log simulate.log"
call xsim  tb_ram_cpu_behav -key {Behavioral:sim_1:Functional:tb_ram_cpu} -tclbatch tb_ram_cpu.tcl -view D:/Downloads/CPU_design_v8.1/project_4.srcs/sim_1/imports/codes/project_4/tb_cpu_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
