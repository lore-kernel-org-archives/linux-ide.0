From: Harri Olin <harri.olin@gmail.com>
Subject: ata device numbers
Date: Sat, 9 Oct 2010 20:08:44 +0300
Message-ID: <4CB0A19C.20604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:38203 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760304Ab0JIRRe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Oct 2010 13:17:34 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 76D88EF878
	for <linux-ide@vger.kernel.org>; Sat,  9 Oct 2010 20:08:46 +0300 (EEST)
Received: from JPCSRV01.JPC.local (ip212-226-155-81.adsl.kpnqwest.fi [212.226.155.81])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 498D8E51A3
	for <linux-ide@vger.kernel.org>; Sat,  9 Oct 2010 20:08:45 +0300 (EEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi

At the end of dmesg, there is an error on device ata13. Can someone tell 
which scsi device number or /dev/ name it refers to?

Is there any reliable way to determine the ata number for devices?

---

Linux version 2.6.32.2 (root@mizar) (gcc version 4.2.3) #1 SMP Mon Jan 4 
04:22:34 EET 2010
Command line: BOOT_IMAGE=Linux ro root=805 vt.default_utf8=0 
netconsole=6665@192.168.11.9/eth1,6666@192.168.11.23/00:50:da:b7:ce:39
KERNEL supported cpus:
   Intel GenuineIntel
   AMD AuthenticAMD
   Centaur CentaurHauls
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009bc00 (usable)
  BIOS-e820: 000000000009bc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000cc000 - 00000000000d0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 00000000cfe70000 (usable)
  BIOS-e820: 00000000cfe70000 - 00000000cfe7e000 (ACPI data)
  BIOS-e820: 00000000cfe7e000 - 00000000cfe81000 (ACPI NVS)
  BIOS-e820: 00000000cfe81000 - 00000000d0000000 (reserved)
  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
  BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
  BIOS-e820: 0000000100000000 - 0000000230000000 (usable)
DMI present.
Phoenix BIOS detected: BIOS may corrupt low RAM, working around it.
e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> 
(reserved)
last_pfn = 0x230000 max_arch_pfn = 0x400000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
   00000-9FFFF write-back
   A0000-BFFFF uncachable
   C0000-C7FFF write-protect
   C8000-DFFFF uncachable
   E0000-FFFFF write-protect
MTRR variable ranges enabled:
   0 base 0D0000000 mask FF0000000 uncachable
   1 base 0E0000000 mask FE0000000 uncachable
   2 base 000000000 mask E00000000 write-back
   3 base 200000000 mask FE0000000 write-back
   4 base 220000000 mask FF0000000 write-back
   5 disabled
   6 disabled
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
e820 update range: 00000000d0000000 - 0000000100000000 (usable) ==> 
(reserved)
last_pfn = 0xcfe70 max_arch_pfn = 0x400000000
initial memory mapped : 0 - 20000000
init_memory_mapping: 0000000000000000-00000000cfe70000
  0000000000 - 00cfe00000 page 2M
  00cfe00000 - 00cfe70000 page 4k
kernel direct mapping tables up to cfe70000 @ 10000-16000
init_memory_mapping: 0000000100000000-0000000230000000
  0100000000 - 0230000000 page 2M
kernel direct mapping tables up to 230000000 @ 14000-1e000
ACPI: RSDP 00000000000f6530 00024 (v02 PTLTD )
ACPI: XSDT 00000000cfe73154 000CC (v01 PTLTD  ? XSDT   06040000  LTP 
00000000)
ACPI: FACP 00000000cfe7d307 000F4 (v03 INTEL           06040000 PTL 
00000002)
ACPI: DSDT 00000000cfe76dec 064A7 (v01  INTEL BEARLAKE 06040000 MSFT 
03000001)
ACPI: FACS 00000000cfe80fc0 00040
ACPI: _MAR 00000000cfe7d3fb 0012F (v01 Intel  OEMDMAR  06040000 LOHR 
00000001)
ACPI: MCFG 00000000cfe7d52a 0003C (v01 PTLTD    MCFG   06040000  LTP 
00000000)
ACPI: HPET 00000000cfe7d566 00038 (v01 PTLTD  HPETTBL  06040000  LTP 
00000001)
ACPI: APIC 00000000cfe7d59e 0009C (v01 PTLTD  ? APIC   06040000  LTP 
00000000)
ACPI: BOOT 00000000cfe7d63a 00028 (v01 PTLTD  $SBFTBL$ 06040000  LTP 
00000001)
ACPI: SPCR 00000000cfe7d662 00050 (v01 PTLTD  $UCRTBL$ 06040000 PTL 
00000001)
ACPI: ERST 00000000cfe7d6b2 00590 (v01 SMCI   ERSTTBL  06040000 SMCI 
00000001)
ACPI: HEST 00000000cfe7dc42 000A8 (v01 SMCI   HESTTBL  06040000 SMCI 
00000001)
ACPI: BERT 00000000cfe7dcea 00030 (v01 SMCI   BERTTBL  06040000 SMCI 
00000001)
ACPI: EINJ 00000000cfe7dd1a 00170 (v01 SMCI   EINJTBL  06040000 SMCI 
00000001)
ACPI: SLIC 00000000cfe7de8a 00176 (v01 OEMID_ OEMTABLE 06040000  LTP 
00000000)
ACPI: SSDT 00000000cfe74a93 0025F (v01  PmRef  Cpu0Tst 00003000 INTL 
20050228)
ACPI: SSDT 00000000cfe749ed 000A6 (v01  PmRef  Cpu7Tst 00003000 INTL 
20050228)
ACPI: SSDT 00000000cfe74947 000A6 (v01  PmRef  Cpu6Tst 00003000 INTL 
20050228)
ACPI: SSDT 00000000cfe748a1 000A6 (v01  PmRef  Cpu5Tst 00003000 INTL 
20050228)
ACPI: SSDT 00000000cfe747fb 000A6 (v01  PmRef  Cpu4Tst 00003000 INTL 
20050228)
ACPI: SSDT 00000000cfe74755 000A6 (v01  PmRef  Cpu3Tst 00003000 INTL 
20050228)
ACPI: SSDT 00000000cfe746af 000A6 (v01  PmRef  Cpu2Tst 00003000 INTL 
20050228)
ACPI: SSDT 00000000cfe74609 000A6 (v01  PmRef  Cpu1Tst 00003000 INTL 
20050228)
ACPI: SSDT 00000000cfe73220 013E9 (v01  PmRef    CpuPm 00003000 INTL 
20050228)
ACPI: Local APIC address 0xfee00000
(7 early reservations) ==> bootmem [0000000000 - 0230000000]
   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 
0000001000]
   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 
0000008000]
   #2 [0001000000 - 0001833654]    TEXT DATA BSS ==> [0001000000 - 
0001833654]
   #3 [000009bc00 - 0000100000]    BIOS reserved ==> [000009bc00 - 
0000100000]
   #4 [0001834000 - 00018341a4]              BRK ==> [0001834000 - 
00018341a4]
   #5 [0000010000 - 0000014000]          PGTABLE ==> [0000010000 - 
0000014000]
   #6 [0000014000 - 0000019000]          PGTABLE ==> [0000014000 - 
0000019000]
found SMP MP-table at [ffff8800000f6560] f6560
  [ffffea0000000000-ffffea0007bfffff] PMD -> 
[ffff880028600000-ffff88002f7fffff] on node 0
Zone PFN ranges:
   DMA      0x00000010 -> 0x00001000
   DMA32    0x00001000 -> 0x00100000
   Normal   0x00100000 -> 0x00230000
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
     0: 0x00000010 -> 0x0000009b
     0: 0x00000100 -> 0x000cfe70
     0: 0x00100000 -> 0x00230000
On node 0 totalpages: 2096635
   DMA zone: 56 pages used for memmap
   DMA zone: 112 pages reserved
   DMA zone: 3811 pages, LIFO batch:0
   DMA32 zone: 14280 pages used for memmap
   DMA32 zone: 833192 pages, LIFO batch:31
   Normal zone: 17024 pages used for memmap
   Normal zone: 1228160 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0xfecc0000] gsi_base[24])
