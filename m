From: Tom van Klinken / ISP Services BV <tom@isp-services.nl>
Subject: Problem with ICH10R and Port Multipliers
Date: Mon, 19 Oct 2009 18:14:16 +0200
Message-ID: <4ADC9058.4090701@isp-services.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040401090906010500070304"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail21-tower01.nl.cleanport.com ([212.79.242.236]:42508 "EHLO
	mail21-tower01.nl.cleanport.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754765AbZJSQTw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Oct 2009 12:19:52 -0400
Received: from (unresolved) ([212.79.224.10] HELO=tom-van-klinkens-mac-pro.local)
	by mail21-tower11.nl.cleanport.com (CleanSMTPd 1.6.7) with ESMTP
	id 4AE5C47D-0 for <linux-ide@vger.kernel.org>;
	Mon, 19 Oct 2009 18:14:16 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040401090906010500070304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've got a Intel DG45FC motherboard that I would like to integrate into 
a NAS system.

This board has the ICH10R chipset and from what I have understood this 
chipset should support port multipliers. 
(http://www.intel.com/design/chipsets/matrixstorage_sb.htm)

However it does not, it also does not show 'pmp' support in the AHCI flags.

After contacting Intel they told me that Port Multipliers are not 
supported on their boards.

Did they deliberately turn PMP support off?

--
Kind Regards,
Tom van Klinken

--------------040401090906010500070304
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.6.32-rc4 (root@desiato) (gcc version 4.3.2 (Gentoo 4.3.2-r3 p1.6, pie-10.1.5) ) #1 SMP Thu Oct 15 22:18:54 CEST 2009
Command line: root=/dev/sda2
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  Centaur CentaurHauls
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
 BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bd8a9000 (usable)
 BIOS-e820: 00000000bd8a9000 - 00000000bd92b000 (ACPI NVS)
 BIOS-e820: 00000000bd92b000 - 00000000bda42000 (reserved)
 BIOS-e820: 00000000bda42000 - 00000000bda56000 (ACPI NVS)
 BIOS-e820: 00000000bda56000 - 00000000bdb56000 (reserved)
 BIOS-e820: 00000000bdb56000 - 00000000bdb5e000 (ACPI data)
 BIOS-e820: 00000000bdb5e000 - 00000000bdb68000 (ACPI NVS)
 BIOS-e820: 00000000bdb68000 - 00000000bdb8a000 (reserved)
 BIOS-e820: 00000000bdb8a000 - 00000000bdb90000 (ACPI NVS)
 BIOS-e820: 00000000bdb90000 - 00000000bdd00000 (usable)
 BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 000000013c000000 (usable)
DMI 2.4 present.
last_pfn = 0x13c000 max_arch_pfn = 0x400000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-CFFFF write-protect
  D0000-E7FFF uncachable
  E8000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 000000000 mask F00000000 write-back
  1 base 0BDD00000 mask FFFF00000 write-through
  2 base 0BDE00000 mask FFFE00000 uncachable
  3 base 0BE000000 mask FFE000000 uncachable
  4 base 0C0000000 mask FC0000000 uncachable
  5 base 100000000 mask FC0000000 write-back
  6 base 13C000000 mask FFC000000 uncachable
last_pfn = 0xbdd00 max_arch_pfn = 0x400000000
initial memory mapped : 0 - 20000000
init_memory_mapping: 0000000000000000-00000000bdd00000
 0000000000 - 00bdc00000 page 2M
 00bdc00000 - 00bdd00000 page 4k
kernel direct mapping tables up to bdd00000 @ 8000-d000
init_memory_mapping: 0000000100000000-000000013c000000
 0100000000 - 013c000000 page 2M
kernel direct mapping tables up to 13c000000 @ b000-11000
ACPI: RSDP 00000000000f03c0 00024 (v02  INTEL)
ACPI: XSDT 00000000bdb5ce18 00044 (v01 INTEL  DG45FC   00000075 MSFT 00010013)
ACPI: FACP 00000000bdb5bd98 000F4 (v04  INTEL    A M I 06222004 MSFT 00010013)
ACPI Warning: 32/64 FACS address mismatch in FADT - two FACS tables! (20090903/tbfadt-369)
ACPI Warning: 32/64X FACS address mismatch in FADT - BDB5FF40/00000000BDB65E40, using 32 (20090903/tbfadt-486)
ACPI: DSDT 00000000bdb56018 0492F (v01 INTEL  DG45FC   00000075 INTL 20051117)
ACPI: FACS 00000000bdb5ff40 00040
ACPI: APIC 00000000bdb5bf18 0006C (v02 INTEL  DG45FC   00000075 MSFT 00010013)
ACPI: MCFG 00000000bdb66d98 0003C (v01 INTEL  DG45FC   00000075 MSFT 00000097)
ACPI: ASF! 00000000bdb65c18 000A0 (v32 INTEL  DG45FC   00000075 TFSM 000F4240)
ACPI: Local APIC address 0xfee00000
No NUMA configuration found
Faking a node at 0000000000000000-000000013c000000
Bootmem setup node 0 0000000000000000-000000013c000000
  NODE_DATA [0000000000001000 - 0000000000004fff]
  bootmap [000000000000c000 -  00000000000337ff] pages 28
(7 early reservations) ==> bootmem [0000000000 - 013c000000]
  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
  #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
  #2 [0001000000 - 00018a90b4]    TEXT DATA BSS ==> [0001000000 - 00018a90b4]
  #3 [000009ec00 - 0000100000]    BIOS reserved ==> [000009ec00 - 0000100000]
  #4 [00018aa000 - 00018aa19c]              BRK ==> [00018aa000 - 00018aa19c]
  #5 [0000008000 - 000000b000]          PGTABLE ==> [0000008000 - 000000b000]
  #6 [000000b000 - 000000c000]          PGTABLE ==> [000000b000 - 000000c000]
Zone PFN ranges:
  DMA      0x00000000 -> 0x00001000
  DMA32    0x00001000 -> 0x00100000
  Normal   0x00100000 -> 0x0013c000
Movable zone start PFN for each node
early_node_map[4] active PFN ranges
    0: 0x00000000 -> 0x0000009e
    0: 0x00000100 -> 0x000bd8a9
    0: 0x000bdb90 -> 0x000bdd00
    0: 0x00100000 -> 0x0013c000
On node 0 totalpages: 1022391
  DMA zone: 56 pages used for memmap
  DMA zone: 104 pages reserved
  DMA zone: 3838 pages, LIFO batch:0
  DMA32 zone: 14280 pages used for memmap
  DMA32 zone: 758353 pages, LIFO batch:31
  Normal zone: 3360 pages used for memmap
  Normal zone: 242400 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
SMP: Allowing 4 CPUs, 0 hotplug CPUs
nr_irqs_gsi: 24
PM: Registered nosave memory: 000000000009e000 - 000000000009f000
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
PM: Registered nosave memory: 00000000bd8a9000 - 00000000bd92b000
PM: Registered nosave memory: 00000000bd92b000 - 00000000bda42000
PM: Registered nosave memory: 00000000bda42000 - 00000000bda56000
PM: Registered nosave memory: 00000000bda56000 - 00000000bdb56000
PM: Registered nosave memory: 00000000bdb56000 - 00000000bdb5e000
PM: Registered nosave memory: 00000000bdb5e000 - 00000000bdb68000
PM: Registered nosave memory: 00000000bdb68000 - 00000000bdb8a000
PM: Registered nosave memory: 00000000bdb8a000 - 00000000bdb90000
PM: Registered nosave memory: 00000000bdd00000 - 00000000fed1c000
PM: Registered nosave memory: 00000000fed1c000 - 00000000fed20000
PM: Registered nosave memory: 00000000fed20000 - 00000000ff000000
PM: Registered nosave memory: 00000000ff000000 - 0000000100000000
Allocating PCI resources starting at bdd00000 (gap: bdd00000:4101c000)
Booting paravirtualized kernel on bare hardware
NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr_node_ids:1
PERCPU: Embedded 25 pages/cpu @ffff880028200000 s70104 r8192 d24104 u524288
pcpu-alloc: s70104 r8192 d24104 u524288 alloc=1*2097152
pcpu-alloc: [0] 0 1 2 3 
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1004591
Policy zone: Normal
Kernel command line: root=/dev/sda2
PID hash table entries: 4096 (order: 3, 32768 bytes)
Initializing CPU#0
xsave/xrstor: enabled xstate_bv 0x3, cntxt size 0x240
Checking aperture...
No AGP bridge found
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing 64MB software IO TLB between ffff880020000000 - ffff880024000000
software IO TLB at phys 0x20000000 - 0x24000000
Memory: 3956744k/5177344k available (4668k kernel code, 1087780k absent, 132820k reserved, 2834k data, 656k init)
Hierarchical RCU implementation.
NR_IRQS:512
Extended CMOS year: 2000
Console: colour VGA+ 80x25
console [tty0] enabled
Fast TSC calibration using PIT
Detected 2666.165 MHz processor.
Calibrating delay loop (skipped), value calculated using timer frequency.. 5332.33 BogoMIPS (lpj=10664660)
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 3072K
CPU 0/0x0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 6 MCE banks
CPU0: Thermal monitoring enabled (TM2)
using mwait in idle threads.
ACPI: Core revision 20090903
Setting APIC routing to flat
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz stepping 0a
Booting processor 1 APIC 0x1 ip 0x6000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5333.03 BogoMIPS (lpj=10666060)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 3072K
CPU 1/0x1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
mce: CPU supports 6 MCE banks
CPU1: Thermal monitoring enabled (TM2)
CPU1: Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz stepping 0a
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Booting processor 2 APIC 0x2 ip 0x6000
Initializing CPU#2
Calibrating delay using timer specific routine.. 5333.05 BogoMIPS (lpj=10666115)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 3072K
CPU 2/0x2 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 2
mce: CPU supports 6 MCE banks
CPU2: Thermal monitoring enabled (TM2)
CPU2: Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz stepping 0a
checking TSC synchronization [CPU#0 -> CPU#2]: passed.
Booting processor 3 APIC 0x3 ip 0x6000
Initializing CPU#3
Calibrating delay using timer specific routine.. 5333.04 BogoMIPS (lpj=10666093)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 3072K
CPU 3/0x3 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 3
mce: CPU supports 6 MCE banks
CPU3: Thermal monitoring enabled (TM2)
CPU3: Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz stepping 0a
checking TSC synchronization [CPU#0 -> CPU#3]: passed.
Brought up 4 CPUs
Total of 4 processors activated (21331.46 BogoMIPS).
xor: automatically using best checksumming function: generic_sse
   generic_sse: 10223.000 MB/sec
xor: using function: generic_sse (10223.000 MB/sec)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
PCI: Not using MMCONFIG.
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: Executed 1 blocks of module-level executable AML code
ACPI: BIOS _OSI(Linux) query ignored
ACPI: Interpreter enabled
ACPI: (supports S0 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
PCI: MCFG area at e0000000 reserved in ACPI motherboard resources
PCI: Using MMCONFIG at e0000000 - efffffff
ACPI: No dock devices found.
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:02.0: reg 10 64bit mmio: [0xd0000000-0xd03fffff]
pci 0000:00:02.0: reg 18 64bit mmio pref: [0xc0000000-0xcfffffff]
pci 0000:00:02.0: reg 20 io port: [0xf1c0-0xf1c7]
pci 0000:00:02.1: reg 10 64bit mmio: [0xd0400000-0xd04fffff]
pci 0000:00:03.0: reg 10 64bit mmio: [0xd0522100-0xd052210f]
pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
pci 0000:00:03.0: PME# disabled
pci 0000:00:19.0: reg 10 32bit mmio: [0xd0500000-0xd051ffff]
pci 0000:00:19.0: reg 14 32bit mmio: [0xd0520000-0xd0520fff]
pci 0000:00:19.0: reg 18 io port: [0xf100-0xf11f]
pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
pci 0000:00:19.0: PME# disabled
pci 0000:00:1a.0: reg 20 io port: [0xf0e0-0xf0ff]
pci 0000:00:1a.1: reg 20 io port: [0xf0c0-0xf0df]
pci 0000:00:1a.2: reg 20 io port: [0xf0a0-0xf0bf]
pci 0000:00:1a.7: reg 10 32bit mmio: [0xd0521c00-0xd0521fff]
pci 0000:00:1a.7: EHCI: BIOS handoff failed (BIOS bug?) 01010001
pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1a.7: PME# disabled
pci 0000:00:1d.0: reg 20 io port: [0xf080-0xf09f]
pci 0000:00:1d.1: reg 20 io port: [0xf060-0xf07f]
pci 0000:00:1d.2: reg 20 io port: [0xf040-0xf05f]
pci 0000:00:1d.7: reg 10 32bit mmio: [0xd0521800-0xd0521bff]
pci 0000:00:1d.7: EHCI: BIOS handoff failed (BIOS bug?) 01010001
pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.7: PME# disabled
pci 0000:00:1f.0: Force enabled HPET at 0xfed00000
pci 0000:00:1f.0: quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 0500-053f claimed by ICH6 GPIO
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0a00 (mask 00ff)
pci 0000:00:1f.2: reg 10 io port: [0xf1b0-0xf1b7]
pci 0000:00:1f.2: reg 14 io port: [0xf1a0-0xf1a3]
pci 0000:00:1f.2: reg 18 io port: [0xf190-0xf197]
pci 0000:00:1f.2: reg 1c io port: [0xf180-0xf183]
pci 0000:00:1f.2: reg 20 io port: [0xf020-0xf03f]
pci 0000:00:1f.2: reg 24 32bit mmio: [0xd0521000-0xd05217ff]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.2: PME# disabled
pci 0000:00:1f.3: reg 10 64bit mmio: [0xd0522000-0xd05220ff]
pci 0000:00:1f.3: reg 20 io port: [0xf000-0xf01f]
pci 0000:00:1f.5: reg 10 io port: [0xf170-0xf177]
pci 0000:00:1f.5: reg 14 io port: [0xf160-0xf163]
pci 0000:00:1f.5: reg 18 io port: [0xf150-0xf157]
pci 0000:00:1f.5: reg 1c io port: [0xf140-0xf143]
pci 0000:00:1f.5: reg 20 io port: [0xf130-0xf13f]
pci 0000:00:1f.5: reg 24 io port: [0xf120-0xf12f]
pci 0000:00:1e.0: transparent bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
raid6: int64x1   2234 MB/s
raid6: int64x2   2958 MB/s
raid6: int64x4   2299 MB/s
raid6: int64x8   2022 MB/s
raid6: sse2x1    4830 MB/s
raid6: sse2x2    5035 MB/s
raid6: sse2x4    7860 MB/s
raid6: using algorithm sse2x4 (7860 MB/s)
PCI: Using ACPI for IRQ routing
hpet clockevent registered
HPET: 4 timers in total, 0 timers will be used for per-cpu timer
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
hpet0: 4 comparators, 64-bit 14.318180 MHz counter
Switching to clocksource tsc
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 10 devices
ACPI: ACPI bus type pnp unregistered
system 00:01: iomem range 0xfed14000-0xfed19fff has been reserved
system 00:01: iomem range 0xe0000000-0xefffffff has been reserved
system 00:01: iomem range 0xfed08000-0xfed08fff has been reserved
system 00:02: ioport range 0xa20-0xa3f has been reserved
system 00:02: ioport range 0xa00-0xa1f has been reserved
system 00:02: ioport range 0xb78-0xb7f has been reserved
system 00:02: ioport range 0xf78-0xf7f has been reserved
system 00:07: ioport range 0x4d0-0x4d1 has been reserved
system 00:09: ioport range 0x400-0x47f has been reserved
system 00:09: ioport range 0x1180-0x119f has been reserved
system 00:09: ioport range 0x500-0x57f could not be reserved
system 00:09: iomem range 0xfed1c000-0xfed1ffff has been reserved
system 00:09: iomem range 0xfec00000-0xfecfffff could not be reserved
system 00:09: iomem range 0xfee00000-0xfee0ffff has been reserved
system 00:09: iomem range 0xfed20000-0xfed9ffff has been reserved
system 00:09: iomem range 0xff000000-0xffffffff has been reserved
pci 0000:00:1e.0: PCI bridge, secondary bus 0000:01
pci 0000:00:1e.0:   IO window: disabled
pci 0000:00:1e.0:   MEM window: disabled
pci 0000:00:1e.0:   PREFETCH window: disabled
pci 0000:00:1e.0: setting latency timer to 64
pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
pci_bus 0000:01: resource 3 io:  [0x00-0xffff]
pci_bus 0000:01: resource 4 mem: [0x000000-0xffffffffffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
HugeTLB registered 2 MB page size, pre-allocated 0 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
msgmni has been set to 7728
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:00:02.0: Boot video device
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
ACPI: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
ACPI: Power Button [PWRF]
ACPI: SSDT 00000000bdb5fc18 002CC (v01    AMI      IST 00000001 MSFT 03000001)
Marking TSC unstable due to TSC halts in idle
Switching to clocksource hpet
processor LNXCPU:00: registered as cooling_device0
Switched to NOHz mode on CPU #3
processor LNXCPU:01: registered as cooling_device1
Switched to NOHz mode on CPU #2
processor LNXCPU:02: registered as cooling_device2
processor LNXCPU:03: registered as cooling_device3
Switched to NOHz mode on CPU #1
Switched to NOHz mode on CPU #0
Real Time Clock Driver v1.12b
Linux agpgart interface v0.103
agpgart-intel 0000:00:00.0: Intel G45/G43 Chipset
agpgart-intel 0000:00:00.0: detected 32764K stolen memory
agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xc0000000
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:03: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
floppy0: no floppy controllers found
brd: module loaded
loop: module loaded
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: irq 24 for MSI/MSI-X
ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pio slum part ccc ems sxs 
ahci 0000:00:1f.2: setting latency timer to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
ata1: SATA max UDMA/133 abar m2048@0xd0521000 port 0xd0521100 irq 24
ata2: SATA max UDMA/133 abar m2048@0xd0521000 port 0xd0521180 irq 24
ata3: SATA max UDMA/133 abar m2048@0xd0521000 port 0xd0521200 irq 24
ata4: SATA max UDMA/133 abar m2048@0xd0521000 port 0xd0521280 irq 24
ata5: SATA max UDMA/133 abar m2048@0xd0521000 port 0xd0521300 irq 24
ata6: SATA max UDMA/133 abar m2048@0xd0521000 port 0xd0521380 irq 24
Intel(R) PRO/1000 Network Driver - version 7.3.21-k5-NAPI
Copyright (c) 1999-2006 Intel Corporation.
e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k2
e1000e: Copyright (c) 1999-2008 Intel Corporation.
e1000e 0000:00:19.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
e1000e 0000:00:19.0: setting latency timer to 64
e1000e 0000:00:19.0: irq 25 for MSI/MSI-X
0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:1c:c0:9c:28:02
0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
0000:00:19.0: eth0: MAC: 7, PHY: 8, PBA No: ffffff-0ff
Intel(R) Gigabit Ethernet Network Driver - version 1.3.16-k2
Copyright (c) 2007-2009 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
console [netcon0] enabled
netconsole: network logging started
ieee1394: raw1394: /dev/raw1394 device initialized
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
ehci_hcd 0000:00:1a.7: setting latency timer to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.7: debug port 1
ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xd0521c00
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: setting latency timer to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xd0521800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
uhci_hcd: USB Universal Host Controller Interface driver
uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1a.0: setting latency timer to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000f0e0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:1a.1: setting latency timer to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000f0c0
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1a.2: setting latency timer to 64
uhci_hcd 0000:00:1a.2: UHCI Host Controller
uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000f0a0
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000f080
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000f060
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000f040
usb usb8: configuration #1 chosen from 1 choice
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 2 ports detected
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
md: multipath personality registered for level -4
md: faulty personality registered for level -5
device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
cpuidle: using governor ladder
cpuidle: using governor menu
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
nf_conntrack.acct=1 kernel parameter, acct=1 nf_conntrack module option or
sysctl net.netfilter.nf_conntrack_acct=1 to enable it.
ctnetlink v0.93: registering with nfnetlink.
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_tables: (C) 2000-2006 Netfilter Core Team
arp_tables: (C) 2002 David S. Miller
TCP cubic registered
NET: Registered protocol family 10
ip6_tables: (C) 2000-2006 Netfilter Core Team
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
raid6test: testing the 4-disk case...
raid6test: test_disks(0, 1): faila=  0(D)  failb=  1(D)  OK
raid6test: test_disks(0, 2): faila=  0(D)  failb=  2(P)  OK
raid6test: test_disks(0, 3): faila=  0(D)  failb=  3(Q)  OK
raid6test: test_disks(1, 2): faila=  1(D)  failb=  2(P)  OK
raid6test: test_disks(1, 3): faila=  1(D)  failb=  3(Q)  OK
raid6test: test_disks(2, 3): faila=  2(P)  failb=  3(Q)  OK
raid6test: testing the 5-disk case...
raid6test: test_disks(0, 1): faila=  0(D)  failb=  1(D)  OK
raid6test: test_disks(0, 2): faila=  0(D)  failb=  2(D)  OK
raid6test: test_disks(0, 3): faila=  0(D)  failb=  3(P)  OK
raid6test: test_disks(0, 4): faila=  0(D)  failb=  4(Q)  OK
raid6test: test_disks(1, 2): faila=  1(D)  failb=  2(D)  OK
raid6test: test_disks(1, 3): faila=  1(D)  failb=  3(P)  OK
raid6test: test_disks(1, 4): faila=  1(D)  failb=  4(Q)  OK
raid6test: test_disks(2, 3): faila=  2(D)  failb=  3(P)  OK
raid6test: test_disks(2, 4): faila=  2(D)  failb=  4(Q)  OK
raid6test: test_disks(3, 4): faila=  3(P)  failb=  4(Q)  OK
raid6test: testing the 16-disk case...
raid6test: test_disks(0, 1): faila=  0(D)  failb=  1(D)  OK
raid6test: test_disks(0, 2): faila=  0(D)  failb=  2(D)  OK
raid6test: test_disks(0, 3): faila=  0(D)  failb=  3(D)  OK
raid6test: test_disks(0, 4): faila=  0(D)  failb=  4(D)  OK
raid6test: test_disks(0, 5): faila=  0(D)  failb=  5(D)  OK
raid6test: test_disks(0, 6): faila=  0(D)  failb=  6(D)  OK
raid6test: test_disks(0, 7): faila=  0(D)  failb=  7(D)  OK
raid6test: test_disks(0, 8): faila=  0(D)  failb=  8(D)  OK
raid6test: test_disks(0, 9): faila=  0(D)  failb=  9(D)  OK
raid6test: test_disks(0, 10): faila=  0(D)  failb= 10(D)  OK
raid6test: test_disks(0, 11): faila=  0(D)  failb= 11(D)  OK
raid6test: test_disks(0, 12): faila=  0(D)  failb= 12(D)  OK
raid6test: test_disks(0, 13): faila=  0(D)  failb= 13(D)  OK
raid6test: test_disks(0, 14): faila=  0(D)  failb= 14(P)  OK
raid6test: test_disks(0, 15): faila=  0(D)  failb= 15(Q)  OK
raid6test: test_disks(1, 2): faila=  1(D)  failb=  2(D)  OK
raid6test: test_disks(1, 3): faila=  1(D)  failb=  3(D)  OK
raid6test: test_disks(1, 4): faila=  1(D)  failb=  4(D)  OK
raid6test: test_disks(1, 5): faila=  1(D)  failb=  5(D)  OK
raid6test: test_disks(1, 6): faila=  1(D)  failb=  6(D)  OK
raid6test: test_disks(1, 7): faila=  1(D)  failb=  7(D)  OK
raid6test: test_disks(1, 8): faila=  1(D)  failb=  8(D)  OK
raid6test: test_disks(1, 9): faila=  1(D)  failb=  9(D)  OK
raid6test: test_disks(1, 10): faila=  1(D)  failb= 10(D)  OK
raid6test: test_disks(1, 11): faila=  1(D)  failb= 11(D)  OK
raid6test: test_disks(1, 12): faila=  1(D)  failb= 12(D)  OK
raid6test: test_disks(1, 13): faila=  1(D)  failb= 13(D)  OK
raid6test: test_disks(1, 14): faila=  1(D)  failb= 14(P)  OK
raid6test: test_disks(1, 15): faila=  1(D)  failb= 15(Q)  OK
raid6test: test_disks(2, 3): faila=  2(D)  failb=  3(D)  OK
raid6test: test_disks(2, 4): faila=  2(D)  failb=  4(D)  OK
raid6test: test_disks(2, 5): faila=  2(D)  failb=  5(D)  OK
raid6test: test_disks(2, 6): faila=  2(D)  failb=  6(D)  OK
raid6test: test_disks(2, 7): faila=  2(D)  failb=  7(D)  OK
raid6test: test_disks(2, 8): faila=  2(D)  failb=  8(D)  OK
raid6test: test_disks(2, 9): faila=  2(D)  failb=  9(D)  OK
raid6test: test_disks(2, 10): faila=  2(D)  failb= 10(D)  OK
raid6test: test_disks(2, 11): faila=  2(D)  failb= 11(D)  OK
raid6test: test_disks(2, 12): faila=  2(D)  failb= 12(D)  OK
raid6test: test_disks(2, 13): faila=  2(D)  failb= 13(D)  OK
raid6test: test_disks(2, 14): faila=  2(D)  failb= 14(P)  OK
raid6test: test_disks(2, 15): faila=  2(D)  failb= 15(Q)  OK
raid6test: test_disks(3, 4): faila=  3(D)  failb=  4(D)  OK
raid6test: test_disks(3, 5): faila=  3(D)  failb=  5(D)  OK
raid6test: test_disks(3, 6): faila=  3(D)  failb=  6(D)  OK
raid6test: test_disks(3, 7): faila=  3(D)  failb=  7(D)  OK
raid6test: test_disks(3, 8): faila=  3(D)  failb=  8(D)  OK
raid6test: test_disks(3, 9): faila=  3(D)  failb=  9(D)  OK
raid6test: test_disks(3, 10): faila=  3(D)  failb= 10(D)  OK
raid6test: test_disks(3, 11): faila=  3(D)  failb= 11(D)  OK
raid6test: test_disks(3, 12): faila=  3(D)  failb= 12(D)  OK
raid6test: test_disks(3, 13): faila=  3(D)  failb= 13(D)  OK
raid6test: test_disks(3, 14): faila=  3(D)  failb= 14(P)  OK
raid6test: test_disks(3, 15): faila=  3(D)  failb= 15(Q)  OK
raid6test: test_disks(4, 5): faila=  4(D)  failb=  5(D)  OK
raid6test: test_disks(4, 6): faila=  4(D)  failb=  6(D)  OK
raid6test: test_disks(4, 7): faila=  4(D)  failb=  7(D)  OK
raid6test: test_disks(4, 8): faila=  4(D)  failb=  8(D)  OK
raid6test: test_disks(4, 9): faila=  4(D)  failb=  9(D)  OK
raid6test: test_disks(4, 10): faila=  4(D)  failb= 10(D)  OK
raid6test: test_disks(4, 11): faila=  4(D)  failb= 11(D)  OK
raid6test: test_disks(4, 12): faila=  4(D)  failb= 12(D)  OK
raid6test: test_disks(4, 13): faila=  4(D)  failb= 13(D)  OK
raid6test: test_disks(4, 14): faila=  4(D)  failb= 14(P)  OK
raid6test: test_disks(4, 15): faila=  4(D)  failb= 15(Q)  OK
raid6test: test_disks(5, 6): faila=  5(D)  failb=  6(D)  OK
raid6test: test_disks(5, 7): faila=  5(D)  failb=  7(D)  OK
raid6test: test_disks(5, 8): faila=  5(D)  failb=  8(D)  OK
raid6test: test_disks(5, 9): faila=  5(D)  failb=  9(D)  OK
raid6test: test_disks(5, 10): faila=  5(D)  failb= 10(D)  OK
raid6test: test_disks(5, 11): faila=  5(D)  failb= 11(D)  OK
raid6test: test_disks(5, 12): faila=  5(D)  failb= 12(D)  OK
raid6test: test_disks(5, 13): faila=  5(D)  failb= 13(D)  OK
raid6test: test_disks(5, 14): faila=  5(D)  failb= 14(P)  OK
raid6test: test_disks(5, 15): faila=  5(D)  failb= 15(Q)  OK
raid6test: test_disks(6, 7): faila=  6(D)  failb=  7(D)  OK
raid6test: test_disks(6, 8): faila=  6(D)  failb=  8(D)  OK
raid6test: test_disks(6, 9): faila=  6(D)  failb=  9(D)  OK
raid6test: test_disks(6, 10): faila=  6(D)  failb= 10(D)  OK
raid6test: test_disks(6, 11): faila=  6(D)  failb= 11(D)  OK
raid6test: test_disks(6, 12): faila=  6(D)  failb= 12(D)  OK
raid6test: test_disks(6, 13): faila=  6(D)  failb= 13(D)  OK
raid6test: test_disks(6, 14): faila=  6(D)  failb= 14(P)  OK
raid6test: test_disks(6, 15): faila=  6(D)  failb= 15(Q)  OK
raid6test: test_disks(7, 8): faila=  7(D)  failb=  8(D)  OK
raid6test: test_disks(7, 9): faila=  7(D)  failb=  9(D)  OK
raid6test: test_disks(7, 10): faila=  7(D)  failb= 10(D)  OK
raid6test: test_disks(7, 11): faila=  7(D)  failb= 11(D)  OK
raid6test: test_disks(7, 12): faila=  7(D)  failb= 12(D)  OK
raid6test: test_disks(7, 13): faila=  7(D)  failb= 13(D)  OK
raid6test: test_disks(7, 14): faila=  7(D)  failb= 14(P)  OK
raid6test: test_disks(7, 15): faila=  7(D)  failb= 15(Q)  OK
raid6test: test_disks(8, 9): faila=  8(D)  failb=  9(D)  OK
raid6test: test_disks(8, 10): faila=  8(D)  failb= 10(D)  OK
raid6test: test_disks(8, 11): faila=  8(D)  failb= 11(D)  OK
raid6test: test_disks(8, 12): faila=  8(D)  failb= 12(D)  OK
raid6test: test_disks(8, 13): faila=  8(D)  failb= 13(D)  OK
raid6test: test_disks(8, 14): faila=  8(D)  failb= 14(P)  OK
raid6test: test_disks(8, 15): faila=  8(D)  failb= 15(Q)  OK
raid6test: test_disks(9, 10): faila=  9(D)  failb= 10(D)  OK
raid6test: test_disks(9, 11): faila=  9(D)  failb= 11(D)  OK
raid6test: test_disks(9, 12): faila=  9(D)  failb= 12(D)  OK
raid6test: test_disks(9, 13): faila=  9(D)  failb= 13(D)  OK
raid6test: test_disks(9, 14): faila=  9(D)  failb= 14(P)  OK
raid6test: test_disks(9, 15): faila=  9(D)  failb= 15(Q)  OK
raid6test: test_disks(10, 11): faila= 10(D)  failb= 11(D)  OK
raid6test: test_disks(10, 12): faila= 10(D)  failb= 12(D)  OK
raid6test: test_disks(10, 13): faila= 10(D)  failb= 13(D)  OK
raid6test: test_disks(10, 14): faila= 10(D)  failb= 14(P)  OK
raid6test: test_disks(10, 15): faila= 10(D)  failb= 15(Q)  OK
raid6test: test_disks(11, 12): faila= 11(D)  failb= 12(D)  OK
raid6test: test_disks(11, 13): faila= 11(D)  failb= 13(D)  OK
raid6test: test_disks(11, 14): faila= 11(D)  failb= 14(P)  OK
raid6test: test_disks(11, 15): faila= 11(D)  failb= 15(Q)  OK
raid6test: test_disks(12, 13): faila= 12(D)  failb= 13(D)  OK
raid6test: test_disks(12, 14): faila= 12(D)  failb= 14(P)  OK
raid6test: test_disks(12, 15): faila= 12(D)  failb= 15(Q)  OK
raid6test: test_disks(13, 14): faila= 13(D)  failb= 14(P)  OK
raid6test: test_disks(13, 15): faila= 13(D)  failb= 15(Q)  OK
raid6test: test_disks(14, 15): faila= 14(P)  failb= 15(Q)  OK
raid6test: 
raid6test: complete (136 tests, 0 failures)
ata4: SATA link down (SStatus 0 SControl 300)
ata2: SATA link down (SStatus 0 SControl 300)
ata5: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata6: SATA link down (SStatus 0 SControl 300)
usb 1-5: new high speed USB device using ehci_hcd and address 3
usb 1-5: configuration #1 chosen from 1 choice
scsi6 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usb 3-1: new low speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
input: Microsoft Comfort Curve Keyboard 2000 as /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1:1.0/input/input2
generic-usb 0003:045E:00DD.0001: input: USB HID v1.11 Keyboard [Microsoft Comfort Curve Keyboard 2000] on usb-0000:00:1a.0-1/input0
input: Microsoft Comfort Curve Keyboard 2000 as /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1:1.1/input/input3
generic-usb 0003:045E:00DD.0002: input: USB HID v1.11 Device [Microsoft Comfort Curve Keyboard 2000] on usb-0000:00:1a.0-1/input1
ata1: link is slow to respond, please be patient (ready=0)
scsi 6:0:0:0: Direct-Access     Ut165    USB2FlashStorage 0.00 PQ: 0 ANSI: 2
sd 6:0:0:0: Attached scsi generic sg0 type 0
sd 6:0:0:0: [sda] 7716864 512-byte logical blocks: (3.95 GB/3.67 GiB)
sd 6:0:0:0: [sda] Write Protect is off
sd 6:0:0:0: [sda] Mode Sense: 00 00 00 00
sd 6:0:0:0: [sda] Assuming drive cache: write through
usb-storage: device scan complete
sd 6:0:0:0: [sda] Assuming drive cache: write through
 sda: sda1 sda2
sd 6:0:0:0: [sda] Assuming drive cache: write through
sd 6:0:0:0: [sda] Attached SCSI removable disk
ata1: COMRESET failed (errno=-16)
ata1: link is slow to respond, please be patient (ready=0)
ata1: COMRESET failed (errno=-16)
ata1: link is slow to respond, please be patient (ready=0)
ata1: COMRESET failed (errno=-16)
ata1: limiting SATA link speed to 1.5 Gbps
ata1: COMRESET failed (errno=-16)
ata1: reset failed, giving up
md: Waiting for all devices to be available before autodetect
md: If you don't use raid, use raid=noautodetect
md: Autodetecting RAID arrays.
md: Scanned 0 and added 0 devices.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with writeback data mode.
VFS: Mounted root (ext3 filesystem) readonly on device 8:2.
Freeing unused kernel memory: 656k freed
udev: starting version 141
EXT3 FS on sda2, internal journal
e1000e 0000:00:19.0: irq 25 for MSI/MSI-X
e1000e 0000:00:19.0: irq 25 for MSI/MSI-X
ADDRCONF(NETDEV_UP): eth0: link is not ready
e1000e: eth0 NIC Link is Up 100 Mbps Full Duplex, Flow Control: None
0000:00:19.0: eth0: 10/100 speed: disabling TSO
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
eth0: no IPv6 routers present
CE: hpet increasing min_delta_ns to 15000 nsec


--------------040401090906010500070304--


