From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: libata: improve post-reset device ready test
Date: Sun, 11 May 2008 03:51:49 +0400
Message-ID: <20080510235149.GA4751@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:52238 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbYEJW4a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 May 2008 18:56:30 -0400
Received: by ug-out-1314.google.com with SMTP id h2so431560ugf.16
        for <linux-ide@vger.kernel.org>; Sat, 10 May 2008 15:56:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, jgarzik@redhat.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Gentlemen,

the following patch causes libata errors in dmesg (which I can ignore)
and much longer bootup because of resets (which is irritating).

There were no problems with that CD-ROM before and with other model too.
Full dmesg at the end of email.


	ata8: link is slow to respond, please be patient (ready=0)
	ata8: device not ready (errno=-16), forcing hardreset
	ata8: link is slow to respond, please be patient (ready=0)
	ata8: SRST failed (errno=-16)
	ata8: link is slow to respond, please be patient (ready=0)
	ata8: SRST failed (errno=-16)
	ata8: link is slow to respond, please be patient (ready=0)
	ata8: SRST failed (errno=-16)
	ata8: SRST failed (errno=-16)
	ata8: reset failed, giving up
	scsi 6:0:1:0: CD-ROM            _NEC     DV-5800C         D9S2 PQ: 0 ANSI: 5

78ab88f04f44bed566d51dce0c7cbfeff6449a06 is first bad commit
commit 78ab88f04f44bed566d51dce0c7cbfeff6449a06
Author: Tejun Heo <htejun@gmail.com>
Date:   Thu May 1 23:41:41 2008 +0900

    libata: improve post-reset device ready test
    
    Some controllers (jmb and inic162x) use 0x77 and 0x7f to indicate that
    the device isn't ready yet.  It looks like they use 0xff if device
    presence is detected but connection isn't established.  0x77 or 0x7f
    after connection is established and use the value from signature FIS
    after receiving it.
    
    This patch implements ata_check_ready(), which takes TF status value
    and determines whether the port is ready or not considering the above
    and other conditions, and use it in @check_ready() functions.  This is
    safe as both 0x77 and 0x7f aren't valid ready status value even though
    they have BSY bit cleared.
    
    This fixes hot plug detection failures which can be triggered with
    certain drives if they aren't already spun up when the data connector
    is hot plugged.
    
    Tested on sil, sil24, ahci (jmb/ich), piix and inic162x combined with
    eight drives from all major vendors.
    
    Signed-off-by: Tejun Heo <htejun@gmail.com>
    Signed-off-by: Jeff Garzik <jgarzik@redhat.com>

:040000 040000 7ad4e3dd5b5849b03b6de634c296a4e7105d1e88 706fca1ce5ce8db2133ad95ecb7b823650af6966 M	drivers
:040000 040000 47b4e423ea6348ca81e41e40ebdda1956520913f 4504ddf729820c85e8d23c1a3350f7ed60ae282f M	include


CONFIG_ATA=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_AHCI=y
CONFIG_ATA_SFF=y
CONFIG_ATA_PIIX=y
CONFIG_PATA_JMICRON=y

Linux version 2.6.26-rc1-bisect (ad@martell) (gcc version 4.1.2 (Gentoo 4.1.2 p1.0.2)) #10 SMP PREEMPT Sun May 11 03:32:42 MSD 2008
Command line: root=/dev/sda2 netconsole=@192.168.0.1/eth0,9353@192.168.0.42/00:1b:38:af:22:49 ignore_loglevel
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff90000 (usable)
 BIOS-e820: 000000007ff90000 - 000000007ff9e000 (ACPI data)
 BIOS-e820: 000000007ff9e000 - 000000007ffe0000 (ACPI NVS)
 BIOS-e820: 000000007ffe0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
