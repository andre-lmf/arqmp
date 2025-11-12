module mem (
  input  logic        clk, we,
  input  logic [31:0] a, wd,
  output logic [31:0] rd,
  input  logic [31:0] va,
  output logic [31:0] vd,
  input logic [3:0] wm);
  logic  [31:0] RAM [0:511];

  // initialize memory with instructions and data
  initial
    $readmemh("riscv.hex", RAM);

  // regular port (read/write)
  always_ff @(posedge clk)
  begin
    if (we) begin
      if(wm[0]) RAM[a[31:2]][ 7:0 ] <= wd[ 7:0 ];
      if(wm[1]) RAM[a[31:2]][15:8 ] <= wd[15:8 ];
      if(wm[2]) RAM[a[31:2]][23:16] <= wd[23:16];
      if(wm[3]) RAM[a[31:2]][31:24] <= wd[31:24];	
    end
    // RAM[a[31:2]] <= wd;
    rd <= RAM[a[31:2]];
  end

  // video port (read only)
  always_ff @(posedge clk)
    vd <= RAM[va[31:2]];
endmodule