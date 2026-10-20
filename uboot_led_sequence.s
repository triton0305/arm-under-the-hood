.global _start
.section .text

_start:
  // GPIO Base: 0xFE200000
  mov x0, #0xfe200000

   // System Timer Base : 0xFE003000
  movz x7, #0x3000
  movk x7, #0xfe00, lsl #16

  // 1 second = 1,000,000 us
  movz w8, #0x4240
  movk w8, #0x000f, lsl #16

  // GPIO17 output
  ldr w1, [x0, #0x04]
  bic w1, w1, #0x00e00000
  orr w1, w1, #0x00200000
  str w1, [x0, #0x04]

  // GPIO22, GPIO23, GPIO24 output
  ldr w1, [x0, #0x08]
  bic w1, w1, #0x00007fc0
  mov w6, #0x1240
  orr w1, w1, w6
  str w1, [x0, #0x08]

  // LED array
  ldr x4, =led_masks
  mov w5, #4

next_led:
  //LED ON
  ldr w2, [x4], #4
  str w2, [x0, #0x1c]

  // Read timer start
  ldr w3, [x7, #0x04]

delay:
  //Wait 1 second
  ldr w6, [x7, #0x04]
  sub w6, w6, w3
  cmp w6, w8
  b.lo delay

  // LED OFF
  str w2, [x0, #0x28]

  // Next LED
  subs w5, w5, #1
  b.ne next_led

  // Return to U-Boot
  mov x0, #0
  ret

.balign 4
led_masks:
  .word 0x00020000
  .word 0x00400000
  .word 0x00800000
  .word 0x01000000
