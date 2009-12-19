From: Mike Cui <cuicui@gmail.com>
Subject: 2.6.32 seemed to have broken nVidia MCP7A sata controller
Date: Fri, 18 Dec 2009 22:13:32 -0800
Message-ID: <7c8826910912182213o2e0e8af7ic305f150c52e0618@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:34600 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbZLSGNf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Dec 2009 01:13:35 -0500
Received: by fxm21 with SMTP id 21so3409866fxm.21
        for <linux-ide@vger.kernel.org>; Fri, 18 Dec 2009 22:13:33 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have an nVidia MCP7A AHCI controller. I upgraded to 2.6.32.2 and my
system deterministically freezes trying to mount file systems. Once in
a while it will come back and finish booting after freezing for 1
minute or 2. dmesg indicates that there were NCQ errors, but 2.6.31
anb before has always worked flawlessly for me. What changed in
2.6.32? I will be more than happy to help track down this issue.

Here is the dmesg output from the last time I could finish booting:


Linux version 2.6.32.2 (mcui@nitrate) (gcc version 4.4.2 (Gentoo 4.4.2
p1.0) ) #5 SMP PREEMPT Fri Dec 18 21:16:48 PST 2009
Command line: root=3D/dev/sda2 ro
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  Centaur CentaurHauls
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
 BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cff90000 (usable)
 BIOS-e820: 00000000cff90000 - 00000000cff9e000 (ACPI data)
 BIOS-e820: 00000000cff9e000 - 00000000cffd0000 (ACPI NVS)
 BIOS-e820: 00000000cffd0000 - 00000000e0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
DMI present.
AMI BIOS detected: BIOS may corrupt low RAM, working around it.
e820 update range: 0000000000000000 - 0000000000010000 (usable) =3D=3D>
(reserved)
last_pfn =3D 0x120000 max_arch_pfn =3D 0x400000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-CFFFF write-protect
  D0000-DFFFF uncachable
  E0000-EFFFF write-through
  F0000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 0E0000000 mask FE0000000 uncachable
  1 base 000000000 mask F00000000 write-back
  2 base 100000000 mask FE0000000 write-back
  3 disabled
  4 disabled
  5 disabled
  6 disabled
  7 disabled
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
e820 update range: 00000000e0000000 - 0000000100000000 (usable) =3D=3D>
(reserved)
last_pfn =3D 0xcff90 max_arch_pfn =3D 0x400000000
initial memory mapped : 0 - 20000000
init_memory_mapping: 0000000000000000-00000000cff90000
 0000000000 - 00cfe00000 page 2M
 00cfe00000 - 00cff90000 page 4k
kernel direct mapping tables up to cff90000 @ 10000-16000
init_memory_mapping: 0000000100000000-0000000120000000
 0100000000 - 0120000000 page 2M
kernel direct mapping tables up to 120000000 @ 14000-1a000
ACPI: RSDP 00000000000fb4c0 00024 (v02 ACPIAM)
ACPI: XSDT 00000000cff90100 00064 (v01 040809 XSDT1444 20090408 MSFT
00000097)
ACPI: FACP 00000000cff90290 000F4 (v03 040809 FACP1444 20090408 MSFT
00000097)
ACPI: DSDT 00000000cff904a0 09D1A (v01  A1049 A1049000 00000000 INTL
20060113)
ACPI: FACS 00000000cff9e000 00040
ACPI: APIC 00000000cff90390 00080 (v01 040809 APIC1444 20090408 MSFT
00000097)
ACPI: MCFG 00000000cff90410 0003C (v01 040809 OEMMCFG  20090408 MSFT
00000097)
ACPI: WDRT 00000000cff90450 00047 (v01 040809 NV-WDRT  20090408 MSFT
00000097)
ACPI: OEMB 00000000cff9e040 0007A (v01 040809 OEMB1444 20090408 MSFT
00000097)
ACPI: HPET 00000000cff9a1c0 00038 (v01 040809 OEMHPET0 20090408 MSFT
00000097)
ACPI: NVHD 00000000cff9e0c0 00284 (v01 040809  NVHDCP  20090408 MSFT
00000097)
ACPI: SSDT 00000000cff9ed50 00A7C (v01 DpgPmm    CpuPm 00000012 INTL
20060113)
ACPI: Local APIC address 0xfee00000
(7 early reservations) =3D=3D> bootmem [0000000000 - 0120000000]
  #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> [0000000000 -
