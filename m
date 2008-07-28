From: "Felipe Sere" <dodofxp@gmail.com>
Subject: Re: ata_piix problem with MacBook Pro and 2.6.26
Date: Mon, 28 Jul 2008 20:54:24 +0200
Message-ID: <da38d7b90807281154p6cd45e0pf0acd83cd583d06a@mail.gmail.com>
References: <da38d7b90807240227q165cb5elad937973a58bf88f@mail.gmail.com>
	 <488D757B.6000002@gmail.com>
	 <da38d7b90807280101y44ef5624of99f7038967405a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.159]:10393 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756307AbYG1Sy0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jul 2008 14:54:26 -0400
Received: by po-out-1718.google.com with SMTP id c31so9154979poi.1
        for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2008 11:54:24 -0700 (PDT)
In-Reply-To: <da38d7b90807280101y44ef5624of99f7038967405a6@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi

I own a MacBook Pro (early 2008) and I am having boot problems.
I run the 2.6.26 kernel, which supposedly fixed an issue with the MBP
not booting without power cord. I am experiencing the same exact
issues:
-No booting if the power cord is not plugged in
-It hangs on the following line: ata_piix 0000:00:1f.2 : MAP [ P0 P2 P1 P3 ]
-Plugging in the power cord in a short amount of time solves the problem
-If the power cord is plugged in too late, I get some 'time unsync' problem
  (Will report on this in a followup mail)

Here are the results of dmesg and lspci -nn:

lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation Mobile PM965/GM965/GL960
Memory Controller Hub [8086:2a00] (rev 03)
00:01.0 PCI bridge [0604]: Intel Corporation Mobile PM965/GM965/GL960
PCI Express Root Port [8086:2a01] (rev 03)
00:1a.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI Controller #4 [8086:2834] (rev 03)
00:1a.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI Controller #5 [8086:2835] (rev 03)
00:1a.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB2 EHCI Controller #2 [8086:283a] (rev 03)
00:1b.0 Audio device [0403]: Intel Corporation 82801H (ICH8 Family) HD
Audio Controller [8086:284b] (rev 03)
00:1c.0 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
Express Port 1 [8086:283f] (rev 03)
00:1c.2 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
Express Port 3 [8086:2843] (rev 03)
00:1c.4 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
Express Port 5 [8086:2847] (rev 03)
00:1c.5 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
Express Port 6 [8086:2849] (rev 03)
00:1d.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI Controller #1 [8086:2830] (rev 03)
00:1d.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI Controller #2 [8086:2831] (rev 03)
00:1d.2 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI Controller #3 [8086:2832] (rev 03)
00:1d.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB2 EHCI Controller #1 [8086:2836] (rev 03)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge
[8086:2448] (rev f3)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801HEM (ICH8M) LPC
Interface Controller [8086:2815] (rev 03)
00:1f.1 IDE interface [0101]: Intel Corporation 82801HBM/HEM
(ICH8M/ICH8M-E) IDE Controller [8086:2850] (rev 03)
00:1f.2 IDE interface [0101]: Intel Corporation 82801HBM/HEM
(ICH8M/ICH8M-E) SATA IDE Controller [8086:2828] (rev 03)
00:1f.3 SMBus [0c05]: Intel Corporation 82801H (ICH8 Family) SMBus
Controller [8086:283e] (rev 03)
01:00.0 VGA compatible controller [0300]: nVidia Corporation GeForce
8600M GT [10de:0407] (rev a1)
0b:00.0 Network controller [0280]: Broadcom Corporation BCM4328
802.11a/b/g/n [14e4:4328] (rev 05)
0c:00.0 Ethernet controller [0200]: Marvell Technology Group Ltd.
Marvell Yukon 88E8058 PCI-E Gigabit Ethernet Controller [11ab:436a]
(rev 13)
0d:03.0 FireWire (IEEE 1394) [0c00]: Texas Instruments TSB82AA2
IEEE-1394b Link Layer Controller [104c:8025] (rev 02)

