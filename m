From: Marc Howard Zuckman <marc@fallon.classyad.com>
Subject: Re: Problem setting dma using pata_it821x driver in vanilla 2.6.23.12
 and gentoo-sources 2.6.23-r3
Date: Sun, 13 Jan 2008 01:37:45 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0801130129060.6533@classyad.com>
References: <200801051734.18088.marc@fallon.classyad.com> <478434C4.5000209@gmail.com>
 <Pine.LNX.4.64.0801100741580.6632@classyad.com> <47861B05.2010201@gmail.com>
 <Pine.LNX.4.64.0801102143150.11200@classyad.com> <4786DE62.6090604@gmail.com>
 <Pine.LNX.4.64.0801121338140.8409@classyad.com> <4789A375.9000302@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from c-71-205-247-245.hsd1.mi.comcast.net ([71.205.247.245]:60088
	"EHLO fallon.classyad.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbYAMGgm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 01:36:42 -0500
In-Reply-To: <4789A375.9000302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Sun, 13 Jan 2008, Tejun Heo wrote:

>
> Does this change anything?  And, yeah, I really wanna see the hdparm
> --Istdout too.
>
I applied the patch to libata-core.c.

A scsi device, /dev/sdb, was recognized, but partition /dev/sdb1 (where
all the data resides) is not seen.  Boot log messages and hdparm output
follow:

Linux version 2.6.23.12 (root@fallon.classyad.com) (gcc version 4.1.1 (Gentoo 4.1.1-r3)) #5 SMP Sun Jan 13 01:07:07 EST 2008
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000005fff0000 (usable)
  BIOS-e820: 000000005fff0000 - 000000005fff3000 (ACPI NVS)
  BIOS-e820: 000000005fff3000 - 0000000060000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
639MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5320
Entering add_active_range(0, 0, 393200) 0 entries of 256 used
Zone PFN ranges:
   DMA             0 ->     4096
   Normal       4096 ->   229376
   HighMem    229376 ->   393200
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
     0:        0 ->   393200
On node 0 totalpages: 393200
   DMA zone: 32 pages used for memmap
   DMA zone: 0 pages reserved
   DMA zone: 4064 pages, LIFO batch:0
   Normal zone: 1760 pages used for memmap
   Normal zone: 223520 pages, LIFO batch:31
   HighMem zone: 1279 pages used for memmap
   HighMem zone: 162545 pages, LIFO batch:31
   Movable zone: 0 pages used for memmap
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 15:2 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 70000000 (gap: 60000000:9ec00000)
Built 1 zonelists in Zone order.  Total pages: 390129
Kernel command line: BOOT_IMAGE=p1ata2.6.23 ro root=307 ide0=ata66 ide2=ata66
ide_setup: ide0=ata66 -- OBSOLETE OPTION, WILL BE REMOVED SOON!
ide_setup: ide2=ata66 -- OBSOLETE OPTION, WILL BE REMOVED SOON!
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2813.563 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1552764k/1572800k available (3124k kernel code, 18908k reserved, 1707k data, 256k init, 655296k highmem)
virtual kernel memory layout:
     fixmap  : 0xffe1a000 - 0xfffff000   (1940 kB)
     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
       .init : 0xc05bf000 - 0xc05ff000   ( 256 kB)
       .data : 0xc040d037 - 0xc05b7ebc   (1707 kB)
       .text : 0xc0100000 - 0xc040d037   (3124 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5631.42 BogoMIPS (lpj=11262850)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 0000b080 00004400 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 17k freed
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Total of 1 processors activated (5631.42 BogoMIPS).
ExtINT not setup in hardware but reported by MP table
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
Brought up 1 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb640, last bus=3
PCI: Using configuration type 1
Setting up standard PCI resources
SCSI subsystem initialized
libata version 2.21 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1080-10bf claimed by ICH4 GPIO
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
PCI->APIC IRQ transform: 0000:00:1d.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:1d.1[B] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:1d.2[C] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:1d.3[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:1d.7[D] -> IRQ 23
PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:00:1f.5[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:02:01.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:03:02.0[A] -> IRQ 22
PCI->APIC IRQ transform: 0000:03:03.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:03:04.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:03:04.1[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:03:0a.0[A] -> IRQ 22
PCI->APIC IRQ transform: 0000:03:0c.0[A] -> IRQ 21
PCI: Bridge: 0000:00:01.0
   IO window: disabled.
   MEM window: f0000000-f1ffffff
   PREFETCH window: e8000000-efffffff
PCI: Bridge: 0000:00:03.0
   IO window: 9000-9fff
   MEM window: f4000000-f40fffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
   IO window: a000-bfff
   MEM window: f2000000-f3ffffff
   PREFETCH window: f4100000-f41fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
Time: tsc clocksource has been installed.
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:01:00.0
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
intel_rng: FWH not detected
Linux agpgart interface v0.102
agpgart: Detected an Intel i875 Chipset.
agpgart: AGP aperture is 128M @ 0xe0000000
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using get_cycles().
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: Printer, Hewlett-Packard HP LaserJet 6P
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: module loaded
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
Copyright (c) 1999-2006 Intel Corporation.
PCI: Setting latency timer of device 0000:02:01.0 to 64
e1000: 0000:02:01.0: e1000_probe: (PCI:33MHz:32-bit) 00:0d:61:19:75:47
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Linux Tulip driver version 1.1.15 (Feb 27, 2007)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #0 config 1000 status 7809 advertising 01e1.
eth1: Digital DS21140 Tulip rev 34 at Port 0xa000, 00:40:05:A3:3D:B0, IRQ 22.
Linux video capture interface: v2.00
bttv: driver version 0.9.17 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 2) at 0000:03:04.0, irq: 18, latency: 32, mmio: 0xf4100000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00fffffb [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
tveeprom 0-0050: Hauppauge model 61201, rev B226, serial# 2049689
tveeprom 0-0050: tuner model is Temic 4036FY5 (idx 26, type 8)
tveeprom 0-0050: TV standards NTSC(M) (eeprom 0x08)
tveeprom 0-0050: audio processor is None (idx 0)
tveeprom 0-0050: has no radio
bttv0: Hauppauge eeprom indicates model#61201
bttv0: tuner type=8
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
tuner 0-0061: chip found @ 0xc2 (bt878 #0 [sw])
tuner 0-0061: type set to 8 (Temic NTSC (4036 FY5))
tuner 0-0061: type set to 8 (Temic NTSC (4036 FY5))
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: WDC WD1000BB-00CAA1, ATA DISK drive
hdb: QUANTUM FIREBALL EX6.4A, ATA DISK drive
hda: selected mode 0x45
hdb: selected mode 0x42
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA CD/DVDW SDR5372V, ATAPI CD/DVD-ROM drive
hdd: TDK CDRW321040B, ATAPI CD/DVD-ROM drive
hdc: selected mode 0x42
hdd: selected mode 0x42
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: Host Protected Area detected.
 	current capacity is 195369455 sectors (100029 MB)
 	native  capacity is 195371568 sectors (100030 MB)
hda: Host Protected Area disabled.
hda: 195371568 sectors (100030 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
  hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
hdb: max request size: 128KiB
hdb: 12594960 sectors (6448 MB) w/418KiB Cache, CHS=13328/15/63, UDMA(33)
hdb: cache flushes not supported
  hdb: hdb1 hdb2
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
sym0: <875> rev 0x3 at pci 0000:03:03.0 irq 16
sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.3
scsi 0:0:0:0: Direct-Access     QUANTUM  VIKING II 4.5WLS 4110 PQ: 0 ANSI: 2
  target0:0:0: tagged command queuing enabled, command queue depth 16.
  target0:0:0: Beginning Domain Validation
  target0:0:0: asynchronous
  target0:0:0: wide asynchronous
  target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)
  target0:0:0: Domain Validation skipping write tests
  target0:0:0: Ending Domain Validation
  target0:0:1: Scan at boot disabled in NVRAM
  target0:0:2: Scan at boot disabled in NVRAM
  target0:0:6: Multiple LUNs disabled in NVRAM
scsi 0:0:6:0: Sequential-Access CONNER   CTT8000-S        1.17 PQ: 0 ANSI: 2
  target0:0:6: Beginning Domain Validation
  target0:0:6: asynchronous
  target0:0:6: FAST-5 SCSI 5.0 MB/s ST (200 ns, offset 15)
  target0:0:6: Domain Validation skipping write tests
  target0:0:6: Ending Domain Validation
  target0:0:8: Scan at boot disabled in NVRAM
  target0:0:9: Scan at boot disabled in NVRAM
  target0:0:10: Scan at boot disabled in NVRAM
  target0:0:11: Scan at boot disabled in NVRAM
  target0:0:12: Scan at boot disabled in NVRAM
  target0:0:13: Scan at boot disabled in NVRAM
  target0:0:14: Scan at boot disabled in NVRAM
  target0:0:15: Scan at boot disabled in NVRAM
st: Version 20070203, fixed bufsize 32768, s/g segs 256
st 0:0:6:0: Attached scsi tape st0
st 0:0:6:0: st0: try direct i/o: yes (alignment 512 B)
sd 0:0:0:0: [sda] 8910423 512-byte hardware sectors (4562 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: b3 00 00 08
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 8910423 512-byte hardware sectors (4562 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: b3 00 00 08
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
st 0:0:6:0: Attached scsi generic sg1 type 1
pata_it821x: controller in smart mode.
PCI: Setting latency timer of device 0000:03:0c.0 to 64
scsi1 : pata_it821x
scsi2 : pata_it821x
ata1: PATA max MWDMA2 cmd 0x0001a810 ctl 0x0001ac02 bmdma 0x0001b800 irq 21
ata2: PATA max MWDMA2 cmd 0x0001b010 ctl 0x0001b402 bmdma 0x0001b808 irq 21
ata1.00: ATA-0: Integrated Technology Express Inc, , max MWDMA2
ata1.00: 0 sectors, multi 0, CHS 0/0/0
ata1.00: Drive reports diagnostics failure. This may indicate a drive
ata1.00: fault or invalid emulation. Contact drive vendor for information.
IT821x RAID1 volume.
ata1.00: configured for PIO
scsi 1:0:0:0: Direct-Access     ATA      Integrated Techn n/a  PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] Very big device. Trying to use READ CAPACITY(16).
sd 1:0:0:0: [sdb] 0 512-byte hardware sectors (0 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 1:0:0:0: Attached scsi generic sg2 type 0
I2O subsystem v1.325
i2o: max drivers = 8
I2O Configuration OSM v1.323
I2O Bus Adapter OSM v1.317
I2O Block Device OSM v1.325
I2O SCSI Peripheral OSM v1.316
I2O ProcFS OSM v1.316
Fusion MPT base driver 3.04.05
Copyright (c) 1999-2007 LSI Logic Corporation
Fusion MPT SPI Host driver 3.04.05
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[22]  MMIO=[f3006000-f30067ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ieee1394: raw1394: /dev/raw1394 device initialized
kvm: no hardware support
usbmon: debugfs is not available
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf4200000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000cc00
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000c000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000c400
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000c800
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 2-1: new full speed USB device using uhci_hcd and address 2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000d6100001749f3]
usb 2-1: configuration #1 chosen from 1 choice
usb 2-2: new full speed USB device using uhci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
usb 3-1: new low speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
usb 3-2: new low speed USB device using uhci_hcd and address 3
usb 3-2: configuration #1 chosen from 1 choice
usbcore: registered new interface driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for USB modems and ISDN adapters
usblp0: USB Bidirectional printer dev 2 if 0 alt 1 proto 2 vid 0x03F0 pid 0x3C02
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
it87: Found IT8712F chip at 0x290, revision 5
EDAC MC: Ver: 2.1.0 Jan  4 2008
EDAC i82875p: i82875p init one
PCI: Unable to reserve mem region #1:1000@fecf0000 for device 0000:00:06.0
EDAC MC0: Giving out device to 'i82875p_edac' 'i82875p': DEV 0000:00:00.0
EDAC PCI0: Giving out device to module 'i82875p_edac' controller 'EDAC PCI controller': DEV '0000:00:00.0' (POLLED)
input: Logitech Trackball as /class/input/input0
input: USB HID v1.10 Mouse [Logitech Trackball] on usb-0000:00:1d.1-1
input: Logitech Logitech USB Keyboard as /class/input/input1
input: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on usb-0000:00:1d.1-2
input: Logitech Logitech USB Keyboard as /class/input/input2
input: USB HID v1.10 Mouse [Logitech Logitech USB Keyboard] on usb-0000:00:1d.1-2
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.14 (Fri Jul 20 09:12:58 2007 UTC).
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 53811 usecs
intel8x0: clocking to 48000
ALSA device list:
   #0: Intel ICH5 with ALC658D at irq 17
   #1: Brooktree Bt878 at 0xf4101000, irq 18
oprofile: using NMI interrupt.
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 256k freed
EXT3 FS on hda7, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1177468k swap on /dev/hdb2.  Priority:-1 extents:1 across:1177468k
hda: selected mode 0x45
hdb: selected mode 0x42

hdparm /dev/sdb
/dev/sdb:
  IO_support    =  0 (default 16-bit)
  readonly      =  0 (off)
  readahead     = 256 (on)
  geometry      = 0/255/63, sectors = 0, start = 0

hdparm --Istdout /dev/sdb:
/dev/sdb:
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 2008 1301 0601 4215 0101 0005
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 496e 7465 6772 6174 6564
2054 6563 686e 6f6c 6f67 7920 4578 7072
6573 7320 496e 6320 2020 2020 2020 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 ffff 0fff 0000 0007
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
003f 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 9eae 12a1 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0001 0003 3133 2121 9111 0091 3266
0021 0021 0001 0505 0005 0500 0000 0005
0005 0005 0040 0000 0000 0000 0000 0000
0000 0000 0001 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

Marc H. Zuckman
