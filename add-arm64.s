	.arch armv8-a
	.file	"add.c"
	.text
	.align	2
	.p2align 5,,15
	.global	add
	.type	add, %function
add:
.LFB0:
	.cfi_startproc
	add	w0, w0, w1
	ret
	.cfi_endproc
.LFE0:
	.size	add, .-add
	.section	.text.startup,"ax",@progbits
	.align	2
	.p2align 5,,15
	.global	main
	.type	main, %function
main:
.LFB1:
	.cfi_startproc
	mov	w0, 0
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 15.2.0-16ubuntu1) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