debug: ignoring loglevel setting.
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524176) 1 entries of 256 used
Entering add_active_range(0, 1048576, 1572864) 2 entries of 256 used
max_pfn_mapped = 1572864
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
init_memory_mapping
DMI 2.4 present.
ACPI: RSDP 000FA980, 0024 (r2 ACPIAM)
ACPI: XSDT 7FF90100, 0054 (r1 KOZIRO FRONTIER  2000707 MSFT       97)
ACPI: FACP 7FF90290, 00F4 (r3 MSTEST OEMFACP   2000707 MSFT       97)
ACPI: DSDT 7FF905C0, 8FA9 (r1  A0637 A0637000        0 INTL 20060113)
ACPI: FACS 7FF9E000, 0040
ACPI: APIC 7FF90390, 006C (r1 MSTEST OEMAPIC   2000707 MSFT       97)
ACPI: MCFG 7FF90400, 003C (r1 MSTEST OEMMCFG   2000707 MSFT       97)
ACPI: SLIC 7FF90440, 0176 (r1 KOZIRO FRONTIER  2000707 MSFT       97)
ACPI: OEMB 7FF9E040, 007B (r1 MSTEST AMI_OEM   2000707 MSFT       97)
ACPI: HPET 7FF99570, 0038 (r1 MSTEST OEMHPET   2000707 MSFT       97)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524176) 1 entries of 256 used
Entering add_active_range(0, 1048576, 1572864) 2 entries of 256 used
  early res: 0 [0-fff] BIOS data page
  early res: 1 [6000-7fff] TRAMPOLINE
  early res: 2 [200000-af2207] TEXT DATA BSS
  early res: 3 [9fc00-fffff] BIOS reserved
  early res: 4 [8000-dfff] PGTABLE
 [ffffe20000000000-ffffe200053fffff] PMD -> [ffff81000c200000-ffff8100115fffff] on node 0
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1572864
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0:        0 ->      159
    0:      256 ->   524176
    0:  1048576 ->  1572864
On node 0 totalpages: 1048367
  DMA zone: 56 pages used for memmap
  DMA zone: 2397 pages reserved
  DMA zone: 1546 pages, LIFO batch:0
  DMA32 zone: 14280 pages used for memmap
  DMA32 zone: 505800 pages, LIFO batch:31
  Normal zone: 7168 pages used for memmap
  Normal zone: 517120 pages, LIFO batch:31
  Movable zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 0, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x8086a202 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7ee00000)
PERCPU: Allocating 33732 bytes of per cpu data
NR_CPUS: 2, nr_cpu_ids: 2
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1024466
Kernel command line: root=/dev/sda2 netconsole=@192.168.0.1/eth0,9353@192.168.0.42/00:1b:38:af:22:49 ignore_loglevel
Initializing CPU#0
Preemptible RCU implementation.
PID hash table entries: 4096 (order: 12, 32768 bytes)
Extended CMOS year: 2000
TSC calibrated against PM_TIMER
time.c: Detected 2135.039 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 1648 kB
 per task-struct memory footprint: 2688 bytes
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking aperture...
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing software IO TLB between 0x161d000 - 0x561d000
Memory: 4025184k/6291456k available (2444k kernel code, 167852k reserved, 1416k data, 240k init)
CPA: page pool initialized 64 of 64 pages preallocated
SLUB: Genslabs=12, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
hpet clockevent registered
Calibrating delay using timer specific routine.. 4273.66 BogoMIPS (lpj=21368347)
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM2)
using mwait in idle threads.
debug: unmapping init memory ffffffff805df000..ffffffff805e4000
ACPI: Core revision 20080321
CPU0: Intel(R) Core(TM)2 CPU          6400  @ 2.13GHz stepping 02
Using local APIC timer interrupts.
APIC timer calibration result 16679989
Detected 16.679 MHz APIC timer.
lockdep: fixing up alternatives.
Booting processor 1/1 ip 6000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4270.11 BogoMIPS (lpj=21350598)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM2)
x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
CPU1: Intel(R) Core(TM)2 CPU          6400  @ 2.13GHz stepping 02
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
Total of 2 processors activated (8543.78 BogoMIPS).
net_namespace: 1040 bytes
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: Using configuration type 1 for base access
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:1f.0: quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 0480-04bf claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 *14 15)
ACPI Warning (tbutils-0217): Incorrect checksum in table [OEMB] - 08, should be 03 [20080321]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 15 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 3.00 loaded.
PCI: Using ACPI for IRQ routing
PCI-GART: No AMD northbridge found.
Switched to high resolution mode on CPU 0
Switched to high resolution mode on CPU 1
system 00:01: iomem range 0xfed14000-0xfed19fff has been reserved
system 00:07: ioport range 0x290-0x297 has been reserved
system 00:08: ioport range 0x4d0-0x4d1 has been reserved
system 00:08: ioport range 0x800-0x87f has been reserved
system 00:08: ioport range 0x480-0x4bf has been reserved
system 00:08: iomem range 0xffafe000-0xffb0cbff could not be reserved
system 00:08: iomem range 0xffb00000-0xffbfffff could not be reserved
system 00:08: iomem range 0xfed1c000-0xfed1ffff has been reserved
system 00:08: iomem range 0xfed20000-0xfed8ffff has been reserved
system 00:08: iomem range 0xfff00000-0xfffffffe could not be reserved
system 00:08: iomem range 0xfebfe000-0xfebfec00 has been reserved
system 00:0b: iomem range 0xfec00000-0xfec00fff has been reserved
system 00:0b: iomem range 0xfee00000-0xfee00fff could not be reserved
system 00:0d: iomem range 0xe0000000-0xefffffff has been reserved
system 00:0e: iomem range 0x0-0x9ffff could not be reserved
system 00:0e: iomem range 0xc0000-0xcffff has been reserved
system 00:0e: iomem range 0xe0000-0xfffff could not be reserved
system 00:0e: iomem range 0x100000-0x7fffffff could not be reserved
system 00:0e: iomem range 0x0-0xffffffffffffffff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: 9000-9fff
  MEM window: 0xf8700000-0xfe7fffff
  PREFETCH window: 0x00000000bfe00000-0x00000000dfdfffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: 0x00000000dfe00000-0x00000000dfefffff