0000001000]
  #1 [0000006000 - 0000008000]       TRAMPOLINE =3D=3D> [0000006000 -
0000008000]
  #2 [0001000000 - 000141d318]    TEXT DATA BSS =3D=3D> [0001000000 -
000141d318]
  #3 [000009ec00 - 0000100000]    BIOS reserved =3D=3D> [000009ec00 -
0000100000]
  #4 [000141e000 - 000141e290]              BRK =3D=3D> [000141e000 -
000141e290]
  #5 [0000010000 - 0000014000]          PGTABLE =3D=3D> [0000010000 -
0000014000]
  #6 [0000014000 - 0000015000]          PGTABLE =3D=3D> [0000014000 -
0000015000]
 [ffffea0000000000-ffffea0003ffffff] PMD ->
[ffff880028600000-ffff88002bbfffff] on node 0
Zone PFN ranges:
  DMA      0x00000010 -> 0x00001000
  DMA32    0x00001000 -> 0x00100000
  Normal   0x00100000 -> 0x00120000
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0: 0x00000010 -> 0x0000009e
    0: 0x00000100 -> 0x000cff90
    0: 0x00100000 -> 0x00120000
On node 0 totalpages: 982814
  DMA zone: 56 pages used for memmap
  DMA zone: 105 pages reserved
  DMA zone: 3821 pages, LIFO batch:0
  DMA32 zone: 14280 pages used for memmap
  DMA32 zone: 833480 pages, LIFO batch:31
  Normal zone: 1792 pages used for memmap
  Normal zone: 129280 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x10de8201 base: 0xfed00000
