From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH #upstream] ahci: add HFLAG_YES_FBS and apply it to 88SE9128
Date: Mon, 20 Dec 2010 05:24:59 +0200
Message-ID: <4D0ECC8B.3030008@iki.fi>
References: <4C4AFE7C.5070506@kernel.org> <4CF45BC0.2030701@iki.fi> <4CF4FCBE.2060406@kernel.org> <4CF55A4B.1020402@iki.fi> <4CFE8EE2.1060908@iki.fi> <4CFF67B6.7090805@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040005050300050601040901"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from saarni.dnainternet.net ([83.102.40.136]:35791 "EHLO
	saarni.dnainternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab0LTDZJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Dec 2010 22:25:09 -0500
In-Reply-To: <4CFF67B6.7090805@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>

This is a multi-part message in MIME format.
--------------040005050300050601040901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 08.12.2010 13:10, Tejun Heo wrote:
> Hello,

Hello!

Sorry for the delay (again).

> On 12/07/2010 08:45 PM, Anssi Hannula wrote:
>>>>> Attached is a patch to make the id entry class-specific. The patch is
>>>>> untested (the issue happens in a production machine).
>>>>
>>>> Thanks a lot for the patch.  It looks correct but it would be great if
>>>> it can be veified.
>>>
>>> I think I can do that later, but probably not this week or so.
>>
>> I've now verified that the patch works on a system with 1b4b:9123
>> controller.
> 
> Thanks for verifying.  Can you please post the kernel log?  Also, do
> all ports seem to work?

Kernel log at boot time is attached. The 1b4b:9123 controllers are at
01:00.x, 06:00.x, 08:00.x, no disks attached to them.

Both of the ports on the controllers seem to work.

-- 
Anssi Hannula

--------------040005050300050601040901
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg"

Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.36.1-desktop-1mnb (thomas@celeste.mandriva.com) (gcc version 4.5.1 (GCC) ) #1 SMP Tue Nov 23 01:22:32 CET 2010
Command line: BOOT_IMAGE=linux root=/dev/delta/root resume=UUID=792c5907-6e5d-4825-aa46-4bc468532645
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009d000 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000efbb0000 (usable)
 BIOS-e820: 00000000efbb0000 - 00000000efbe2000 (ACPI NVS)
 BIOS-e820: 00000000efbe2000 - 00000000efbf0000 (ACPI data)
 BIOS-e820: 00000000efbf0000 - 00000000efc00000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000210000000 (usable)
NX (Execute Disable) protection: active
DMI 2.4 present.
e820 update range: 0000000000000000 - 0000000000001000 (usable) ==> (reserved)
e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
No AGP bridge found
last_pfn = 0x210000 max_arch_pfn = 0x400000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-C8FFF write-protect
  C9000-EFFFF uncachable
  F0000-FFFFF write-through
MTRR variable ranges enabled:
  0 base 000000000 mask F00000000 write-back
  1 base 0F0000000 mask FF0000000 uncachable
  2 base 100000000 mask F00000000 write-back
  3 base 200000000 mask FF0000000 write-back
  4 disabled
  5 disabled
  6 disabled
  7 disabled
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
e820 update range: 00000000f0000000 - 0000000100000000 (usable) ==> (reserved)
last_pfn = 0xefbb0 max_arch_pfn = 0x400000000
initial memory mapped : 0 - 20000000
found SMP MP-table at [ffff8800000f5ab0] f5ab0
init_memory_mapping: 0000000000000000-00000000efbb0000
 0000000000 - 00efa00000 page 2M
 00efa00000 - 00efbb0000 page 4k
kernel direct mapping tables up to efbb0000 @ 8000-e000
init_memory_mapping: 0000000100000000-0000000210000000
 0100000000 - 0210000000 page 2M
kernel direct mapping tables up to 210000000 @ c000-16000
RAMDISK: 37af7000 - 37ff0000
ACPI: RSDP 00000000000f78a0 00014 (v00 GBT   )
ACPI: RSDT 00000000efbe2040 00040 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
ACPI: FACP 00000000efbe20c0 00074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
ACPI: DSDT 00000000efbe2180 0734D (v01 GBT    GBTUACPI 00001000 MSFT 0100000C)
ACPI: FACS 00000000efbb0000 00040
ACPI: HPET 00000000efbe9640 00038 (v01 GBT    GBTUACPI 42302E31 GBTU 00000098)
ACPI: MCFG 00000000efbe96c0 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
ACPI: EUDS 00000000efbe9780 00560 (v01 GBT             00000000      00000000)
ACPI: TAMG 00000000efbe9ce0 00A32 (v01 GBT    GBT   B0 5455312E BG?? 53450101)
ACPI: APIC 00000000efbe9540 000BC (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
ACPI: SSDT 00000000efbea740 015A0 (v01  INTEL PPM RCM  80000001 INTL 20061109)
ACPI: Local APIC address 0xfee00000
No NUMA configuration found
Faking a node at 0000000000000000-0000000210000000
Initmem setup node 0 0000000000000000-0000000210000000
  NODE_DATA [0000000100000000 - 0000000100004fff]
 [ffffea0000000000-ffffea00073fffff] PMD -> [ffff880100200000-ffff8801073fffff] on node 0
Zone PFN ranges:
  DMA      0x00000001 -> 0x00001000
  DMA32    0x00001000 -> 0x00100000
  Normal   0x00100000 -> 0x00210000
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0: 0x00000001 -> 0x0000009d
    0: 0x00000100 -> 0x000efbb0
    0: 0x00100000 -> 0x00210000
On node 0 totalpages: 2095948
  DMA zone: 56 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 3940 pages, LIFO batch:0
  DMA32 zone: 14280 pages used for memmap
  DMA32 zone: 963560 pages, LIFO batch:31
  Normal zone: 15232 pages used for memmap
  Normal zone: 1098880 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x02] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x04] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x06] enabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