PCI: Bridge: 0000:00:1c.3
  IO window: disabled.
  MEM window: 0xfe900000-0xfe9fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
  IO window: a000-afff
  MEM window: 0xfe800000-0xfe8fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: b000-bfff
  MEM window: 0xfea00000-0xfeafffff
  PREFETCH window: 0x0000000088000000-0x00000000880fffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1c.3 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.4 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 3670016 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
NET: Registered protocol family 1
msgmni has been set to 7862 for ipc namespace ffffffff80572360
io scheduler noop registered
io scheduler cfq registered (default)
pci 0000:01:00.0: Boot video device
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.103
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:03:00.0 to 64
atl1 0000:03:00.0: version 2.1.1
8139too Fast Ethernet driver 0.9.28
ACPI: PCI Interrupt 0000:05:02.0[A] -> GSI 23 (level, low) -> IRQ 23
eth1: RealTek RTL8139 at 0xb800, 00:80:48:2e:06:2e, IRQ 23
eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
netconsole: local port 6665
netconsole: local IP 192.168.0.1
netconsole: interface eth0
netconsole: remote port 9353
netconsole: remote IP 192.168.0.42
netconsole: remote ethernet address 00:1b:38:af:22:49
netconsole: device eth0 not up yet, forcing it
atl1 0000:03:00.0: eth0 link is up 1000 Mbps full duplex
netconsole: timeout waiting for carrier
console [netcon0] enabled
netconsole: network logging started
Driver 'sd' needs updating - please use bus_type methods
ahci 0000:02:00.0: version 3.0
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
PCI: Setting latency timer of device 0000:02:00.0 to 64
scsi0 : ahci
scsi1 : ahci
ata1: SATA max UDMA/133 abar m8192@0xfe8fe000 port 0xfe8fe100 irq 16
ata2: SATA max UDMA/133 abar m8192@0xfe8fe000 port 0xfe8fe180 irq 16
ata1: SATA link down (SStatus 0 SControl 300)
ata2: SATA link down (SStatus 0 SControl 300)
ata_piix 0000:00:1f.2: version 2.12
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0xec00 ctl 0xe880 bmdma 0xe400 irq 19
ata4: SATA max UDMA/133 cmd 0xe800 ctl 0xe480 bmdma 0xe408 irq 19
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-8: ST3750330AS, SD15, max UDMA/133
ata3.00: 1465149168 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata3.01: ATA-7: ST3160811AS, 3.AAE, max UDMA/133
ata3.01: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata3.00: configured for UDMA/133
ata3.01: configured for UDMA/133
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-7: ST3250620AS, 3.AAE, max UDMA/133
ata4.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata4.00: configured for UDMA/133
scsi 2:0:0:0: Direct-Access     ATA      ST3750330AS      SD15 PQ: 0 ANSI: 5
sd 2:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sda] 1465149168 512-byte hardware sectors (750156 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2
sd 2:0:0:0: [sda] Attached SCSI disk
scsi 2:0:1:0: Direct-Access     ATA      ST3160811AS      3.AA PQ: 0 ANSI: 5
sd 2:0:1:0: [sdb] 312581808 512-byte hardware sectors (160042 MB)
sd 2:0:1:0: [sdb] Write Protect is off
sd 2:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 2:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:1:0: [sdb] 312581808 512-byte hardware sectors (160042 MB)
sd 2:0:1:0: [sdb] Write Protect is off
sd 2:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 2:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: unknown partition table
sd 2:0:1:0: [sdb] Attached SCSI disk
scsi 3:0:0:0: Direct-Access     ATA      ST3250620AS      3.AA PQ: 0 ANSI: 5
sd 3:0:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1
sd 3:0:0:0: [sdc] Attached SCSI disk
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 19 (level, low) -> IRQ 19
ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
PCI: Setting latency timer of device 0000:00:1f.5 to 64
scsi4 : ata_piix
scsi5 : ata_piix
ata5: SATA max UDMA/133 cmd 0xd400 ctl 0xd080 bmdma 0xc880 irq 19
ata6: SATA max UDMA/133 cmd 0xd000 ctl 0xcc00 bmdma 0xc888 irq 19
ata5: SATA link down (SStatus 0 SControl 300)
ata6: SATA link down (SStatus 0 SControl 300)
ACPI: PCI Interrupt 0000:02:00.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:02:00.1 to 64
scsi6 : pata_jmicron
scsi7 : pata_jmicron
ata7: PATA max UDMA/100 cmd 0xac00 ctl 0xa880 bmdma 0xa400 irq 17
ata8: PATA max UDMA/100 cmd 0xa800 ctl 0xa480 bmdma 0xa408 irq 17
ata7.01: ATAPI: _NEC DV-5800C, D9S2, max UDMA/33
ata7.01: configured for UDMA/33
ata8: link is slow to respond, please be patient (ready=0)
ata8: device not ready (errno=-16), forcing hardreset
ata8: link is slow to respond, please be patient (ready=0)
ata8: SRST failed (errno=-16)
CPA self-test:
 4k 6144 large 2548 gb 0 x 0[0-0] miss 262144
 4k 182784 large 2203 gb 0 x 0[0-0] miss 262144
 4k 182784 large 2203 gb 0 x 0[0-0] miss 262144
ok.
ata8: link is slow to respond, please be patient (ready=0)
ata8: SRST failed (errno=-16)
ata8: link is slow to respond, please be patient (ready=0)
ata8: SRST failed (errno=-16)
ata8: SRST failed (errno=-16)
ata8: reset failed, giving up
scsi 6:0:1:0: CD-ROM            _NEC     DV-5800C         D9S2 PQ: 0 ANSI: 5
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.16.
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1b.0 to 64
input: AT Translated Set 2 keyboard as /class/input/input0
ALSA device list:
  #0: HDA Intel at 0xfebf8000 irq 22
TCP cubic registered
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
debug: unmapping init memory ffffffff805e4000..ffffffff80620000
Write protecting the kernel read-only data: 3412k
Testing CPA: undo ffffffff8046e000-ffffffff8055e000
Testing CPA: again
Driver 'sr' needs updating - please use bus_type methods
sr0: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 6:0:1:0: Attached scsi CD-ROM sr0
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000dc00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.26-rc1-bisect uhci_hcd
usb usb1: SerialNumber: 0000:00:1a.0
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1a.1: irq 17, io base 0x0000e000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.26-rc1-bisect uhci_hcd
usb usb2: SerialNumber: 0000:00:1a.1
ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:1a.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xfebffc00
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: EHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.26-rc1-bisect ehci_hcd
usb usb3: SerialNumber: 0000:00:1a.7
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000d480
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.26-rc1-bisect uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.0
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000d800
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.26-rc1-bisect uhci_hcd
usb usb5: SerialNumber: 0000:00:1d.1
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000d880
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb6: Product: UHCI Host Controller
usb usb6: Manufacturer: Linux 2.6.26-rc1-bisect uhci_hcd
usb usb6: SerialNumber: 0000:00:1d.2
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 7
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfebff800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 6 ports detected
usb usb7: New USB device found, idVendor=1d6b, idProduct=0002
usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb7: Product: EHCI Host Controller
usb usb7: Manufacturer: Linux 2.6.26-rc1-bisect ehci_hcd
usb usb7: SerialNumber: 0000:00:1d.7
EXT3 FS on sda2, internal journal
usbcore: registered new interface driver usblp
Adding 9775512k swap on /dev/sda1.  Priority:-1 extents:1 across:9775512k
ip_tables: (C) 2000-2006 Netfilter Core Team
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
eth1: link up, 100Mbps, full-duplex, lpa 0x45E1

