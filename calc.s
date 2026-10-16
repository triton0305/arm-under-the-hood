.global _start
.section .text
_start:
  mov x0, #10
  mov x1, #20
  add x2, x0, x1
  sub x3, x1, x0
  cmp x2, #31
  bne equal
  mov x0, #1
  mov x8, #93
  svc #0
equal:
  mov x0, #0
  mov x8, #93
  svc #0
