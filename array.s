.global _start
.section .data
values:
  .quad 10
  .quad 20
  .quad 30
.section .text
_start:
  ldr x0, =values
  ldr x1, [x0]
  ldr x2, [x0, #8]
  ldr x3, [x0, #16]
  mov x0, #0
  mov x8, #93
  svc #0
