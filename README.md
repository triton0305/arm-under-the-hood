# arm-under-the-hood

A hands-on study repository covering AArch64 assembly, debugging, cross compilation, boot flow, and Linux internals.

The focus is on understanding ARM CPU behavior and the role of low-level code in Embedded Linux and BSP development through practical exercises.

## Goals

- AArch64 registers and basic instructions
- Linux system calls and `svc`
- Arithmetic and conditional branches
- Memory, addresses, pointers, arrays, and structures
- Bit operations and GPIO register access
- System Timer and software PWM
- Function calls, stack frames, and the AAPCS64 calling convention
- C and Assembly interaction
- Low-level debugging with GDB
- ARM64 cross compilation
- Firmware startup, bootloader, and Linux kernel analysis
- Low-level foundations for Embedded Linux and BSP development

## Environment

### Target

- Raspberry Pi 4 Model B / BCM2711
- AArch64 / ARM64
- Debian GNU/Linux 13
- U-Boot 2025.01, 64-bit build
- GNU Assembler
- GNU Linker
- GDB

### Host

- Windows 11
- WSL2 Ubuntu (x86-64)
- GNU GCC for native x86-64 compilation
- GNU AArch64 cross-GCC and cross-binutils
- QEMU User Mode

Linux user-space exercises use Linux system calls. U-Boot exercises run before Linux and return to U-Boot when finished, except for continuous hardware-control demos.

## Progress

### AArch64 Basics

- ✅ Registers and the relationship between `xN` and `wN`
- ✅ Linux syscall convention
- ✅ `svc`
- ✅ `exit` syscall
- ✅ `write` syscall
- ✅ `.text`, `.data`, `.ascii`, `.quad`
- ✅ `mov`, `movz`, `movk`
- ✅ `add`, `sub`, `mul`
- ✅ `cmp` and condition flags
- ✅ Conditional branches and loops
- ✅ unsigned and signed comparison conditions
- ✅ `subs` and `cbz`
- ✅ GDB instruction stepping
- ✅ `ldr`, `str`
- ✅ Memory / Address / Pointer
- ✅ Arrays and base address + offset
- ✅ Post-index addressing
- ✅ Structures and member offsets
- ✅ Bit masks: `lsl`, `bic`, `orr`
- ✅ Label addresses with `adr`
- ✅ `bl`, `ret`
- ✅ Link Register (`x30`)
- ✅ Stack Pointer (`sp`)
- ✅ Frame Pointer (`x29`)
- ✅ Stack frames and nested function calls
- ✅ `stp`, `ldp`
- ✅ AAPCS64 basics: arguments, return values, register preservation, and stack alignment

The planned introductory AArch64 assembly course was completed on **2026-10-20**.

### U-Boot and Hardware Access

- ✅ Load ELF files from the FAT boot partition
- ✅ Execute AArch64 ELF programs with `bootelf -p`
- ✅ Diagnose the `autostart` execution issue
- ✅ Preserve the return address and return to U-Boot
- ✅ GPIO MMIO on BCM2711
- ✅ GPIO function selection with Read-Modify-Write
- ✅ LED ON/OFF and sequential output
- ✅ System Timer-based delays
- ✅ Software PWM and duty-cycle control
- ✅ Four-channel breathing LED sequence
- ✅ Inspect calculation results using U-Boot `md.q`

### Cross Development

- ✅ Host / Target architecture identification
- ✅ Native Assembly and Linking
- ✅ AArch64 Cross Assembly
- ✅ AArch64 Cross Linking
- ✅ ELF architecture verification
- ✅ QEMU User Mode execution of Linux user-space examples
- ✅ C Cross Compilation
- ✅ C → Assembly → Object → Executable build pipeline
- ✅ Static linking through the GCC driver
- ✅ Compiler optimization comparison: `-O0`, `-O1`, and `-O2`
- ✅ x86-64 and AArch64 compiler-generated assembly comparison
- ✅ System V AMD64 and AAPCS64 calling convention comparison
- ⬜ Sysroot and Target Libraries
- ⬜ Remote Debugging with GDB

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
- `b.eq` / `b.ne`

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
- Post-index addressing
- Inspecting arrays with GDB

</details>

<details>
<summary><code>structure.s</code> — Structure members and memory offsets</summary>

<br>

Connects structure member access in C with explicit memory offsets in assembly.

Topics:

- Member addresses
- Field sizes and offsets
- Base address + member offset
- Loading and storing individual fields

</details>

<details>
<summary><code>mmio_mock.s</code> — Register operations using mock memory</summary>

