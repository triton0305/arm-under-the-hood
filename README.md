# arm-under-the-hood

A hands-on study repository for understanding ARM low-level behavior through AArch64 assembly, debugging, cross compilation, boot flow, and Linux internals.

The goal is not to memorize assembly instructions, but to understand how ARM CPUs actually work and how low-level code is used in Embedded Linux and BSP development.

## Goals

- AArch64 registers and basic instructions
- Linux system calls and `svc`
- Arithmetic and conditional branches
- Memory, addresses, and pointers
- Function calls and stack frames
- C and Assembly interaction
- Low-level debugging with GDB
- ARM64 cross compilation
- ARM32 / Cortex-M comparison
- STM32 startup and exception flow
- U-Boot startup
- Linux kernel low-level entry paths

## Environment

### Target

- Raspberry Pi 4
- AArch64 / ARM64
- Debian GNU/Linux
- GNU Assembler
- GNU Linker
- GDB

### Host

- Windows 11
- WSL2 Ubuntu
- ARM64 Cross Compiler

## Progress

### AArch64 Basics

- [x] Registers
- [x] Linux syscall convention
- [x] `svc`
- [x] `exit` syscall
- [x] `write` syscall
- [x] `.text`, `.data`, `.ascii`
- [x] `mov`
- [x] `add`, `sub`
- [x] `cmp`
- [x] Condition flags
- [x] `beq`, `bne`
- [x] GDB instruction stepping
- [ ] `ldr`, `str`
- [ ] Memory / Address / Pointer
- [ ] Arrays / Structures
- [ ] `bl`, `ret`
- [ ] Link Register (`x30`)
- [ ] Stack Pointer (`sp`)
- [ ] Frame Pointer (`x29`)
- [ ] Stack Frame
- [ ] C ↔ Assembly
- [ ] Cross Compilation

### Later Topics

- [ ] ARM32 / Cortex-M comparison
- [ ] STM32 startup sequence
- [ ] Exception / Interrupt flow
- [ ] U-Boot startup
- [ ] Linux kernel exception entry
- [ ] System call entry
- [ ] Context switching basics

## Labs

<details>
<summary><code>exit.s</code> — Basic Linux AArch64 system call</summary>

<br>

Introduces the basic Linux AArch64 syscall mechanism.

Topics:

- Registers
- Syscall numbers
- `svc #0`
- Process exit status

</details>

<details>
<summary><code>write.s</code> — write syscall and string output</summary>

<br>

Prints a message using the Linux `write` syscall.

Topics:

- `.data`
- `.ascii`
- Labels
- Buffer addresses
- `ldr`
- Syscall arguments

</details>

<details>
<summary><code>calc.s</code> — Arithmetic and conditional branches</summary>

<br>

Practices basic arithmetic operations and conditional branches.

Topics:

- `mov`
- `add`
- `sub`
- `cmp`
- Zero flag
- `beq`
- `bne`

</details>

## Build

Assembly sources are currently built directly using GNU Assembler and Linker.

```bash id="qrd3oc"
as calc.s -o calc.o
ld calc.o -o calc
./calc
```

## Repository Direction

The goal of this repository is not to become an assembly optimization specialist.

The focus is to develop enough low-level understanding to read and reason about:

- Firmware startup code
- Bootloader code
- CPU initialization
- Exception and interrupt handling
- Linux kernel low-level code
- BSP internals

A `Learning History` section will be added as the repository grows.
