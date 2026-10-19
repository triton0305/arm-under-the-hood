.global _start
.section .data
device:
  .word 7
  .word 1
  .quad 100

.section .text
_start:
  ldr x0, =device
  ldr w1, [x0]
  ldr w2, [x0, #4]
  ldr x3, [x0, #8]
  mov x0, #0
  mov x8, #93
  svc #0
