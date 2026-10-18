# arm-under-the-hood

A hands-on study repository covering AArch64 assembly, debugging, cross compilation, boot flow, and Linux internals.

The focus is on understanding ARM CPU behavior and the role of low-level code in Embedded Linux and BSP development through practical exercises.

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
- WSL2 Ubuntu (x86-64)
- GNU AArch64 cross-binutils
- QEMU User Mode

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

### Cross Development

- ✅ Host / Target architecture identification
- ✅ Native Assembly and Linking
- ✅ AArch64 Cross Assembly
- ✅ AArch64 Cross Linking
- ✅ ELF architecture verification
- ✅ QEMU User Mode execution
- ⬜ C Cross Compilation
- ⬜ Sysroot and Target Libraries
- ⬜ Remote Debugging with GDB

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

Introduces the Linux AArch64 syscall mechanism.

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

Practices arithmetic operations and conditional branches.

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

The same AArch64 assembly source is used for native and cross builds.

### Native Build — Raspberry Pi (AArch64)

Assembly and linking are performed directly on the ARM64 target.

```bash
as array.s -o array.o
ld array.o -o array
./array
echo $?
```

### Cross Build — WSL (x86-64 → AArch64)

Assembly and linking are performed on the x86-64 host using the AArch64 cross-toolchain.

```bash
aarch64-linux-gnu-as array.s -o array.o
aarch64-linux-gnu-ld array.o -o array
```

Verify the generated files:

```bash
file array.o
file array
```

Expected architecture information:

```text
array.o: ELF 64-bit LSB relocatable, ARM aarch64
array:   ELF 64-bit LSB executable, ARM aarch64
```

Execute the ARM64 binary using QEMU User Mode:

```bash
qemu-aarch64 ./array
echo $?
```

Expected exit status:

```text
0
```

The native assembler on the x86-64 host cannot assemble AArch64 instructions. The cross-toolchain generates ARM64 object files and executables, while QEMU User Mode provides an environment for executing the resulting binary.

## Repository Direction

This repository focuses on the low-level concepts required to understand and analyze:

- Firmware startup code
- Bootloader code
- CPU initialization
- Exception and interrupt handling
- Linux kernel low-level code
- BSP internals

Exercises are organized around source code, instruction behavior, debugging, and verification.

## Learning History

<details>
<summary><strong>2026-10-18 — AArch64 Cross Assembly and Execution</strong></summary>

- Confirmed the x86-64 host architecture.
- Assembled AArch64 code using the cross assembler.
- Linked and verified the ARM64 executable.
- Executed the binary using QEMU User Mode.

</details>

<details>
<summary><strong>2026-10-16 — AArch64 Basics, Branching, and Memory Access</strong></summary>

- Practiced Linux system calls and basic instructions.
- Examined conditional branches and condition flags.
- Practiced memory access, pointers, and arrays.
- Verified register and memory behavior using GDB.

</details>
