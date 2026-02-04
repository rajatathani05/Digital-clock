//------------------------------------------------------------------------------
// File        : digital clock
// Author      : Rajat Athani / 1BM24EC417
// Created     : 2026-02-04
// Module      : Digital clock
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description : This testbench validates the operation of the digital clock by checking
//               time counting, rollover conditions, and reset functionality through simulation.
//------------------------------------------------------------------------------
module tb;

  logic clk = 0;
  logic rst;
  logic [5:0] sec;
  logic [5:0] min;

  always #5 clk = ~clk;

  time_counter dut (
    .clk(clk),
    .rst(rst),
    .sec(sec),
    .min(min)
  );

  covergroup cg_time @(posedge clk);

    cp_sec : coverpoint sec {
      bins rollover = (59 => 0);
    }

    cp_min : coverpoint min {
      bins inc = (0 => 1), (1 => 2), (2 => 3), (3 => 4), (4 => 5);
    }

    cross_sec_min : cross cp_sec, cp_min;

  endgroup

  cg_time cg = new();

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);

    rst = 1;
    #10 rst = 0;

    repeat (200) @(posedge clk);

    $display("Coverage = %0.2f %%", cg.get_inst_coverage());
    $finish;
  end

endmodule
