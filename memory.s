.global _start
.section .data
value:
  .quad 10
.section .text
_start:
  ldr x0, =value
  ldr x1, [x0]
  add x1, x1, #5
  str x1, [x0]
  mov x0, #0
  mov x8, #93
  svc #0