IOAPIC[1]: apic_id 5, version 32, address 0xfecc0000, GSI 24-47
ACPI: IOAPIC (id[0x06] address[0xfecc0400] gsi_base[48])
IOAPIC[2]: apic_id 6, version 32, address 0xfecc0400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0xffffffff base: 0xfed00000
SMP: Allowing 4 CPUs, 0 hotplug CPUs
nr_irqs_gsi: 72
Allocating PCI resources starting at d0000000 (gap: d0000000:10000000)
NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr_node_ids:1
PERCPU: Embedded 27 pages/cpu @ffff880028200000 s79768 r8192 d22632 u524288
pcpu-alloc: s79768 r8192 d22632 u524288 alloc=1*2097152
pcpu-alloc: [0] 0 1 2 3
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2065163
Kernel command line: BOOT_IMAGE=Linux ro root=805 vt.default_utf8=0 
netconsole=6665@192.168.11.9/eth1,6666@192.168.11.23/00:50:da:b7:ce:39
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Initializing CPU#0
xsave/xrstor: enabled xstate_bv 0x3, cntxt size 0x240
Checking aperture...
No AGP bridge found
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing 64MB software IO TLB between ffff880020000000 - ffff880024000000
software IO TLB at phys 0x20000000 - 0x24000000
Memory: 8181488k/9175040k available (4667k kernel code, 788500k absent, 
204116k reserved, 2447k data, 464k init)
Hierarchical RCU implementation.
NR_IRQS:512
Extended CMOS year: 2000
Console: colour VGA+ 80x50
console [tty0] enabled
hpet clockevent registered
HPET: 4 timers in total, 0 timers will be used for per-cpu timer
Fast TSC calibration using PIT
Detected 2825.893 MHz processor.
Calibrating delay loop (skipped), value calculated using timer 
frequency.. 5651.78 BogoMIPS (lpj=2825893)
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 6144K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 6 MCE banks
CPU0: Thermal monitoring handled by SMI
using mwait in idle threads.
Performance Events: Core2 events, Intel PMU driver.
... version:                2
... bit width:              40
... generic registers:      2
... value mask:             000000ffffffffff
... max period:             000000007fffffff
... fixed-purpose events:   3
... event mask:             0000000700000003
ACPI: Core revision 20090903
Setting APIC routing to flat
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: Intel(R) Core(TM)2 Quad CPU    Q9550  @ 2.83GHz stepping 0a
Booting processor 1 APIC 0x1 ip 0x6000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5652.46 BogoMIPS 
(lpj=2826230)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 6144K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring handled by SMI
CPU1: Intel(R) Core(TM)2 Quad CPU    Q9550  @ 2.83GHz stepping 0a
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Booting processor 2 APIC 0x2 ip 0x6000
Initializing CPU#2
Calibrating delay using timer specific routine.. 5652.48 BogoMIPS 
(lpj=2826240)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 6144K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 2
CPU2: Thermal monitoring handled by SMI
CPU2: Intel(R) Core(TM)2 Quad CPU    Q9550  @ 2.83GHz stepping 0a
checking TSC synchronization [CPU#0 -> CPU#2]: passed.
Booting processor 3 APIC 0x3 ip 0x6000
Initializing CPU#3
Calibrating delay using timer specific routine.. 5652.48 BogoMIPS 
(lpj=2826242)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 6144K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 3
CPU3: Thermal monitoring handled by SMI
CPU3: Intel(R) Core(TM)2 Quad CPU    Q9550  @ 2.83GHz stepping 0a
checking TSC synchronization [CPU#0 -> CPU#3]: passed.
Brought up 4 CPUs
Total of 4 processors activated (22609.21 BogoMIPS).
xor: automatically using best checksumming function: generic_sse
    generic_sse: 10784.000 MB/sec
xor: using function: generic_sse (10784.000 MB/sec)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 16
PCI: MCFG area at e0000000 reserved in E820
PCI: Using MMCONFIG at e0000000 - e10fffff
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: No dock devices found.
ACPI Warning for \_SB_.PCI0._OSC: Return type mismatch - found Integer, 
expected Buffer (20090903/nspredef-1006)
_OSC evaluation returned wrong type
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:01.0: PME# disabled
pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
pci 0000:00:06.0: PME# disabled
pci 0000:00:1a.0: reg 20 io port: [0x1820-0x183f]
pci 0000:00:1a.1: reg 20 io port: [0x1840-0x185f]
pci 0000:00:1a.2: reg 20 io port: [0x1860-0x187f]
pci 0000:00:1a.7: reg 10 32bit mmio: [0xd0000000-0xd00003ff]
pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1a.7: PME# disabled
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: PME# disabled
pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.4: PME# disabled
pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.5: PME# disabled
pci 0000:00:1d.0: reg 20 io port: [0x1880-0x189f]
pci 0000:00:1d.1: reg 20 io port: [0x18a0-0x18bf]
pci 0000:00:1d.2: reg 20 io port: [0x18c0-0x18df]
pci 0000:00:1d.7: reg 10 32bit mmio: [0xd0000400-0xd00007ff]
pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.7: PME# disabled
pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 1180-11bf claimed by ICH6 GPIO
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0290 (mask 0097)
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 0ca0 (mask 00af)
pci 0000:00:1f.2: reg 10 io port: [0x1c50-0x1c57]
pci 0000:00:1f.2: reg 14 io port: [0x1c44-0x1c47]
pci 0000:00:1f.2: reg 18 io port: [0x1c48-0x1c4f]
pci 0000:00:1f.2: reg 1c io port: [0x1c40-0x1c43]
pci 0000:00:1f.2: reg 20 io port: [0x18e0-0x18ff]
pci 0000:00:1f.2: reg 24 32bit mmio: [0xd0000800-0xd0000fff]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.2: PME# disabled
pci 0000:00:1f.3: reg 10 64bit mmio: [0xd0001000-0xd00010ff]
pci 0000:00:1f.3: reg 20 io port: [0x1100-0x111f]
pci 0000:00:1f.6: reg 10 64bit mmio: [0xd0002000-0xd0002fff]
pci 0000:01:00.0: PXH quirk detected; SHPC device MSI disabled
pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
pci 0000:01:00.0: PME# disabled
pci 0000:01:00.1: reg 10 32bit mmio: [0xd0100000-0xd0100fff]
pci 0000:01:00.2: PXH quirk detected; SHPC device MSI disabled
pci 0000:01:00.2: PME# supported from D0 D3hot D3cold
pci 0000:01:00.2: PME# disabled
pci 0000:01:00.3: reg 10 32bit mmio: [0xd0101000-0xd0101fff]
pci 0000:00:01.0: bridge io port: [0x2000-0x3fff]
pci 0000:00:01.0: bridge 32bit mmio: [0xd0100000-0xd13fffff]
pci 0000:02:01.0: reg 10 64bit mmio: [0xd0200000-0xd02fffff]
pci 0000:02:01.0: reg 18 io port: [0x2000-0x20ff]
pci 0000:02:01.0: reg 1c 64bit mmio: [0xd0400000-0xd07fffff]
pci 0000:02:01.0: reg 30 32bit mmio pref: [0x000000-0x3fffff]
pci 0000:01:00.0: bridge io port: [0x2000-0x2fff]
pci 0000:01:00.0: bridge 32bit mmio: [0xd0200000-0xd07fffff]
pci 0000:03:01.0: reg 10 64bit mmio: [0xd0c00000-0xd0cfffff]
pci 0000:03:01.0: reg 18 io port: [0x3000-0x30ff]
pci 0000:03:01.0: reg 1c 64bit mmio: [0xd0800000-0xd0bfffff]
pci 0000:03:01.0: reg 30 32bit mmio pref: [0x000000-0x3fffff]
pci 0000:03:02.0: reg 10 64bit mmio: [0xd0d00000-0xd0dfffff]
pci 0000:03:02.0: reg 18 io port: [0x3400-0x34ff]
pci 0000:03:02.0: reg 1c 64bit mmio: [0xd1000000-0xd13fffff]
pci 0000:03:02.0: reg 30 32bit mmio pref: [0x000000-0x3fffff]
pci 0000:01:00.2: bridge io port: [0x3000-0x3fff]
pci 0000:01:00.2: bridge 32bit mmio: [0xd0800000-0xd13fffff]
pci 0000:04:00.0: reg 10 32bit mmio: [0xd1420000-0xd143ffff]
pci 0000:04:00.0: reg 14 32bit mmio: [0xd1600000-0xd17fffff]
pci 0000:04:00.0: reg 18 io port: [0x4000-0x401f]
pci 0000:04:00.0: reg 1c 32bit mmio: [0xd1400000-0xd1403fff]
pci 0000:04:00.0: reg 30 32bit mmio pref: [0x000000-0x1fffff]
pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
pci 0000:04:00.0: PME# disabled
pci 0000:04:00.1: reg 10 32bit mmio: [0xd1440000-0xd145ffff]
pci 0000:04:00.1: reg 14 32bit mmio: [0xd1800000-0xd19fffff]
pci 0000:04:00.1: reg 18 io port: [0x4020-0x403f]
pci 0000:04:00.1: reg 1c 32bit mmio: [0xd1404000-0xd1407fff]
pci 0000:04:00.1: reg 30 32bit mmio pref: [0x000000-0x1fffff]
pci 0000:04:00.1: PME# supported from D0 D3hot D3cold
pci 0000:04:00.1: PME# disabled
pci 0000:00:06.0: bridge io port: [0x4000-0x4fff]
pci 0000:00:06.0: bridge 32bit mmio: [0xd1400000-0xd19fffff]
pci 0000:0d:00.0: reg 10 32bit mmio: [0xd1a00000-0xd1a1ffff]
pci 0000:0d:00.0: reg 18 io port: [0x5000-0x501f]
pci 0000:0d:00.0: PME# supported from D0 D3hot D3cold
pci 0000:0d:00.0: PME# disabled
pci 0000:00:1c.4: bridge io port: [0x5000-0x5fff]
pci 0000:00:1c.4: bridge 32bit mmio: [0xd1a00000-0xd1afffff]
pci 0000:0f:00.0: reg 10 32bit mmio: [0xd1b00000-0xd1b1ffff]
pci 0000:0f:00.0: reg 18 io port: [0x6000-0x601f]
pci 0000:0f:00.0: PME# supported from D0 D3hot D3cold
pci 0000:0f:00.0: PME# disabled
pci 0000:00:1c.5: bridge io port: [0x6000-0x6fff]
pci 0000:00:1c.5: bridge 32bit mmio: [0xd1b00000-0xd1bfffff]
pci 0000:11:04.0: reg 10 32bit mmio pref: [0xd8000000-0xdfffffff]
pci 0000:11:04.0: reg 14 io port: [0x7000-0x70ff]
pci 0000:11:04.0: reg 18 32bit mmio: [0xd1c00000-0xd1c0ffff]
pci 0000:11:04.0: reg 30 32bit mmio pref: [0x000000-0x01ffff]
pci 0000:11:04.0: supports D1 D2
pci 0000:00:1e.0: transparent bridge
pci 0000:00:1e.0: bridge io port: [0x7000-0x7fff]
pci 0000:00:1e.0: bridge 32bit mmio: [0xd1c00000-0xd1cfffff]
pci 0000:00:1e.0: bridge 64bit mmio pref: [0xd8000000-0xdfffffff]
pci_bus 0000:00: on NUMA node 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEG_.PXHA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEG_.PXHB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP6._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
_OSC evaluation returned wrong type
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
vgaarb: device added: PCI:0000:11:04.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
raid6: int64x1   2253 MB/s
raid6: int64x2   2980 MB/s
raid6: int64x4   3125 MB/s
raid6: int64x8   2046 MB/s
raid6: sse2x1    4632 MB/s
raid6: sse2x2    5191 MB/s
raid6: sse2x4    8136 MB/s
raid6: using algorithm sse2x4 (8136 MB/s)
PCI: Using ACPI for IRQ routing
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
hpet0: 4 comparators, 64-bit 14.318180 MHz counter
Switching to clocksource tsc
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
system 00:01: ioport range 0x295-0x296 has been reserved
system 00:01: ioport range 0x800-0x80f has been reserved
system 00:01: ioport range 0x1000-0x107f has been reserved
system 00:01: ioport range 0x1180-0x11bf has been reserved
system 00:01: ioport range 0x4d0-0x4d1 has been reserved
system 00:01: ioport range 0xfe00-0xfe00 has been reserved
system 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
system 00:01: iomem range 0xe0000000-0xefffffff has been reserved
system 00:01: iomem range 0xfef00000-0xfeffffff has been reserved
pci 0000:01:00.0: PCI bridge, secondary bus 0000:02
pci 0000:01:00.0:   IO window: 0x2000-0x2fff
pci 0000:01:00.0:   MEM window: 0xd0200000-0xd07fffff
pci 0000:01:00.0:   PREFETCH window: 0xd2000000-0xd23fffff
pci 0000:01:00.2: PCI bridge, secondary bus 0000:03
pci 0000:01:00.2:   IO window: 0x3000-0x3fff
pci 0000:01:00.2:   MEM window: 0xd0800000-0xd13fffff
pci 0000:01:00.2:   PREFETCH window: 0xd2400000-0xd2bfffff
pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
pci 0000:00:01.0:   IO window: 0x2000-0x3fff
pci 0000:00:01.0:   MEM window: 0xd0100000-0xd13fffff
pci 0000:00:01.0:   PREFETCH window: 0xd2000000-0xd2bfffff
pci 0000:00:06.0: PCI bridge, secondary bus 0000:04
pci 0000:00:06.0:   IO window: 0x4000-0x4fff
pci 0000:00:06.0:   MEM window: 0xd1400000-0xd19fffff
pci 0000:00:06.0:   PREFETCH window: 0xd2c00000-0xd2ffffff
pci 0000:00:1c.0: PCI bridge, secondary bus 0000:05
pci 0000:00:1c.0:   IO window: 0x8000-0x8fff
pci 0000:00:1c.0:   MEM window: 0xd1d00000-0xd1efffff
pci 0000:00:1c.0:   PREFETCH window: 0x000000d3000000-0x000000d31fffff
pci 0000:00:1c.4: PCI bridge, secondary bus 0000:0d
pci 0000:00:1c.4:   IO window: 0x5000-0x5fff
pci 0000:00:1c.4:   MEM window: 0xd1a00000-0xd1afffff
pci 0000:00:1c.4:   PREFETCH window: 0x000000d3200000-0x000000d33fffff
pci 0000:00:1c.5: PCI bridge, secondary bus 0000:0f
pci 0000:00:1c.5:   IO window: 0x6000-0x6fff
pci 0000:00:1c.5:   MEM window: 0xd1b00000-0xd1bfffff
pci 0000:00:1c.5:   PREFETCH window: 0x000000d3400000-0x000000d35fffff
pci 0000:00:1e.0: PCI bridge, secondary bus 0000:11
pci 0000:00:1e.0:   IO window: 0x7000-0x7fff
pci 0000:00:1e.0:   MEM window: 0xd1c00000-0xd1cfffff
pci 0000:00:1e.0:   PREFETCH window: 0x000000d8000000-0x000000dfffffff
pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:01.0: setting latency timer to 64
pci 0000:01:00.0: setting latency timer to 64
pci 0000:01:00.2: setting latency timer to 64
pci 0000:00:06.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:06.0: setting latency timer to 64
pci 0000:00:1c.0: enabling device (0040 -> 0043)
pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:1c.0: setting latency timer to 64
pci 0000:00:1c.4: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:1c.4: setting latency timer to 64
pci 0000:00:1c.5: PCI INT B -> GSI 17 (level, low) -> IRQ 17
pci 0000:00:1c.5: setting latency timer to 64
pci 0000:00:1e.0: setting latency timer to 64
pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
pci_bus 0000:01: resource 0 io:  [0x2000-0x3fff]
pci_bus 0000:01: resource 1 mem: [0xd0100000-0xd13fffff]
pci_bus 0000:01: resource 2 pref mem [0xd2000000-0xd2bfffff]
pci_bus 0000:02: resource 0 io:  [0x2000-0x2fff]
pci_bus 0000:02: resource 1 mem: [0xd0200000-0xd07fffff]
pci_bus 0000:02: resource 2 pref mem [0xd2000000-0xd23fffff]
pci_bus 0000:03: resource 0 io:  [0x3000-0x3fff]
pci_bus 0000:03: resource 1 mem: [0xd0800000-0xd13fffff]
pci_bus 0000:03: resource 2 pref mem [0xd2400000-0xd2bfffff]
pci_bus 0000:04: resource 0 io:  [0x4000-0x4fff]
pci_bus 0000:04: resource 1 mem: [0xd1400000-0xd19fffff]
pci_bus 0000:04: resource 2 pref mem [0xd2c00000-0xd2ffffff]
pci_bus 0000:05: resource 0 io:  [0x8000-0x8fff]
pci_bus 0000:05: resource 1 mem: [0xd1d00000-0xd1efffff]
pci_bus 0000:05: resource 2 pref mem [0xd3000000-0xd31fffff]
pci_bus 0000:0d: resource 0 io:  [0x5000-0x5fff]
pci_bus 0000:0d: resource 1 mem: [0xd1a00000-0xd1afffff]
pci_bus 0000:0d: resource 2 pref mem [0xd3200000-0xd33fffff]
pci_bus 0000:0f: resource 0 io:  [0x6000-0x6fff]
pci_bus 0000:0f: resource 1 mem: [0xd1b00000-0xd1bfffff]
pci_bus 0000:0f: resource 2 pref mem [0xd3400000-0xd35fffff]
pci_bus 0000:11: resource 0 io:  [0x7000-0x7fff]
pci_bus 0000:11: resource 1 mem: [0xd1c00000-0xd1cfffff]
pci_bus 0000:11: resource 2 pref mem [0xd8000000-0xdfffffff]
pci_bus 0000:11: resource 3 io:  [0x00-0xffff]
pci_bus 0000:11: resource 4 mem: [0x000000-0xffffffffffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
pci 0000:04:00.0: Disabling L0s
pci 0000:04:00.1: Disabling L0s
pci 0000:11:04.0: Boot video device
Simple Boot Flag at 0x36 set to 0x80
HugeTLB registered 2 MB page size, pre-allocated 0 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Slow work thread pool: Starting up
Slow work thread pool: Ready
SGI XFS with security attributes, large block/inode numbers, no debug 
enabled
msgmni has been set to 15981
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
pcieport 0000:00:01.0: irq 72 for MSI/MSI-X
pcieport 0000:00:01.0: setting latency timer to 64
pcieport 0000:00:06.0: irq 73 for MSI/MSI-X
pcieport 0000:00:06.0: setting latency timer to 64
pcieport 0000:00:1c.0: irq 74 for MSI/MSI-X
pcieport 0000:00:1c.0: setting latency timer to 64
pcieport 0000:00:1c.4: irq 75 for MSI/MSI-X
pcieport 0000:00:1c.4: setting latency timer to 64
pcieport 0000:00:1c.5: irq 76 for MSI/MSI-X
pcieport 0000:00:1c.5: setting latency timer to 64
input: Power Button as /class/input/input0
ACPI: Power Button [PWRB]
input: Power Button as /class/input/input1
ACPI: Power Button [PWRF]
ACPI: SSDT 00000000cfe755ad 00261 (v01  PmRef  Cpu0Ist 00003000 INTL 
20050228)
ACPI: SSDT 00000000cfe74cf2 00518 (v01  PmRef  Cpu0Cst 00003001 INTL 
20050228)
Monitor-Mwait will be used to enter C-1 state
processor LNXCPU:00: registered as cooling_device0
ACPI: SSDT 00000000cfe7580e 001F2 (v01  PmRef  Cpu1Ist 00003000 INTL 
20050228)
ACPI: SSDT 00000000cfe7520a 00085 (v01  PmRef  Cpu1Cst 00003000 INTL 
20050228)
processor LNXCPU:01: registered as cooling_device1
ACPI: SSDT 00000000cfe75a00 001F2 (v01  PmRef  Cpu2Ist 00003000 INTL 
20050228)
ACPI: SSDT 00000000cfe7528f 00085 (v01  PmRef  Cpu2Cst 00003000 INTL 
20050228)
processor LNXCPU:02: registered as cooling_device2
ACPI: SSDT 00000000cfe75bf2 001F2 (v01  PmRef  Cpu3Ist 00003000 INTL 
20050228)
ACPI: SSDT 00000000cfe75314 00085 (v01  PmRef  Cpu3Cst 00003000 INTL 
20050228)
processor LNXCPU:03: registered as cooling_device3
Linux agpgart interface v0.103
ipmi message handler version 39.2
ipmi device interface
IPMI System Interface driver.
ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca2, 
slave address 0x20, irq 0
ipmi: Found new BMC (man_id: 0x0028c5,  prod_id: 0x0004, dev_id: 0x22)
IPMI kcs interface initialized
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
floppy0: no floppy controllers found
brd: module loaded
loop: module loaded
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
ahci 0000:00:1f.2: irq 77 for MSI/MSI-X
ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA 
mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pmp pio slum part ccc 
ems sxs
ahci 0000:00:1f.2: setting latency timer to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
ata1: SATA max UDMA/133 irq_stat 0x00400040, connection status changed 
irq 77
ata2: SATA max UDMA/133 irq_stat 0x00400040, connection status changed
ata3: SATA max UDMA/133 irq_stat 0x00400040, connection status changed
ata4: SATA max UDMA/133 irq_stat 0x00400040, connection status changed
ata5: SATA max UDMA/133 irq_stat 0x00400040, connection status changed
ata6: SATA max UDMA/133 irq_stat 0x00400040, connection status changed
sata_mv 0000:02:01.0: version 1.28
sata_mv 0000:02:01.0: PCI INT A -> GSI 24 (level, low) -> IRQ 24
sata_mv 0000:02:01.0: Gen-II 32 slots 8 ports SCSI mode IRQ via INTx
scsi6 : sata_mv
scsi7 : sata_mv
scsi8 : sata_mv
scsi9 : sata_mv
scsi10 : sata_mv
scsi11 : sata_mv
scsi12 : sata_mv
scsi13 : sata_mv
ata7: SATA max UDMA/133 mmio m1048576@0xd0200000 port 0xd0222000 irq 24
ata8: SATA max UDMA/133 mmio m1048576@0xd0200000 port 0xd0224000 irq 24
ata9: SATA max UDMA/133 mmio m1048576@0xd0200000 port 0xd0226000 irq 24
ata10: SATA max UDMA/133 mmio m1048576@0xd0200000 port 0xd0228000 irq 24
ata11: SATA max UDMA/133 mmio m1048576@0xd0200000 port 0xd0232000 irq 24
ata12: SATA max UDMA/133 mmio m1048576@0xd0200000 port 0xd0234000 irq 24
ata13: SATA max UDMA/133 mmio m1048576@0xd0200000 port 0xd0236000 irq 24
ata14: SATA max UDMA/133 mmio m1048576@0xd0200000 port 0xd0238000 irq 24
sata_mv 0000:03:01.0: PCI INT A -> GSI 48 (level, low) -> IRQ 48
sata_mv 0000:03:01.0: Gen-II 32 slots 8 ports SCSI mode IRQ via INTx
scsi14 : sata_mv
scsi15 : sata_mv
scsi16 : sata_mv
scsi17 : sata_mv
scsi18 : sata_mv
scsi19 : sata_mv
scsi20 : sata_mv
scsi21 : sata_mv
ata15: SATA max UDMA/133 mmio m1048576@0xd0c00000 port 0xd0c22000 irq 48
ata16: SATA max UDMA/133 mmio m1048576@0xd0c00000 port 0xd0c24000 irq 48
ata17: SATA max UDMA/133 mmio m1048576@0xd0c00000 port 0xd0c26000 irq 48
ata18: SATA max UDMA/133 mmio m1048576@0xd0c00000 port 0xd0c28000 irq 48
ata19: SATA max UDMA/133 mmio m1048576@0xd0c00000 port 0xd0c32000 irq 48
ata20: SATA max UDMA/133 mmio m1048576@0xd0c00000 port 0xd0c34000 irq 48
ata21: SATA max UDMA/133 mmio m1048576@0xd0c00000 port 0xd0c36000 irq 48
ata22: SATA max UDMA/133 mmio m1048576@0xd0c00000 port 0xd0c38000 irq 48
sata_mv 0000:03:02.0: PCI INT A -> GSI 52 (level, low) -> IRQ 52
sata_mv 0000:03:02.0: Gen-II 32 slots 8 ports SCSI mode IRQ via INTx
scsi22 : sata_mv
scsi23 : sata_mv
scsi24 : sata_mv
scsi25 : sata_mv
scsi26 : sata_mv
scsi27 : sata_mv
scsi28 : sata_mv
scsi29 : sata_mv
ata23: SATA max UDMA/133 mmio m1048576@0xd0d00000 port 0xd0d22000 irq 52
ata24: SATA max UDMA/133 mmio m1048576@0xd0d00000 port 0xd0d24000 irq 52
ata25: SATA max UDMA/133 mmio m1048576@0xd0d00000 port 0xd0d26000 irq 52
ata26: SATA max UDMA/133 mmio m1048576@0xd0d00000 port 0xd0d28000 irq 52
ata27: SATA max UDMA/133 mmio m1048576@0xd0d00000 port 0xd0d32000 irq 52
ata28: SATA max UDMA/133 mmio m1048576@0xd0d00000 port 0xd0d34000 irq 52
ata29: SATA max UDMA/133 mmio m1048576@0xd0d00000 port 0xd0d36000 irq 52
ata30: SATA max UDMA/133 mmio m1048576@0xd0d00000 port 0xd0d38000 irq 52
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
netconsole: local port 6665
netconsole: local IP 192.168.11.9
netconsole: interface eth1
netconsole: remote port 6666
netconsole: remote IP 192.168.11.23
netconsole: remote ethernet address 00:50:da:b7:ce:39
netconsole: eth1 doesn't exist, aborting.
netconsole: cleaning up
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
ehci_hcd 0000:00:1a.7: setting latency timer to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.7: debug port 1
ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xd0000000
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
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xd0000400
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
uhci_hcd: USB Universal Host Controller Interface driver
uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1a.0: setting latency timer to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 16, io base 0x00001820
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
uhci_hcd 0000:00:1a.1: setting latency timer to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 17, io base 0x00001840
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1a.2: setting latency timer to 64
uhci_hcd 0000:00:1a.2: UHCI Host Controller
uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1a.2: irq 18, io base 0x00001860
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001880
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 22 (level, low) -> IRQ 22
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.1: irq 22, io base 0x000018a0
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
uhci_hcd 0000:00:1d.2: irq 18, io base 0x000018c0
usb usb8: configuration #1 chosen from 1 choice
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 2 ports detected
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
Driver 'rtc_cmos' needs updating - please use bus_type methods
rtc_cmos 00:05: RTC can wake from S4
rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
md: multipath personality registered for level -4
device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: 
dm-devel@redhat.com
cpuidle: using governor ladder
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
oprofile: using NMI interrupt.
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
nf_conntrack.acct=1 kernel parameter, acct=1 nf_conntrack module option or
sysctl net.netfilter.nf_conntrack_acct=1 to enable it.
xt_time: kernel timezone is -0000
ip_tables: (C) 2000-2006 Netfilter Core Team
ClusterIP Version 0.8 loaded successfully
TCP cubic registered
NET: Registered protocol family 17
rtc_cmos 00:05: setting system clock to 2010-10-09 15:03:24 UTC (1286636604)
ata15: SATA link down (SStatus 0 SControl 300)
usb 1-1: new high speed USB device using ehci_hcd and address 2
usb 1-1: configuration #1 chosen from 1 choice
ata23: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata23.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata23.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata23.00: configured for UDMA/133
usb 1-5: new high speed USB device using ehci_hcd and address 3
usb 1-5: configuration #1 chosen from 1 choice
input: Peppercon AG Multidevice as /class/input/input2
generic-usb 0003:14DD:0002.0001: input: USB HID v1.01 Mouse [Peppercon 
AG Multidevice] on usb-0000:00:1a.7-5/input0
input: Peppercon AG Multidevice as /class/input/input3
generic-usb 0003:14DD:0002.0002: input: USB HID v1.01 Keyboard 
[Peppercon AG Multidevice] on usb-0000:00:1a.7-5/input1
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7: WDC WD800AAJS-22PSA0, 05.06H05, max UDMA/133
ata6.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata6.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata1.00: 156301488 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata6.00: configured for UDMA/133
ata2.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata1.00: configured for UDMA/133
ata3.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata3.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
scsi 0:0:0:0: Direct-Access     ATA      WDC WD800AAJS-22 05.0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sda:
ata2.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata3.00: configured for UDMA/133
ata4.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata4.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata2.00: configured for UDMA/133
scsi 1:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 1:0:0:0: [sdb] Write Protect is off
ata4.00: configured for UDMA/133
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 1:0:0:0: Attached scsi generic sg1 type 0
  sdb:
scsi 2:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdc] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 2:0:0:0: Attached scsi generic sg2 type 0
scsi 3:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdd] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 3:0:0:0: Attached scsi generic sg3 type 0
  sdd:
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdc: sda1 sda2 sda3 < sdb1
  sdc1
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 2:0:0:0: [sdc] Attached SCSI disk
  sdd1
sd 3:0:0:0: [sdd] Attached SCSI disk
  sda5 sda6
ata5.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata5.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata5.00: configured for UDMA/133
scsi 4:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 ANSI: 5
sd 4:0:0:0: [sde] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 4:0:0:0: Attached scsi generic sg4 type 0
scsi 5:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 ANSI: 5
sd 5:0:0:0: [sdf] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 5:0:0:0: [sdf] Write Protect is off
sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:0:0:0: Attached scsi generic sg5 type 0
  sdf:
sd 4:0:0:0: [sde] Write Protect is off
sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sde: sda7 sde1
sd 4:0:0:0: [sde] Attached SCSI disk
  sdf1
sd 5:0:0:0: [sdf] Attached SCSI disk
  sda8 sda9 >
sd 0:0:0:0: [sda] Attached SCSI disk
ata7: link is slow to respond, please be patient (ready=0)
ata7: SRST failed (errno=-16)
ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata7.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata7.00: configured for UDMA/133
scsi 6:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 ANSI: 5
sd 6:0:0:0: [sdg] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 6:0:0:0: Attached scsi generic sg6 type 0
sd 6:0:0:0: [sdg] Write Protect is off
sd 6:0:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 6:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdg: sdg1
sd 6:0:0:0: [sdg] Attached SCSI disk
ata8: link is slow to respond, please be patient (ready=0)
ata8: SRST failed (errno=-16)
ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata8.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata8.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata8.00: configured for UDMA/133
scsi 7:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 ANSI: 5
sd 7:0:0:0: [sdh] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 7:0:0:0: [sdh] Write Protect is off
sd 7:0:0:0: Attached scsi generic sg7 type 0
sd 7:0:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 7:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdh: sdh1
sd 7:0:0:0: [sdh] Attached SCSI disk
ata9: link is slow to respond, please be patient (ready=0)
ata9: SRST failed (errno=-16)
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata9.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata9.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata9.00: configured for UDMA/133
scsi 8:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 ANSI: 5
sd 8:0:0:0: [sdi] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 8:0:0:0: Attached scsi generic sg8 type 0
sd 8:0:0:0: [sdi] Write Protect is off
sd 8:0:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 8:0:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdi: sdi1
sd 8:0:0:0: [sdi] Attached SCSI disk
ata10: link is slow to respond, please be patient (ready=0)
ata10: SRST failed (errno=-16)
ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata10.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata10.00: configured for UDMA/133
scsi 9:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 ANSI: 5
sd 9:0:0:0: [sdj] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 9:0:0:0: Attached scsi generic sg9 type 0
sd 9:0:0:0: [sdj] Write Protect is off
sd 9:0:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 9:0:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdj: sdj1
sd 9:0:0:0: [sdj] Attached SCSI disk
ata11: link is slow to respond, please be patient (ready=0)
ata11: SRST failed (errno=-16)
ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata11.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata11.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata11.00: configured for UDMA/133
scsi 10:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 
ANSI: 5
sd 10:0:0:0: [sdk] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 10:0:0:0: Attached scsi generic sg10 type 0
sd 10:0:0:0: [sdk] Write Protect is off
sd 10:0:0:0: [sdk] Mode Sense: 00 3a 00 00
sd 10:0:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdk: sdk1
sd 10:0:0:0: [sdk] Attached SCSI disk
ata12: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata12.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata12.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata12.00: configured for UDMA/133
scsi 11:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 
ANSI: 5
sd 11:0:0:0: [sdl] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 11:0:0:0: Attached scsi generic sg11 type 0
sd 11:0:0:0: [sdl] Write Protect is off
sd 11:0:0:0: [sdl] Mode Sense: 00 3a 00 00
sd 11:0:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdl: sdl1
sd 11:0:0:0: [sdl] Attached SCSI disk
ata13: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata13.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata13.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata13.00: configured for UDMA/133
scsi 12:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 
ANSI: 5
sd 12:0:0:0: [sdm] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 12:0:0:0: Attached scsi generic sg12 type 0
sd 12:0:0:0: [sdm] Write Protect is off
sd 12:0:0:0: [sdm] Mode Sense: 00 3a 00 00
sd 12:0:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdm: sdm1
sd 12:0:0:0: [sdm] Attached SCSI disk
ata14: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata14.00: ATA-8: SAMSUNG HD204UI, 1AQ10001, max UDMA/133
ata14.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata14.00: configured for UDMA/133
scsi 13:0:0:0: Direct-Access     ATA      SAMSUNG HD204UI  1AQ1 PQ: 0 
ANSI: 5
sd 13:0:0:0: [sdn] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 13:0:0:0: Attached scsi generic sg13 type 0
sd 13:0:0:0: [sdn] Write Protect is off
sd 13:0:0:0: [sdn] Mode Sense: 00 3a 00 00
sd 13:0:0:0: [sdn] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdn: unknown partition table
sd 13:0:0:0: [sdn] Attached SCSI disk
ata16: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata16.00: ATA-8: SAMSUNG HD204UI, 1AQ10001, max UDMA/133
ata16.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata16.00: configured for UDMA/133
scsi 15:0:0:0: Direct-Access     ATA      SAMSUNG HD204UI  1AQ1 PQ: 0 
ANSI: 5
sd 15:0:0:0: [sdo] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 15:0:0:0: Attached scsi generic sg14 type 0
sd 15:0:0:0: [sdo] Write Protect is off
sd 15:0:0:0: [sdo] Mode Sense: 00 3a 00 00
sd 15:0:0:0: [sdo] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdo: unknown partition table
sd 15:0:0:0: [sdo] Attached SCSI disk
ata17: SATA link down (SStatus 0 SControl 300)
ata18: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata18.00: ATA-8: SAMSUNG HD204UI, 1AQ10001, max UDMA/133
ata18.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata18.00: configured for UDMA/133
scsi 17:0:0:0: Direct-Access     ATA      SAMSUNG HD204UI  1AQ1 PQ: 0 
ANSI: 5
sd 17:0:0:0: [sdp] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 17:0:0:0: Attached scsi generic sg15 type 0
sd 17:0:0:0: [sdp] Write Protect is off
sd 17:0:0:0: [sdp] Mode Sense: 00 3a 00 00
sd 17:0:0:0: [sdp] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdp: unknown partition table
sd 17:0:0:0: [sdp] Attached SCSI disk
ata19: SATA link down (SStatus 0 SControl 300)
ata20: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata20.00: ATA-8: SAMSUNG HD204UI, 1AQ10001, max UDMA/133
ata20.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata20.00: configured for UDMA/133
scsi 19:0:0:0: Direct-Access     ATA      SAMSUNG HD204UI  1AQ1 PQ: 0 
ANSI: 5
sd 19:0:0:0: [sdq] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 19:0:0:0: Attached scsi generic sg16 type 0
sd 19:0:0:0: [sdq] Write Protect is off
sd 19:0:0:0: [sdq] Mode Sense: 00 3a 00 00
sd 19:0:0:0: [sdq] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdq: unknown partition table
sd 19:0:0:0: [sdq] Attached SCSI disk
ata21: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata21.00: ATA-8: SAMSUNG HD204UI, 1AQ10001, max UDMA/133
ata21.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata21.00: configured for UDMA/133
scsi 20:0:0:0: Direct-Access     ATA      SAMSUNG HD204UI  1AQ1 PQ: 0 
ANSI: 5
sd 20:0:0:0: [sdr] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 20:0:0:0: Attached scsi generic sg17 type 0
sd 20:0:0:0: [sdr] Write Protect is off
sd 20:0:0:0: [sdr] Mode Sense: 00 3a 00 00
sd 20:0:0:0: [sdr] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdr: unknown partition table
sd 20:0:0:0: [sdr] Attached SCSI disk
ata22: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata22.00: ATA-8: SAMSUNG HD204UI, 1AQ10001, max UDMA/133
ata22.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata22.00: configured for UDMA/133
scsi 21:0:0:0: Direct-Access     ATA      SAMSUNG HD204UI  1AQ1 PQ: 0 
ANSI: 5
sd 21:0:0:0: [sds] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
sd 21:0:0:0: Attached scsi generic sg18 type 0
scsi 22:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 
ANSI: 5
sd 22:0:0:0: [sdt] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 22:0:0:0: [sdt] Write Protect is off
sd 22:0:0:0: [sdt] Mode Sense: 00 3a 00 00
sd 22:0:0:0: [sdt] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 22:0:0:0: Attached scsi generic sg19 type 0
  sdt:
sd 21:0:0:0: [sds] Write Protect is off
sd 21:0:0:0: [sds] Mode Sense: 00 3a 00 00
sd 21:0:0:0: [sds] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sds: sdt1
sd 22:0:0:0: [sdt] Attached SCSI disk
  unknown partition table
sd 21:0:0:0: [sds] Attached SCSI disk
ata24: link is slow to respond, please be patient (ready=0)
ata24: SRST failed (errno=-16)
ata24: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata24.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata24.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata24.00: configured for UDMA/133
scsi 23:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 
ANSI: 5
sd 23:0:0:0: [sdu] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 23:0:0:0: Attached scsi generic sg20 type 0
sd 23:0:0:0: [sdu] Write Protect is off
sd 23:0:0:0: [sdu] Mode Sense: 00 3a 00 00
sd 23:0:0:0: [sdu] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdu: sdu1
sd 23:0:0:0: [sdu] Attached SCSI disk
ata25: link is slow to respond, please be patient (ready=0)
ata25: SRST failed (errno=-16)
ata25: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata25.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata25.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata25.00: configured for UDMA/133
scsi 24:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 
ANSI: 5
sd 24:0:0:0: [sdv] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 24:0:0:0: Attached scsi generic sg21 type 0
sd 24:0:0:0: [sdv] Write Protect is off
sd 24:0:0:0: [sdv] Mode Sense: 00 3a 00 00
sd 24:0:0:0: [sdv] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdv: sdv1
sd 24:0:0:0: [sdv] Attached SCSI disk
ata26: link is slow to respond, please be patient (ready=0)
ata26: SRST failed (errno=-16)
ata26: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata26.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata26.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata26.00: configured for UDMA/133
scsi 25:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 
ANSI: 5
sd 25:0:0:0: [sdw] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 25:0:0:0: Attached scsi generic sg22 type 0
sd 25:0:0:0: [sdw] Write Protect is off
sd 25:0:0:0: [sdw] Mode Sense: 00 3a 00 00
sd 25:0:0:0: [sdw] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdw: sdw1
sd 25:0:0:0: [sdw] Attached SCSI disk
ata27: link is slow to respond, please be patient (ready=0)
ata27: SRST failed (errno=-16)
ata27: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata27.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata27.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata27.00: configured for UDMA/133
scsi 26:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 
ANSI: 5
sd 26:0:0:0: [sdx] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 26:0:0:0: Attached scsi generic sg23 type 0
sd 26:0:0:0: [sdx] Write Protect is off
sd 26:0:0:0: [sdx] Mode Sense: 00 3a 00 00
sd 26:0:0:0: [sdx] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdx: sdx1
sd 26:0:0:0: [sdx] Attached SCSI disk
ata28: SATA link down (SStatus 0 SControl 300)
ata29: link is slow to respond, please be patient (ready=0)
ata29: SRST failed (errno=-16)
ata29: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata29.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata29.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata29.00: configured for UDMA/133
scsi 28:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 
ANSI: 5
sd 28:0:0:0: [sdy] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 28:0:0:0: Attached scsi generic sg24 type 0
sd 28:0:0:0: [sdy] Write Protect is off
sd 28:0:0:0: [sdy] Mode Sense: 00 3a 00 00
sd 28:0:0:0: [sdy] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdy: sdy1
sd 28:0:0:0: [sdy] Attached SCSI disk
ata30: link is slow to respond, please be patient (ready=0)
ata30: SRST failed (errno=-16)
ata30: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata30.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata30.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata30.00: configured for UDMA/133
scsi 29:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 
ANSI: 5
sd 29:0:0:0: [sdz] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 29:0:0:0: Attached scsi generic sg25 type 0
sd 29:0:0:0: [sdz] Write Protect is off
sd 29:0:0:0: [sdz] Mode Sense: 00 3a 00 00
sd 29:0:0:0: [sdz] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdz: sdz1
sd 29:0:0:0: [sdz] Attached SCSI disk
md: Waiting for all devices to be available before autodetect
md: If you don't use raid, use raid=noautodetect
md: Autodetecting RAID arrays.
md: Scanned 19 and added 19 devices.
md: autorun ...
md: considering sdz1 ...
md:  adding sdz1 ...
md:  adding sdy1 ...
md:  adding sdx1 ...
md:  adding sdw1 ...
md:  adding sdv1 ...
md:  adding sdu1 ...
md:  adding sdt1 ...
md:  adding sdm1 ...
md:  adding sdl1 ...
md:  adding sdk1 ...
md:  adding sdj1 ...
md:  adding sdi1 ...
md:  adding sdh1 ...
md:  adding sdg1 ...
md:  adding sdf1 ...
md:  adding sde1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md: created md0
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: bind<sde1>
md: bind<sdf1>
md: bind<sdg1>
md: bind<sdh1>
md: bind<sdi1>
md: bind<sdj1>
md: bind<sdk1>
md: bind<sdl1>
md: bind<sdm1>
md: bind<sdt1>
md: bind<sdu1>
md: bind<sdv1>
md: bind<sdw1>
md: bind<sdx1>
md: bind<sdy1>
md: bind<sdz1>
md: running: 
<sdz1><sdy1><sdx1><sdw1><sdv1><sdu1><sdt1><sdm1><sdl1><sdk1><sdj1><sdi1><sdh1><sdg1><sdf1><sde1><sdd1><sdc1><sdb1>
raid5: device sdz1 operational as raid disk 10
raid5: device sdy1 operational as raid disk 2
raid5: device sdx1 operational as raid disk 17
raid5: device sdw1 operational as raid disk 15
raid5: device sdv1 operational as raid disk 16
raid5: device sdu1 operational as raid disk 12
raid5: device sdt1 operational as raid disk 13
raid5: device sdm1 operational as raid disk 18
raid5: device sdl1 operational as raid disk 14
raid5: device sdk1 operational as raid disk 9
raid5: device sdj1 operational as raid disk 7
raid5: device sdi1 operational as raid disk 6
raid5: device sdh1 operational as raid disk 8
raid5: device sdg1 operational as raid disk 5
raid5: device sdf1 operational as raid disk 1
raid5: device sde1 operational as raid disk 3
raid5: device sdd1 operational as raid disk 0
raid5: device sdc1 operational as raid disk 11
raid5: device sdb1 operational as raid disk 4
raid5: allocated 20022kB for md0
10: w=1 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
2: w=2 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
17: w=3 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
15: w=4 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
16: w=5 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
12: w=6 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
13: w=7 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
18: w=8 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
14: w=9 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
9: w=10 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
7: w=11 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
6: w=12 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
8: w=13 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
5: w=14 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
1: w=15 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
3: w=16 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
0: w=17 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
11: w=18 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
4: w=19 pa=0 pr=19 m=2 a=2 r=19 op1=0 op2=0
raid5: raid level 6 set md0 active with 19 out of 19 devices, algorithm 2
RAID5 conf printout:
  --- rd:19 wd:19
  disk 0, o:1, dev:sdd1
  disk 1, o:1, dev:sdf1
  disk 2, o:1, dev:sdy1
  disk 3, o:1, dev:sde1
  disk 4, o:1, dev:sdb1
  disk 5, o:1, dev:sdg1
  disk 6, o:1, dev:sdi1
  disk 7, o:1, dev:sdj1
  disk 8, o:1, dev:sdh1
  disk 9, o:1, dev:sdk1
  disk 10, o:1, dev:sdz1
  disk 11, o:1, dev:sdc1
  disk 12, o:1, dev:sdu1
  disk 13, o:1, dev:sdt1
  disk 14, o:1, dev:sdl1
  disk 15, o:1, dev:sdw1
  disk 16, o:1, dev:sdv1
  disk 17, o:1, dev:sdx1
  disk 18, o:1, dev:sdm1
md0: detected capacity change from 0 to 12752611704832
md: ... autorun DONE.
REISERFS (device sda5): found reiserfs format "3.6" with standard journal
REISERFS (device sda5): using ordered data mode
REISERFS (device sda5): journal params: device sda5, size 8192, journal 
first block 18, max trans len 1024, max batch 900, max commit age 30, 
max trans age 30
REISERFS (device sda5): checking transaction log (sda5)
REISERFS (device sda5): Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly on device 8:5.
Freeing unused kernel memory: 464k freed
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.05
iTCO_wdt: Found a ICH9R TCO device (Version=2, TCOBASE=0x1060)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k2
e1000e: Copyright (c) 1999-2008 Intel Corporation.
e1000e 0000:0d:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
e1000e 0000:0d:00.0: setting latency timer to 64
e1000e 0000:0d:00.0: irq 78 for MSI/MSI-X
i801_smbus 0000:00:1f.3: enabling device (0001 -> 0003)
i801_smbus 0000:00:1f.3: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Intel(R) Gigabit Ethernet Network Driver - version 1.3.16-k2
Copyright (c) 2007-2009 Intel Corporation.
igb 0000:04:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
igb 0000:04:00.0: setting latency timer to 64
igb 0000:04:00.0: irq 79 for MSI/MSI-X
igb 0000:04:00.0: irq 80 for MSI/MSI-X
igb 0000:04:00.0: irq 81 for MSI/MSI-X
igb 0000:04:00.0: irq 82 for MSI/MSI-X
igb 0000:04:00.0: irq 83 for MSI/MSI-X
igb 0000:04:00.0: irq 84 for MSI/MSI-X
igb 0000:04:00.0: irq 85 for MSI/MSI-X
igb 0000:04:00.0: irq 86 for MSI/MSI-X
igb 0000:04:00.0: irq 87 for MSI/MSI-X
0000:0d:00.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:30:48:66:e8:56
0000:0d:00.0: eth0: Intel(R) PRO/1000 Network Connection
Linux video capture interface: v2.00
0000:0d:00.0: eth0: MAC: 2, PHY: 2, PBA No: ffffff-0ff
e1000e 0000:0f:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
e1000e 0000:0f:00.0: setting latency timer to 64
e1000e 0000:0f:00.0: irq 88 for MSI/MSI-X
em28xx: New device USB 2821 Device @ 480 Mbps (eb1a:2821, interface 0, 
class 0)
em28xx #0: chip ID is em2820 (or em2710)
0000:0f:00.0: eth1: (PCI Express:2.5GB/s:Width x1) 00:30:48:66:e8:57
0000:0f:00.0: eth1: Intel(R) PRO/1000 Network Connection
0000:0f:00.0: eth1: MAC: 2, PHY: 2, PBA No: ffffff-0ff
igb 0000:04:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:04:00.0: eth2: (PCIe:2.5Gb/s:Width x4) 00:30:48:dc:b3:72
igb 0000:04:00.0: eth2: PBA No: 0101ff-0ff
igb 0000:04:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
igb 0000:04:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
igb 0000:04:00.1: setting latency timer to 64
igb 0000:04:00.1: irq 89 for MSI/MSI-X
igb 0000:04:00.1: irq 90 for MSI/MSI-X
igb 0000:04:00.1: irq 91 for MSI/MSI-X
igb 0000:04:00.1: irq 92 for MSI/MSI-X
igb 0000:04:00.1: irq 93 for MSI/MSI-X
igb 0000:04:00.1: irq 94 for MSI/MSI-X
igb 0000:04:00.1: irq 95 for MSI/MSI-X
igb 0000:04:00.1: irq 96 for MSI/MSI-X
igb 0000:04:00.1: irq 97 for MSI/MSI-X
em28xx #0: i2c eeprom 00: 1a eb 67 95 1a eb 21 28 90 00 11 03 6a 22 00 00
em28xx #0: i2c eeprom 10: 00 00 04 57 06 21 01 00 00 00 00 00 00 00 00 00
em28xx #0: i2c eeprom 20: 02 00 01 01 f0 10 00 00 00 00 00 00 5b 00 00 00
em28xx #0: i2c eeprom 30: 00 00 20 40 20 80 02 20 10 01 03 01 00 00 00 00
em28xx #0: i2c eeprom 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
em28xx #0: i2c eeprom 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
em28xx #0: i2c eeprom 60: 00 00 00 00 00 00 00 00 00 00 22 03 55 00 53 00
em28xx #0: i2c eeprom 70: 42 00 20 00 32 00 38 00 32 00 31 00 20 00 44 00
em28xx #0: i2c eeprom 80: 65 00 76 00 69 00 63 00 65 00 00 00 00 00 00 00
em28xx #0: i2c eeprom 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
em28xx #0: i2c eeprom a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
em28xx #0: i2c eeprom b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
em28xx #0: i2c eeprom c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
em28xx #0: i2c eeprom d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
em28xx #0: i2c eeprom e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
em28xx #0: i2c eeprom f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
em28xx #0: EEPROM ID= 0x9567eb1a, EEPROM hash = 0x37da7b8a
em28xx #0: EEPROM info:
em28xx #0:	AC97 audio (5 sample rates)
em28xx #0:	500mA max power
em28xx #0:	Table at 0x04, strings=0x226a, 0x0000, 0x0000
em28xx #0: Identified as Terratec Cinergy 250 USB (card=2)
igb 0000:04:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0000:04:00.1: eth3: (PCIe:2.5Gb/s:Width x4) 00:30:48:dc:b3:73
igb 0000:04:00.1: eth3: PBA No: 0101ff-0ff
igb 0000:04:00.1: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
saa7115 1-0025: saa7113 found (1f7113d0e100000) @ 0x4a (em28xx #0)
em28xx #0: Config register raw data: 0x90
em28xx #0: AC97 vendor ID = 0xffffffff
em28xx #0: AC97 features = 0x6a90
em28xx #0: Empia 202 AC97 audio processor detected
em28xx #0: v4l2 driver version 0.1.2
em28xx #0: V4L2 video device registered as /dev/video0
em28xx audio device (eb1a:2821): interface 1, class 1
em28xx audio device (eb1a:2821): interface 2, class 1
usbcore: registered new interface driver em28xx
em28xx driver loaded
  md0: unknown partition table
Adding 3903784k swap on /dev/sda2.  Priority:-1 extents:1 across:3903784k
w83627hf: Found W83627HF chip at 0x290
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
REISERFS (device sda6): found reiserfs format "3.6" with standard journal
REISERFS (device sda6): using ordered data mode
REISERFS (device sda6): journal params: device sda6, size 8192, journal 
first block 18, max trans len 1024, max batch 900, max commit age 30, 
max trans age 30
REISERFS (device sda6): checking transaction log (sda6)
REISERFS (device sda6): Using r5 hash to sort names
REISERFS (device sda7): found reiserfs format "3.6" with standard journal
REISERFS (device sda7): using ordered data mode
REISERFS (device sda7): journal params: device sda7, size 8192, journal 
first block 18, max trans len 1024, max batch 900, max commit age 30, 
max trans age 30
REISERFS (device sda7): checking transaction log (sda7)
REISERFS (device sda7): Using r5 hash to sort names
REISERFS (device sda8): found reiserfs format "3.6" with standard journal
REISERFS (device sda8): using ordered data mode
REISERFS (device sda8): journal params: device sda8, size 8192, journal 
first block 18, max trans len 1024, max batch 900, max commit age 30, 
max trans age 30
REISERFS (device sda8): checking transaction log (sda8)
REISERFS (device sda8): Using r5 hash to sort names
Filesystem "md0": Disabling barriers, trial barrier write failed
XFS mounting filesystem md0
Ending clean XFS mount for filesystem: md0
igb 0000:04:00.1: changing MTU from 1500 to 9014
device eth0 entered promiscuous mode
e1000e 0000:0d:00.0: irq 78 for MSI/MSI-X
e1000e 0000:0d:00.0: irq 78 for MSI/MSI-X
device eth1 entered promiscuous mode
e1000e 0000:0f:00.0: irq 88 for MSI/MSI-X
e1000e 0000:0f:00.0: irq 88 for MSI/MSI-X
igb: eth3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
e1000e: eth1 NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
0000:0f:00.0: eth1: 10/100 speed: disabling TSO
br0: port 2(eth1) entering learning state
device tap1 entered promiscuous mode
br0: port 3(tap1) entering learning state
device tap2 entered promiscuous mode
br0: port 4(tap2) entering learning state
e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
br0: port 1(eth0) entering learning state
device tap4 entered promiscuous mode
device tap5 entered promiscuous mode
igb: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
igb: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
br0: port 2(eth1) entering forwarding state
br0: port 3(tap1) entering forwarding state
br0: port 4(tap2) entering forwarding state
br0: port 1(eth0) entering forwarding state
device tap3 entered promiscuous mode
br0: port 5(tap3) entering learning state
br0: port 5(tap3) entering forwarding state
kvm: emulating exchange as write
  sdn: sdn1
mtrr: type mismatch for d8000000,2000000 old: write-back new: 
write-combining
ata23: exception Emask 0x10 SAct 0x0 SErr 0x100000 action 0x6 frozen
ata23: edma_err_cause=00000020 pp_flags=00000003, SError=00100000
ata23: SError: { Dispar }
ata23: hard resetting link
ata23: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata23.00: configured for UDMA/133
ata23: EH complete


-- 
Harri.