and dmesg:
Linux version 2.6.26 (root@zenwalk) (gcc version 4.2.3) #1 SMP PREEMPT
Mon Jul 14 22:56:25 CEST 2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ecd3000 (usable)
 BIOS-e820: 000000007ecd3000 - 000000007eed4000 (ACPI NVS)
 BIOS-e820: 000000007eed4000 - 000000007ef87000 (ACPI data)
 BIOS-e820: 000000007ef87000 - 000000007ef89000 (ACPI NVS)
 BIOS-e820: 000000007ef89000 - 000000007fec3000 (ACPI data)
 BIOS-e820: 000000007fec3000 - 000000007fec5000 (ACPI NVS)
 BIOS-e820: 000000007fec5000 - 000000007fec8000 (ACPI data)
 BIOS-e820: 000000007fec8000 - 000000007fecb000 (ACPI NVS)
 BIOS-e820: 000000007fecb000 - 000000007fecc000 (ACPI data)
 BIOS-e820: 000000007fecc000 - 000000007fedf000 (ACPI NVS)
 BIOS-e820: 000000007fedf000 - 000000007fef9000 (ACPI data)
 BIOS-e820: 000000007fef9000 - 000000007feff000 (reserved)
 BIOS-e820: 000000007feff000 - 000000007ff00000 (ACPI data)
 BIOS-e820: 000000007ff00000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
1132MB HIGHMEM available.
896MB LOWMEM available.
Entering add_active_range(0, 0, 519379) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   519379
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   519379
On node 0 totalpages: 519379
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 2266 pages used for memmap
  HighMem zone: 287737 pages, LIFO batch:31
  Movable zone: 0 pages used for memmap
