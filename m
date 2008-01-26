From: Peter Favrholdt <linux-ide@how.dk>
Subject: Linux 2.6.24 sata_promise SATA300TX4 problems
Date: Sat, 26 Jan 2008 11:23:53 +0100
Message-ID: <479B0A39.2050700@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pqueuea.post.tele.dk ([193.162.153.9]:46704 "EHLO
	pqueuea.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbYAZKqd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jan 2008 05:46:33 -0500
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueuea.post.tele.dk (Postfix) with ESMTP id 7AB50DC17F
	for <linux-ide@vger.kernel.org>; Sat, 26 Jan 2008 11:25:59 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>

Hi Mikael & list,

I have previously reported problems with my setup:

SATA300TX4 + 4 Seagate Barracuda ES 500GB

I just tested with 2.6.24. After copying approx 25GB of each drive using
  dd if=/dev/sd[abcd] of=/dev/null bs=1M
sda failed with the following message:

[ 1060.069489] ata1: SError: { 10B8B Dispar BadCRC TrStaTrns }
[ 1060.069498] ata1.00: cmd 25/00:00:90:2c:e6/00:02:01:00:00/e0 tag 0 
dma 262144 in
[ 1060.069501]          res 40/00:28:00:00:00/00:00:00:00:00/40 Emask 
0x4 (timeout)

I have included lspci and dmesg output below.

My system is rock solid using 2.6.21-rc2 with Mikael Pettersons 1.5Gbps 
patch.

I will happily test any patch/suggestions thrown towards me :-)

Best regards,

Peter


lspci -v (only the promise card):

