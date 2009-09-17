From: Holger Hasselmann <hhasselm@web.de>
Subject: Re: Gigabyte GA-MA69VM-S2 can't do 64bit DMA
Date: Fri, 18 Sep 2009 00:12:51 +0200
Message-ID: <4AB2B463.4010408@web.de>
References: <4AAE8252.8000206@web.de> <4AAFE66D.8050807@gmail.com> <4AB0ADB2.8090009@web.de> <4AB0C2AD.6020503@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070905070702060101070504"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:41477 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbZIQWMw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Sep 2009 18:12:52 -0400
In-Reply-To: <4AB0C2AD.6020503@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Shane.Huang@amd.com

This is a multi-part message in MIME format.
--------------070905070702060101070504
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo schrieb:
> Holger Hasselmann wrote:
>   
>> I have tried the attached patch on a clean 2.6.31 source and it is working.
>>
>> dmesg is showing the following:
>>
>> libata version 3.00 loaded.
>> ahci 0000:00:12.0: version 3.0
>> ahci 0000:00:12.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
>> ahci 0000:00:12.0: ASUS M2A-VM: BIOS too old, forcing 32bit DMA, update
>> BIOS
>> ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
>> ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA
>> mode
>> ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pmp pio slum part
>>
>> Will try it later on the latest git, I think the dmesg should identify
>> the Board correct then and.
>>     
>
> Oh, yes, please.  It should be printing different message.
>
>   
I have tried the 2.6.31-git2 and this is  the dmesg output :

ibata version 3.00 
loaded.                                                                                            

ahci 0000:00:12.0: version 
3.0                                                                                         

ahci 0000:00:12.0: PCI INT A -> GSI 22 (level, low) -> IRQ 
22                                                         
ahci 0000:00:12.0: Fujitsu-Siemens AMILO Pa 2510: this board can't do 
64bit DMA, forcing 32bit                        
ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 
32bit                                                       
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA 
mode                                          
ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pmp pio slum part 

It's correct now.

Thanks very much.

By the way, I was wondering, because I  am a lucky owner of the 
GA-MA69VM-S2 board.
I have  seen it  when I  was trying out the issue with my laptop and 
read the name of the kernel patch.
You will not believe it, on my board with the bios version F8 I do not 
have any issue with the plain 2.6.31 kernel
without patch. 

Thanks again,
Holger



--------------070905070702060101070504
Content-Type: text/plain;
 name="dmesg_GA-MA69VM-S2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_GA-MA69VM-S2.txt"

Linux version 2.6.31-ARCH (root@T-POWA-LX) (gcc version 4.4.1 (GCC) ) #1 SMP PREEMPT Thu Sep 10 16:21:57 CEST 2009
Command line: root=/dev/disk/by-uuid/39d2291f-43e8-4b4d-83da-dc547863811c ro
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  Centaur CentaurHauls
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cfee0000 (usable)
 BIOS-e820: 00000000cfee0000 - 00000000cfee3000 (ACPI NVS)
 BIOS-e820: 00000000cfee3000 - 00000000cfef0000 (ACPI data)
 BIOS-e820: 00000000cfef0000 - 00000000cff00000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000128000000 (usable)
DMI 2.4 present.
last_pfn = 0x128000 max_arch_pfn = 0x400000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-C7FFF write-protect
  C8000-FFFFF uncachable
MTRR variable ranges enabled:
  0 base 0000000000 mask FF80000000 write-back
  1 base 0080000000 mask FFC0000000 write-back
  2 base 00C0000000 mask FFF0000000 write-back
  3 base 00CFF00000 mask FFFFF00000 uncachable
  4 base 0100000000 mask FFE0000000 write-back
  5 base 0120000000 mask FFF8000000 write-back
  6 disabled
  7 disabled
TOM2: 0000000128000000 aka 4736M
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
e820 update range: 00000000cff00000 - 0000000100000000 (usable) ==> (reserved)
last_pfn = 0xcfee0 max_arch_pfn = 0x400000000
e820 update range: 0000000000001000 - 0000000000006000 (usable) ==> (reserved)
Scanning 1 areas for low memory corruption
modified physical RAM map:
 modified: 0000000000000000 - 0000000000001000 (usable)
 modified: 0000000000001000 - 0000000000006000 (reserved)
 modified: 0000000000006000 - 000000000009f800 (usable)
 modified: 000000000009f800 - 00000000000a0000 (reserved)
 modified: 00000000000f0000 - 0000000000100000 (reserved)
 modified: 0000000000100000 - 00000000cfee0000 (usable)
 modified: 00000000cfee0000 - 00000000cfee3000 (ACPI NVS)
 modified: 00000000cfee3000 - 00000000cfef0000 (ACPI data)
 modified: 00000000cfef0000 - 00000000cff00000 (reserved)
 modified: 00000000e0000000 - 00000000f0000000 (reserved)
 modified: 00000000fec00000 - 0000000100000000 (reserved)
 modified: 0000000100000000 - 0000000128000000 (usable)