DMI 2.4 present.
ACPI: RSDP 000FE020, 0024 (r2 APPLE )
ACPI: XSDT 7FEEE1C0, 0084 (r1 APPLE   Apple00       C1       1000013)
ACPI: FACP 7FEEC000, 00F4 (r3 APPLE   Apple00       C1 Loki       5F)
ACPI: DSDT 7FEE1000, 498E (r1 APPLE  MacBookP    40001 INTL 20061109)
ACPI: FACS 7FECC000, 0040
ACPI: HPET 7FEEB000, 0038 (r1 APPLE   Apple00        1 Loki       5F)
ACPI: APIC 7FEEA000, 0068 (r1 APPLE   Apple00        1 Loki       5F)
ACPI: MCFG 7FEE9000, 003C (r1 APPLE   Apple00        1 Loki       5F)
ACPI: ASF! 7FEE8000, 00A5 (r32 APPLE   Apple00        1 Loki       5F)
ACPI: SBST 7FEE7000, 0030 (r1 APPLE   Apple00        1 Loki       5F)
ACPI: ECDT 7FEE6000, 0053 (r1 APPLE   Apple00        1 Loki       5F)
ACPI: SSDT 7FEC7000, 04DC (r1  APPLE    CpuPm     3000 INTL 20061109)
ACPI: SSDT 7FEC6000, 025F (r1  APPLE  Cpu0Tst     3000 INTL 20061109)
ACPI: SSDT 7FEC5000, 00A6 (r1  APPLE  Cpu1Tst     3000 INTL 20061109)
ACPI: SSDT 7FEE0000, 0544 (r1 SataRe  SataPri     1000 INTL 20061109)
ACPI: SSDT 7FEDF000, 0477 (r1 SataRe  SataSec     1000 INTL 20061109)
ACPI: DMI BIOS year==0, assuming ACPI-capable machine
ACPI: DMI detected: Apple
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:70000000)
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 39300 bytes of per cpu data
NR_CPUS: 4, nr_cpu_ids: 2
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 515321
Kernel command line: auto BOOT_IMAGE=Zenwalk ro root=804
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Preemptible RCU implementation.
PID hash table entries: 4096 (order: 12, 16384 bytes)
Extended CMOS year: 2000
Detected 2394.009 MHz processor.
Console: colour dummy device 80x25
console [tty0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2053652k/2077516k available (2541k kernel code, 22624k
reserved, 754k data, 244k init, 1160012k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff80000 - 0xfffff000   ( 508 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc043e000 - 0xc047b000   ( 244 kB)
      .data : 0xc037b6b5 - 0xc0437fc0   ( 754 kB)
      .text : 0xc0100000 - 0xc037b6b5   (2541 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
CPA: page pool initialized 1 of 1 pages preallocated
SLUB: Genslabs=12, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
hpet clockevent registered
Calibrating delay using timer specific routine.. 4793.74 BogoMIPS (lpj=2396874)
Mount-cache hash table entries: 512
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 3072K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
using mwait in idle threads.
Checking 'hlt' instruction... OK.
ACPI: Core revision 20080321
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: Intel(R) Core(TM)2 Duo CPU     T8300  @ 2.40GHz stepping 06
Booting processor 1/1 ip 6000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4787.74 BogoMIPS (lpj=2393874)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 3072K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Intel(R) Core(TM)2 Duo CPU     T8300  @ 2.40GHz stepping 06
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
Total of 2 processors activated (9581.49 BogoMIPS).
net_namespace: 488 bytes
xor: automatically using best checksumming function: pIII_sse
   pIII_sse  :  8820.000 MB/sec
xor: using function: pIII_sse (8820.000 MB/sec)
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 255
PCI: Not using MMCONFIG.
PCI: Using configuration type 1 for base access
Setting up standard PCI resources
ACPI: EC: EC description table is found, configuring boot EC
ACPI: EC: non-query interrupt received, switching to interrupt mode
ACPI: BIOS _OSI(Linux) query ignored via DMI
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 255
PCI: BIOS Bug: MCFG area at f0000000 is not reserved in ACPI
motherboard resources
PCI: Not using MMCONFIG.
ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
ACPI: EC: driver started in interrupt mode
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:1f.0: quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 0500-053f claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 *7 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 9 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
system 00:01: iomem range 0xfed1c000-0xfed1ffff could not be reserved
system 00:01: iomem range 0xfed14000-0xfed17fff could not be reserved
system 00:01: iomem range 0xfed18000-0xfed18fff could not be reserved
system 00:01: iomem range 0xfed19000-0xfed19fff could not be reserved
system 00:01: iomem range 0xf0000000-0xf3ffffff could not be reserved
system 00:01: iomem range 0xfed20000-0xfed3ffff has been reserved
system 00:01: iomem range 0xfed45000-0xfed8ffff has been reserved
system 00:05: iomem range 0xfed00000-0xfed003ff has been reserved
system 00:07: ioport range 0x680-0x69f has been reserved
system 00:07: ioport range 0x800-0x80f has been reserved
system 00:07: ioport range 0x810-0x817 has been reserved
system 00:07: ioport range 0x400-0x47f has been reserved
system 00:07: ioport range 0x500-0x53f has been reserved
system 00:07: ioport range 0x1640-0x164f has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: 7000-7fff
  MEM window: 0x90000000-0x930fffff
  PREFETCH window: 0x0000000080000000-0x000000008fffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: 0x9b400000-0x9b4fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
  IO window: 6000-6fff
  MEM window: 0x97400000-0x9b3fffff
  PREFETCH window: 0x0000000093100000-0x00000000970fffff
PCI: Bridge: 0000:00:1c.4
  IO window: disabled.
  MEM window: 0x97300000-0x973fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.5
  IO window: 5000-5fff
  MEM window: 0x97200000-0x972fffff
  PREFETCH window: 0x000000009b600000-0x000000009b6fffff
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: 0x97100000-0x971fffff
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
pci 0000:00:1c.0: enabling device (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
pci 0000:00:1c.2: enabling device (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.4 to 64
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.5 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs...it isn't (bad gzip magic numbers);
looks like an initrd
Freeing initrd memory: 1619k freed
highmem bounce pool size: 64 pages
SGI XFS with security attributes, no debug enabled
SGI XFS Quota Management subsystem
msgmni has been set to 1750
async_tx: api initialized (sync-only)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler cfq registered (default)
pci 0000:01:00.0: Boot video device
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie02]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
Allocate Port Service[0000:00:1c.4:pcie02]
PCI: Setting latency timer of device 0000:00:1c.5 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.5:pcie00]
Allocate Port Service[0000:00:1c.5:pcie02]
vesafb: framebuffer at 0x91000000, mapped to 0xf8880000, using 6144k,
total 14336k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
bootsplash 3.1.6-2004/03/31: looking for picture...<6> silentjpeg size
259124 bytes,<6>...found (1024x768, 249242 bytes, v3).
Console: switching to colour frame buffer device 118x38
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
Switched to high resolution mode on CPU 1
Switched to high resolution mode on CPU 0
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
brd: module loaded
PPP generic driver version 2.4.2
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
ata_piix 0000:00:1f.1: version 2.12
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1f.1 to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x8108 ctl 0x811c bmdma 0x80e0 irq 21
ata2: PATA max UDMA/100 cmd 0x8100 ctl 0x8118 bmdma 0x80e8 irq 21
ata1.00: ATAPI: MATSHITADVD-R   UJ-867, HA13, max UDMA/66
ata1.00: configured for UDMA/66
scsi 0:0:0:0: CD-ROM            MATSHITA DVD-R   UJ-867   HA13 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:0:0: Attached scsi CD-ROM sr0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 18 (level, low) -> IRQ 18
#### the following line is where it hangs #######

ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ata_piix 0000:00:1f.2: SCR access via SIDPR is available but doesn't work
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0x80f8 ctl 0x8114 bmdma 0x8020 irq 18
ata4: SATA max UDMA/133 cmd 0x80f0 ctl 0x8110 bmdma 0x8028 irq 18
ata3.00: ATA-8: FUJITSU MHY2200BH, 0081000D, max UDMA/100
ata3.00: 390721968 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata3.00: configured for UDMA/100
scsi 2:0:0:0: Direct-Access     ATA      FUJITSU MHY2200B 0081 PQ: 0 ANSI: 5
sd 2:0:0:0: [sda] 390721968 512-byte hardware sectors (200050 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 2:0:0:0: [sda] 390721968 512-byte hardware sectors (200050 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2 sda3 sda4
sd 2:0:0:0: [sda] Attached SCSI disk
usbcore: registered new interface driver libusual
PNP: No PS/2 controller found. Probing ports directly.
i8042.c: No controller found.
mice: PS/2 mouse device common for all mice
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
raid6: int32x1    937 MB/s
raid6: int32x2    882 MB/s
raid6: int32x4    757 MB/s
raid6: int32x8    695 MB/s
raid6: mmxx1     3007 MB/s
raid6: mmxx2     3441 MB/s
raid6: sse1x1    2019 MB/s
raid6: sse1x2    2621 MB/s
raid6: sse2x1    3675 MB/s
raid6: sse2x2    4007 MB/s
raid6: using algorithm sse2x2 (4007 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
md: multipath personality registered for level -4
device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised: dm-devel@redhat.com
device-mapper: multipath: version 1.0.5 loaded
device-mapper: multipath round-robin: version 1.0.0 loaded
cpuidle: using governor ladder
cpuidle: using governor menu
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
TCP cubic registered
NET: Registered protocol family 17
Starting balanced_irq
Using IPI No-Shortcut mode
md: Autodetecting RAID arrays.
md: Scanned 0 and added 0 devices.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Couldn't find valid RAM disk image starting at 0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 244k freed
Linux agpgart interface v0.103
ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: irq 21, io mem 0x9b504c00
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
sr 0:0:0:0: Attached scsi generic sg0 type 5
sd 2:0:0:0: Attached scsi generic sg1 type 0
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 20, io mem 0x9b504800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 20, io base 0x000080c0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: SSDT 7FECAA98, 0340 (r1  APPLE  Cpu0Ist     3000 INTL 20061109)
ACPI: SSDT 7FEC8C18, 02AD (r1  APPLE  Cpu0Cst     3001 INTL 20061109)
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
Monitor-Mwait will be used to enter C-3 state
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: ACPI0007:00 is registered as cooling_device0
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: SSDT 7FEC9F18, 00C8 (r1  APPLE  Cpu1Ist     3000 INTL 20061109)
ACPI: SSDT 7FEC8F18, 0085 (r1  APPLE  Cpu1Cst     3000 INTL 20061109)
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: ACPI0007:01 is registered as cooling_device1
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: AC Adapter [ADP1] (on-line)
input: Power Button (FF) as /class/input/input0
Marking TSC unstable due to: TSC halts in idle.
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 16, io base 0x000080a0
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: Power Button (FF) [PWRF]
input: Lid Switch as /class/input/input1
ACPI: Lid Switch [LID0]
input: Power Button (CM) as /class/input/input2
ACPI: Power Button (CM) [PWRB]
input: Sleep Button (CM) as /class/input/input3
ACPI: Sleep Button (CM) [SLPB]
ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 20 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.0: irq 16, io base 0x00008080
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.1: irq 18, io base 0x00008060
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.2: irq 21, io base 0x00008040
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
ACPI: Battery Slot [BAT0] (battery present)
usb 2-4: new high speed USB device using ehci_hcd and address 3
ACPI: PCI Interrupt 0000:0c:00.0[A] -> <6>ACPI: PCI Interrupt
0000:0b:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:0b:00.0 to 64
GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:0c:00.0 to 64
sky2 0000:0c:00.0: v1.21 addr 0x97200000 irq 17 Yukon-EC Ultra (0xb4) rev 3
sky2 eth0: addr 00:1f:5b:f4:30:55
ssb: WARNING: Invalid SPROM CRC (corrupt SPROM)
ssb: Sonics Silicon Backplane found on PCI device 0000:0b:00.0
ACPI: PCI Interrupt 0000:0d:03.0[A] -> GSI 19 (level, low) -> IRQ 19
nvidia: module license 'NVIDIA' taints kernel.
usb 2-4: configuration #1 chosen from 1 choice
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]
MMIO=[97104000-971047ff]  Max Packet=[4096]  IR/IT contexts=[4/8]
input: Video Bus as /class/input/input4
ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:01:00.0 to 64
NVRM: loading NVIDIA UNIX x86 Kernel Module  173.14.05  Mon May 19
00:06:12 PDT 2008
usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
hub 3-1:1.0: USB hub found
hub 3-1:1.0: 3 ports detected
Linux video capture interface: v2.00
usb 5-1: new full speed USB device using uhci_hcd and address 2
usb 5-1: configuration #1 chosen from 1 choice
input: Logitech USB Gaming Mouse as /class/input/input5
input: USB HID v1.11 Mouse [Logitech USB Gaming Mouse] on usb-0000:00:1d.0-1
hiddev0: USB HID v1.11 Device [Logitech USB Gaming Mouse] on usb-0000:00:1d.0-1
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001ff3fffe2acf7e]
usb 7-1: new low speed USB device using uhci_hcd and address 2
Clocksource tsc unstable (delta = -281498055 ns)
usb 7-1: configuration #1 chosen from 1 choice
hiddev1: USB HID v1.11 Device [Apple Computer, Inc. IR Receiver] on
usb-0000:00:1d.2-1
usb 7-2: new full speed USB device using uhci_hcd and address 3
usb 7-2: configuration #1 chosen from 1 choice
input: Apple, Inc. Apple Internal Keyboard / Trackpad as /class/input/input6
input: USB HID v1.11 Keyboard [Apple, Inc. Apple Internal Keyboard /
Trackpad] on usb-0000:00:1d.2-2
HID device claimed by neither input, hiddev nor hidraw
input: Apple, Inc. Apple Internal Keyboard / Trackpad as /class/input/input7
input: USB HID v1.11 Mouse [Apple, Inc. Apple Internal Keyboard /
Trackpad] on usb-0000:00:1d.2-2
uvcvideo: Found UVC 1.00 device Built-in iSight (05ac:8502)
input: Built-in iSight as /class/input/input8
usb 3-1.1: new full speed USB device using uhci_hcd and address 3
usb 3-1.1: configuration #1 chosen from 1 choice
usbcore: registered new interface driver uvcvideo
USB Video Class driver (v0.1.0)
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new interface driver hci_usb
EXT3 FS on sda4, internal journal
fuse init (API version 7.9)
sky2 eth0: enabling interface
ip_tables: (C) 2000-2006 Netfilter Core Team
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ACPI: EC: GPE storm detected, disabling EC GPE
ACPI: EC: missing confirmations, switch off interrupt mode.

Tell me what other information you want me to provide .-)

Cheers
-- 
Felipe Sere
