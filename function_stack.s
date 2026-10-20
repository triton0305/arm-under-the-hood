.global _start

.section .text

_start:
  /* Save U-Boot's frame pointer and return address. */
  stp x29, x30, [sp, #-16]!
  mov x29, sp

  mov x0, #10
  mov x1, #20
  bl add_and_adjust

  /* Store the result for inspection. */
  adr x2, result
  str x0, [x2]

  /* Release our stack space and return to U-Boot. */
  ldp x29, x30, [sp], #16
  ret

add_and_adjust:
  /* Save the return address before calling another function. */
  stp x29, x30, [sp, #-16]!
  mov x29, sp

  bl add_numbers
  add x0, x0, #5

  /* Release our stack space and return to _start. */
  ldp x29, x30, [sp], #16
  ret

add_numbers:
  add x0, x0, x1
  ret

.section .data
.balign 8
result:
  .quad 0