initial memory mapped : 0 - 20000000
init_memory_mapping: 0000000000000000-00000000cfee0000
 0000000000 - 00cfe00000 page 2M
 00cfe00000 - 00cfee0000 page 4k
kernel direct mapping tables up to cfee0000 @ 8000-e000
init_memory_mapping: 0000000100000000-0000000128000000
 0100000000 - 0128000000 page 2M
kernel direct mapping tables up to 128000000 @ c000-12000
RAMDISK: 37f25000 - 37fefd9f
ACPI: RSDP 00000000000f6b00 00014 (v00 GBT   )
ACPI: RSDT 00000000cfee3000 00038 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
ACPI: FACP 00000000cfee3040 00074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
ACPI: DSDT 00000000cfee30c0 049B3 (v01 GBT    GBTUACPI 00001000 MSFT 0100000C)
ACPI: FACS 00000000cfee0000 00040
ACPI: SSDT 00000000cfee7b40 0028A (v01 PTLTD  POWERNOW 00000001  LTP 00000001)
ACPI: HPET 00000000cfee7e00 00038 (v01 GBT    GBTUACPI 42302E31 GBTU 00000098)
ACPI: MCFG 00000000cfee7e40 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
ACPI: APIC 00000000cfee7a80 00084 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
ACPI: Local APIC address 0xfee00000
(8 early reservations) ==> bootmem [0000000000 - 0128000000]
  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
  #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
  #2 [0001000000 - 00016813d0]    TEXT DATA BSS ==> [0001000000 - 00016813d0]
  #3 [0037f25000 - 0037fefd9f]          RAMDISK ==> [0037f25000 - 0037fefd9f]
  #4 [000009f800 - 0000100000]    BIOS reserved ==> [000009f800 - 0000100000]
  #5 [0001682000 - 00016820fe]              BRK ==> [0001682000 - 00016820fe]
  #6 [0000008000 - 000000c000]          PGTABLE ==> [0000008000 - 000000c000]
  #7 [000000c000 - 000000d000]          PGTABLE ==> [000000c000 - 000000d000]
found SMP MP-table at [ffff8800000f5140] f5140
 [ffffea0000000000-ffffea00041fffff] PMD -> [ffff880028600000-ffff88002bdfffff] on node 0
Zone PFN ranges:
  DMA      0x00000000 -> 0x00001000
  DMA32    0x00001000 -> 0x00100000
  Normal   0x00100000 -> 0x00128000
Movable zone start PFN for each node
early_node_map[4] active PFN ranges
    0: 0x00000000 -> 0x00000001
    0: 0x00000006 -> 0x0000009f
    0: 0x00000100 -> 0x000cfee0
    0: 0x00100000 -> 0x00128000
On node 0 totalpages: 1015418
  DMA zone: 56 pages used for memmap
  DMA zone: 104 pages reserved
  DMA zone: 3834 pages, LIFO batch:0
  DMA32 zone: 14280 pages used for memmap
  DMA32 zone: 833304 pages, LIFO batch:31
  Normal zone: 2240 pages used for memmap
  Normal zone: 161600 pages, LIFO batch:31
