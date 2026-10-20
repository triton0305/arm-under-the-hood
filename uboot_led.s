.global _start
.section .text

_start:
  mov x0, #0xfe200000

  ldr w1, [x0, #0x04]
  bic w1, w1, #0x00e00000
  orr w1, w1, #0x00200000
  str w1, [x0, #0x04]

  mov w2, #0x00020000
  str w2, [x0, #0x1c]

  mov x3, #0x20000000

delay:
  subs x3, x3, #1
  b.ne delay

  str w2, [x0, #0x28]

  mov x0, #0
  ret
