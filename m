From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: ATA_PIIX + SATA_MV -> kernel ate my HDD
Date: Thu, 23 Aug 2007 17:10:53 +0200
Message-ID: <46CDA37D.9070208@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:43685 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762435AbXHWPLF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Aug 2007 11:11:05 -0400
Received: from postfix1.syneticon.net (postfix1.syneticon.net [192.168.112.6])
	by mail2.syneticon.net (Postfix) with ESMTP id B99D240FF4
	for <linux-ide@vger.kernel.org>; Thu, 23 Aug 2007 17:11:00 +0200 (CEST)
Received: from localhost (filter1.syneticon.net [192.168.113.3])
	by postfix1.syneticon.net (Postfix) with ESMTP id 96C7994DC
	for <linux-ide@vger.kernel.org>; Thu, 23 Aug 2007 17:10:59 +0200 (CEST)
Received: from postfix1.syneticon.net ([192.168.113.4])
	by localhost (mx03.syneticon.net [192.168.113.3]) (amavisd-new, port 10025)
	with ESMTP id GfVt9m9DAPON for <linux-ide@vger.kernel.org>;
	Thu, 23 Aug 2007 17:10:55 +0200 (CEST)
Received: from [192.168.10.145] (xdsl-87-79-108-211.netcologne.de [87.79.108.211])
	by postfix1.syneticon.net (Postfix) with ESMTP
	for <linux-ide@vger.kernel.org>; Thu, 23 Aug 2007 17:10:55 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>

I have a device with Intel ICH4 IDE controller, and a Marvell SATA one.

The device has one IDE and five SATA drives connected.

Till now, I used the old IDE, and it worked fine: the system had a 
/dev/hda drive, and five /dev/sd[a-e] drives.

Just today I compiled the kernel with PATA support (ATA_PIIX) instead of 
older IDE, and the kernel doesn't see one SATA drive anymore.

/dev/hda is now /dev/sda (obviously), but the kernel detects only four 
SATA drives (/dev/sd[b-e]).


Below, lspci, and dmesg.
Any clues, of course, are appreciated. If the .config is needed, let me 
know.