01:08.0 Mass storage controller: Promise Technology, Inc. PDC40718 (SATA 
300 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC40718 (SATA 300 TX4)
         Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 19
         I/O ports at a400 [size=128]
         I/O ports at a800 [size=256]
         Memory at e9024000 (32-bit, non-prefetchable) [size=4K]
         Memory at e9000000 (32-bit, non-prefetchable) [size=128K]
         [virtual] Expansion ROM at 300a0000 [disabled] [size=32K]
         Capabilities: [60] Power Management version 2
         Kernel driver in use: sata_promise

lspci:

00:00.0 Host bridge: nVidia Corporation nForce2 IGP2 (rev c1)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
Controller (rev a1)
00:05.0 Multimedia audio controller: nVidia Corporation nForce Audio 
Processing Unit (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 
Audio Controler (MCP) (rev a1)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE 
1394) Controller (rev a3)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:04.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 
Gigabit Ethernet Controller (rev 13)
01:08.0 Mass storage controller: Promise Technology, Inc. PDC40718 (SATA 
300 TX4) (rev 02)
01:0b.0 RAID bus controller: Silicon Image, Inc. SiI 3112 
[SATALink/SATARaid] Serial ATA Controller (rev 02)
03:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP 
(rev 01)

Here is my complete dmesg:

[   24.897952] forcedeth: Reverse Engineered nForce ethernet driver. 
Version 0.61.
[   24.898267] ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
[   24.898317] ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCH] -> GSI 
22 (level, high) -> IRQ 18
[   24.898440] PCI: Setting latency timer of device 0000:00:04.0 to 64
[   25.051795] Switched to high resolution mode on CPU 0
[   25.421997] forcedeth 0000:00:04.0: ifname eth1, PHY OUI 0x20 @ 1, 
addr 00:11:2f:10:c1:c8
[   25.422057] forcedeth 0000:00:04.0: timirq lnktim desc-v1
[   25.422118] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   25.422169] ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
[   25.422284] NFORCE2: IDE controller (0x10de:0x0065 rev 0xa2) at  PCI 
slot 0000:00:09.0
[   25.422355] NFORCE2: not 100% native mode: will probe irqs later
[   25.422405] NFORCE2: BIOS didn't set cable bits correctly. Enabling 
workaround.
[   25.422465] NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
[   25.422516]     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: 
hda:DMA, hdb:DMA
[   25.422642]     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: 
hdc:DMA, hdd:DMA
[   25.422798] Probing IDE interface ide0...
[   25.731527] hdb: ST380021A, ATA DISK drive
[   26.091338] hda: ST380021A, ATA DISK drive
[   26.091419] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   26.091509] hda: UDMA/100 mode selected
[   26.091635] hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   26.091984] hdb: UDMA/100 mode selected
[   26.092132] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   26.092294] Probing IDE interface ide1...
[   27.300704] hdc: HITACHI DVD-ROM GD-2500, ATAPI CD/DVD-ROM drive
[   27.300856] hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[   27.359737] hdc: MWDMA2 mode selected
[   27.360303] ide1 at 0x170-0x177,0x376 on irq 15
[   27.360515] hda: max request size: 128KiB
[   27.360881] hda: 156301488 sectors (80026 MB) w/2048KiB Cache, 
CHS=65535/16/63
[   27.361001] hda: cache flushes not supported
[   27.361072]  hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
[   27.422072] hdb: max request size: 128KiB
[   27.422450] hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, 
CHS=65535/16/63
[   27.422569] hdb: cache flushes not supported
[   27.422631]  hdb: hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 hdb9 >
[   27.554655] hdc: ATAPI 24X DVD-ROM drive, 512kB Cache
[   27.554828] Uniform CD-ROM driver Revision: 3.20
[   27.557777] Driver 'sd' needs updating - please use bus_type methods
[   27.557849] Driver 'sr' needs updating - please use bus_type methods
[   27.557978] sata_promise 0000:01:08.0: version 2.11
[   27.558158] ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
[   27.558209] ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC3] -> GSI 
18 (level, high) -> IRQ 19
[   27.558503] scsi0 : sata_promise
[   27.558622] scsi1 : sata_promise
[   27.558719] scsi2 : sata_promise
[   27.558817] scsi3 : sata_promise
[   27.558908] ata1: SATA max UDMA/133 mmio m4096@0xe9024000 port 
0xe9024380 irq 19
[   27.558967] ata2: SATA max UDMA/133 mmio m4096@0xe9024000 port 
0xe9024280 irq 19
[   27.559026] ata3: SATA max UDMA/133 mmio m4096@0xe9024000 port 
0xe9024200 irq 19
[   27.559084] ata4: SATA max UDMA/133 mmio m4096@0xe9024000 port 
0xe9024300 irq 19
[   28.040224] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   28.095145] ata1.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[   28.095193] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   28.178404] ata1.00: configured for UDMA/133
[   28.659895] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   28.707063] ata2.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[   28.707111] ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   28.790326] ata2.00: configured for UDMA/133
[   29.279570] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   29.331818] ata3.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[   29.331867] ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   29.423407] ata3.00: configured for UDMA/133
[   29.909240] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   29.959518] ata4.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[   29.959566] ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   30.051097] ata4.00: configured for UDMA/133
[   30.051231] scsi 0:0:0:0: Direct-Access     ATA      ST3500630NS 
  3.AE PQ: 0 ANSI: 5
[   30.051395] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors 
(500108 MB)
[   30.051456] sd 0:0:0:0: [sda] Write Protect is off
[   30.051503] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   30.051519] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   30.051614] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors 
(500108 MB)
[   30.051671] sd 0:0:0:0: [sda] Write Protect is off
[   30.051718] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   30.051732] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   30.051791]  sda: unknown partition table
[   30.066602] sd 0:0:0:0: [sda] Attached SCSI disk
[   30.066719] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   30.067030] scsi 1:0:0:0: Direct-Access     ATA      ST3500630NS 
  3.AE PQ: 0 ANSI: 5
[   30.067184] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors 
(500108 MB)
[   30.067241] sd 1:0:0:0: [sdb] Write Protect is off
[   30.067288] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   30.067302] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   30.067390] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors 
(500108 MB)
[   30.067447] sd 1:0:0:0: [sdb] Write Protect is off
[   30.067493] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   30.067507] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   30.067567]  sdb: unknown partition table
[   30.087344] sd 1:0:0:0: [sdb] Attached SCSI disk
[   30.087451] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   30.087758] scsi 2:0:0:0: Direct-Access     ATA      ST3500630NS 
  3.AE PQ: 0 ANSI: 5