SMP: Allowing 4 CPUs, 0 hotplug CPUs
nr_irqs_gsi: 24
Allocating PCI resources starting at e0000000 (gap: e0000000:1ec00000)
NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
PERCPU: Embedded 25 pages/cpu @ffff880028200000 s71000 r8192 d23208
u524288
pcpu-alloc: s71000 r8192 d23208 u524288 alloc=3D1*2097152
pcpu-alloc: [0] 0 1 2 3
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
966581
Kernel command line: root=3D/dev/sda2 ro
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Initializing CPU#0
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing 64MB software IO TLB between ffff880020000000 -
ffff880024000000
software IO TLB at phys 0x20000000 - 0x24000000
Memory: 3798160k/4718592k available (2428k kernel code, 787336k
absent, 132212k reserved, 972k data, 372k init)
SLUB: Genslabs=3D13, HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
4,
Nodes=3D1
Hierarchical RCU implementation.
NR_IRQS:384
Extended CMOS year: 2000
spurious 8259A interrupt: IRQ7.
Console: colour VGA+ 80x25
console [tty0] enabled
hpet clockevent registered
HPET: 4 timers in total, 0 timers will be used for per-cpu timer
=46ast TSC calibration using PIT
Detected 2399.985 MHz processor.
Calibrating delay loop (skipped), value calculated using timer
frequency.. 4799.97 BogoMIPS (lpj=3D2399985)
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 6 MCE banks
CPU0: Thermal monitoring enabled (TM2)
using mwait in idle threads.
=46reeing SMP alternatives: 18k freed
ACPI: Core revision 20090903
Setting APIC routing to flat
=2E.TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
CPU0: Intel(R) Core(TM)2 Quad CPU    Q6600  @ 2.40GHz stepping 0b
Booting processor 1 APIC 0x1 ip 0x6000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4799.85 BogoMIPS
(lpj=3D2399926)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM2)
CPU1: Intel(R) Core(TM)2 Quad CPU    Q6600  @ 2.40GHz stepping 0b
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Booting processor 2 APIC 0x2 ip 0x6000
Initializing CPU#2
Calibrating delay using timer specific routine.. 4799.90 BogoMIPS
(lpj=3D2399954)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 2
CPU2: Thermal monitoring enabled (TM2)
CPU2: Intel(R) Core(TM)2 Quad CPU    Q6600  @ 2.40GHz stepping 0b
checking TSC synchronization [CPU#0 -> CPU#2]: passed.
Booting processor 3 APIC 0x3 ip 0x6000
Initializing CPU#3
Calibrating delay using timer specific routine.. 4799.86 BogoMIPS
(lpj=3D2399934)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 3
CPU3: Thermal monitoring enabled (TM2)
CPU3: Intel(R) Core(TM)2 Quad CPU    Q6600  @ 2.40GHz stepping 0b
checking TSC synchronization [CPU#0 -> CPU#3]: passed.
Brought up 4 CPUs
Total of 4 processors activated (19199.59 BogoMIPS).
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: MCFG configuration 0: base fc000000 segment 0 buses 0 - 31
PCI: Not using MMCONFIG.
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: Executed 1 blocks of module-level executable AML code
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: MCFG configuration 0: base fc000000 segment 0 buses 0 - 31
PCI: MCFG area at fc000000 reserved in ACPI motherboard resources
PCI: Using MMCONFIG at fc000000 - fdffffff
ACPI: No dock devices found.
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:03.0: reg 10 io port: [0x4f00-0x4fff]
pci 0000:00:03.2: reg 10 io port: [0x4900-0x493f]
pci 0000:00:03.2: reg 20 io port: [0x4d00-0x4d3f]
pci 0000:00:03.2: reg 24 io port: [0x4e00-0x4e3f]
pci 0000:00:03.2: PME# supported from D3hot D3cold
pci 0000:00:03.2: PME# disabled
pci 0000:00:03.5: reg 10 32bit mmio: [0xfae80000-0xfaefffff]
pci 0000:00:04.0: reg 10 32bit mmio: [0xfae7f000-0xfae7ffff]
pci 0000:00:04.0: supports D1 D2
pci 0000:00:04.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:04.0: PME# disabled
pci 0000:00:04.1: reg 10 32bit mmio: [0xfae7ec00-0xfae7ecff]
pci 0000:00:04.1: supports D1 D2
pci 0000:00:04.1: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:04.1: PME# disabled
pci 0000:00:06.0: reg 10 32bit mmio: [0xfae7d000-0xfae7dfff]
pci 0000:00:06.0: supports D1 D2
pci 0000:00:06.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:06.0: PME# disabled
pci 0000:00:06.1: reg 10 32bit mmio: [0xfae7e800-0xfae7e8ff]
pci 0000:00:06.1: supports D1 D2
pci 0000:00:06.1: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:06.1: PME# disabled
pci 0000:00:08.0: reg 10 32bit mmio: [0xfae78000-0xfae7bfff]
pci 0000:00:08.0: PME# supported from D3hot D3cold
pci 0000:00:08.0: PME# disabled
pci 0000:00:0a.0: reg 10 32bit mmio: [0xfae7c000-0xfae7cfff]
pci 0000:00:0a.0: reg 14 io port: [0xd480-0xd487]
pci 0000:00:0a.0: reg 18 32bit mmio: [0xfae7e400-0xfae7e4ff]
pci 0000:00:0a.0: reg 1c 32bit mmio: [0xfae7e000-0xfae7e00f]
pci 0000:00:0a.0: supports D1 D2
pci 0000:00:0a.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:0a.0: PME# disabled
pci 0000:00:0b.0: reg 10 io port: [0xd400-0xd407]
pci 0000:00:0b.0: reg 14 io port: [0xd080-0xd083]
pci 0000:00:0b.0: reg 18 io port: [0xd000-0xd007]
pci 0000:00:0b.0: reg 1c io port: [0xcc00-0xcc03]
pci 0000:00:0b.0: reg 20 io port: [0xc880-0xc88f]
pci 0000:00:0b.0: reg 24 32bit mmio: [0xfae76000-0xfae77fff]
pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:0c.0: PME# disabled
pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:10.0: PME# disabled
pci 0000:00:15.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:15.0: PME# disabled
pci 0000:00:09.0: transparent bridge
pci 0000:03:00.0: reg 10 32bit mmio: [0xfb000000-0xfbffffff]
pci 0000:03:00.0: reg 14 64bit mmio pref: [0xe0000000-0xefffffff]
pci 0000:03:00.0: reg 1c 64bit mmio pref: [0xf8000000-0xf9ffffff]
pci 0000:03:00.0: reg 24 io port: [0xec00-0xec7f]
pci 0000:03:00.0: reg 30 32bit mmio pref: [0xfafe0000-0xfaffffff]
pci 0000:00:10.0: bridge io port: [0xe000-0xefff]
pci 0000:00:10.0: bridge 32bit mmio: [0xfaf00000-0xfbffffff]
pci 0000:00:10.0: bridge 64bit mmio pref: [0xe0000000-0xf9ffffff]
pci_bus 0000:00: on NUMA node 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PBB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.IXVE._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN0A] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN0B] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN0C] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN0D] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN1A] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN1B] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN1C] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN1D] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN2A] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN2B] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN2C] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN2D] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN3A] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN3B] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN3C] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN3D] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN4A] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN4B] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN4C] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN4D] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN5A] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN5B] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN5C] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN5D] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN6A] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN6B] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN6C] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LN6D] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LUB0] (IRQs 20 21 22 23) *7
ACPI: PCI Interrupt Link [LUB2] (IRQs 20 21 22 23) *11
ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *11
ACPI: PCI Interrupt Link [LAZA] (IRQs 20 21 22 23) *15
ACPI: PCI Interrupt Link [SGRU] (IRQs 20 21 22 23) *5
ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *15
ACPI: PCI Interrupt Link [LPMU] (IRQs 20 21 22 23) *14
ACPI: PCI Interrupt Link [LSA0] (IRQs 20 21 22 23) *10
ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [UB11] (IRQs 20 21 22 23) *9
ACPI: PCI Interrupt Link [UB12] (IRQs 20 21 22 23) *5
ACPI: PCI Interrupt Link [LRP0] (IRQs 20 21 22 23) *11
ACPI: PCI Interrupt Link [LRP1] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LRP2] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LRP3] (IRQs 20 21 22 23) *9
ACPI: PCI Interrupt Link [LRP4] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LRP5] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LRP6] (IRQs 20 21 22 23) *0, disabled.
vgaarb: device added:
PCI:0000:03:00.0,decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
PCI: Using ACPI for IRQ routing
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31, 31
hpet0: 4 comparators, 64-bit 25.000000 MHz counter
Switching to clocksource tsc
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
system 00:04: ioport range 0x4d0-0x4d1 has been reserved
system 00:04: ioport range 0x800-0x80f has been reserved
system 00:04: ioport range 0x4000-0x407f has been reserved
system 00:04: ioport range 0x4080-0x40ff has been reserved
system 00:04: ioport range 0x4400-0x447f has been reserved
system 00:04: ioport range 0x4480-0x44ff has been reserved
system 00:04: ioport range 0x4800-0x487f has been reserved
system 00:04: ioport range 0x4880-0x48ff has been reserved
system 00:04: iomem range 0xfefe2000-0xfefe3fff has been reserved
system 00:04: iomem range 0xfefe1000-0xfefe1fff has been reserved
system 00:04: iomem range 0xfee01000-0xfeefffff has been reserved
system 00:08: ioport range 0x290-0x297 has been reserved
system 00:09: iomem range 0xfec00000-0xfec00fff could not be reserved
system 00:09: iomem range 0xfee00000-0xfee00fff has been reserved
system 00:0a: iomem range 0xfc000000-0xfdffffff has been reserved
system 00:0b: iomem range 0x0-0x9ffff could not be reserved
system 00:0b: iomem range 0xc0000-0xcffff has been reserved
system 00:0b: iomem range 0xe0000-0xfffff could not be reserved
system 00:0b: iomem range 0x100000-0xdfffffff could not be reserved
system 00:0b: iomem range 0xfec00000-0xffffffff could not be reserved
pci 0000:00:09.0: PCI bridge, secondary bus 0000:01
pci 0000:00:09.0:   IO window: disabled
pci 0000:00:09.0:   MEM window: disabled
pci 0000:00:09.0:   PREFETCH window: disabled
pci 0000:00:0c.0: PCI bridge, secondary bus 0000:02
pci 0000:00:0c.0:   IO window: disabled
pci 0000:00:0c.0:   MEM window: disabled
pci 0000:00:0c.0:   PREFETCH window: disabled
pci 0000:00:10.0: PCI bridge, secondary bus 0000:03
pci 0000:00:10.0:   IO window: 0xe000-0xefff
pci 0000:00:10.0:   MEM window: 0xfaf00000-0xfbffffff
pci 0000:00:10.0:   PREFETCH window: 0x000000e0000000-0x000000f9ffffff
pci 0000:00:15.0: PCI bridge, secondary bus 0000:04
pci 0000:00:15.0:   IO window: disabled
pci 0000:00:15.0:   MEM window: disabled
pci 0000:00:15.0:   PREFETCH window: disabled
pci 0000:00:09.0: setting latency timer to 64
ACPI: PCI Interrupt Link [LRP0] enabled at IRQ 23
pci 0000:00:0c.0: PCI INT A -> Link[LRP0] -> GSI 23 (level, low) ->
IRQ 23
pci 0000:00:0c.0: setting latency timer to 64
pci 0000:00:10.0: setting latency timer to 64
ACPI: PCI Interrupt Link [LRP3] enabled at IRQ 22
pci 0000:00:15.0: PCI INT A -> Link[LRP3] -> GSI 22 (level, low) ->
IRQ 22
pci 0000:00:15.0: setting latency timer to 64
pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
pci_bus 0000:01: resource 3 io:  [0x00-0xffff]
pci_bus 0000:01: resource 4 mem: [0x000000-0xffffffffffffffff]
pci_bus 0000:03: resource 0 io:  [0xe000-0xefff]
pci_bus 0000:03: resource 1 mem: [0xfaf00000-0xfbffffff]
pci_bus 0000:03: resource 2 pref mem [0xe0000000-0xf9ffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
NET: Registered protocol family 1
pci 0000:03:00.0: Boot video device
msgmni has been set to 7420
io scheduler noop registered
io scheduler cfq registered (default)
pcieport 0000:00:0c.0: irq 24 for MSI/MSI-X
pcieport 0000:00:0c.0: setting latency timer to 64
pcieport 0000:00:15.0: irq 25 for MSI/MSI-X
pcieport 0000:00:15.0: setting latency timer to 64
ahci 0000:00:0b.0: version 3.0
ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 21
ahci 0000:00:0b.0: PCI INT A -> Link[LSA0] -> GSI 21 (level, low) ->
IRQ 21
ahci 0000:00:0b.0: irq 26 for MSI/MSI-X
ahci 0000:00:0b.0: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl
SATA mode
ahci 0000:00:0b.0: flags: 64bit ncq sntf led pmp pio slum part sxs boh
ahci 0000:00:0b.0: setting latency timer to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
ata1: SATA max UDMA/133 abar m8192@0xfae76000 port 0xfae76100 irq 26
ata2: SATA max UDMA/133 abar m8192@0xfae76000 port 0xfae76180 irq 26
ata3: SATA max UDMA/133 abar m8192@0xfae76000 port 0xfae76200 irq 26
ata4: SATA max UDMA/133 abar m8192@0xfae76000 port 0xfae76280 irq 26
ata5: SATA max UDMA/133 abar m8192@0xfae76000 port 0xfae76300 irq 26
ata6: SATA max UDMA/133 abar m8192@0xfae76000 port 0xfae76380 irq 26
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 appears to have AUX port disabled, if this is incorrect
please boot with i8042.nopnp
serio: i8042 KBD port at 0x60,0x64 irq 1
cpuidle: using governor ladder
cpuidle: using governor menu
TCP cubic registered
NET: Registered protocol family 17
input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input0
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6: SATA link down (SStatus 0 SControl 300)
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5: SATA link down (SStatus 0 SControl 300)
ata4.00: ATAPI: TSSTcorp CDDVDW SH-S203B, SB02, max UDMA/100, ATAPI AN
ata4.00: configured for UDMA/100
ata1.00: ATA-7: WDC WD800ADFS-75SLR2, 21.07Q21, max UDMA/133
ata1.00: 156250000 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      WDC WD800ADFS-75 21.0 PQ: 0
ANSI: 5
sd 0:0:0:0: [sda] 156250000 512-byte logical blocks: (80.0 GB/74.5
GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
ata2.00: ATA-7: ST3250620AS, 3.AAC, max UDMA/133
ata2.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata2.00: configured for UDMA/133
scsi 1:0:0:0: Direct-Access     ATA      ST3250620AS      3.AA PQ: 0
ANSI: 5
sd 1:0:0:0: [sdb] 488397168 512-byte logical blocks: (250 GB/232 GiB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdb:
scsi 3:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S203B  SB02 PQ: 0
ANSI: 5
 sdb1 sdb2
sd 1:0:0:0: [sdb] Attached SCSI disk
EXT4-fs (sda2): mounted filesystem with ordered data mode
VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
=46reeing unused kernel memory: 372k freed
udev: starting version 135
input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
ACPI: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
ACPI: Power Button [PWRF]
ACPI: SSDT 00000000cff9e350 00277 (v01 DpgPmm  P001Ist 00000011 INTL
20060113)
processor LNXCPU:00: registered as cooling_device0
ACPI: SSDT 00000000cff9e5d0 00277 (v01 DpgPmm  P002Ist 00000012 INTL
20060113)
processor LNXCPU:01: registered as cooling_device1
ACPI: SSDT 00000000cff9e850 00277 (v01 DpgPmm  P003Ist 00000012 INTL
20060113)
processor LNXCPU:02: registered as cooling_device2
ACPI: SSDT 00000000cff9ead0 00277 (v01 DpgPmm  P004Ist 00000012 INTL
20060113)
processor LNXCPU:03: registered as cooling_device3
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Driver 'rtc_cmos' needs updating - please use bus_type methods
rtc_cmos 00:06: RTC can wake from S4
rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
forcedeth: Reverse Engineered nForce ethernet driver. Version 0.64.
ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 20
forcedeth 0000:00:0a.0: PCI INT A -> Link[LMAC] -> GSI 20 (level, low)
-> IRQ 20
forcedeth 0000:00:0a.0: setting latency timer to 64
sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 3:0:0:0: Attached scsi CD-ROM sr0
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
forcedeth 0000:00:0a.0: ifname eth0, PHY OUI 0x732 @ 3, addr
00:23:54:44:72:8a
forcedeth 0000:00:0a.0: highdma csum pwrctl gbit lnktim msi desc-v3
ACPI: PCI Interrupt Link [LUB0] enabled at IRQ 23
ohci_hcd 0000:00:04.0: PCI INT A -> Link[LUB0] -> GSI 23 (level, low)
-> IRQ 23
ohci_hcd 0000:00:04.0: setting latency timer to 64
ohci_hcd 0000:00:04.0: OHCI Host Controller
ohci_hcd 0000:00:04.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:04.0: irq 23, io mem 0xfae7f000
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sr 3:0:0:0: Attached scsi generic sg2 type 5
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Warning! ehci_hcd should always be loaded before uhci_hcd and
ohci_hcd, not after
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 22
ehci_hcd 0000:00:04.1: PCI INT B -> Link[LUB2] -> GSI 22 (level, low)
-> IRQ 22
ehci_hcd 0000:00:04.1: setting latency timer to 64
ehci_hcd 0000:00:04.1: EHCI Host Controller
ehci_hcd 0000:00:04.1: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:04.1: debug port 1
ehci_hcd 0000:00:04.1: cache line size of 32 is not supported
ehci_hcd 0000:00:04.1: irq 22, io mem 0xfae7ec00
ehci_hcd 0000:00:04.1: USB 2.0 started, EHCI 1.00
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
ACPI: PCI Interrupt Link [UB11] enabled at IRQ 21
ohci_hcd 0000:00:06.0: PCI INT A -> Link[UB11] -> GSI 21 (level, low)
-> IRQ 21
ohci_hcd 0000:00:06.0: setting latency timer to 64
ohci_hcd 0000:00:06.0: OHCI Host Controller
ohci_hcd 0000:00:06.0: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:06.0: irq 21, io mem 0xfae7d000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
ACPI: PCI Interrupt Link [UB12] enabled at IRQ 20
ehci_hcd 0000:00:06.1: PCI INT B -> Link[UB12] -> GSI 20 (level, low)
-> IRQ 20
ehci_hcd 0000:00:06.1: setting latency timer to 64
ehci_hcd 0000:00:06.1: EHCI Host Controller
ehci_hcd 0000:00:06.1: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:06.1: debug port 1
ehci_hcd 0000:00:06.1: cache line size of 32 is not supported
ehci_hcd 0000:00:06.1: irq 20, io mem 0xfae7e800
ehci_hcd 0000:00:06.1: USB 2.0 started, EHCI 1.00
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
HDA Intel 0000:00:08.0: power state changed by ACPI to D0
ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 23
HDA Intel 0000:00:08.0: PCI INT A -> Link[LAZA] -> GSI 23 (level, low)
-> IRQ 23
HDA Intel 0000:00:08.0: setting latency timer to 64
usb 2-1: new high speed USB device using ehci_hcd and address 2
hda-codec: No codec parser is available
usb 2-1: configuration #1 chosen from 1 choice
nvidia: module license 'NVIDIA' taints kernel.
Disabling lock debugging due to kernel taint
usb 3-3: new full speed USB device using ohci_hcd and address 2
usb 3-3: configuration #1 chosen from 1 choice
hub 3-3:1.0: USB hub found
hub 3-3:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LPMU] enabled at IRQ 22
nvidia 0000:00:03.5: PCI INT B -> Link[LPMU] -> GSI 22 (level, low) ->
IRQ 22
ACPI: PCI Interrupt Link [SGRU] enabled at IRQ 21
nvidia 0000:03:00.0: PCI INT A -> Link[SGRU] -> GSI 21 (level, low) ->
IRQ 21
nvidia 0000:03:00.0: setting latency timer to 64
NVRM: loading NVIDIA UNIX x86_64 Kernel Module  190.42  Tue Oct 20
20:25:42 PDT 2009
usb 3-3.1: new low speed USB device using ohci_hcd and address 3
usb 3-3.1: configuration #1 chosen from 1 choice
input: Dell Dell USB Keyboard Hub as
/devices/pci0000:00/0000:00:06.0/usb3/3-3/3-3.1/3-3.1:1.0/input/input3
generic-usb 0003:413C:2006.0001: input: USB HID v1.10 Keyboard [Dell
Dell USB Keyboard Hub] on usb-0000:00:06.0-3.1/input0
input: Dell Dell USB Keyboard Hub as
/devices/pci0000:00/0000:00:06.0/usb3/3-3/3-3.1/3-3.1:1.1/input/input4
generic-usb 0003:413C:2006.0002: input: USB HID v1.10 Device [Dell
Dell USB Keyboard Hub] on usb-0000:00:06.0-3.1/input1
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
usb 3-3.3: new low speed USB device using ohci_hcd and address 4
usb 3-3.3: configuration #1 chosen from 1 choice
input: Microsoft Microsoft IntelliMouse=C2=AE Explorer as
/devices/pci0000:00/0000:00:06.0/usb3/3-3/3-3.3/3-3.3:1.0/input/input5
generic-usb 0003:045E:0095.0003: input: USB HID v1.11 Mouse [Microsoft
Microsoft IntelliMouse=C2=AE Explorer] on usb-0000:00:06.0-3.3/input0
fuse init (API version 7.13)
ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
ata1.00: cmd 61/08:00:4f:ad:03/00:00:00:00:00/40 tag 0 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: hard resetting link
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1.00: device reported invalid CHS sector 0
ata1: EH complete
SGI XFS with security attributes, large block/inode numbers, no debug
enabled
XFS mounting filesystem sda4
Ending clean XFS mount for filesystem: sda4
Adding 4112632k swap on /dev/sda3.  Priority:-1 extents:1
across:4112632k
ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
ata1.00: cmd 61/40:00:d7:8d:e2/00:00:05:00:00/40 tag 0 ncq 32768 out
         res 40/00:78:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
ata1: hard resetting link
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1.00: device reported invalid CHS sector 0
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
ata1.00: cmd 61/10:00:3f:6b:73/00:00:02:00:00/40 tag 0 ncq 8192 out
         res 40/00:78:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
ata1: hard resetting link
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1.00: device reported invalid CHS sector 0
ata1: EH complete
ata1.00: NCQ disabled due to excessive errors
ata1.00: exception Emask 0x0 SAct 0x7ff1ffff SErr 0x0 action 0x6
frozen
ata1.00: cmd 61/08:00:f7:95:e2/00:00:05:00:00/40 tag 0 ncq 4096 out
         res 40/00:78:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
ata1.00: cmd 61/08:08:c7:0c:95/00:00:00:00:00/40 tag 1 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:10:3f:b7:97/00:00:00:00:00/40 tag 2 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:18:4f:ad:c3/00:00:00:00:00/40 tag 3 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:20:af:ad:c3/00:00:00:00:00/40 tag 4 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:28:cf:ad:c3/00:00:00:00:00/40 tag 5 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:30:37:36:c4/00:00:00:00:00/40 tag 6 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:38:47:36:c4/00:00:00:00:00/40 tag 7 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:40:cf:6d:c4/00:00:00:00:00/40 tag 8 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/20:48:0f:6e:c4/00:00:00:00:00/40 tag 9 ncq 16384 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:50:87:72:c4/00:00:00:00:00/40 tag 10 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:58:8f:b3:cb/00:00:00:00:00/40 tag 11 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/20:60:4f:ad:d7/00:00:00:00:00/40 tag 12 ncq 16384 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:68:8f:ad:03/00:00:01:00:00/40 tag 13 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:70:4f:ed:4d/00:00:01:00:00/40 tag 14 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/10:78:b7:70:91/00:00:02:00:00/40 tag 15 ncq 8192 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:80:2f:d7:08/00:00:00:00:00/40 tag 16 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:a0:bf:ea:08/00:00:00:00:00/40 tag 20 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:a8:47:bb:0f/00:00:00:00:00/40 tag 21 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:b0:4f:71:15/00:00:00:00:00/40 tag 22 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:b8:87:73:15/00:00:00:00:00/40 tag 23 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:c0:4f:ad:43/00:00:00:00:00/40 tag 24 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:c8:07:af:83/00:00:00:00:00/40 tag 25 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:d0:37:b0:83/00:00:00:00:00/40 tag 26 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:d8:97:b3:83/00:00:00:00:00/40 tag 27 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:e0:3f:d4:83/00:00:00:00:00/40 tag 28 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:e8:97:d6:83/00:00:00:00:00/40 tag 29 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:f0:d7:d7:83/00:00:00:00:00/40 tag 30 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: hard resetting link
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
ata1.00: device reported invalid CHS sector 0