SMP: Allowing 8 CPUs, 4 hotplug CPUs
nr_irqs_gsi: 40
early_res array is doubled to 64 at [7000 - 77ff]
PM: Registered nosave memory: 000000000009d000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
PM: Registered nosave memory: 00000000efbb0000 - 00000000efbe2000
PM: Registered nosave memory: 00000000efbe2000 - 00000000efbf0000
PM: Registered nosave memory: 00000000efbf0000 - 00000000efc00000
PM: Registered nosave memory: 00000000efc00000 - 00000000f0000000
PM: Registered nosave memory: 00000000f0000000 - 00000000f4000000
PM: Registered nosave memory: 00000000f4000000 - 00000000fec00000
PM: Registered nosave memory: 00000000fec00000 - 0000000100000000
Allocating PCI resources starting at f4000000 (gap: f4000000:ac00000)
Booting paravirtualized kernel on bare hardware
setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:8 nr_node_ids:1
PERCPU: Embedded 29 pages/cpu @ffff880001a00000 s87040 r8192 d23552 u262144
pcpu-alloc: s87040 r8192 d23552 u262144 alloc=1*2097152
pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
early_res array is doubled to 128 at [11000 - 11fff]
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2066380
Policy zone: Normal
Kernel command line: BOOT_IMAGE=linux root=/dev/delta/root resume=UUID=792c5907-6e5d-4825-aa46-4bc468532645
PID hash table entries: 4096 (order: 3, 32768 bytes)
Checking aperture...
No AGP bridge found
Calgary: detecting Calgary via BIOS EBDA area
Calgary: Unable to locate Rio Grande table in EBDA - bailing!
Subtract (60 early reservations)
  #1 [0001000000 - 00019624c8]   TEXT DATA BSS
  #2 [0037af7000 - 0037ff0000]         RAMDISK
  #3 [0001963000 - 00019630ee]             BRK
  #4 [00000f5ac0 - 0000100000]   BIOS reserved
  #5 [00000f5ab0 - 00000f5ac0]    MP-table mpf
  #6 [000009d000 - 00000f0d00]   BIOS reserved
  #7 [00000f0f54 - 00000f5ab0]   BIOS reserved
  #8 [00000f0d00 - 00000f0f54]    MP-table mpc
  #9 [0000001000 - 0000003000]      TRAMPOLINE
  #10 [0000003000 - 0000007000]     ACPI WAKEUP
  #11 [0000008000 - 000000c000]         PGTABLE
  #12 [000000c000 - 0000011000]         PGTABLE
  #13 [0100000000 - 0100005000]       NODE_DATA
  #14 [0001963100 - 0001964100]         BOOTMEM
  #15 [0100005000 - 0100005600]         BOOTMEM
  #16 [0100006000 - 0100007000]         BOOTMEM
  #17 [0100007000 - 0100008000]         BOOTMEM
  #18 [0100200000 - 0107400000]        MEMMAP 0
  #19 [0001964100 - 000197c100]         BOOTMEM
  #20 [000197c100 - 0001994100]         BOOTMEM
  #21 [0001994100 - 00019ac100]         BOOTMEM
  #22 [00019ad000 - 00019ae000]         BOOTMEM
  #23 [0001962500 - 0001962541]         BOOTMEM
  #24 [0001962580 - 00019625c3]         BOOTMEM
  #25 [0001962600 - 0001962868]         BOOTMEM
  #26 [0001962880 - 00019628e8]         BOOTMEM
  #27 [0001962900 - 0001962968]         BOOTMEM
  #28 [0001962980 - 00019629e8]         BOOTMEM
  #29 [0001962a00 - 0001962a68]         BOOTMEM
  #30 [0001962a80 - 0001962ae8]         BOOTMEM
  #31 [0001962b00 - 0001962b68]         BOOTMEM
  #32 [0001962b80 - 0001962be8]         BOOTMEM
  #33 [0001962c00 - 0001962c68]         BOOTMEM
  #34 [0001962c80 - 0001962ce8]         BOOTMEM
  #35 [0001962d00 - 0001962d68]         BOOTMEM
  #36 [0001962d80 - 0001962da0]         BOOTMEM
  #37 [0001962dc0 - 0001962de0]         BOOTMEM
  #38 [0001962e00 - 0001962e57]         BOOTMEM
  #39 [0001962e80 - 0001962ed7]         BOOTMEM
  #40 [0001a00000 - 0001a1d000]         BOOTMEM
  #41 [0001a40000 - 0001a5d000]         BOOTMEM
  #42 [0001a80000 - 0001a9d000]         BOOTMEM
  #43 [0001ac0000 - 0001add000]         BOOTMEM
  #44 [0001b00000 - 0001b1d000]         BOOTMEM
  #45 [0001b40000 - 0001b5d000]         BOOTMEM
  #46 [0001b80000 - 0001b9d000]         BOOTMEM
  #47 [0001bc0000 - 0001bdd000]         BOOTMEM
  #48 [0001962f00 - 0001962f08]         BOOTMEM
  #49 [0001962f40 - 0001962f48]         BOOTMEM
  #50 [0001962f80 - 0001962fa0]         BOOTMEM
  #51 [0001962fc0 - 0001963000]         BOOTMEM
  #52 [00019ac100 - 00019ac220]         BOOTMEM
  #53 [00019ac240 - 00019ac288]         BOOTMEM
  #54 [00019ac2c0 - 00019ac308]         BOOTMEM
  #55 [00019ae000 - 00019b6000]         BOOTMEM
  #56 [0001bdd000 - 0005bdd000]         BOOTMEM
  #57 [00019b6000 - 00019d6000]         BOOTMEM
  #58 [0005bdd000 - 0005c1d000]         BOOTMEM
  #59 [0000012000 - 000001a000]         BOOTMEM
Memory: 8185048k/8650752k available (4059k kernel code, 266960k absent, 198744k reserved, 3255k data, 708k init)
SLUB: Genslabs=14, HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Hierarchical RCU implementation.
	RCU-based detection of stalled CPUs is disabled.
	Verbose stalled-CPUs detection is disabled.