<br>

Practices register-style bit operations using memory before applying them to hardware MMIO.

Topics:

- Read-Modify-Write
- Bit masks
- `lsl`, `bic`, `orr`
- Preserving unrelated bits

</details>

<details>
<summary><code>uboot_return.s</code> — ELF entry and return to U-Boot</summary>

<br>

Introduces execution under U-Boot and returning to the caller without a Linux system call.

Topics:

- ELF entry points
- Load address and execution address
- `fatload` and `bootelf -p`
- Return addresses and `ret`

</details>

<details>
<summary><code>uboot_led.s</code> — GPIO LED control through MMIO</summary>

<br>

Controls an LED connected to BCM GPIO17 by accessing BCM2711 GPIO registers directly.

Topics:

- GPIO base address `0xFE200000`
- Function selection with Read-Modify-Write
- `GPSET0` and `GPCLR0`
- LED ON/OFF control
- Hardware verification

</details>

<details>
<summary><code>uboot_led_sequence.s</code> — Sequential LED output</summary>

<br>

Extends GPIO output to a sequence across multiple LED channels.

Topics:

- GPIO output masks
- Mask arrays and iteration
- Sequential ON/OFF control
- Timing between output changes

</details>

<details>
<summary><code>uboot_led_breathing.s</code> — Four-channel software PWM</summary>

<br>

Runs a continuous breathing sequence across four LEDs on Raspberry Pi 4.

| LED | BCM GPIO | Physical Pin |
|---|---|---|
| LED0 | GPIO17 | 11 |
| LED2 | GPIO22 | 15 |
| LED4 | GPIO23 | 16 |
| LED6 | GPIO24 | 18 |

Each LED gradually brightens and dims before the next LED starts. The complete sequence repeats continuously.

Topics:

- System Timer base address `0xFE003000` and the CLO counter
- PWM period of 1,000 µs, approximately 1 kHz
- Duty-cycle conversion to ON time
- A step counter mapped to increasing and decreasing duty values
- Five PWM periods per brightness step
- Approximately one second per LED

The four-channel sequence was verified on real hardware. This demo runs continuously and does not contain a console-input exit handler.

</details>

<details>
<summary><code>function_call.s</code> — Function call, return value, and U-Boot return</summary>

<br>

Passes `10` and `20` in `x0` and `x1`, calls `add_numbers`, and stores the returned value in memory before returning to U-Boot.

Topics:

- `bl` and `ret`
- Arguments and the return value in registers
- `x30` as the Link Register
- Saving U-Boot's return address in `x9`
- `adr` and storing the result through an address
- Explicit `.text` and `.data` placement

The `x9` save is specific to this small example: the called function does not modify it. The calling convention does not guarantee that another function will preserve `x9`.

Verified memory result:

```text
U-Boot> md.q 0x02001000 1
02001000: 000000000000001e                   ........
```

`0x1e` is decimal `30`.

</details>

<details>
<summary><code>function_stack.s</code> — Nested calls and stack preservation</summary>

<br>

Calls `add_and_adjust`, which calls `add_numbers` and adds `5` to its return value.

Both `_start` and `add_and_adjust` save and restore their caller's frame pointer and return address on the stack.

Topics:

- Nested `bl` calls and overwriting `x30`
- `stp x29, x30, [sp, #-16]!`
- `mov x29, sp`
- `ldp x29, x30, [sp], #16`
- Frame records and stack allocation
- Restoring the caller's frame pointer and return address
- Returning SP to its original value
- Maintaining 16-byte stack alignment

The program returned to U-Boot, and the result stored at `0x02001000` was confirmed as decimal `35` (`0x23`).

</details>

<details>
<summary><code>add.c</code>, <code>add.s</code>, <code>add-arm64.s</code>, and <code>add-x86.s</code> — C cross compilation and generated assembly</summary>

<br>

Cross-compiles a small C program for Linux AArch64 and compares compiler-generated assembly across architectures and optimization levels.

```c
int add(int a, int b)
{
    return a + b;
}

int main(void)
{
    int result = add(10, 20);
    return result - 30;
}
```

Files:

| File | Purpose |
|---|---|
| `add.c` | C source used for compilation and execution |
| `add.s` | AArch64 assembly generated with default optimization (`-O0`) |
| `add-arm64.s` | AArch64 assembly retained for architecture comparison |
| `add-x86.s` | x86-64 assembly retained for architecture comparison |

Topics:

- C → Assembly → Object → Executable
- Cross-GCC, assembler, and linker roles
- Relocatable and executable ELF files
- Static linking and C runtime startup code
- `_start` versus `main`
- Compiler optimization at `-O0`, `-O1`, and `-O2`
- Stack accesses and function-call elimination
- System V AMD64 versus AAPCS64

At `-O0`, the generated AArch64 code stores arguments and local values on the stack and calls `add` from `main`.

In the optimized output examined during the exercise, `add` became a register addition, and `main` was reduced to returning zero.

The statically linked AArch64 executable was run on the x86-64 host using QEMU User Mode and returned exit status `0`. Execution on the Raspberry Pi target has not yet been verified for this C example.

</details>

## Build

Select the build and execution environment for each exercise.

<details>
<summary><strong>Linux User Space — Native Assembly Build on Raspberry Pi</strong></summary>

<br>

Assembly and linking are performed directly on the ARM64 target.

```bash
as array.s -o array.o
ld array.o -o array
./array
echo $?
```

</details>

<details>
<summary><strong>Linux User Space — Cross Assembly Build on WSL</strong></summary>

<br>

Assemble and link Linux AArch64 source on the x86-64 host:

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

Execute using QEMU User Mode:

```bash
qemu-aarch64 ./array
echo $?
```

Verified exit status:

```text
0
```

The native x86-64 assembler cannot assemble AArch64 instructions. The cross-toolchain generates ARM64 files, while QEMU User Mode executes the Linux user-space binary.

GPIO MMIO exercises are verified separately on Raspberry Pi hardware under U-Boot.

</details>

<details>
<summary><strong>Linux User Space — C Cross Compilation on WSL</strong></summary>

<br>

Generate AArch64 assembly from C, then assemble it into a relocatable object:

```bash
aarch64-linux-gnu-gcc -S add.c -o add.s
aarch64-linux-gnu-as add.s -o add.o
file add.o
```

With no optimization option specified, GCC uses `-O0`.

Link through the GCC driver to include the C runtime startup files and required libraries:

```bash
aarch64-linux-gnu-gcc -static add.o -o add
file add
```

Verified file properties:

| File | Verified Properties |
|---|---|
| `add.o` | ELF 64-bit LSB relocatable, ARM aarch64 |
| `add` | ELF 64-bit LSB executable, ARM aarch64, statically linked |

Execute using QEMU User Mode:

```bash
qemu-aarch64 ./add
echo $?
```

Verified exit status:

```text
0
```

The program returns `add(10, 20) - 30`, so zero is the expected result.

### Compare Optimization Levels

Generate separate assembly files without overwriting the retained examples:

```bash
aarch64-linux-gnu-gcc -O0 -S add.c -o /tmp/add-arm64-O0.s
aarch64-linux-gnu-gcc -O1 -S add.c -o /tmp/add-arm64-O1.s
aarch64-linux-gnu-gcc -O2 -S add.c -o /tmp/add-arm64-O2.s
```

In the optimized output examined during the exercise, `main` returned zero directly without calling `add`.

Compare x86-64 and AArch64 output at the same optimization level:

```bash
gcc -O2 -S add.c -o /tmp/add-x86-O2.s
aarch64-linux-gnu-gcc -O2 -S add.c -o /tmp/add-arm64-O2.s
```

Exact assembly output depends on the compiler version, target, and compilation options.

### GCC Driver versus Direct LD Invocation

Directly linking this C object with:

```bash
aarch64-linux-gnu-ld add.o -o add
```

produced:

```text
warning: cannot find entry symbol _start
```

The object defines `main`, but does not define the process entry point `_start`. Calling LD directly does not automatically include the usual C runtime startup files.

Using the GCC driver resolved the link setup:

```bash
aarch64-linux-gnu-gcc -static add.o -o add
```

The handwritten Linux assembly examples define their own `_start` and can be linked directly with LD.

</details>

<details>
<summary><strong>U-Boot — GPIO Example</strong></summary>

<br>

Build on Raspberry Pi while Linux is running:

```bash
as uboot_led.s -o uboot_led.o
ld -Ttext=0x02000000 -e _start uboot_led.o -o uboot_led.elf
sudo cp uboot_led.elf /boot/firmware/
sync
```

Run from the U-Boot console:

```text
fatload mmc 0:1 ${loadaddr} uboot_led.elf
setenv autostart yes
bootelf -p ${loadaddr}
```

In the verified setup, `${loadaddr}` is `0x01000000`. U-Boot reads the ELF file there, then loads its segments to the linked addresses. The entry point is `0x02000000`.

</details>

<details>
<summary><strong>U-Boot — Function Call Example</strong></summary>

<br>

