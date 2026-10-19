.global _start
.section .data
gpio_mock:
  .space 0x1C
gpset0:
  .word 0

.section .text
_start:
  ldr x0, =gpio_mock
  mov w1, #1
  lsl w1, w1, #17
  str w1, [x0, #0x1C]
  mov x0, #0
  mov x8, #93
  svc #0