NR_IRQS:2304
Console: colour VGA+ 80x25
console [tty0] enabled
allocated 83886080 bytes of page_cgroup
please try 'cgroup_disable=memory' option if you don't want memory cgroups
hpet clockevent registered
Fast TSC calibration using PIT
Detected 2734.257 MHz processor.
Calibrating delay loop (skipped), value calculated using timer frequency.. 5468.51 BogoMIPS (lpj=2734257)
pid_max: default: 32768 minimum: 301
Security Framework initialized
TOMOYO Linux initialized
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Mount-cache hash table entries: 256
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys net_cls
Initializing cgroup subsys blkio
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 9 MCE banks
CPU0: Thermal monitoring enabled (TM1)
using mwait in idle threads.
Performance Events: PEBS fmt1+, Nehalem events, Intel PMU driver.
... version:                3
... bit width:              48
... generic registers:      4
... value mask:             0000ffffffffffff
... max period:             000000007fffffff
... fixed-purpose events:   3
... event mask:             000000070000000f
ACPI: Checking initramfs for custom DSDT
ACPI: Core revision 20100702
ftrace: converting mcount calls to 0f 1f 44 00 00
ftrace: allocating 16051 entries in 63 pages
Setting APIC routing to flat
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: Intel(R) Core(TM) i5 CPU         750  @ 2.67GHz stepping 05
Booting Node   0, Processors  #1 #2 #3
Brought up 4 CPUs
Total of 4 processors activated (21869.26 BogoMIPS).
devtmpfs: initialized
Time: 19:43:59  Date: 12/07/10
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf0000000-0xf3ffffff] (base 0xf0000000)
PCI: MMCONFIG at [mem 0xf0000000-0xf3ffffff] reserved in E820
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI Warning: Incorrect checksum in table [TAMG] - 0xBF, should be 0xBE (20100702/tbutils-314)
ACPI: No dock devices found.
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
pci_root PNP0A03:00: host bridge window [io  0x0000-0x0cf7]
pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff]
pci_root PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff]
pci_root PNP0A03:00: host bridge window [mem 0xfed40000-0xfed44fff]
pci_root PNP0A03:00: host bridge window [mem 0xefc00000-0xfebfffff]
pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
pci 0000:00:03.0: PME# disabled
pci 0000:00:1a.0: reg 20: [io  0xff00-0xff1f]
pci 0000:00:1a.1: reg 20: [io  0xfe00-0xfe1f]
pci 0000:00:1a.2: reg 20: [io  0xfd00-0xfd1f]
pci 0000:00:1a.7: reg 10: [mem 0xfbfff000-0xfbfff3ff]
pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1a.7: PME# disabled
pci 0000:00:1b.0: reg 10: [mem 0xfbff8000-0xfbffbfff 64bit]
pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1b.0: PME# disabled
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: PME# disabled
pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.1: PME# disabled
pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.2: PME# disabled
pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.3: PME# disabled
pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.5: PME# disabled
pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.6: PME# disabled
pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.7: PME# disabled
pci 0000:00:1d.0: reg 20: [io  0xfc00-0xfc1f]
pci 0000:00:1d.1: reg 20: [io  0xfb00-0xfb1f]
pci 0000:00:1d.2: reg 20: [io  0xfa00-0xfa1f]
pci 0000:00:1d.3: reg 20: [io  0xf900-0xf91f]
pci 0000:00:1d.7: reg 10: [mem 0xfbffe000-0xfbffe3ff]
pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.7: PME# disabled
pci 0000:00:1f.2: reg 10: [io  0xf800-0xf807]
pci 0000:00:1f.2: reg 14: [io  0xf700-0xf703]
pci 0000:00:1f.2: reg 18: [io  0xf600-0xf607]
pci 0000:00:1f.2: reg 1c: [io  0xf500-0xf503]
pci 0000:00:1f.2: reg 20: [io  0xf400-0xf41f]
pci 0000:00:1f.2: reg 24: [mem 0xfbffd000-0xfbffd7ff]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.2: PME# disabled
pci 0000:00:1f.3: reg 10: [mem 0xfbffc000-0xfbffc0ff 64bit]
pci 0000:00:1f.3: reg 20: [io  0x0500-0x051f]
pci 0000:01:00.0: reg 10: [io  0x8f00-0x8f07]
pci 0000:01:00.0: reg 14: [io  0x8e00-0x8e03]
pci 0000:01:00.0: reg 18: [io  0x8d00-0x8d07]
pci 0000:01:00.0: reg 1c: [io  0x8c00-0x8c03]
pci 0000:01:00.0: reg 20: [io  0x8b00-0x8b0f]
pci 0000:01:00.0: reg 24: [mem 0xfb7ff000-0xfb7ff7ff]
pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0000ffff pref]
pci 0000:01:00.0: PME# supported from D3hot
pci 0000:01:00.0: PME# disabled
pci 0000:01:00.1: reg 10: [io  0x8a00-0x8a07]
pci 0000:01:00.1: reg 14: [io  0x8900-0x8903]
pci 0000:01:00.1: reg 18: [io  0x8800-0x8807]
pci 0000:01:00.1: reg 1c: [io  0x8700-0x8703]
pci 0000:01:00.1: reg 20: [io  0x8600-0x860f]
pci 0000:01:00.1: reg 24: [mem 0xfb7fe000-0xfb7fe00f]
pci 0000:01:00.1: reg 30: [mem 0x00000000-0x0000ffff pref]
pci 0000:01:00.1: PME# supported from D3hot
pci 0000:01:00.1: PME# disabled
pci 0000:00:03.0: PCI bridge to [bus 01-01]
pci 0000:00:03.0:   bridge window [io  0x8000-0x8fff]
pci 0000:00:03.0:   bridge window [mem 0xfb700000-0xfb7fffff]
pci 0000:00:03.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:02:00.0: reg 10: [io  0x7e00-0x7eff]
pci 0000:02:00.0: reg 18: [mem 0xfb5ff000-0xfb5fffff 64bit pref]
pci 0000:02:00.0: reg 20: [mem 0xfb5f8000-0xfb5fbfff 64bit pref]
pci 0000:02:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
pci 0000:02:00.0: supports D1 D2
pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:02:00.0: PME# disabled
pci 0000:00:1c.0: PCI bridge to [bus 02-02]
pci 0000:00:1c.0:   bridge window [io  0x7000-0x7fff]
pci 0000:00:1c.0:   bridge window [mem 0xfb600000-0xfb6fffff]
pci 0000:00:1c.0:   bridge window [mem 0xfb500000-0xfb5fffff 64bit pref]
pci 0000:03:00.0: reg 10: [io  0xee00-0xeeff]
pci 0000:03:00.0: reg 18: [mem 0xfbdff000-0xfbdfffff 64bit pref]
pci 0000:03:00.0: reg 20: [mem 0xfbdf8000-0xfbdfbfff 64bit pref]
pci 0000:03:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
pci 0000:03:00.0: supports D1 D2
pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:03:00.0: PME# disabled
pci 0000:00:1c.1: PCI bridge to [bus 03-03]
pci 0000:00:1c.1:   bridge window [io  0xe000-0xefff]
pci 0000:00:1c.1:   bridge window [mem 0xfbe00000-0xfbefffff]
pci 0000:00:1c.1:   bridge window [mem 0xfbd00000-0xfbdfffff 64bit pref]
pci 0000:04:00.0: reg 24: [mem 0xfbcfe000-0xfbcfffff]
pci 0000:04:00.0: PME# supported from D3hot
pci 0000:04:00.0: PME# disabled
pci 0000:04:00.1: reg 10: [io  0xdf00-0xdf07]
pci 0000:04:00.1: reg 14: [io  0xde00-0xde03]
pci 0000:04:00.1: reg 18: [io  0xdd00-0xdd07]
pci 0000:04:00.1: reg 1c: [io  0xdc00-0xdc03]
pci 0000:04:00.1: reg 20: [io  0xdb00-0xdb0f]
pci 0000:04:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
pci 0000:00:1c.2: PCI bridge to [bus 04-04]
pci 0000:00:1c.2:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.2:   bridge window [mem 0xfbc00000-0xfbcfffff]
pci 0000:00:1c.2:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:05:00.0: reg 24: [mem 0xfbbfe000-0xfbbfffff]
pci 0000:05:00.0: PME# supported from D3hot
pci 0000:05:00.0: PME# disabled
pci 0000:05:00.1: reg 10: [io  0xcf00-0xcf07]
pci 0000:05:00.1: reg 14: [io  0xce00-0xce03]
pci 0000:05:00.1: reg 18: [io  0xcd00-0xcd07]
pci 0000:05:00.1: reg 1c: [io  0xcc00-0xcc03]
pci 0000:05:00.1: reg 20: [io  0xcb00-0xcb0f]
pci 0000:05:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
pci 0000:00:1c.3: PCI bridge to [bus 05-05]
pci 0000:00:1c.3:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1c.3:   bridge window [mem 0xfbb00000-0xfbbfffff]
pci 0000:00:1c.3:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:06:00.0: reg 10: [io  0xbf00-0xbf07]
pci 0000:06:00.0: reg 14: [io  0xbe00-0xbe03]
pci 0000:06:00.0: reg 18: [io  0xbd00-0xbd07]
pci 0000:06:00.0: reg 1c: [io  0xbc00-0xbc03]
pci 0000:06:00.0: reg 20: [io  0xbb00-0xbb0f]
pci 0000:06:00.0: reg 24: [mem 0xfbaff000-0xfbaff7ff]
pci 0000:06:00.0: reg 30: [mem 0x00000000-0x0000ffff pref]
pci 0000:06:00.0: PME# supported from D3hot
pci 0000:06:00.0: PME# disabled
pci 0000:06:00.1: reg 10: [io  0xba00-0xba07]
pci 0000:06:00.1: reg 14: [io  0xb900-0xb903]
pci 0000:06:00.1: reg 18: [io  0xb800-0xb807]
pci 0000:06:00.1: reg 1c: [io  0xb700-0xb703]
pci 0000:06:00.1: reg 20: [io  0xb600-0xb60f]
pci 0000:06:00.1: reg 24: [mem 0xfbafe000-0xfbafe00f]
pci 0000:06:00.1: reg 30: [mem 0x00000000-0x0000ffff pref]
pci 0000:06:00.1: PME# supported from D3hot
pci 0000:06:00.1: PME# disabled
pci 0000:00:1c.5: PCI bridge to [bus 06-06]
pci 0000:00:1c.5:   bridge window [io  0xb000-0xbfff]
pci 0000:00:1c.5:   bridge window [mem 0xfba00000-0xfbafffff]
pci 0000:00:1c.5:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:07:00.0: reg 24: [mem 0xfb9fe000-0xfb9fffff]
pci 0000:07:00.0: PME# supported from D3hot
pci 0000:07:00.0: PME# disabled
pci 0000:07:00.1: reg 10: [io  0xaf00-0xaf07]
pci 0000:07:00.1: reg 14: [io  0xae00-0xae03]
pci 0000:07:00.1: reg 18: [io  0xad00-0xad07]
pci 0000:07:00.1: reg 1c: [io  0xac00-0xac03]
pci 0000:07:00.1: reg 20: [io  0xab00-0xab0f]
pci 0000:07:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
pci 0000:00:1c.6: PCI bridge to [bus 07-07]
pci 0000:00:1c.6:   bridge window [io  0xa000-0xafff]
pci 0000:00:1c.6:   bridge window [mem 0xfb900000-0xfb9fffff]
pci 0000:00:1c.6:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:08:00.0: reg 10: [io  0x9f00-0x9f07]
pci 0000:08:00.0: reg 14: [io  0x9e00-0x9e03]
pci 0000:08:00.0: reg 18: [io  0x9d00-0x9d07]
pci 0000:08:00.0: reg 1c: [io  0x9c00-0x9c03]
pci 0000:08:00.0: reg 20: [io  0x9b00-0x9b0f]
pci 0000:08:00.0: reg 24: [mem 0xfb8ff000-0xfb8ff7ff]
pci 0000:08:00.0: reg 30: [mem 0x00000000-0x0000ffff pref]
pci 0000:08:00.0: PME# supported from D3hot
pci 0000:08:00.0: PME# disabled
pci 0000:08:00.1: reg 10: [io  0x9a00-0x9a07]
pci 0000:08:00.1: reg 14: [io  0x9900-0x9903]
pci 0000:08:00.1: reg 18: [io  0x9800-0x9807]
pci 0000:08:00.1: reg 1c: [io  0x9700-0x9703]
pci 0000:08:00.1: reg 20: [io  0x9600-0x960f]
pci 0000:08:00.1: reg 24: [mem 0xfb8fe000-0xfb8fe00f]
pci 0000:08:00.1: reg 30: [mem 0x00000000-0x0000ffff pref]
pci 0000:08:00.1: PME# supported from D3hot
pci 0000:08:00.1: PME# disabled
pci 0000:00:1c.7: PCI bridge to [bus 08-08]
pci 0000:00:1c.7:   bridge window [io  0x9000-0x9fff]
pci 0000:00:1c.7:   bridge window [mem 0xfb800000-0xfb8fffff]
pci 0000:00:1c.7:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:09:01.0: supports D1 D2
pci 0000:09:01.0: PME# supported from D0 D1 D2 D3hot
pci 0000:09:01.0: PME# disabled
pci 0000:09:06.0: reg 10: [mem 0xfafff000-0xfafff7ff]
pci 0000:09:06.0: reg 14: [mem 0xfaff8000-0xfaffbfff]
pci 0000:09:06.0: supports D1 D2
pci 0000:09:06.0: PME# supported from D0 D1 D2 D3hot
pci 0000:09:06.0: PME# disabled
pci 0000:00:1e.0: PCI bridge to [bus 09-0a] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0xf000-0x0000] (disabled)
pci 0000:00:1e.0:   bridge window [mem 0xf9800000-0xfaffffff]
pci 0000:00:1e.0:   bridge window [mem 0xf6000000-0xf7ffffff 64bit pref]
pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0xfed40000-0xfed44fff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0xefc00000-0xfebfffff] (subtractive decode)
pci 0000:0a:00.0: reg 10: [mem 0xf6000000-0xf7ffffff pref]
pci 0000:0a:00.0: reg 14: [mem 0xfa7fc000-0xfa7fffff]
pci 0000:0a:00.0: reg 18: [mem 0xf9800000-0xf9ffffff]
pci 0000:0a:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
pci 0000:09:01.0: PCI bridge to [bus 0a-0a]
pci 0000:09:01.0:   bridge window [io  0xf000-0x0000] (disabled)
pci 0000:09:01.0:   bridge window [mem 0xf9800000-0xfa7fffff]
pci 0000:09:01.0:   bridge window [mem 0xf6000000-0xf7ffffff 64bit pref]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX6._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX7._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
HEST: Table is not found!
vgaarb: device added: PCI:0000:0a:00.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
reserve RAM buffer: 000000000009d000 - 000000000009ffff 
reserve RAM buffer: 00000000efbb0000 - 00000000efffffff 
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
HPET: 8 timers in total, 5 timers will be used for per-cpu timer
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 40, 41, 42, 43, 44, 0
hpet0: 8 comparators, 64-bit 14.318180 MHz counter
hpet: hpet2 irq 40 for MSI
hpet: hpet3 irq 41 for MSI
hpet: hpet4 irq 42 for MSI
hpet: hpet5 irq 43 for MSI
Switching to clocksource tsc
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 11 devices
ACPI: ACPI bus type pnp unregistered
system 00:01: [io  0x04d0-0x04d1] has been reserved
system 00:01: [io  0x0290-0x029f] has been reserved
system 00:01: [io  0x0800-0x0805] has been reserved
system 00:01: [io  0x0290-0x0294] has been reserved
system 00:01: [io  0x0880-0x088f] has been reserved
system 00:07: [io  0x0400-0x04cf] has been reserved
system 00:07: [io  0x04d2-0x04ff] has been reserved
system 00:08: [mem 0xf0000000-0xf3ffffff] has been reserved
system 00:09: [mem 0x000d7400-0x000d7fff] has been reserved
system 00:09: [mem 0x000f0000-0x000f7fff] could not be reserved
system 00:09: [mem 0x000f8000-0x000fbfff] could not be reserved
system 00:09: [mem 0x000fc000-0x000fffff] could not be reserved
system 00:09: [mem 0xefbb0000-0xefbeffff] could not be reserved
system 00:09: [mem 0x00000000-0x0009ffff] could not be reserved
system 00:09: [mem 0x00100000-0xefbaffff] could not be reserved
system 00:09: [mem 0xefbc0000-0xefbcffff] could not be reserved
system 00:09: [mem 0xfec00000-0xfec00fff] could not be reserved
system 00:09: [mem 0xfed10000-0xfed1dfff] has been reserved
system 00:09: [mem 0xfed20000-0xfed8ffff] could not be reserved
system 00:09: [mem 0xfee00000-0xfee00fff] has been reserved
system 00:09: [mem 0xffb00000-0xffb7ffff] has been reserved
system 00:09: [mem 0xfff00000-0xffffffff] has been reserved
system 00:09: [mem 0x000e0000-0x000effff] has been reserved
pci 0000:00:03.0: BAR 15: assigned [mem 0xefc00000-0xefcfffff pref]
pci 0000:00:1c.2: BAR 15: assigned [mem 0xefd00000-0xefefffff 64bit pref]
pci 0000:00:1c.3: BAR 15: assigned [mem 0xf4000000-0xf41fffff 64bit pref]
pci 0000:00:1c.5: BAR 15: assigned [mem 0xf4200000-0xf43fffff pref]
pci 0000:00:1c.6: BAR 15: assigned [mem 0xf4400000-0xf45fffff 64bit pref]
pci 0000:00:1c.7: BAR 15: assigned [mem 0xf4600000-0xf47fffff pref]
pci 0000:01:00.0: BAR 6: assigned [mem 0xefc00000-0xefc0ffff pref]
pci 0000:01:00.1: BAR 6: assigned [mem 0xefc10000-0xefc1ffff pref]
pci 0000:00:03.0: PCI bridge to [bus 01-01]
pci 0000:00:03.0:   bridge window [io  0x8000-0x8fff]
pci 0000:00:03.0:   bridge window [mem 0xfb700000-0xfb7fffff]
pci 0000:00:03.0:   bridge window [mem 0xefc00000-0xefcfffff pref]
pci 0000:02:00.0: BAR 6: assigned [mem 0xfb500000-0xfb51ffff pref]
pci 0000:00:1c.0: PCI bridge to [bus 02-02]
pci 0000:00:1c.0:   bridge window [io  0x7000-0x7fff]
pci 0000:00:1c.0:   bridge window [mem 0xfb600000-0xfb6fffff]
pci 0000:00:1c.0:   bridge window [mem 0xfb500000-0xfb5fffff 64bit pref]
pci 0000:03:00.0: BAR 6: assigned [mem 0xfbd00000-0xfbd1ffff pref]
pci 0000:00:1c.1: PCI bridge to [bus 03-03]
pci 0000:00:1c.1:   bridge window [io  0xe000-0xefff]
pci 0000:00:1c.1:   bridge window [mem 0xfbe00000-0xfbefffff]
pci 0000:00:1c.1:   bridge window [mem 0xfbd00000-0xfbdfffff 64bit pref]
pci 0000:00:1c.2: PCI bridge to [bus 04-04]
pci 0000:00:1c.2:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.2:   bridge window [mem 0xfbc00000-0xfbcfffff]
pci 0000:00:1c.2:   bridge window [mem 0xefd00000-0xefefffff 64bit pref]
pci 0000:00:1c.3: PCI bridge to [bus 05-05]
pci 0000:00:1c.3:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1c.3:   bridge window [mem 0xfbb00000-0xfbbfffff]
pci 0000:00:1c.3:   bridge window [mem 0xf4000000-0xf41fffff 64bit pref]
pci 0000:06:00.0: BAR 6: assigned [mem 0xf4200000-0xf420ffff pref]
pci 0000:06:00.1: BAR 6: assigned [mem 0xf4210000-0xf421ffff pref]
pci 0000:00:1c.5: PCI bridge to [bus 06-06]
pci 0000:00:1c.5:   bridge window [io  0xb000-0xbfff]
pci 0000:00:1c.5:   bridge window [mem 0xfba00000-0xfbafffff]
pci 0000:00:1c.5:   bridge window [mem 0xf4200000-0xf43fffff pref]
pci 0000:00:1c.6: PCI bridge to [bus 07-07]
pci 0000:00:1c.6:   bridge window [io  0xa000-0xafff]
pci 0000:00:1c.6:   bridge window [mem 0xfb900000-0xfb9fffff]
pci 0000:00:1c.6:   bridge window [mem 0xf4400000-0xf45fffff 64bit pref]
pci 0000:08:00.0: BAR 6: assigned [mem 0xf4600000-0xf460ffff pref]
pci 0000:08:00.1: BAR 6: assigned [mem 0xf4610000-0xf461ffff pref]
pci 0000:00:1c.7: PCI bridge to [bus 08-08]
pci 0000:00:1c.7:   bridge window [io  0x9000-0x9fff]
pci 0000:00:1c.7:   bridge window [mem 0xfb800000-0xfb8fffff]
pci 0000:00:1c.7:   bridge window [mem 0xf4600000-0xf47fffff pref]
pci 0000:0a:00.0: BAR 6: assigned [mem 0xfa000000-0xfa01ffff pref]
pci 0000:09:01.0: PCI bridge to [bus 0a-0a]
pci 0000:09:01.0:   bridge window [io  disabled]
pci 0000:09:01.0:   bridge window [mem 0xf9800000-0xfa7fffff]
pci 0000:09:01.0:   bridge window [mem 0xf6000000-0xf7ffffff 64bit pref]
pci 0000:00:1e.0: PCI bridge to [bus 09-0a]
pci 0000:00:1e.0:   bridge window [io  disabled]
pci 0000:00:1e.0:   bridge window [mem 0xf9800000-0xfaffffff]
pci 0000:00:1e.0:   bridge window [mem 0xf6000000-0xf7ffffff 64bit pref]
pci 0000:00:03.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:03.0: setting latency timer to 64
pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:1c.0: setting latency timer to 64
pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
pci 0000:00:1c.1: setting latency timer to 64
pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
pci 0000:00:1c.2: setting latency timer to 64
pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
pci 0000:00:1c.3: setting latency timer to 64
pci 0000:00:1c.5: PCI INT B -> GSI 17 (level, low) -> IRQ 17
pci 0000:00:1c.5: setting latency timer to 64
pci 0000:00:1c.6: PCI INT C -> GSI 18 (level, low) -> IRQ 18
pci 0000:00:1c.6: setting latency timer to 64
pci 0000:00:1c.7: PCI INT D -> GSI 19 (level, low) -> IRQ 19
pci 0000:00:1c.7: setting latency timer to 64
pci 0000:00:1e.0: setting latency timer to 64
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff]
pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff]
pci_bus 0000:00: resource 9 [mem 0xefc00000-0xfebfffff]
pci_bus 0000:01: resource 0 [io  0x8000-0x8fff]
pci_bus 0000:01: resource 1 [mem 0xfb700000-0xfb7fffff]
pci_bus 0000:01: resource 2 [mem 0xefc00000-0xefcfffff pref]
pci_bus 0000:02: resource 0 [io  0x7000-0x7fff]
pci_bus 0000:02: resource 1 [mem 0xfb600000-0xfb6fffff]
pci_bus 0000:02: resource 2 [mem 0xfb500000-0xfb5fffff 64bit pref]
pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
pci_bus 0000:03: resource 1 [mem 0xfbe00000-0xfbefffff]
pci_bus 0000:03: resource 2 [mem 0xfbd00000-0xfbdfffff 64bit pref]
pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
pci_bus 0000:04: resource 1 [mem 0xfbc00000-0xfbcfffff]
pci_bus 0000:04: resource 2 [mem 0xefd00000-0xefefffff 64bit pref]
pci_bus 0000:05: resource 0 [io  0xc000-0xcfff]
pci_bus 0000:05: resource 1 [mem 0xfbb00000-0xfbbfffff]
pci_bus 0000:05: resource 2 [mem 0xf4000000-0xf41fffff 64bit pref]
pci_bus 0000:06: resource 0 [io  0xb000-0xbfff]
pci_bus 0000:06: resource 1 [mem 0xfba00000-0xfbafffff]
pci_bus 0000:06: resource 2 [mem 0xf4200000-0xf43fffff pref]
pci_bus 0000:07: resource 0 [io  0xa000-0xafff]
pci_bus 0000:07: resource 1 [mem 0xfb900000-0xfb9fffff]
pci_bus 0000:07: resource 2 [mem 0xf4400000-0xf45fffff 64bit pref]
pci_bus 0000:08: resource 0 [io  0x9000-0x9fff]
pci_bus 0000:08: resource 1 [mem 0xfb800000-0xfb8fffff]
pci_bus 0000:08: resource 2 [mem 0xf4600000-0xf47fffff pref]
pci_bus 0000:09: resource 1 [mem 0xf9800000-0xfaffffff]
pci_bus 0000:09: resource 2 [mem 0xf6000000-0xf7ffffff 64bit pref]
pci_bus 0000:09: resource 4 [io  0x0000-0x0cf7]
pci_bus 0000:09: resource 5 [io  0x0d00-0xffff]
pci_bus 0000:09: resource 6 [mem 0x000a0000-0x000bffff]
pci_bus 0000:09: resource 7 [mem 0x000c0000-0x000dffff]
pci_bus 0000:09: resource 8 [mem 0xfed40000-0xfed44fff]
pci_bus 0000:09: resource 9 [mem 0xefc00000-0xfebfffff]
pci_bus 0000:0a: resource 1 [mem 0xf9800000-0xfa7fffff]
pci_bus 0000:0a: resource 2 [mem 0xf6000000-0xf7ffffff 64bit pref]
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
UDP hash table entries: 4096 (order: 5, 131072 bytes)
UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
NET: Registered protocol family 1
pci 0000:0a:00.0: Boot video device
PCI: CLS 64 bytes, default 64
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 5092k freed
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing 64MB software IO TLB between ffff880001bdd000 - ffff880005bdd000
software IO TLB at phys 0x1bdd000 - 0x5bdd000
audit: initializing netlink socket (disabled)
type=2000 audit(1291751038.791:1): initialized
HugeTLB registered 2 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
msgmni has been set to 15996
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
intel_idle: MWAIT substates: 0x1120
intel_idle: v0.4 model 0x1E
intel_idle: lapic_timer_reliable_states 0x2
ERST: Table is not found!
Linux agpgart interface v0.103
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
brd: module loaded
PNP: No PS/2 controller found. Probing ports directly.
Failed to disable AUX port, but continuing anyway... Is this a SiS?
If AUX port is really absent please use the 'i8042.noaux' option.
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
rtc_cmos 00:04: RTC can wake from S4
rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, 242 bytes nvram, hpet irqs
cpuidle: using governor ladder
cpuidle: using governor menu
TCP cubic registered
Registering the dns_resolver key type
PM: Checking image partition UUID=792c5907-6e5d-4825-aa46-4bc468532645
PM: Resume from disk failed.
registered taskstats version 1
  Magic number: 6:263:748
