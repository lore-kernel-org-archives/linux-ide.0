From: "Jakub W." =?iso-8859-2?Q?J=F3=BCwicki?= <jakub007@go2.pl>
Subject: sis180 on asrock k7s8xe+ -> crashes
Date: Fri, 27 Aug 2004 17:30:38 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1093620638.9715.17.camel@alladin.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kogut.o2.pl ([212.126.20.61]:4482 "EHLO kogut.o2.pl")
	by vger.kernel.org with ESMTP id S266219AbUH0Pas (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Aug 2004 11:30:48 -0400
Received: from w2ksrv.mshome.net (bme81.neoplus.adsl.tpnet.pl [83.28.224.81])
	by kogut.o2.pl (o2.pl Mailer 2.0.1) with ESMTP id 51B622EE8EF
	for <linux-ide@vger.kernel.org>; Fri, 27 Aug 2004 17:30:39 +0200 (CEST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,
I have ASRock K7S8XE+ motherboard with SIS180. I wanted to use SATA with
2.6.8 and previous kernels, but it doesn't work - after detecting hdd
system is stuck. Could you look at dmesg and tell if there are chances
that in the near future it will be working?

Regards,
Jimm

-----------------------------------
Linux version 2.6.8-gentoo-r3 (root@alladin.local) (gcc version 3.3.4
20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #2 Thu Aug 26
22:09:53 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @
0x000faaa0
ACPI: RSDT (v001 AMIINT SiS740XX 0x00001000 MSFT 0x0100000b) @
0x1fff0000
ACPI: FADT (v001 AMIINT SiS740XX 0x00000011 MSFT 0x0100000b) @
0x1fff0030
ACPI: MADT (v001 AMIINT SiS740XX 0x00001000 MSFT 0x0100000b) @
0x1fff00c0
ACPI: DSDT (v001    SiS      748 0x00000100 MSFT 0x0100000d) @
0x00000000
ACPI: PM-Timer IO Port: 0x808
Built 1 zonelists
Kernel command line: root=/dev/hda3 vga=791 pmdisk=/dev/hda3
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1575.237 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 513860k/524224k available (3324k kernel code, 9580k reserved,
839k data, 184k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 3129.34 BogoMIPS
Security Scaffold v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
checking if image is initramfs...it isn't (ungzip failed); looks like an
initrd
Freeing initrd memory: 40k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=2
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully
acquired
Parsing all Control
Methods:................................................................................................................................................
Table [DSDT](id F004) - 428 Objects with 43 Devices 144 Methods 12
Regions
ACPI Namespace successfully loaded at root c05580fc
ACPI: IRQ9 SCI: Edge set to Level Trigger.
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
successful
evgpeblk-0867 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at
0000000000000820 on int 9
evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 10
Runtime GPEs in this block
evgpeblk-0867 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at
0000000000000830 on int 9
evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 0
Runtime GPEs in this block
Completing Region/Field/Buffer/Package
initialization:..............................................................................
Initialized 12/12 Regions 5/5 Fields 33/33 Buffers 28/28 Packages (437
nodes)
Executing all Device _STA and_INI
methods:.............................................
45 Devices found containing: 45 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 *4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 10 11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 4
ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 4 (level, low) -> IRQ 4
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 3
ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:0b.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
PCI: Cannot allocate resource region 0 of device 0000:00:0b.0
PCI: Cannot allocate resource region 0 of device 0000:00:0b.1
vesafb: framebuffer at 0xc0000000, mapped to 0xe0807000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=41
vesafb: protected mode interface info at c000:54f0
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.15 [Flags: R/O].
udf: registering filesystem
SGI XFS with ACLs, no debug enabled
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1)
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Console: switching to colour frame buffer device 128x48
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin
is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
acpi_floppy_resource: 2 ioports at 0x3f2
acpi_floppy_resource: 2 ioports at 0x3f4
acpi_floppy_resource: 1 ioports at 0x3f7
floppy: controller ACPI FDC0 at I/O 0x3f2-0x3f3, 0x3f7-0x3f7 irq 6 dma
channel 2
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Using cfq io scheduler
nbd: registered device at major 43
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 10 (level, low) -> IRQ 10
eth0: RealTek RTL8139 at 0xb800, 00:02:44:67:5b:75, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 1
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD1200JB-00EVA0, ATA DISK drive
hdb: TOSHIBA CD-ROM XM-6702B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 1024KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63,
UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
hdb: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.02 loaded.
ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 5 (level, low) -> IRQ 5
ata1: SATA max UDMA/133 cmd 0xDC00 ctl 0xD802 bmdma 0xCC00 irq 5
ata2: SATA max UDMA/133 cmd 0xD400 ctl 0xD002 bmdma 0xCC08 irq 5
ata1: dev 0 cfg 49:2f00 82:346b 83:4b01 84:4000 85:3469 86:0201 87:4000
88:003f
ata1: dev 0 ATA, max UDMA/100, 78165360 sectors:
irq 5: nobody cared!
 [<c0107a5a>]
 [<c0107b3c>]
 [<c0107de1>]
 [<c0106234>]
 [<c011cef0>]
 [<c011cf66>]
 [<c0107dbd>]
 [<c0106234>]
 [<c0110be4>]
 [<c027e712>]
 [<c032a1b3>]
 [<c032a2d4>]
 [<c0329837>]
 [<c032965f>]
 [<c032ba3c>]
 [<c032b2d0>]
 [<c032d6f9>]
 [<c0282d82>]
 [<c0282ddb>]
 [<c0282e1c>]
 [<c02ef28f>]
 [<c02ef3b9>]
 [<c02ef861>]
 [<c02efe1f>]
 [<c01198ed>]
 [<c028309c>]
 [<c052a63f>]
 [<c05147bc>]
 [<c01283f7>]
 [<c0100410>]
 [<c0100445>]
 [<c0104278>]
 [<c010427d>]
handlers:
[<c032b2d0>]
Disabling IRQ #5
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sis
ata2: no device found (phy stat 00000000)
scsi1 : sata_sis
  Vendor: ATA       Model: ST340016A         Rev: 3.05
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 78165360 512-byte hdwr sectors (40021 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0:<3>ata1: command 0xc8 timeout, stat
0x50 host_stat 0x4
 p1 p2 p3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
----------------------------------