[   30.087913] sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors 
(500108 MB)
[   30.087970] sd 2:0:0:0: [sdc] Write Protect is off
[   30.088017] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   30.088031] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   30.088121] sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors 
(500108 MB)
[   30.088177] sd 2:0:0:0: [sdc] Write Protect is off
[   30.088224] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   30.088238] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   30.088297]  sdc: unknown partition table
[   30.104312] sd 2:0:0:0: [sdc] Attached SCSI disk
[   30.104418] sd 2:0:0:0: Attached scsi generic sg2 type 0
[   30.104724] scsi 3:0:0:0: Direct-Access     ATA      ST3500630NS 
  3.AE PQ: 0 ANSI: 5
[   30.104871] sd 3:0:0:0: [sdd] 976773168 512-byte hardware sectors 
(500108 MB)
[   30.104928] sd 3:0:0:0: [sdd] Write Protect is off
[   30.104975] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   30.104989] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   30.105076] sd 3:0:0:0: [sdd] 976773168 512-byte hardware sectors 
(500108 MB)
[   30.105132] sd 3:0:0:0: [sdd] Write Protect is off
[   30.105178] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   30.105192] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   30.105251]  sdd: unknown partition table
[   30.115877] sd 3:0:0:0: [sdd] Attached SCSI disk
[   30.115988] sd 3:0:0:0: Attached scsi generic sg3 type 0
[   30.116302] sata_sil 0000:01:0b.0: version 2.3
[   30.116362] ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [APC3] -> GSI 
18 (level, high) -> IRQ 19
[   30.116530] scsi4 : sata_sil
[   30.116632] scsi5 : sata_sil
[   30.116722] ata5: SATA max UDMA/100 mmio m512@0xe9025000 tf 
0xe9025080 irq 19
[   30.116774] ata6: SATA max UDMA/100 mmio m512@0xe9025000 tf 
0xe90250c0 irq 19
[   30.438948] ata5: SATA link down (SStatus 0 SControl 310)
[   30.768774] ata6: SATA link down (SStatus 0 SControl 310)
[   30.770218] ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
[   30.770270] ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 
21 (level, high) -> IRQ 20
[   30.770396] PCI: Setting latency timer of device 0000:00:02.2 to 64
[   30.770400] ehci_hcd 0000:00:02.2: EHCI Host Controller
[   30.770509] ehci_hcd 0000:00:02.2: new USB bus registered, assigned 
bus number 1
[   30.770603] ehci_hcd 0000:00:02.2: debug port 1
[   30.770652] PCI: cache line size of 64 is not supported by device 
0000:00:02.2
[   30.770661] ehci_hcd 0000:00:02.2: irq 20, io mem 0xea083000
[   30.788757] ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 
10 Dec 2004
[   30.788985] usb usb1: configuration #1 chosen from 1 choice
[   30.789075] hub 1-0:1.0: USB hub found
[   30.789129] hub 1-0:1.0: 6 ports detected
[   30.898798] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller 
(OHCI) Driver
[   30.899088] ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
[   30.899138] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 
20 (level, high) -> IRQ 21
[   30.899264] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   30.899268] ohci_hcd 0000:00:02.0: OHCI Host Controller
[   30.899353] ohci_hcd 0000:00:02.0: new USB bus registered, assigned 
bus number 2
[   30.899422] ohci_hcd 0000:00:02.0: irq 21, io mem 0xea087000
[   30.960777] usb usb2: configuration #1 chosen from 1 choice
[   30.960862] hub 2-0:1.0: USB hub found
[   30.960916] hub 2-0:1.0: 3 ports detected
[   31.068949] ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
[   31.068998] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 
22 (level, high) -> IRQ 18
[   31.069125] PCI: Setting latency timer of device 0000:00:02.1 to 64
[   31.069129] ohci_hcd 0000:00:02.1: OHCI Host Controller
[   31.069214] ohci_hcd 0000:00:02.1: new USB bus registered, assigned 
bus number 3
[   31.069282] ohci_hcd 0000:00:02.1: irq 18, io mem 0xea082000
[   31.130689] usb usb3: configuration #1 chosen from 1 choice
[   31.130779] hub 3-0:1.0: USB hub found
[   31.130833] hub 3-0:1.0: 3 ports detected
[   31.238724] PNP: No PS/2 controller found. Probing ports directly.
[   31.488773] serio: i8042 KBD port at 0x60,0x64 irq 1
[   31.488928] mice: PS/2 mouse device common for all mice
[   31.489008] i2c /dev entries driver
[   31.489216] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x5000
[   31.489329] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x5500
[   31.638311] usb 2-1: new low speed USB device using ohci_hcd and 
address 2
[   31.828263] usb 2-1: configuration #1 chosen from 1 choice
[   32.128054] usb 2-2: new low speed USB device using ohci_hcd and 
address 3
[   32.317993] raid6: int32x1    728 MB/s
[   32.487918] raid6: int32x2    728 MB/s
[   32.657815] raid6: int32x4    681 MB/s
[   32.827763] raid6: int32x8    608 MB/s
[   32.997627] raid6: mmxx1     1513 MB/s
[   33.167530] raid6: mmxx2     2385 MB/s
[   33.337463] raid6: sse1x1    1399 MB/s
[   33.507345] raid6: sse1x2    2149 MB/s
[   33.507390] raid6: using algorithm sse1x2 (2149 MB/s)
[   33.507437] md: raid6 personality registered for level 6
[   33.507485] md: raid5 personality registered for level 5
[   33.507531] md: raid4 personality registered for level 4
[   33.507635] device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) 
initialised: dm-devel@redhat.com
[   33.507758] TCP cubic registered
[   33.507809] Using IPI Shortcut mode
[   33.508092] md: Autodetecting RAID arrays.
[   33.508138] md: Scanned 0 and added 0 devices.
[   33.508183] md: autorun ...
[   33.508226] md: ... autorun DONE.
[   33.519306] kjournald starting.  Commit interval 5 seconds
[   33.519361] EXT3-fs: mounted filesystem with ordered data mode.
[   33.519413] VFS: Mounted root (ext3 filesystem) readonly.
[   33.519693] Freeing unused kernel memory: 188k freed
[   33.616174] usb 2-2: configuration #1 chosen from 1 choice
[   34.373020] NET: Registered protocol family 1
[   36.545839] hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[   36.546026] hdc: drive_cmd: error=0x04 { AbortedCommand }
[   36.546135] ide: failed opcode was: 0xe3
[   37.267015] input: PC Speaker as /class/input/input2
[   37.321217] usbcore: registered new interface driver hiddev
[   37.326352] ACPI: PCI Interrupt Link [APCM] enabled at IRQ 21
[   37.326408] ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [APCM] -> GSI 
21 (level, high) -> IRQ 20
[   37.326533] PCI: Setting latency timer of device 0000:00:0d.0 to 64
[   37.377141] input: Logitech USB Receiver as /class/input/input3
[   37.387211] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[20] 
MMIO=[ea084000-ea0847ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
[   37.435354] input: USB HID v1.10 Keyboard [Logitech USB Receiver] on 
usb-0000:00:02.0-1
[   37.446186] input: Logitech USB Receiver as /class/input/input4
[   37.505340] input: USB HID v1.10 Mouse [Logitech USB Receiver] on 
usb-0000:00:02.0-1
[   37.513023] input: Logitech USB-PS/2 Trackball as /class/input/input5
[   37.575333] input: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] 
on usb-0000:00:02.0-2
[   37.575478] usbcore: registered new interface driver usbhid
[   37.575528] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[   37.620028] ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 20
[   37.620084] ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCJ] -> GSI 
20 (level, high) -> IRQ 21
[   37.620226] PCI: Setting latency timer of device 0000:00:06.0 to 64
[   37.955010] intel8x0_measure_ac97_clock: measured 58784 usecs
[   37.955065] intel8x0: clocking to 48000
[   38.494913] ohci1394: fw-host0: SelfID received outside of bus reset 
sequence
[   38.814700] ieee1394: Host added: ID:BUS[0-00:1023] 
GUID[00e01800007b0179]
[   39.054650] hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[   39.054830] hdc: drive_cmd: error=0x04 { AbortedCommand }
[   39.054939] ide: failed opcode was: 0xe3
[   39.483047] Adding 979924k swap on /dev/hda7.  Priority:-1 extents:1 
across:979924k
[   39.740419] EXT3 FS on hda8, internal journal
[   40.991735] md: md0 stopped.
[   41.101335] md: bind<sdd>
[   41.101533] md: bind<sdc>
[   41.101710] md: bind<sdb>
[   41.101873] md: bind<sda>
[   41.108620] raid5: device sda operational as raid disk 0
[   41.108672] raid5: device sdb operational as raid disk 3
[   41.108719] raid5: device sdc operational as raid disk 2
[   41.108766] raid5: device sdd operational as raid disk 1
[   41.109238] raid5: allocated 4203kB for md0
[   41.109284] raid5: raid level 5 set md0 active with 4 out of 4 
devices, algorithm 2
[   41.109342] RAID5 conf printout:
[   41.109386]  --- rd:4 wd:4
[   41.109429]  disk 0, o:1, dev:sda
[   41.109473]  disk 1, o:1, dev:sdd
[   41.109516]  disk 2, o:1, dev:sdc
[   41.109560]  disk 3, o:1, dev:sdb
[   52.301250] ReiserFS: hda6: found reiserfs format "3.6" with standard 
journal
[   52.301321] ReiserFS: hda6: using ordered data mode
[   52.306452] ReiserFS: hda6: journal params: device hda6, size 8192, 
journal first block 18, max trans len 1024, max batch 900, max commit 
age 30, max trans age 30
[   52.307509] ReiserFS: hda6: checking transaction log (hda6)
[   52.357121] ReiserFS: hda6: Using r5 hash to sort names
[   52.482552] kjournald starting.  Commit interval 5 seconds
[   52.529309] EXT3 FS on md0, internal journal
[   52.530417] EXT3-fs: mounted filesystem with ordered data mode.
[   53.555062] skge eth0: enabling interface
[   58.325139] skge eth0: Link is up at 100 Mbps, full duplex, flow 
control both
[   61.194087] lp0: using parport0 (interrupt-driven).
[   61.202660] ppdev: user-space parallel port driver
[ 1060.069478] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
action 0x2 frozen
[ 1060.069489] ata1: SError: { 10B8B Dispar BadCRC TrStaTrns }
[ 1060.069498] ata1.00: cmd 25/00:00:90:2c:e6/00:02:01:00:00/e0 tag 0 
dma 262144 in
[ 1060.069501]          res 40/00:28:00:00:00/00:00:00:00:00/40 Emask 
0x4 (timeout)
[ 1060.069505] ata1.00: status: { DRDY }
[ 1065.437567] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1070.114210] ata1: device not ready (errno=-16), forcing hardreset
[ 1070.114219] ata1: hard resetting link
[ 1076.320932] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1080.158924] ata1: COMRESET failed (errno=-16)
[ 1080.158934] ata1: hard resetting link
[ 1086.365744] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1090.203665] ata1: COMRESET failed (errno=-16)
[ 1090.203675] ata1: hard resetting link
[ 1096.410416] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1125.195332] ata1: COMRESET failed (errno=-16)
[ 1125.195344] ata1: limiting SATA link speed to 1.5 Gbps
[ 1125.195348] ata1: hard resetting link
[ 1130.202827] ata1: COMRESET failed (errno=-16)
[ 1130.202837] ata1: reset failed, giving up
[ 1130.202841] ata1.00: disabled
[ 1130.202864] ata1: exception Emask 0x10 SAct 0x0 SErr 0x1390002 action 
0xa frozen t4
[ 1130.202867] ata1: hotplug_status 0x80
[ 1130.202871] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar BadCRC 
TrStaTrns }
[ 1130.202908] ata1: hard resetting link
[ 1136.810334] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1140.227798] ata1: COMRESET failed (errno=-16)
[ 1140.227808] ata1: hard resetting link
[ 1146.843986] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1150.262189] ata1: COMRESET failed (errno=-16)
[ 1150.262199] ata1: hard resetting link
[ 1156.868724] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1185.283976] ata1: COMRESET failed (errno=-16)
[ 1185.283996] ata1: limiting SATA link speed to 1.5 Gbps
[ 1185.283999] ata1: hard resetting link
[ 1190.331327] ata1: COMRESET failed (errno=-16)
[ 1190.331337] ata1: reset failed, giving up
[ 1190.331352] ata1: exception Emask 0x10 SAct 0x0 SErr 0x1390002 action 
0xa frozen t3
[ 1190.331356] ata1: hotplug_status 0x80
[ 1190.331360] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar BadCRC 
TrStaTrns }
[ 1190.331396] ata1: hard resetting link
[ 1196.937871] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1200.365980] ata1: COMRESET failed (errno=-16)
[ 1200.365990] ata1: hard resetting link
[ 1206.972464] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1210.390683] ata1: COMRESET failed (errno=-16)
[ 1210.390693] ata1: hard resetting link
[ 1217.008237] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1245.392315] ata1: COMRESET failed (errno=-16)
[ 1245.392325] ata1: limiting SATA link speed to 1.5 Gbps
[ 1245.392328] ata1: hard resetting link
[ 1250.450259] ata1: COMRESET failed (errno=-16)
[ 1250.450268] ata1: reset failed, giving up
[ 1250.450281] ata1: exception Emask 0x10 SAct 0x0 SErr 0x1390002 action 
0xa frozen t2
[ 1250.450284] ata1: hotplug_status 0x80
[ 1250.450289] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar BadCRC 
TrStaTrns }
[ 1250.450304] ata1: hard resetting link
[ 1257.056218] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1260.484408] ata1: COMRESET failed (errno=-16)
[ 1260.484417] ata1: hard resetting link
[ 1267.072563] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1270.499165] ata1: COMRESET failed (errno=-16)
[ 1270.499174] ata1: hard resetting link
[ 1277.075718] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1305.530799] ata1: COMRESET failed (errno=-16)
[ 1305.530809] ata1: limiting SATA link speed to 1.5 Gbps
[ 1305.530813] ata1: hard resetting link
[ 1310.578793] ata1: COMRESET failed (errno=-16)
[ 1310.578801] ata1: reset failed, giving up
[ 1310.578814] ata1: exception Emask 0x10 SAct 0x0 SErr 0x1390002 action 
0xa frozen t1
[ 1310.578817] ata1: hotplug_status 0x80
[ 1310.578822] ata1: SError: { RecovComm PHYRdyChg 10B8B Dispar BadCRC 
TrStaTrns }
[ 1310.578837] ata1: hard resetting link
[ 1317.184707] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1320.602902] ata1: COMRESET failed (errno=-16)
[ 1320.602911] ata1: hard resetting link
[ 1327.209508] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1330.627649] ata1: COMRESET failed (errno=-16)
[ 1330.627657] ata1: hard resetting link
[ 1337.234946] ata1: port is slow to respond, please be patient (Status 
0xff)
[ 1365.669300] ata1: COMRESET failed (errno=-16)
[ 1365.669311] ata1: limiting SATA link speed to 1.5 Gbps
[ 1365.669314] ata1: hard resetting link
[ 1370.716641] ata1: COMRESET failed (errno=-16)
[ 1370.716650] ata1: reset failed, giving up
[ 1370.716656] ata1: EH pending after 5 tries, giving up
[ 1370.716684] sd 0:0:0:0: [sda] Result: hostbyte=0x00 driverbyte=0x08
[ 1370.716688] sd 0:0:0:0: [sda] Sense Key : 0xb [current] [descriptor]
[ 1370.716693] Descriptor sense data with sense descriptors (in hex):
[ 1370.716696]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[ 1370.716703]         00 00 00 00
[ 1370.716706] sd 0:0:0:0: [sda] ASC=0x0 ASCQ=0x0
[ 1370.716710] end_request: I/O error, dev sda, sector 31861904
[ 1370.716715] Buffer I/O error on device sda, logical block 3982738
[ 1370.716722] Buffer I/O error on device sda, logical block 3982739
[ 1370.716726] Buffer I/O error on device sda, logical block 3982740
[ 1370.716730] Buffer I/O error on device sda, logical block 3982741
[ 1370.716733] Buffer I/O error on device sda, logical block 3982742
[ 1370.716737] Buffer I/O error on device sda, logical block 3982743
[ 1370.716741] Buffer I/O error on device sda, logical block 3982744
[ 1370.716744] Buffer I/O error on device sda, logical block 3982745
[ 1370.716748] Buffer I/O error on device sda, logical block 3982746
[ 1370.716752] Buffer I/O error on device sda, logical block 3982747
[ 1370.716795] ata1: EH complete
[ 1370.716992] sd 0:0:0:0: rejecting I/O to offline device
[ 1370.717003] ata1.00: detaching (SCSI 0:0:0:0)
[ 1370.717222] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[ 1370.718840] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[ 1370.718847] sd 0:0:0:0: [sda] Stopping disk
[ 1370.718855] sd 0:0:0:0: [sda] START_STOP FAILED
[ 1370.718857] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