rtc_cmos 00:04: setting system clock to 2010-12-07 19:43:59 UTC (1291751039)
BIOS EDD facility v0.16 2004-Jun-25, 10 devices found
Freeing unused kernel memory: 708k freed
nash-hotplug (45): /proc/45/oom_adj is deprecated, please use /proc/45/oom_score_adj instead.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
ehci_hcd 0000:00:1a.7: setting latency timer to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.7: debug port 2
ehci_hcd 0000:00:1a.7: cache line size of 64 is not supported
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xfbfff000
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.36.1-desktop-1mnb ehci_hcd
usb usb1: SerialNumber: 0000:00:1a.7
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: setting latency timer to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: debug port 2
ehci_hcd 0000:00:1d.7: cache line size of 64 is not supported
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfbffe000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: EHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.36.1-desktop-1mnb ehci_hcd
usb usb2: SerialNumber: 0000:00:1d.7
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 8 ports detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
uhci_hcd: USB Universal Host Controller Interface driver
uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1a.0: setting latency timer to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000ff00
usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.36.1-desktop-1mnb uhci_hcd
usb usb3: SerialNumber: 0000:00:1a.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:1a.1: setting latency timer to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000fe00
usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.36.1-desktop-1mnb uhci_hcd
usb usb4: SerialNumber: 0000:00:1a.1
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1a.2: setting latency timer to 64
uhci_hcd 0000:00:1a.2: UHCI Host Controller
uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000fd00
usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.36.1-desktop-1mnb uhci_hcd
usb usb5: SerialNumber: 0000:00:1a.2
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000fc00
usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb6: Product: UHCI Host Controller
usb usb6: Manufacturer: Linux 2.6.36.1-desktop-1mnb uhci_hcd
usb usb6: SerialNumber: 0000:00:1d.0
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000fb00
usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb7: Product: UHCI Host Controller
usb usb7: Manufacturer: Linux 2.6.36.1-desktop-1mnb uhci_hcd
usb usb7: SerialNumber: 0000:00:1d.1
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000fa00
usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb8: Product: UHCI Host Controller
usb usb8: Manufacturer: Linux 2.6.36.1-desktop-1mnb uhci_hcd
usb usb8: SerialNumber: 0000:00:1d.2
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: setting latency timer to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 9
uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000f900
usb usb9: New USB device found, idVendor=1d6b, idProduct=0001
usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb9: Product: UHCI Host Controller
usb usb9: Manufacturer: Linux 2.6.36.1-desktop-1mnb uhci_hcd
usb usb9: SerialNumber: 0000:00:1d.3
hub 9-0:1.0: USB hub found
hub 9-0:1.0: 2 ports detected
async_tx: api initialized (async)
raid6: int64x1   2703 MB/s
raid6: int64x2   3433 MB/s
raid6: int64x4   2347 MB/s
raid6: int64x8   2355 MB/s
raid6: sse2x1    7558 MB/s
raid6: sse2x2    8867 MB/s
raid6: sse2x4    9789 MB/s
raid6: using algorithm sse2x4 (9789 MB/s)
xor: automatically using best checksumming function: generic_sse
   generic_sse: 12240.000 MB/sec
