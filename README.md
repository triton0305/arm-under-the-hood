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

- ✅ Registers
- ✅ Linux syscall convention
- ✅ `svc`
- ✅ `exit` syscall
- ✅ `write` syscall
- ✅ `.text`, `.data`, `.ascii`, `.quad`
- ✅ `mov`
- ✅ `add`, `sub`
- ✅ `cmp`
- ✅ Condition flags
- ✅ `beq`, `bne`
- ✅ GDB instruction stepping
- ✅ `ldr`, `str`
- ✅ Memory / Address / Pointer
- ✅ Arrays and base address + offset
- 🔜 Structures
- ⬜ `bl`, `ret`
- ⬜ Link Register (`x30`)
- ⬜ Stack Pointer (`sp`)
- ⬜ Frame Pointer (`x29`)
- ⬜ Stack Frame
- ⬜ C ↔ Assembly
- ⬜ Cross Compilation

### Later Topics

- ⬜ ARM32 / Cortex-M comparison
- ⬜ STM32 startup sequence
- ⬜ Exception / Interrupt flow
- ⬜ U-Boot startup
- ⬜ Linux kernel exception entry
- ⬜ System call entry
- ⬜ Context switching basics

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

<details>
<summary><code>memory.s</code> — Memory load, store, and pointer basics</summary>

<br>

Practices memory access using AArch64 load and store instructions.

Topics:

- `.quad`
- `ldr`
- `str`
- Memory addresses
- Dereferencing
- Pointer-like register usage
- Inspecting memory with GDB

</details>

<details>
<summary><code>array.s</code> — Array access with base address and offset</summary>

<br>

Practices accessing consecutive array elements using a base address and byte offsets.

Topics:

- Base addresses
- Memory offsets
- `[x0, #8]`
- `[x0, #16]`
- Sequential memory layout
- Inspecting arrays with GDB

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

## Learning History

### 2026-10-16 — AArch64 Basics, Branching, and Memory Access

- Set up an AArch64 assembly study environment on Raspberry Pi 4.
- Learned the Linux AArch64 syscall convention using `x0`, `x8`, and `svc #0`.
- Implemented `exit.s` and verified process exit status with `echo $?`.
- Implemented `write.s` using the Linux `write` syscall.
- Learned `.text`, `.data`, `.ascii`, labels, and basic address loading.
- Practiced `mov`, `add`, `sub`, and `cmp`.
- Learned how `cmp` updates condition flags and how `beq` / `bne` use the Zero flag.
- Used GDB to inspect registers, PC, condition flags, and execute instructions with `stepi`.
- Implemented `memory.s` using `ldr` and `str`.
- Connected AArch64 memory access with C pointer concepts:
  - `ldr x0, =value` → address of `value`
  - `ldr x1, [x0]` → dereference and load
  - `str x1, [x0]` → store through an address
- Verified a memory value changing from `10` to `15` before and after `str`.
- Implemented `array.s`.
- Learned array access using a base address and byte offsets.
- Verified consecutive `.quad` values through GDB:
  - `[x0]` → `10`
  - `[x0, #8]` → `20`
  - `[x0, #16]` → `30`
