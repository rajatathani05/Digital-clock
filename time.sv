//------------------------------------------------------------------------------
// File        : digital_clock.sv
// Author      : Rajat Athani / 1BM24EC417
// Created     : 2026-02-04
// Module      : Digital clock
// Project     : SystemVerilog and Verification (23EC6PE2SV)
// Faculty     : Prof. Ajaykumar Devarapalli
//
// Description : This module implements a digital clock using counters to track seconds,
//               minutes, with proper rollover and reset functionality
//------------------------------------------------------------------------------
module time_counter (
  input  logic clk,
  input  logic rst,
  output logic [5:0] sec,
  output logic [5:0] min
);

  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      sec <= 0;
      min <= 0;
    end
    else begin
      if (sec == 59) begin
        sec <= 0;
        if (min == 59)
          min <= 0;
        else
          min <= min + 1;
      end
      else begin
        sec <= sec + 1;
      end
    end
  end

endmodule