xor: using function: generic_sse (12240.000 MB/sec)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
SCSI subsystem initialized
libata version 3.00 loaded.
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: irq 45 for MSI/MSI-X
ahci: SSS flag set, parallel bus scan disabled
ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ems apst 
ahci 0000:00:1f.2: setting latency timer to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
ata1: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd100 irq 45
ata2: SATA max UDMA/133 irq_stat 0x00400040, connection status changed irq 45
ata3: SATA max UDMA/133 irq_stat 0x00400040, connection status changed irq 45
ata4: SATA max UDMA/133 irq_stat 0x00400040, connection status changed irq 45
ata5: SATA max UDMA/133 irq_stat 0x00400040, connection status changed
ata6: SATA max UDMA/133 irq_stat 0x00400040, connection status changed
ahci 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
ahci 0000:01:00.0: irq 46 for MSI/MSI-X
ahci 0000:01:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
ahci 0000:01:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
ahci 0000:01:00.0: setting latency timer to 64
ahci 0000:01:00.0: port 0 can do FBS, forcing FBSCP
ahci 0000:01:00.0: port 1 can do FBS, forcing FBSCP
scsi6 : ahci
scsi7 : ahci
ata7: SATA max UDMA/133 abar m2048@0xfb7ff000 port 0xfb7ff100 irq 46
ata8: SATA max UDMA/133 abar m2048@0xfb7ff000 port 0xfb7ff180 irq 46
ahci 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
ahci 0000:04:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
ahci 0000:04:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
ahci 0000:04:00.0: setting latency timer to 64
scsi8 : ahci
scsi9 : ahci
ata9: SATA max UDMA/133 abar m8192@0xfbcfe000 port 0xfbcfe100 irq 18
ata10: SATA max UDMA/133 abar m8192@0xfbcfe000 port 0xfbcfe180 irq 18
ahci 0000:05:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
ahci 0000:05:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
ahci 0000:05:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
ahci 0000:05:00.0: setting latency timer to 64
scsi10 : ahci
scsi11 : ahci
ata11: SATA max UDMA/133 abar m8192@0xfbbfe000 port 0xfbbfe100 irq 19
ata12: SATA max UDMA/133 abar m8192@0xfbbfe000 port 0xfbbfe180 irq 19
ahci 0000:06:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
ahci 0000:06:00.0: irq 47 for MSI/MSI-X
ahci 0000:06:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
ahci 0000:06:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
ahci 0000:06:00.0: setting latency timer to 64
ahci 0000:06:00.0: port 0 can do FBS, forcing FBSCP
ahci 0000:06:00.0: port 1 can do FBS, forcing FBSCP
scsi12 : ahci
scsi13 : ahci
ata13: SATA max UDMA/133 abar m2048@0xfbaff000 port 0xfbaff100 irq 47
ata14: SATA max UDMA/133 abar m2048@0xfbaff000 port 0xfbaff180 irq 47
ahci 0000:07:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
ahci 0000:07:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
ahci 0000:07:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
ahci 0000:07:00.0: setting latency timer to 64
scsi14 : ahci
scsi15 : ahci
ata15: SATA max UDMA/133 abar m8192@0xfb9fe000 port 0xfb9fe100 irq 18
ata16: SATA max UDMA/133 abar m8192@0xfb9fe000 port 0xfb9fe180 irq 18
ahci 0000:08:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
ahci 0000:08:00.0: irq 48 for MSI/MSI-X
ahci 0000:08:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
ahci 0000:08:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
ahci 0000:08:00.0: setting latency timer to 64
ahci 0000:08:00.0: port 0 can do FBS, forcing FBSCP
ahci 0000:08:00.0: port 1 can do FBS, forcing FBSCP
scsi16 : ahci
scsi17 : ahci
ata17: SATA max UDMA/133 abar m2048@0xfb8ff000 port 0xfb8ff100 irq 48
ata18: SATA max UDMA/133 abar m2048@0xfb8ff000 port 0xfb8ff180 irq 48
usb 2-3: new high speed USB device using ehci_hcd and address 2
ata8: SATA link down (SStatus 0 SControl 370)
ata7: SATA link down (SStatus 0 SControl 370)
ata9: SATA link down (SStatus 0 SControl 300)
ata14: SATA link down (SStatus 0 SControl 370)
ata13: SATA link down (SStatus 0 SControl 370)
ata15: SATA link down (SStatus 0 SControl 300)
ata16: SATA link down (SStatus 0 SControl 300)
ata17: SATA link down (SStatus 0 SControl 370)
ata18: SATA link down (SStatus 0 SControl 370)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-8: WDC WD20EARS-00S8B1, 80.00A80, max UDMA/133
ata1.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata1.00: configured for UDMA/133
ata12: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.00: ATA-8: WDC WD20EARS-00S8B1, 80.00A80, max UDMA/133
ata10.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata10.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      WDC WD20EARS-00S 80.0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata11.00: ATA-8: WDC WD20EARS-00S8B1, 80.00A80, max UDMA/133
ata11.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata11.00: configured for UDMA/133
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
ata12.00: ATA-8: WDC WD20EARS-00S8B1, 80.00A80, max UDMA/133
ata12.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata12.00: configured for UDMA/133
usb 2-3: New USB device found, idVendor=0bda, idProduct=0151
usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-3: Product: USB2.0-CRW
usb 2-3: Manufacturer: Generic
usb 2-3: SerialNumber: 20060413092100000
usb 9-1: new low speed USB device using uhci_hcd and address 2
usb 9-1: New USB device found, idVendor=1997, idProduct=0409
usb 9-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 9-1: Product: Micro Keyboard
usb 9-1: Manufacturer: Riitek
input: Riitek Micro Keyboard as /devices/pci0000:00/0000:00:1d.3/usb9/9-1/9-1:1.0/input/input0
generic-usb 0003:1997:0409.0001: input,hidraw0: USB HID v1.11 Keyboard [Riitek Micro Keyboard] on usb-0000:00:1d.3-1/input0
input: Riitek Micro Keyboard as /devices/pci0000:00/0000:00:1d.3/usb9/9-1/9-1:1.1/input/input1
generic-usb 0003:1997:0409.0002: input,hidraw1: USB HID v1.11 Mouse [Riitek Micro Keyboard] on usb-0000:00:1d.3-1/input1
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-8: WDC WD20EARS-00MVWB0, 51.0AB51, max UDMA/133
ata2.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata2.00: configured for UDMA/133
scsi 1:0:0:0: Direct-Access     ATA      WDC WD20EARS-00M 51.0 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-8: WDC WD20EARS-00S8B1, 80.00A80, max UDMA/133
ata3.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata3.00: configured for UDMA/133
scsi 2:0:0:0: Direct-Access     ATA      WDC WD20EARS-00S 80.0 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdc] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1
sd 2:0:0:0: [sdc] Attached SCSI disk
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-8: WDC WD20EARS-00S8B1, 80.00A80, max UDMA/133
ata4.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata4.00: configured for UDMA/133
scsi 3:0:0:0: Direct-Access     ATA      WDC WD20EARS-00S 80.0 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdd] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1
sd 3:0:0:0: [sdd] Attached SCSI disk
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.00: ATA-8: WDC WD20EARS-00S8B1, 80.00A80, max UDMA/133
ata5.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata5.00: configured for UDMA/133
scsi 4:0:0:0: Direct-Access     ATA      WDC WD20EARS-00S 80.0 PQ: 0 ANSI: 5
sd 4:0:0:0: [sde] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 4:0:0:0: [sde] Write Protect is off
sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sde: sde1
sd 4:0:0:0: [sde] Attached SCSI disk
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.00: ATA-8: WDC WD20EARS-00S8B1, 80.00A80, max UDMA/133
ata6.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata6.00: configured for UDMA/133
scsi 5:0:0:0: Direct-Access     ATA      WDC WD20EARS-00S 80.0 PQ: 0 ANSI: 5
sd 5:0:0:0: [sdf] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 5:0:0:0: [sdf] Write Protect is off
sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
scsi 9:0:0:0: Direct-Access     ATA      WDC WD20EARS-00S 80.0 PQ: 0 ANSI: 5
sd 5:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 9:0:0:0: [sdg] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 9:0:0:0: [sdg] Write Protect is off
sd 9:0:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 9:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
scsi 10:0:0:0: Direct-Access     ATA      WDC WD20EARS-00S 80.0 PQ: 0 ANSI: 5
sd 10:0:0:0: [sdh] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
scsi 11:0:0:0: Direct-Access     ATA      WDC WD20EARS-00S 80.0 PQ: 0 ANSI: 5
sd 11:0:0:0: [sdi] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 10:0:0:0: [sdh] Write Protect is off
sd 10:0:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 11:0:0:0: [sdi] Write Protect is off
sd 11:0:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 10:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 11:0:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdf: sdf1
sd 5:0:0:0: [sdf] Attached SCSI disk
 sdg: sdg1
