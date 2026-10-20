.global _start

.section .text

_start:
  /*Save the return address supplied by U-Boot*/
  mov x9, x30

  mov x0, #10
  mov x1, #20

  bl add_numbers

  /*Store the result in memory for inspection.*/
  adr x2, result
  str x0, [x2]

  /*Restore the return address and return to U-Boot*/
  mov x30, x9
  ret

add_numbers:
  add x0, x0, x1
  ret

.section .data
.balign 8
result:
  .quad 0
