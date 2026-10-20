
.global _start
.section .text

_start:
  // GPIO Base: 0xFE200000
  mov x0, #0xfe200000

  // System Timer Base: 0xFE003000
  movz x7, #0x3000
  movk x7, #0xfe00, lsl #16

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

  // All LEDs OFF
  movz w6, #0x01c2, lsl #16
  str w6, [x0, #0x28]

  // PWM period: 1000 us
  // 1% duty: 10 us
  mov w11, #1000
  mov w12, #10

all_leds:
  // Restart LED array
  ldr x4, =led_masks
  mov w5, #4

next_led:
  ldr w2, [x4], #4
  mov w9, #0

fade_step:
  cmp w9, #100
  b.hs fade_down

  // Fade in: 0% -> 99%
  mov w10, w9
  b duty_ready

fade_down:
  // Fade out: 100% -> 1%
  mov w10, #200
  sub w10, w10, w9

duty_ready:
  // ON time = duty * 10 us
  mul w10, w10, w12

  // Repeat each duty 5 times
  mov w14, #5

pwm_cycle:
  // Read timer start
  ldr w3, [x7, #0x04]

  // LED ON
  cbz w10, pwm_off
  str w2, [x0, #0x1c]

pwm_on_wait:
  ldr w6, [x7, #0x04]
  sub w6, w6, w3
  cmp w6, w10
  b.lo pwm_on_wait

pwm_off:
  // LED OFF
  str w2, [x0, #0x28]

pwm_period_wait:
  // Wait until 1000 us elapsed
  ldr w6, [x7, #0x04]
  sub w6, w6, w3
  cmp w6, w11
  b.lo pwm_period_wait

  subs w14, w14, #1
  b.ne pwm_cycle

  // Next brightness step
  add w9, w9, #1
  cmp w9, #200
  b.lo fade_step

  // Next LED
  str w2, [x0, #0x28]
  subs w5, w5, #1
  b.ne next_led

  // Repeat forever
  b all_leds

.balign 4
led_masks:
  .word 0x00020000
  .word 0x00400000
  .word 0x00800000
  .word 0x01000000