# lspci
00:00.0 Host bridge: Intel Corporation Unknown device 358c (rev 02)
00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV 
Processor to I/O Controller (rev 02)
00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV 
Processor to I/O Controller (rev 02)
00:02.0 VGA compatible controller: Intel Corporation Unknown device 358e 
(rev 02)
00:02.1 Display controller: Intel Corporation Unknown device 358e (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 
EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 83)
00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface 
Bridge (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE 
Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
SMBus Controller (rev 03)
01:00.0 SCSI storage controller: Marvell Technology Group Ltd. 
MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
01:01.0 Ethernet controller: Intel Corporation 82541GI Gigabit Ethernet 
Controller (rev 05)
01:02.0 Ethernet controller: Intel Corporation 82541GI Gigabit Ethernet 
Controller (rev 05)
01:03.0 USB Controller: NetChip Technology, Inc Unknown device 2282 (rev 11)


# dmesg
Linux version 2.6.22.4-N5200-1 (root@superthecus) (gcc version 4.1.2 
20061115 (prerelease) (Debian 4.1.1-21)) #2 Thu Aug 23 16:41:37 CEST 2007
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000000fbf0000 (usable)
  BIOS-e820: 000000000fbf0000 - 000000000fbf3000 (ACPI NVS)
  BIOS-e820: 000000000fbf3000 - 000000000fc00000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
251MB LOWMEM available.
found SMP MP-table at 000f3e30
Entering add_active_range(0, 0, 64496) 0 entries of 256 used
Zone PFN ranges:
   DMA             0 ->     4096
   Normal       4096 ->    64496
early_node_map[1] active PFN ranges
     0:        0 ->    64496
On node 0 totalpages: 64496
   DMA zone: 32 pages used for memmap
   DMA zone: 0 pages reserved
   DMA zone: 4064 pages, LIFO batch:0
   Normal zone: 471 pages used for memmap
   Normal zone: 59929 pages, LIFO batch:15
DMI 2.2 present.
ACPI: RSDP 000F5E60, 0014 (r0 IntelR)
ACPI: RSDT 0FBF3040, 002C (r1 IntelR AWRDACPI 42302E31 AWRD        0)
ACPI: FACP 0FBF30C0, 0074 (r1 IntelR AWRDACPI 42302E31 AWRD        0)
ACPI: DSDT 0FBF3180, 3467 (r1 INTELR AWRDACPI     1000 MSFT  100000E)
ACPI: FACS 0FBF0000, 0040
ACPI: APIC 0FBF6640, 005A (r1 IntelR AWRDACPI 42302E31 AWRD        0)
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:9 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 10000000 (gap: 0fc00000:ef000000)
Built 1 zonelists.  Total pages: 63993
Kernel command line: auto BOOT_IMAGE=2.6.22.4-1 ro root=/dev/sda1 
console=ttyS0,115200 panic=20
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 4096 bytes)
Detected 599.014 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 252672k/257984k available (1559k kernel code, 4776k reserved, 
673k data, 148k init, 0k highmem)
virtual kernel memory layout:
     fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
     vmalloc : 0xd0800000 - 0xfffb5000   ( 759 MB)
     lowmem  : 0xc0000000 - 0xcfbf0000   ( 251 MB)
       .init : 0xc0332000 - 0xc0357000   ( 148 kB)
       .data : 0xc0285e13 - 0xc032e56c   ( 673 kB)
       .text : 0xc0100000 - 0xc0285e13   (1559 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
SLUB: Genslabs=22, HWalign=64, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Calibrating delay using timer specific routine.. 1198.70 BogoMIPS 
(lpj=5993503)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: a7e9fbbf 00000000 00000000 00000000 
00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 512K
CPU: After all inits, caps: a7e9fbbf 00000000 00000000 00002040 00000000 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: Intel(R) Celeron(R) M processor          600MHz stepping 05
Checking 'hlt' instruction... OK.
ACPI: Core revision 20070126
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb610, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH4 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 7 9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 11 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 2.21 loaded.
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
pnp: 00:08: ioport range 0x400-0x4bf could not be reserved
pnp: 00:0a: iomem range 0xd0000-0xd3fff has been reserved
pnp: 00:0a: iomem range 0xf0000-0xf7fff could not be reserved
pnp: 00:0a: iomem range 0xf8000-0xfbfff could not be reserved
pnp: 00:0a: iomem range 0xfc000-0xfffff could not be reserved
Time: tsc clocksource has been installed.
PCI: Bridge: 0000:00:1e.0
   IO window: d000-dfff
   MEM window: e8000000-e81fffff
   PREFETCH window: e8200000-e82fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
Machine check exception polling timer started.
io scheduler noop registered
io scheduler cfq registered (default)
Boot video device is 0000:00:02.0
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU0] (supports 2 throttling states)
Real Time Clock Driver v1.12ac
intel_rng: FWH not detected
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:07: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
loop: module loaded
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 21 (level, low) -> IRQ 16
e1000: 0000:01:01.0: e1000_probe: (PCI:33MHz:32-bit) 00:14:fd:10:49:da
Switched to high resolution mode on CPU 0
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 22 (level, low) -> IRQ 17
e1000: 0000:01:02.0: e1000_probe: (PCI:33MHz:32-bit) 00:14:fd:10:49:db
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
ata_piix 0000:00:1f.1: version 2.11
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.1 to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001f000 
irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001f008 
irq 15
ata1.00: ATA-0: TRANSCEND, 2.0, max PIO4
ata1.00: 2000880 sectors, multi 1: LBA
ata1.00: configured for PIO4
ata2: port disabled. ignoring.
scsi 0:0:0:0: Direct-Access     ATA      TRANSCEND        2.0  PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 2000880 512-byte hardware sectors (1024 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:0:0: [sda] 2000880 512-byte hardware sectors (1024 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't 
support DPO or FUA
  sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
sata_mv 0000:01:00.0: version 0.81
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 20 (level, low) -> IRQ 19
sata_mv 0000:01:00.0: 32 slots 8 ports SCSI mode IRQ via INTx
scsi2 : sata_mv
scsi3 : sata_mv
scsi4 : sata_mv
scsi5 : sata_mv
scsi6 : sata_mv
scsi7 : sata_mv
scsi8 : sata_mv
scsi9 : sata_mv
ata3: SATA max UDMA/133 cmd 0x00000000 ctl 0xd0922120 bmdma 0x00000000 
irq 19
ata4: SATA max UDMA/133 cmd 0x00000000 ctl 0xd0924120 bmdma 0x00000000 
irq 19
ata5: SATA max UDMA/133 cmd 0x00000000 ctl 0xd0926120 bmdma 0x00000000 
irq 19
ata6: SATA max UDMA/133 cmd 0x00000000 ctl 0xd0928120 bmdma 0x00000000 
irq 19
ata7: SATA max UDMA/133 cmd 0x00000000 ctl 0xd0932120 bmdma 0x00000000 
irq 19
ata8: SATA max UDMA/133 cmd 0x00000000 ctl 0xd0934120 bmdma 0x00000000 
irq 19
ata9: SATA max UDMA/133 cmd 0x00000000 ctl 0xd0936120 bmdma 0x00000000 
irq 19
ata10: SATA max UDMA/133 cmd 0x00000000 ctl 0xd0938120 bmdma 0x00000000 
irq 19
ata3.00: ATA-7: WDC WD4000YR-01PLB0, 01.06A01, max UDMA/133
ata3.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata3.00: configured for UDMA/133
ata4.00: ATA-7: WDC WD4000YR-01PLB0, 01.06A01, max UDMA/133
ata4.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata4.00: configured for UDMA/133
ata5.00: ATA-7: WDC WD4000YR-01PLB0, 01.06A01, max UDMA/133
ata5.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata5.00: configured for UDMA/133
ata6.00: ATA-7: WDC WD4000YR-01PLB0, 01.06A01, max UDMA/133
ata6.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata6.00: configured for UDMA/133
ata7: no device found (phy stat 00000121)
ata8: no device found (phy stat 00000000)
ata9: no device found (phy stat 00000000)
ata10: no device found (phy stat 00000000)
scsi 2:0:0:0: Direct-Access     ATA      WDC WD4000YR-01P 01.0 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 2:0:0:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdb: sdb1
sd 2:0:0:0: [sdb] Attached SCSI disk
scsi 3:0:0:0: Direct-Access     ATA      WDC WD4000YR-01P 01.0 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdc] 781422768 512-byte hardware sectors (400088 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 3:0:0:0: [sdc] 781422768 512-byte hardware sectors (400088 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdc: sdc1
sd 3:0:0:0: [sdc] Attached SCSI disk
scsi 4:0:0:0: Direct-Access     ATA      WDC WD4000YR-01P 01.0 PQ: 0 ANSI: 5
sd 4:0:0:0: [sdd] 781422768 512-byte hardware sectors (400088 MB)
sd 4:0:0:0: [sdd] Write Protect is off
sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 4:0:0:0: [sdd] 781422768 512-byte hardware sectors (400088 MB)
sd 4:0:0:0: [sdd] Write Protect is off
sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdd: sdd1
sd 4:0:0:0: [sdd] Attached SCSI disk
scsi 5:0:0:0: Direct-Access     ATA      WDC WD4000YR-01P 01.0 PQ: 0 ANSI: 5
sd 5:0:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
sd 5:0:0:0: [sde] Write Protect is off
sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 5:0:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
sd 5:0:0:0: [sde] Write Protect is off
sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sde: sde1
sd 5:0:0:0: [sde] Attached SCSI disk
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 20
md: raid1 personality registered for level 1
raid6: int32x1    196 MB/s
raid6: int32x2    230 MB/s
raid6: int32x4    194 MB/s
raid6: int32x8    152 MB/s
raid6: mmxx1      600 MB/s
raid6: mmxx2      679 MB/s
raid6: sse1x1     492 MB/s
raid6: sse1x2     698 MB/s
raid6: sse2x1     796 MB/s
raid6: sse2x2     892 MB/s
raid6: using algorithm sse2x2 (892 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
    pIII_sse  :  1602.400 MB/sec
raid5: using function: pIII_sse (1602.400 MB/sec)
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: 
dm-devel@redhat.com
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sde1 ...
md:  adding sde1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md: created md0
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: bind<sde1>
md: running: <sde1><sdd1><sdc1><sdb1>
raid5: device sde1 operational as raid disk 3
raid5: device sdd1 operational as raid disk 2
raid5: device sdc1 operational as raid disk 1
raid5: device sdb1 operational as raid disk 0
raid5: allocated 5244kB for md0
raid5: raid level 5 set md0 active with 4 out of 5 devices, algorithm 2
RAID5 conf printout:
  --- rd:5 wd:4
  disk 0, o:1, dev:sdb1
  disk 1, o:1, dev:sdc1
  disk 2, o:1, dev:sdd1
  disk 3, o:1, dev:sde1
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
EXT3 FS on sda1, internal journal
Ethernet Channel Bonding Driver: v3.1.3 (June 13, 2007)
bonding: MII link monitoring set to 100 ms
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, Flow 
Control: RX
bonding: bond0: enslaving eth0 as an active interface with an up link.
e1000: eth1: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, Flow 
Control: RX
bonding: bond0: enslaving eth1 as an active interface with an up link.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.


-- 
Tomasz Chmielewski
http://wpkg.org