Place `.text` at `0x02000000` and `.data` at `0x02001000` so the result has a known address for inspection.

```bash
as function_call.s -o function_call.o
ld -Ttext=0x02000000 -Tdata=0x02001000 -e _start function_call.o -o function_call.elf
sudo cp function_call.elf /boot/firmware/
sync
```

Run and inspect the result:

```text
fatload mmc 0:1 ${loadaddr} function_call.elf
setenv autostart yes
bootelf -p ${loadaddr}
md.q 0x02001000 1
```

Verified result: `10 + 20 = 30` (`0x1e`).

</details>

<details>
<summary><strong>U-Boot — Nested Calls and Stack Example</strong></summary>

<br>

Build on Raspberry Pi:

```bash
as function_stack.s -o function_stack.o
ld -Ttext=0x02000000 -Tdata=0x02001000 -e _start function_stack.o -o function_stack.elf
sudo cp function_stack.elf /boot/firmware/
sync
```

Run and inspect the result:

```text
fatload mmc 0:1 ${loadaddr} function_stack.elf
setenv autostart yes
bootelf -p ${loadaddr}
md.q 0x02001000 1
```

Verified result: `(10 + 20) + 5 = 35` (`0x23`).

Both function examples inspect their results in memory after returning to U-Boot. The build used for verification did not print an application return-code message.

GNU ld issued a warning about a LOAD segment with RWX permissions when the code and data were linked into the same segment. Both generated ELF files were verified under U-Boot.

</details>

## Troubleshooting

<details>
<summary><strong>U-Boot loads an ELF but returns without executing it</strong></summary>

<br>

### Symptom

`fatload` successfully read the ELF file, but `bootelf -p` immediately returned to the prompt and the LED remained off.

### Investigation

- Reviewed the assembly source and tried a different execution address.
- Confirmed that direct GPIO writes from U-Boot could control the LED.
- Checked `printenv autostart` and found that the variable was undefined.
- Found a U-Boot mailing-list discussion about silently skipping ELF execution when autostart is disabled.

### Resolution

```text
setenv autostart yes
bootelf -p ${loadaddr}
```

The same ELF then changed the GPIO function register and performed the LED ON/OFF sequence before returning to U-Boot. No assembly source change or rebuild was needed to resolve this issue.

The setting is applied in the current U-Boot session; the procedure does not require saving the environment persistently.