sd 9:0:0:0: [sdg] Attached SCSI disk
 sdi: sdi1
sd 11:0:0:0: [sdi] Attached SCSI disk
 sdh: sdh1
sd 10:0:0:0: [sdh] Attached SCSI disk
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.18.0-ioctl (2010-06-29) initialised: dm-devel@redhat.com
HP CISS Driver (v 3.6.26)
pata_jmicron 0000:04:00.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
pata_jmicron 0000:04:00.1: setting latency timer to 64
scsi18 : pata_jmicron
scsi19 : pata_jmicron
ata19: PATA max UDMA/100 cmd 0xdf00 ctl 0xde00 bmdma 0xdb00 irq 19
ata20: PATA max UDMA/100 cmd 0xdd00 ctl 0xdc00 bmdma 0xdb08 irq 19
pata_jmicron 0000:05:00.1: enabling device (0000 -> 0001)
pata_jmicron 0000:05:00.1: PCI INT B -> GSI 16 (level, low) -> IRQ 16
pata_jmicron 0000:05:00.1: setting latency timer to 64
scsi20 : pata_jmicron
scsi21 : pata_jmicron
ata21: PATA max UDMA/100 cmd 0xcf00 ctl 0xce00 bmdma 0xcb00 irq 16
ata22: PATA max UDMA/100 cmd 0xcd00 ctl 0xcc00 bmdma 0xcb08 irq 16
pata_jmicron 0000:07:00.1: enabling device (0000 -> 0001)
pata_jmicron 0000:07:00.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
pata_jmicron 0000:07:00.1: setting latency timer to 64
scsi22 : pata_jmicron
scsi23 : pata_jmicron
ata23: PATA max UDMA/100 cmd 0xaf00 ctl 0xae00 bmdma 0xab00 irq 19
ata24: PATA max UDMA/100 cmd 0xad00 ctl 0xac00 bmdma 0xab08 irq 19
ata19.00: ATA-0: CF Card, Ver2.21, max UDMA/100
ata19.00: 7880544 sectors, multi 0: LBA 
ata19.00: limited to UDMA/33 due to 40-wire cable
ata19.00: configured for UDMA/33
ata19.00: configured for UDMA/33
ata19: EH complete
scsi 18:0:0:0: Direct-Access     ATA      CF Card          Ver2 PQ: 0 ANSI: 5
sd 18:0:0:0: [sdj] 7880544 512-byte logical blocks: (4.03 GB/3.75 GiB)
sd 18:0:0:0: [sdj] Write Protect is off
sd 18:0:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 18:0:0:0: [sdj] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdj: sdj1 sdj2
sd 18:0:0:0: [sdj] Attached SCSI disk
Uniform Multi-Platform E-IDE driver
ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
Probing IDE interface ide0...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ide1 at 0x170-0x177,0x376 on irq 15

--------------040005050300050601040901--