Detected use of extended apic ids on hypertransport bus
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x10b9a201 base: 0xfed00000
SMP: Allowing 4 CPUs, 2 hotplug CPUs
nr_irqs_gsi: 24
PM: Registered nosave memory: 0000000000001000 - 0000000000006000
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
PM: Registered nosave memory: 00000000cfee0000 - 00000000cfee3000
PM: Registered nosave memory: 00000000cfee3000 - 00000000cfef0000
PM: Registered nosave memory: 00000000cfef0000 - 00000000cff00000
PM: Registered nosave memory: 00000000cff00000 - 00000000e0000000
PM: Registered nosave memory: 00000000e0000000 - 00000000f0000000
PM: Registered nosave memory: 00000000f0000000 - 00000000fec00000
PM: Registered nosave memory: 00000000fec00000 - 0000000100000000
Allocating PCI resources starting at cff00000 (gap: cff00000:10100000)
NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_ids:4 nr_node_ids:1
PERCPU: Embedded 28 pages at ffff880028022000, static data 82400 bytes
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 998738
Kernel command line: root=/dev/disk/by-uuid/39d2291f-43e8-4b4d-83da-dc547863811c ro
PID hash table entries: 4096 (order: 12, 32768 bytes)
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Initializing CPU#0
Checking aperture...
No AGP bridge found
Node 0: aperture @ eb1e000000 size 32 MB
Aperture beyond 4GB. Ignoring.
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 20000000
PM: Registered nosave memory: 0000000020000000 - 0000000024000000
Memory: 3923496k/4849664k available (3628k kernel code, 787992k absent, 137188k reserved, 1501k data, 484k init)
SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
NR_IRQS:768
Fast TSC calibration using PIT
Detected 2505.536 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
hpet clockevent registered
HPET: 4 timers in total, 0 timers will be used for per-cpu timer
Calibrating delay loop (skipped), value calculated using timer frequency.. 5013.86 BogoMIPS (lpj=8351786)
Security Framework initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
tseg: 00cff00000
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 5 MCE banks
using C1E aware idle routine
Performance Counters: AMD PMU driver.
... version:                 0
... bit width:               48
... generic counters:        4
... value mask:              0000ffffffffffff
... max period:              00007fffffffffff
... fixed-purpose counters:  0
... counter mask:            000000000000000f
ACPI: Core revision 20090521
Setting APIC routing to flat
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: AMD Athlon(tm) Dual Core Processor 4850e stepping 02
Booting processor 1 APIC 0x1 ip 0x6000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5013.23 BogoMIPS (lpj=8352377)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
mce: CPU supports 5 MCE banks
x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
CPU1: AMD Athlon(tm) Dual Core Processor 4850e stepping 02
Brought up 2 CPUs
Total of 2 processors activated (10026.10 BogoMIPS).
CPU0 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 0 1
CPU1 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 1 0
Booting paravirtualized kernel on bare hardware
NET: Registered protocol family 16
node 0 link 0: io port [d000, ffff]
TOM: 00000000d8000000 aka 3456M
node 0 link 0: mmio [a0000, bffff]
node 0 link 0: mmio [d8000000, dfffffff]
node 0 link 0: mmio [e0000000, fe02ffff]
node 0 link 0: mmio [e0000000, efffffff]
TOM2: 0000000128000000 aka 4736M
bus: [00,02] on node 0 link 0
bus: 00 index 0 io port: [0, ffff]
bus: 00 index 1 mmio: [a0000, bffff]
bus: 00 index 2 mmio: [d8000000, ffffffff]
bus: 00 index 3 mmio: [128000000, fcffffffff]
ACPI: bus type pci registered
PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
PCI: MCFG area at e0000000 reserved in E820
PCI: Using MMCONFIG at e0000000 - efffffff
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: No dock devices found.
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:12.0: reg 10 io port: [0xff00-0xff07]
pci 0000:00:12.0: reg 14 io port: [0xfe00-0xfe03]
pci 0000:00:12.0: reg 18 io port: [0xfd00-0xfd07]
pci 0000:00:12.0: reg 1c io port: [0xfc00-0xfc03]
pci 0000:00:12.0: reg 20 io port: [0xfb00-0xfb0f]
pci 0000:00:12.0: reg 24 32bit mmio: [0xfe02f000-0xfe02f3ff]
pci 0000:00:13.0: reg 10 32bit mmio: [0xfe02e000-0xfe02efff]
pci 0000:00:13.1: reg 10 32bit mmio: [0xfe02d000-0xfe02dfff]
pci 0000:00:13.2: reg 10 32bit mmio: [0xfe02c000-0xfe02cfff]
pci 0000:00:13.3: reg 10 32bit mmio: [0xfe02b000-0xfe02bfff]
pci 0000:00:13.4: reg 10 32bit mmio: [0xfe02a000-0xfe02afff]
pci 0000:00:13.5: reg 10 32bit mmio: [0xfe029000-0xfe0290ff]
pci 0000:00:13.5: supports D1 D2
pci 0000:00:13.5: PME# supported from D0 D1 D2 D3hot
pci 0000:00:13.5: PME# disabled
pci 0000:00:14.0: reg 10 io port: [0xb00-0xb0f]
pci 0000:00:14.1: reg 10 io port: [0x00-0x07]
pci 0000:00:14.1: reg 14 io port: [0x00-0x03]
pci 0000:00:14.1: reg 18 io port: [0x00-0x07]
pci 0000:00:14.1: reg 1c io port: [0x00-0x03]
pci 0000:00:14.1: reg 20 io port: [0xf900-0xf90f]
pci 0000:00:14.2: reg 10 64bit mmio: [0xfe024000-0xfe027fff]
pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
pci 0000:00:14.2: PME# disabled
pci 0000:01:05.0: reg 10 64bit mmio: [0xd8000000-0xdfffffff]
pci 0000:01:05.0: reg 18 64bit mmio: [0xfdff0000-0xfdffffff]
pci 0000:01:05.0: reg 20 io port: [0xee00-0xeeff]
pci 0000:01:05.0: reg 24 32bit mmio: [0xfde00000-0xfdefffff]
pci 0000:01:05.0: supports D1 D2
pci 0000:00:01.0: bridge io port: [0xe000-0xefff]
pci 0000:00:01.0: bridge 32bit mmio: [0xfde00000-0xfdffffff]
pci 0000:00:01.0: bridge 64bit mmio pref: [0xd8000000-0xdfffffff]
pci 0000:02:0f.0: reg 10 io port: [0xde00-0xdeff]
pci 0000:02:0f.0: reg 14 32bit mmio: [0xfddff000-0xfddff0ff]
pci 0000:02:0f.0: reg 30 32bit mmio: [0x000000-0x01ffff]
pci 0000:02:0f.0: supports D1 D2
pci 0000:02:0f.0: PME# supported from D1 D2 D3hot D3cold
pci 0000:02:0f.0: PME# disabled
pci 0000:00:14.4: transparent bridge
pci 0000:00:14.4: bridge io port: [0xd000-0xdfff]
pci 0000:00:14.4: bridge 32bit mmio: [0xfdd00000-0xfddfffff]
pci 0000:00:14.4: bridge 32bit mmio pref: [0xfdc00000-0xfdcfffff]
pci_bus 0000:00: on NUMA node 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0, disabled.
PCI: Using ACPI for IRQ routing
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 20000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
Switched to high resolution mode on CPU 0
Switched to high resolution mode on CPU 1
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
system 00:01: ioport range 0x4d0-0x4d1 has been reserved
system 00:01: ioport range 0x220-0x225 has been reserved
system 00:01: ioport range 0x290-0x294 has been reserved
system 00:02: ioport range 0x4100-0x411f has been reserved
system 00:02: ioport range 0x228-0x22f has been reserved
system 00:02: ioport range 0x40b-0x40b has been reserved
system 00:02: ioport range 0x4d6-0x4d6 has been reserved
system 00:02: ioport range 0xc00-0xc01 has been reserved
system 00:02: ioport range 0xc14-0xc14 has been reserved
system 00:02: ioport range 0xc50-0xc52 has been reserved
system 00:02: ioport range 0xc6c-0xc6d has been reserved
system 00:02: ioport range 0xc6f-0xc6f has been reserved
system 00:02: ioport range 0xcd0-0xcd1 has been reserved
system 00:02: ioport range 0xcd2-0xcd3 has been reserved
system 00:02: ioport range 0xcd4-0xcdf has been reserved
system 00:02: ioport range 0x4000-0x40fe has been reserved
system 00:02: ioport range 0x4210-0x4217 has been reserved
system 00:02: ioport range 0xb00-0xb1f could not be reserved
system 00:02: ioport range 0x238-0x23f has been reserved
system 00:0a: iomem range 0xe0000000-0xefffffff has been reserved
system 00:0b: iomem range 0xcd400-0xcffff has been reserved
system 00:0b: iomem range 0xf0000-0xf7fff could not be reserved
system 00:0b: iomem range 0xf8000-0xfbfff could not be reserved
system 00:0b: iomem range 0xfc000-0xfffff could not be reserved
system 00:0b: iomem range 0xcfee0000-0xcfefffff could not be reserved
system 00:0b: iomem range 0xffff0000-0xffffffff has been reserved
system 00:0b: iomem range 0x0-0x9ffff could not be reserved
system 00:0b: iomem range 0x100000-0xcfedffff could not be reserved
system 00:0b: iomem range 0xcfff0000-0xd7feffff could not be reserved
system 00:0b: iomem range 0xfec00000-0xfec00fff could not be reserved
system 00:0b: iomem range 0xfee00000-0xfee00fff has been reserved
system 00:0b: iomem range 0xfff80000-0xfffeffff has been reserved
pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
pci 0000:00:01.0:   IO window: 0xe000-0xefff
pci 0000:00:01.0:   MEM window: 0xfde00000-0xfdffffff
pci 0000:00:01.0:   PREFETCH window: 0x000000d8000000-0x000000dfffffff
pci 0000:00:14.4: PCI bridge, secondary bus 0000:02
pci 0000:00:14.4:   IO window: 0xd000-0xdfff
pci 0000:00:14.4:   MEM window: 0xfdd00000-0xfddfffff
pci 0000:00:14.4:   PREFETCH window: 0xfdc00000-0xfdcfffff
pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
pci_bus 0000:01: resource 0 io:  [0xe000-0xefff]
pci_bus 0000:01: resource 1 mem: [0xfde00000-0xfdffffff]
pci_bus 0000:01: resource 2 pref mem [0xd8000000-0xdfffffff]
pci_bus 0000:02: resource 0 io:  [0xd000-0xdfff]
pci_bus 0000:02: resource 1 mem: [0xfdd00000-0xfddfffff]
pci_bus 0000:02: resource 2 pref mem [0xfdc00000-0xfdcfffff]
pci_bus 0000:02: resource 3 io:  [0x00-0xffff]
pci_bus 0000:02: resource 4 mem: [0x000000-0xffffffffffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
NET: Registered protocol family 1
Unpacking initramfs...
Freeing initrd memory: 811k freed
Scanning for low memory corruption every 60 seconds
audit: initializing netlink socket (disabled)
type=2000 audit(1253228132.240:1): initialized
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
msgmni has been set to 7666
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:01:05.0: Boot video device
Linux agpgart interface v0.103
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
input: Macintosh mouse button emulation as /devices/virtual/input/input0
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
cpuidle: using governor ladder
cpuidle: using governor menu
TCP cubic registered
NET: Registered protocol family 17
registered taskstats version 1
Initalizing network drop monitor service
Freeing unused kernel memory: 484k freed
SCSI subsystem initialized
libata version 3.00 loaded.
ahci 0000:00:12.0: version 3.0
ahci 0000:00:12.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:12.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f100 irq 22
ata2: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f180 irq 22
ata3: SATA max UDMA/133 irq_stat 0x00400040, connection status changed irq 22
ata4: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f280 irq 22
pata_atiixp 0000:00:14.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
scsi4 : pata_atiixp
scsi5 : pata_atiixp
ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf900 irq 14
ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf908 irq 15
ata2: SATA link down (SStatus 0 SControl 300)
ata4: softreset failed (device not ready)
ata4: applying SB600 PMP SRST workaround and retrying
ata1: softreset failed (device not ready)
ata1: applying SB600 PMP SRST workaround and retrying
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATAPI: TSSTcorp CDDVDW SH-S203D, SB00, max UDMA/100, ATAPI AN
ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
ata1.00: SB600 AHCI: limiting to 255 sectors per cmd
ata1.00: configured for UDMA/100
scsi 0:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S203D  SB00 PQ: 0 ANSI: 5
ata4.00: HPA detected: current 976771055, native 976773168
ata4.00: ATA-7: ST3500630AS, 3.AAK, max UDMA/133
ata4.00: 976771055 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata4.00: SB600 AHCI: limiting to 255 sectors per cmd
ata4.00: SB600 AHCI: limiting to 255 sectors per cmd
ata4.00: configured for UDMA/133
ata3: softreset failed (device not ready)
ata3: applying SB600 PMP SRST workaround and retrying
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: HPA detected: current 490232639, native 490234752
ata3.00: ATA-7: Maxtor 6V250F0, VA111630, max UDMA/133
ata3.00: 490232639 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
ata3.00: configured for UDMA/133
scsi 2:0:0:0: Direct-Access     ATA      Maxtor 6V250F0   VA11 PQ: 0 ANSI: 5
scsi 3:0:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:0:0: Attached scsi CD-ROM sr0
sd 2:0:0:0: [sda] 490232639 512-byte logical blocks: (250 GB/233 GiB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda:
sd 3:0:0:0: [sdb] 976771055 512-byte logical blocks: (500 GB/465 GiB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sda1 sda2 sda3 sda4 < sdb1
sd 3:0:0:0: [sdb] Attached SCSI disk
 sda5 >
sd 2:0:0:0: [sda] Attached SCSI disk
EXT4-fs (sda2): barriers enabled
EXT4-fs (sda2): delayed allocation enabled
EXT4-fs: file extents enabled
EXT4-fs: mballoc enabled
EXT4-fs (sda2): mounted filesystem with ordered data mode
kjournald2 starting: pid 519, dev sda2:8, commit interval 5 seconds
rtc_cmos 00:05: RTC can wake from S4
rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, 242 bytes nvram, hpet irqs
udev: starting version 146
processor LNXCPU:00: registered as cooling_device0
processor LNXCPU:01: registered as cooling_device1
powernow-k8: Found 1 AMD Athlon(tm) Dual Core Processor 4850e processors (2 cpu cores) (version 2.20.00)
powernow-k8:    0 : fid 0x11 (2500 MHz), vid 0xe
powernow-k8:    1 : fid 0x10 (2400 MHz), vid 0xf
powernow-k8:    2 : fid 0xe (2200 MHz), vid 0x11
powernow-k8:    3 : fid 0xc (2000 MHz), vid 0x13
powernow-k8:    4 : fid 0xa (1800 MHz), vid 0x15
powernow-k8:    5 : fid 0x2 (1000 MHz), vid 0x16
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
input: PC Speaker as /devices/platform/pcspkr/input/input1
k8temp 0000:00:18.3: Temperature readouts might be wrong - check erratum #141
sr 0:0:0:0: Attached scsi generic sg0 type 5
sd 2:0:0:0: Attached scsi generic sg1 type 0
sd 3:0:0:0: Attached scsi generic sg2 type 0
piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd 0000:00:13.5: PCI INT D -> GSI 19 (level, low) -> IRQ 19
ehci_hcd 0000:00:13.5: EHCI Host Controller
ehci_hcd 0000:00:13.5: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.5: applying AMD SB600/SB700 USB freeze workaround
ehci_hcd 0000:00:13.5: debug port 1
ehci_hcd 0000:00:13.5: irq 19, io mem 0xfe029000
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd 0000:00:13.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 16, io mem 0xfe02e000
EDAC MC: Ver: 2.1.0 Sep 10 2009
EDAC amd64_edac:  Ver: 3.2.0 Sep 10 2009
lp: driver loaded but no devices found
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
EDAC amd64: This node reports that Memory ECC is currently disabled.
EDAC amd64: bit 0x400000 in register F3x44 of the MISC_CONTROL device (0000:00:18.3) should be enabled
EDAC amd64: WARNING: ECC is NOT currently enabled by the BIOS. Module will NOT be loaded.
    Either Enable ECC in the BIOS, or use the 'ecc_enable_override' parameter.
    Might be a BIOS bug, if BIOS says ECC is enabled
    Use of the override can cause unknown side effects.
amd64_edac: probe of 0000:00:18.2 failed with error -22
ohci_hcd 0000:00:13.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.1: irq 17, io mem 0xfe02d000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ohci_hcd 0000:00:13.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.2: OHCI Host Controller
ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:13.2: irq 18, io mem 0xfe02c000
ppdev: user-space parallel port driver
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ohci_hcd 0000:00:13.3: PCI INT B -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.3: OHCI Host Controller
ohci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 5
ohci_hcd 0000:00:13.3: irq 17, io mem 0xfe02b000
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ohci_hcd 0000:00:13.4: PCI INT C -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.4: OHCI Host Controller
ohci_hcd 0000:00:13.4: new USB bus registered, assigned bus number 6
ohci_hcd 0000:00:13.4: irq 18, io mem 0xfe02a000
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
usb 1-3: new high speed USB device using ehci_hcd and address 4
rt2870sta: module is from the staging directory, the quality is unknown, you have been warned.
rtusb init --->
usbcore: registered new interface driver rt2870
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
ACPI: Power Button [PWRF]
input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input3
ACPI: Power Button [PWRB]
IT8716 SuperIO detected.
parport_pc 00:09: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
it87: Found IT8716F chip at 0x228, revision 3
it87: in3 is VCC (+5V)
it87: in7 is VCCH (+5V Stand-By)
usb 1-3: configuration #1 chosen from 1 choice
hub 1-3:1.0: USB hub found
hub 1-3:1.0: 4 ports detected
lp0: using parport0 (interrupt-driven).
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
r8169 0000:02:0f.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
r8169 0000:02:0f.0: no PCI Express capability
eth0: RTL8169sc/8110sc at 0xffffc90000036000, 00:1a:4d:f8:6e:72, XID 18000000 IRQ 23
HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
usb 1-4: new high speed USB device using ehci_hcd and address 5
input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:14.2/input/input4
usb 1-4: configuration #1 chosen from 1 choice


=== pAd = ffffc90010166000, size = 598568 ===

<-- RTMPAllocAdapterBlock, Status=0
usb 2-1: new low speed USB device using ohci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
usb 2-2: new low speed USB device using ohci_hcd and address 3
usbcore: registered new interface driver hiddev
input: Microsoft Basic Optical Mouse as /devices/pci0000:00/0000:00:13.0/usb2/2-1/2-1:1.0/input/input5
generic-usb 0003:045E:0083.0001: input,hidraw0: USB HID v1.10 Mouse [Microsoft Basic Optical Mouse] on usb-0000:00:13.0-1/input0
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
usb 2-2: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /devices/pci0000:00/0000:00:13.0/usb2/2-2/2-2:1.0/input/input6
cherry 0003:046A:0023.0002: input,hidraw1: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:13.0-2/input0
input: HID 046a:0023 as /devices/pci0000:00/0000:00:13.0/usb2/2-2/2-2:1.1/input/input7
cherry 0003:046A:0023.0003: input,hidraw2: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:13.0-2/input1
EXT4-fs (sda2): internal journal on sda2:8
Adding 489972k swap on /dev/sda3.  Priority:-1 extents:1 across:489972k 
Clocksource tsc unstable (delta = -232832585 ns)
<-- RTMPAllocTxRxRingMemory, Status=0
-->RTUSBVenderReset
<--RTUSBVenderReset
I/F(ra0) Key1Str is Invalid key length! KeyLen = 0!
I/F(ra0) Key2Str is Invalid key length! KeyLen = 0!
I/F(ra0) Key3Str is Invalid key length! KeyLen = 0!
I/F(ra0) Key4Str is Invalid key length! KeyLen = 0!
1. Phy Mode = 5
2. Phy Mode = 5
RTMPSetPhyMode: channel is out of range, use first channel=1 
3. Phy Mode = 9
MCS Set = ff ff 00 00 01
<==== RTMPInitialize, Status=0
0x1300 = 00064300
pci 0000:01:05.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[drm] Initialized drm 1.1.0 20060810
[drm] Initialized radeon 1.31.0 20080528 for 0000:01:05.0 on minor 0
[drm] Setting GART location based on new memory map
[drm] Loading RS690/RS740 Microcode
[drm] Num pipes: 1
[drm] writeback test succeeded in 1 usecs
===>rt_ioctl_giwscan. 1(1) BSS returned, data->length = 158
==>rt_ioctl_siwfreq::SIOCSIWFREQ[cmd=0x8b04] (Channel=1)
CPU0 attaching NULL sched-domain.
CPU1 attaching NULL sched-domain.
CPU0 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 0 1
CPU1 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 1 0
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ra0: no IPv6 routers present
Rcv Wcid(1) AddBAReq
Start Seq = 00000000

--------------070905070702060101070504
Content-Type: text/plain;
 name="dmi_GA-MA69VM-S2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmi_GA-MA69VM-S2.txt"

# dmidecode 2.10
SMBIOS 2.4 present.
53 structures occupying 2374 bytes.
Table at 0x000F0100.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Award Software International, Inc.
	Version: F8
	Release Date: 03/03/2008
	Address: 0xE0000
	Runtime Size: 128 kB
	ROM Size: 512 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PNP is supported
		APM is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		5.25"/360 kB floppy services are supported (int 13h)
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 kB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		AGP is supported
		LS-120 boot is supported
		ATAPI Zip drive boot is supported
		BIOS boot specification is supported
		Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Gigabyte Technology Co., Ltd.
	Product Name: GA-MA69VM-S2
	Version:  
	Serial Number:  
	UUID: 30303141-3444-4638-3645-3732FFFFFFFF
	Wake-up Type: Power Switch
	SKU Number:  
	Family:  

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Gigabyte Technology Co., Ltd.
	Product Name: GA-MA69VM-S2
	Version:  
	Serial Number:  

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: Gigabyte Technology Co., Ltd.
	Type: Desktop
	Lock: Not Present
	Version:  
	Serial Number:  
	Asset Tag:  
	Boot-up State: Unknown
	Power Supply State: Unknown
	Thermal State: Unknown
	Security Status: Unknown
	OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: Socket M2
	Type: Central Processor
	Family: Athlon
	Manufacturer: AMD
	ID: B2 0F 06 00 FF FB 8B 17
	Signature: Family 15, Model 107, Stepping 2
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		PSE-36 (36-bit page size extension)
		CLFSH (CLFLUSH instruction supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		HTT (Hyper-threading technology)
	Version: AMD Athlon(tm) Dual Core Processor 4850e.G
	Voltage: 1.2 V
	External Clock: 200 MHz
	Max Speed: 3200 MHz
	Current Speed: 2500 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x000A
	L2 Cache Handle: 0x000C
	L3 Cache Handle: Not Provided
	Serial Number:  
	Asset Tag:  
	Part Number:  

Handle 0x0005, DMI type 5, 24 bytes
Memory Controller Information
	Error Detecting Method: 64-bit ECC
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 1024 MB
	Maximum Total Memory Size: 4096 MB
	Supported Speeds:
		70 ns
		60 ns
	Supported Memory Types:
		Standard
		EDO
	Memory Module Voltage: 3.3 V
	Associated Memory Slots: 4
		0x0006
		0x0007
		0x0008
		0x0009
	Enabled Error Correcting Capabilities:
		None

Handle 0x0006, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: A0
	Bank Connections: 1
	Current Speed: 32 ns
	Type: Other Unknown EDO
	Installed Size: 2048 MB (Double-bank Connection)
	Enabled Size: 2048 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0007, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: A1
	Bank Connections: 2
	Current Speed: 32 ns
	Type: Other Unknown EDO
	Installed Size: 2048 MB (Double-bank Connection)
	Enabled Size: 2048 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0008, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: A2
	Bank Connections: 3
	Current Speed: 32 ns
	Type: Other Unknown EDO
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x0009, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: A3
	Bank Connections: 4
	Current Speed: 32 ns
	Type: Other Unknown EDO
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x000A, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Internal Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 128 kB
	Maximum Size: 128 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000B, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Internal Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 128 kB
	Maximum Size: 128 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000C, DMI type 7, 19 bytes
Cache Information
	Socket Designation: External Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 512 kB
	Maximum Size: 512 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000D, DMI type 7, 19 bytes
Cache Information
	Socket Designation: External Cache
	Configuration: Disabled, Not Socketed, Level 2
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 0 kB
	Maximum Size: 1024 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PRIMARY IDE
	Internal Connector Type: On Board IDE
	External Reference Designator:  
	External Connector Type: None
	Port Type: Other

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: FDD
	Internal Connector Type: On Board Floppy
	External Reference Designator:  
	External Connector Type: None
	Port Type: 8251 FIFO Compatible

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: COM1
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator:  
	External Connector Type: DB-9 male
	Port Type: Serial Port 16450 Compatible

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: COM2
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator:  
	External Connector Type: DB-9 male
	Port Type: Serial Port 16450 Compatible

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: LPT1
	Internal Connector Type: DB-25 female
	External Reference Designator:  
	External Connector Type: DB-25 female
	Port Type: Parallel Port ECP/EPP

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Keyboard
	Internal Connector Type: Other
	External Reference Designator:  
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PS/2 Mouse
	Internal Connector Type: PS/2
	External Reference Designator: Detected
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB
	Internal Connector Type: None
	External Reference Designator:  
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB
	Internal Connector Type: None
	External Reference Designator:  
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0017, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB
	Internal Connector Type: None
	External Reference Designator:  
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0018, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB
	Internal Connector Type: None
	External Reference Designator:  
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0019, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB
	Internal Connector Type: None
	External Reference Designator:  
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x001A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB
	Internal Connector Type: None
	External Reference Designator:  
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x001B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB
	Internal Connector Type: None
	External Reference Designator:  
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x001C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB
	Internal Connector Type: None
	External Reference Designator:  
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x001D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB
	Internal Connector Type: None
	External Reference Designator:  
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x001E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB
	Internal Connector Type: None
	External Reference Designator:  
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x001F, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 6
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported
		SMBus signal is supported

Handle 0x0020, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 7
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported
		SMBus signal is supported

Handle 0x0021, DMI type 9, 13 bytes
System Slot Information
	Designation: AGP
	Type: 32-bit AGP
	Current Usage: Available
	Length: Long
	ID: 8
	Characteristics:
		5.0 V is provided

Handle 0x0022, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Express x16
	Type: x16 PCI Express
	Current Usage: Available
	Length: Other
	ID: 16
	Characteristics:
		3.3 V is provided

Handle 0x0023, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Express x4
	Type: x4 PCI Express
	Current Usage: Available
	Length: Other
	ID: 32
	Characteristics:
		3.3 V is provided

Handle 0x0024, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 3
		n|US|iso8859-1
		n|US|iso8859-1
		r|CA|iso8859-1
	Currently Installed Language: n|US|iso8859-1

Handle 0x0025, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 2 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x0026, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0025
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: A0
	Bank Locator: Bank0/1
	Type: Unknown
	Type Detail: None
	Speed: 800 MHz
	Manufacturer:  
	Serial Number:  
	Asset Tag:  
	Part Number:  

Handle 0x0027, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0025
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: A1
	Bank Locator: Bank2/3
	Type: Unknown
	Type Detail: None
	Speed: 800 MHz
	Manufacturer:  
	Serial Number:  
	Asset Tag:  
	Part Number:  

Handle 0x0028, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0025
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: A2
	Bank Locator: Bank4/5
	Type: Unknown
	Type Detail: None
	Speed: 800 MHz
	Manufacturer:  
	Serial Number:  
	Asset Tag:  
	Part Number:  

Handle 0x0029, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0025
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: A3
	Bank Locator: Bank6/7
	Type: Unknown
	Type Detail: None
	Speed: 800 MHz
	Manufacturer:  
	Serial Number:  
	Asset Tag:  
	Part Number:  

Handle 0x002A, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000FFFFFFFF
	Range Size: 4 GB
	Physical Array Handle: 0x0025
	Partition Width: 32

Handle 0x002B, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x0026
	Memory Array Mapped Address Handle: 0x002A
	Partition Row Position: 1

Handle 0x002C, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00080000000
	Ending Address: 0x000FFFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x0027
	Memory Array Mapped Address Handle: 0x002A
	Partition Row Position: 1

Handle 0x002D, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x0028
	Memory Array Mapped Address Handle: 0x002A
	Partition Row Position: 1

Handle 0x002E, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x0029
	Memory Array Mapped Address Handle: 0x002A
	Partition Row Position: 1

Handle 0x002F, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x0030, DMI type 188, 244 bytes
OEM-specific Type
	Header and Data:
		BC F4 30 00 00 00 00 D8 00 00 00 00 00 00 00 28
		01 00 00 00 01 06 76 00 00 00 00 00 03 00 00 00
		00 00 27 01 00 00 00 00 01 00 00 00 00 00 00 00
		02 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00
		04 00 00 00 00 00 00 00 05 00 00 00 00 00 00 00
		06 00 00 00 00 00 00 00 07 00 00 00 01 28 00 D8
		40 00 10 0A 00 00 00 00 00 00 02 00 EF 02 00 5D
		01 00 00 00 01 02 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		E0 3D F8 00 00 00 00 00 00 00 00 00 00 00 00 00
		46 00 00 00 00 00 00 00 05 00 00 00 00 00 00 00
		24 F2 7D 5D 20 13 22 00 10 0C 01 00 6B 00 10 77
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00

Handle 0x0031, DMI type 190, 212 bytes
OEM-specific Type
	Header and Data:
		BE D4 31 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00

Handle 0x0032, DMI type 192, 244 bytes
OEM-specific Type
	Header and Data:
		C0 F4 32 00 15 13 15 15 15 14 13 15 15 00 00 00
		15 14 15 14 16 16 15 15 15 00 00 00 2D 00 00 00
		14 13 13 15 15 14 14 14 14 14 15 16 15 16 15 16
		16 14 30 00 00 00 22 32 11 20 20 25 20 10 22 32
		11 20 20 25 20 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00

Handle 0x0033, DMI type 194, 244 bytes
OEM-specific Type
	Header and Data:
		C2 F4 33 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00

Handle 0x0034, DMI type 127, 4 bytes
End Of Table


--------------070905070702060101070504--