Reference: [U-Boot mailing list — executing ELF files requires variable autostart](https://www.mail-archive.com/u-boot@lists.denx.de/msg578479.html).

</details>

## Repository Direction

This repository focuses on the low-level concepts required to understand and analyze:

- Firmware startup code
- Bootloader code
- CPU initialization
- Exception and interrupt handling
- Linux kernel low-level code
- BSP internals

Exercises are organized around source code, instruction behavior, debugging, and verification.

The introductory assembly course now covers register operations, memory access, hardware MMIO, timing, function calls, and stack preservation. Further work will connect these foundations to C, device drivers, and boot or kernel code as needed.

## Learning History

<details>
<summary><strong>2026-10-16 — AArch64 Basics, Branching, and Memory Access</strong></summary>

<br>

- Set up an AArch64 assembly study environment on Raspberry Pi 4.
- Learned the Linux AArch64 syscall convention using `x0`, `x8`, and `svc #0`.
- Implemented `exit.s` and verified process exit status with `echo $?`.
- Implemented `write.s` using the Linux `write` syscall.
- Learned `.text`, `.data`, `.ascii`, `.quad`, labels, and address loading.
- Practiced `mov`, `add`, `sub`, and `cmp`.
- Examined how `cmp` updates condition flags and how `b.eq` / `b.ne` use the Zero flag.
- Used GDB to inspect registers, PC, condition flags, and execute instructions with `stepi`.
- Implemented `memory.s` using `ldr` and `str`.
- Connected AArch64 memory access with C pointer concepts:
  - `ldr x0, =value` → address of `value`
  - `ldr x1, [x0]` → dereference and load
  - `str x1, [x0]` → store through an address
- Verified a memory value changing from `10` to `15` before and after `str`.
- Implemented `array.s` to practice base address and byte offset addressing.
- Verified consecutive `.quad` values using GDB:
  - `[x0]` → `10`
  - `[x0, #8]` → `20`
  - `[x0, #16]` → `30`

</details>

<details>
<summary><strong>2026-10-18 — AArch64 Cross Assembly and Execution</strong></summary>

<br>

- Cloned the repository into the WSL development environment.
- Confirmed the host architecture as `x86_64` using `uname -m`.
- Observed assembler errors when processing AArch64 instructions with the native x86-64 assembler.
- Installed `binutils-aarch64-linux-gnu`.
- Assembled `array.s` using `aarch64-linux-gnu-as`.
- Verified the object file as an AArch64 relocatable ELF using `file`.
- Linked the object file using `aarch64-linux-gnu-ld`.
- Verified the resulting executable as an AArch64 ELF.
- Executed the ARM64 binary using `qemu-aarch64`.
- Confirmed successful execution with exit status `0`.
- Compared native and cross-build commands across the Raspberry Pi and WSL environments.

</details>

<details>
<summary><strong>2026-10-19 — Structures, GPIO MMIO, and Software PWM</strong></summary>

<br>

- Completed structure member access and register-style bit operations, building on earlier memory exercises.
- Applied Read-Modify-Write operations to BCM2711 GPIO function registers.
- Built and loaded AArch64 ELF programs for execution under U-Boot.
- Diagnosed the `autostart` issue and verified LED output with the existing ELF.
- Controlled GPIO17 using `GPSET0` and `GPCLR0`.
- Extended LED control to a multi-channel sequence.
- Used the System Timer CLO counter for delays and software PWM timing.
- Converted a step counter into increasing and decreasing ON times.
- Verified a repeating breathing sequence on GPIO17, GPIO22, GPIO23, and GPIO24.
- Finished the hardware-control stage with function calls and stack frames remaining as the final introductory assembly topics.

A separate U-Boot C LED/KEY assignment was also prepared. Its key-state logic was checked with host-side mock inputs. Actual U-Boot integration and hardware execution were outside that assignment's verification scope.

</details>

<details>
<summary><strong>2026-10-20 — Function Calls, Nested Calls, and Stack Frames</strong></summary>

<br>

- Reviewed how `wN` accesses the lower 32 bits of `xN` and how writing `wN` clears the upper 32 bits.
- Distinguished a Linux system call using `x8` and `svc` from a function return using `x30` and `ret`.
- Implemented `function_call.s` with arguments in `x0` and `x1` and the return value in `x0`.
- Preserved the U-Boot return address while `bl add_numbers` replaced `x30` with the local return address.
- Used `adr` and `str` to store the calculation result in memory.
- Linked `.text` and `.data` at known addresses and verified `10 + 20 = 30` using `md.q`.
- Implemented `function_stack.s` with nested calls from `_start` to `add_and_adjust` to `add_numbers`.
- Used `stp` and `ldp` to save and restore `x29` and `x30` while allocating and releasing stack space.
- Traced the frame pointer, stack pointer, and return address through the complete call and return sequence.
- Reviewed why omitting the inner restore leaves `x30` pointing to the instruction after `bl add_numbers`.
- Verified the nested-call result `(10 + 20) + 5 = 35` and return to the U-Boot prompt.
- Reviewed the basic AAPCS64 rules for argument passing, return values, register preservation, and 16-byte stack alignment.
- Completed the planned introductory AArch64 assembly course.

</details>

<details>
<summary><strong>2026-10-20 — C Cross Compilation, Optimization, and ABI Comparison on WSL</strong></summary>

<br>

This evening session used WSL Ubuntu on the x86-64 laptop, separately from the Raspberry Pi function-call and stack exercises.

- Created `add.c` in `~/study/cross-compile-lab`.
- Generated AArch64 assembly using `aarch64-linux-gnu-gcc -S`.
- Assembled the generated source using `aarch64-linux-gnu-as`.
- Verified `add.o` as an AArch64 relocatable ELF.
- Encountered a missing `_start` warning when invoking LD directly on the C object.
- Distinguished the process entry point `_start` from the C function `main`.
- Linked through `aarch64-linux-gnu-gcc -static` to include C runtime startup files and required libraries.
- Verified the resulting executable as a statically linked AArch64 ELF.
- Executed the program using `qemu-aarch64` and confirmed exit status `0`.
- Compared assembly generated at `-O0`, `-O1`, and `-O2`.
- Observed stack accesses and a function call in the unoptimized output.
- Observed optimized output reducing `main` to returning zero.
- Compared x86-64 and AArch64 instructions and argument-passing registers.
- Reviewed System V AMD64 and AAPCS64, including return addresses, register preservation, and stack alignment.
- Distinguished normal function returns from Linux system calls.
- Copied the C source and retained assembly outputs into the repository root.

The C example has been verified under QEMU User Mode. Raspberry Pi execution, dynamic linking and sysroot exercises, and remote debugging remain future work.

</details>
