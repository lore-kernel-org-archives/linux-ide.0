From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: FYI: BUG in SATA Promise 300 TX4 (2.6.24 - 2.6.27-3) w/Linux
Date: Sun, 16 Nov 2008 18:34:41 +0100
Message-ID: <492059B1.4030708@how.dk>
References: <491C9A4F.1020801@tlinx.org>	<491FB7E2.2030105@kernel.org> <18719.65298.689618.835202@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pqueueb.post.tele.dk ([193.162.153.10]:37369 "EHLO
	pqueueb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbYKPSMU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Nov 2008 13:12:20 -0500
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by pqueueb.post.tele.dk (Postfix) with ESMTP id 2D3D18720
	for <linux-ide@vger.kernel.org>; Sun, 16 Nov 2008 18:37:41 +0100 (CET)
In-Reply-To: <18719.65298.689618.835202@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Hi Michael and list,

Mikael Pettersson wrote:
 > The hardreset fix was included in 2.6.27.5. I wanted it in
 > 2.6.26-stable too, but that branch seems to have been closed now.

Having read about the hardreset fix I have just tried 2.6.27.5 on my 
setup (which works ok at 1.5Gbps but fails at 3.0Gbps).

I'm still experiencing the same "link is slow to respond" problem using 
sata_promise in linux-2.6.27.5 with my Promise Technology, Inc. PDC40718 
(SATA 300 TX4) (rev 02) and 4 Seagate 500GB ES drives Model: 
ST3500630NS, Firmware:  3.AEE (with 1.5/3.0Gbps jumper removed = 3.0Gbps)

After doing:

dd if=/dev/sda of=/dev/null bs=1M &
dd if=/dev/sdb of=/dev/null bs=1M &
dd if=/dev/sdc of=/dev/null bs=1M &
dd if=/dev/sdd of=/dev/null bs=1M &

it runs fine for a while, then fails similar to my experiences with 
earlier kernels.

Best regards,

Peter


[    0.438775] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.438961] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    0.439392] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.439630] 00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    0.439890] parport_pc 00:0c: reported by Plug and Play ACPI
[    0.439991] parport0: PC-style at 0x378 (0x778), irq 7, dma 3 
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
[    0.519897] Floppy drive(s): fd0 is 1.44M
[    0.543252] FDC 0 is a post-1991 82077
[    0.545415] brd: module loaded
[    0.545648] ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
[    0.545701] skge 0000:01:04.0: PCI INT A -> Link[APC2] -> GSI 17 
(level, high) -> IRQ 17
[    0.545799] skge 1.13 addr 0xe9020000 irq 17 chip Yukon-Lite rev 7
[    0.546028] skge eth0: addr 00:11:2f:10:bc:bc
[    0.546133] forcedeth: Reverse Engineered nForce ethernet driver. 
Version 0.61.
[    0.546466] ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
[    0.546516] forcedeth 0000:00:04.0: PCI INT A -> Link[APCH] -> GSI 22 
(level, high) -> IRQ 22
[    0.546577] forcedeth 0000:00:04.0: setting latency timer to 64
[    0.546607] nv_probe: set workaround bit for reversed mac addr
[    0.879571] Switched to high resolution mode on CPU 0
[    1.060432] forcedeth 0000:00:04.0: ifname eth1, PHY OUI 0x732 @ 1, 
addr 00:11:2f:10:c1:c8
[    1.060491] forcedeth 0000:00:04.0: timirq lnktim desc-v1
[    1.060576] Uniform Multi-Platform E-IDE driver
[    1.060704] amd74xx 0000:00:09.0: UDMA133 controller
[    1.060752] amd74xx 0000:00:09.0: IDE controller (0x10de:0x0065 rev 0xa2)
[    1.060820] amd74xx 0000:00:09.0: BIOS didn't set cable bits 
correctly. Enabling workaround.
[    1.060879] amd74xx 0000:00:09.0: not 100% native mode: will probe 
irqs later
[    1.060932]     ide0: BM-DMA at 0xf000-0xf007
[    1.060982]     ide1: BM-DMA at 0xf008-0xf00f
[    1.061030] Probing IDE interface ide0...
[    1.370125] hda: ST380021A, ATA DISK drive
[    1.670124] hdb: ST380021A, ATA DISK drive
[    1.730047] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    1.730233] hda: UDMA/100 mode selected
[    1.730351] hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    1.730481] hdb: UDMA/100 mode selected
[    1.730615] Probing IDE interface ide1...
[    2.570125] hdc: HITACHI DVD-ROM GD-2500, ATAPI CD/DVD-ROM drive
[    2.930042] hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    2.989009] hdc: MWDMA2 mode selected
[    2.989579] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    2.989679] ide1 at 0x170-0x177,0x376 on irq 15
[    2.989966] hda: max request size: 128KiB
[    2.990352] hda: 156301488 sectors (80026 MB) w/2048KiB Cache, 
CHS=65535/16/63
[    2.990472] hda: cache flushes not supported
[    2.990553]  hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
[    3.049360] hdb: max request size: 128KiB
[    3.049857] hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, 
CHS=65535/16/63
[    3.049977] hdb: cache flushes not supported
[    3.050053]  hdb: hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 hdb9 >
[    3.184964] hdc: ATAPI 24X DVD-ROM drive, 512kB Cache
[    3.185137] Uniform CD-ROM driver Revision: 3.20
[    3.188154] Driver 'sd' needs updating - please use bus_type methods
[    3.188229] Driver 'sr' needs updating - please use bus_type methods
[    3.188347] sata_promise 0000:01:08.0: version 2.12
[    3.188530] ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
[    3.188582] sata_promise 0000:01:08.0: PCI INT A -> Link[APC3] -> GSI 
18 (level, high) -> IRQ 18
[    3.188822] scsi0 : sata_promise
[    3.188967] scsi1 : sata_promise
[    3.189074] scsi2 : sata_promise
[    3.189183] scsi3 : sata_promise
[    3.189283] ata1: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024380 irq 18
[    3.189341] ata2: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024280 irq 18
[    3.189398] ata3: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024200 irq 18
[    3.189455] ata4: SATA max UDMA/133 mmio m4096@0xe9024000 ata 
0xe9024300 irq 18
[    3.530038] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.581782] ata1.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[    3.581829] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[    3.673415] ata1.00: configured for UDMA/133
[    4.020036] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.069958] ata2.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[    4.070013] ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[    4.161596] ata2.00: configured for UDMA/133
[    4.510036] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.563919] ata3.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[    4.563967] ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[    4.647225] ata3.00: configured for UDMA/133
[    4.990036] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.038870] ata4.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[    5.038918] ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[    5.122183] ata4.00: configured for UDMA/133
[    5.122316] scsi 0:0:0:0: Direct-Access     ATA      ST3500630NS 
  3.AE PQ: 0 ANSI: 5
[    5.122502] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors 
(500108 MB)
[    5.122564] sd 0:0:0:0: [sda] Write Protect is off
[    5.122610] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.122631] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    5.122745] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors 
(500108 MB)
[    5.122803] sd 0:0:0:0: [sda] Write Protect is off
[    5.122850] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.122869] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    5.122929]  sda: unknown partition table
[    5.137793] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.137936] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    5.138035] scsi 1:0:0:0: Direct-Access     ATA      ST3500630NS 
  3.AE PQ: 0 ANSI: 5
[    5.138209] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors 
(500108 MB)
[    5.138268] sd 1:0:0:0: [sdb] Write Protect is off
[    5.138315] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    5.138334] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    5.138433] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors 
(500108 MB)
[    5.138492] sd 1:0:0:0: [sdb] Write Protect is off
[    5.139565] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    5.139585] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    5.139644]  sdb: unknown partition table
[    5.151121] sd 1:0:0:0: [sdb] Attached SCSI disk
[    5.151240] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    5.151334] scsi 2:0:0:0: Direct-Access     ATA      ST3500630NS 
  3.AE PQ: 0 ANSI: 5
[    5.151502] sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors 
(500108 MB)
[    5.151560] sd 2:0:0:0: [sdc] Write Protect is off
[    5.151606] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    5.151626] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    5.151725] sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors 
(500108 MB)
[    5.151784] sd 2:0:0:0: [sdc] Write Protect is off
[    5.151830] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    5.151849] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    5.151908]  sdc: unknown partition table
[    5.161924] sd 2:0:0:0: [sdc] Attached SCSI disk
[    5.162040] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    5.162134] scsi 3:0:0:0: Direct-Access     ATA      ST3500630NS 
  3.AE PQ: 0 ANSI: 5
[    5.162304] sd 3:0:0:0: [sdd] 976773168 512-byte hardware sectors 
(500108 MB)
[    5.162363] sd 3:0:0:0: [sdd] Write Protect is off
[    5.162409] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    5.162428] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    5.162526] sd 3:0:0:0: [sdd] 976773168 512-byte hardware sectors 
(500108 MB)
[    5.162585] sd 3:0:0:0: [sdd] Write Protect is off
[    5.162631] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    5.162651] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    5.162710]  sdd: unknown partition table
[    5.178706] sd 3:0:0:0: [sdd] Attached SCSI disk
[    5.178826] sd 3:0:0:0: Attached scsi generic sg3 type 0
[    5.179254] ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
[    5.179309] ehci_hcd 0000:00:02.2: PCI INT C -> Link[APCL] -> GSI 21 
(level, high) -> IRQ 21
[    5.179377] ehci_hcd 0000:00:02.2: setting latency timer to 64
[    5.179381] ehci_hcd 0000:00:02.2: EHCI Host Controller
[    5.179489] ehci_hcd 0000:00:02.2: new USB bus registered, assigned 
bus number 1
[    5.179586] ehci_hcd 0000:00:02.2: debug port 1
[    5.179635] ehci_hcd 0000:00:02.2: cache line size of 64 is not supported
[    5.179649] ehci_hcd 0000:00:02.2: irq 21, io mem 0xea083000
[    5.190005] ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 
10 Dec 2004
[    5.190166] usb usb1: configuration #1 chosen from 1 choice
[    5.190262] hub 1-0:1.0: USB hub found
[    5.190317] hub 1-0:1.0: 6 ports detected
[    5.410239] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller 
(OHCI) Driver
[    5.410524] ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
[    5.410575] ohci_hcd 0000:00:02.0: PCI INT A -> Link[APCF] -> GSI 20 
(level, high) -> IRQ 20
[    5.410639] ohci_hcd 0000:00:02.0: setting latency timer to 64
[    5.410642] ohci_hcd 0000:00:02.0: OHCI Host Controller
[    5.410734] ohci_hcd 0000:00:02.0: new USB bus registered, assigned 
bus number 2
[    5.410805] ohci_hcd 0000:00:02.0: irq 20, io mem 0xea087000
[    5.472121] usb usb2: configuration #1 chosen from 1 choice
[    5.472216] hub 2-0:1.0: USB hub found
[    5.472271] hub 2-0:1.0: 3 ports detected
[    5.690426] ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
[    5.690476] ohci_hcd 0000:00:02.1: PCI INT B -> Link[APCG] -> GSI 22 
(level, high) -> IRQ 22
[    5.690538] ohci_hcd 0000:00:02.1: setting latency timer to 64
[    5.690541] ohci_hcd 0000:00:02.1: OHCI Host Controller
[    5.690632] ohci_hcd 0000:00:02.1: new USB bus registered, assigned 
bus number 3
[    5.690702] ohci_hcd 0000:00:02.1: irq 22, io mem 0xea082000
[    5.752085] usb usb3: configuration #1 chosen from 1 choice
[    5.752176] hub 3-0:1.0: USB hub found
[    5.752230] hub 3-0:1.0: 3 ports detected
[    5.830005] usb 2-1: new low speed USB device using ohci_hcd and 
address 2
[    5.860305] PNP: No PS/2 controller found. Probing ports directly.
[    6.020032] usb 2-1: configuration #1 chosen from 1 choice
[    6.110391] serio: i8042 KBD port at 0x60,0x64 irq 1
[    6.110568] mice: PS/2 mouse device common for all mice
[    6.110650] i2c /dev entries driver
[    6.110859] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x5000
[    6.110978] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x5500
[    6.160006] usb 2-2: new low speed USB device using ohci_hcd and 
address 3
[    6.348997] usb 2-2: configuration #1 chosen from 1 choice
[    6.900054] raid6: int32x1    735 MB/s
[    7.070018] raid6: int32x2    828 MB/s
[    7.240105] raid6: int32x4    602 MB/s
[    7.410002] raid6: int32x8    605 MB/s
[    7.580007] raid6: mmxx1     1525 MB/s
[    7.750031] raid6: mmxx2     1668 MB/s
[    7.920043] raid6: sse1x1    1423 MB/s
[    8.090031] raid6: sse1x2    2186 MB/s
[    8.090075] raid6: using algorithm sse1x2 (2186 MB/s)
[    8.090122] md: raid6 personality registered for level 6
[    8.090169] md: raid5 personality registered for level 5
[    8.090215] md: raid4 personality registered for level 4
[    8.090348] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) 
initialised: dm-devel@redhat.com
[    8.090488] TCP cubic registered
[    8.090543] Using IPI Shortcut mode
[    8.091079] md: Autodetecting RAID arrays.
[    8.091125] md: Scanned 0 and added 0 devices.
[    8.091170] md: autorun ...
[    8.091213] md: ... autorun DONE.
[    8.108113] kjournald starting.  Commit interval 5 seconds
[    8.108167] EXT3-fs: mounted filesystem with ordered data mode.
[    8.108251] VFS: Mounted root (ext3 filesystem) readonly.
[    8.108546] Freeing unused kernel memory: 208k freed
[    9.326077] NET: Registered protocol family 1
[   11.645880] hdc: task_no_data_intr: status=0x51 { DriveReady 
SeekComplete Error }
[   11.646070] hdc: task_no_data_intr: error=0x04 { AbortedCommand }
[   11.646211] ide: failed opcode was: 0xe3
[   12.171261] usbcore: registered new interface driver hiddev
[   12.177807] input: Logitech USB Receiver as /class/input/input2
[   12.198052] input: PC Speaker as /class/input/input3
[   12.220189] input: USB HID v1.10 Keyboard [Logitech USB Receiver] on 
usb-0000:00:02.0-1
[   12.231204] input: Logitech USB Receiver as /class/input/input4
[   12.273150] input: USB HID v1.10 Mouse [Logitech USB Receiver] on 
usb-0000:00:02.0-1
[   12.278735] input: Logitech USB-PS/2 Trackball as /class/input/input5
[   12.279083] input: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] 
on usb-0000:00:02.0-2
[   12.279218] usbcore: registered new interface driver usbhid
[   12.279267] usbhid: v2.6:USB HID core driver
[   12.433286] ACPI: PCI Interrupt Link [APCM] enabled at IRQ 21
[   12.433342] ohci1394 0000:00:0d.0: PCI INT A -> Link[APCM] -> GSI 21 
(level, high) -> IRQ 21
[   12.433403] ohci1394 0000:00:0d.0: setting latency timer to 64
[   12.633606] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[21] 
MMIO=[ea084000-ea0847ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
[   12.753615] ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 20
[   12.753672] Intel ICH 0000:00:06.0: PCI INT A -> Link[APCJ] -> GSI 20 
(level, high) -> IRQ 20
[   12.753751] Intel ICH 0000:00:06.0: setting latency timer to 64
[   13.090016] intel8x0_measure_ac97_clock: measured 55817 usecs
[   13.090069] intel8x0: clocking to 48000
[   13.760518] ohci1394: fw-host0: SelfID received outside of bus reset 
sequence
[   14.081466] ieee1394: Host added: ID:BUS[0-00:1023] 
GUID[00e01800007b0179]
[   14.291280] hdc: task_no_data_intr: status=0x51 { DriveReady 
SeekComplete Error }
[   14.291469] hdc: task_no_data_intr: error=0x04 { AbortedCommand }
[   14.291610] ide: failed opcode was: 0xe3
[   15.215173] Adding 979924k swap on /dev/hda7.  Priority:-1 extents:1 
across:979924k
[   15.479143] EXT3 FS on hda8, internal journal
[   16.369094] md: md0 stopped.
[   16.452154] md: bind<sdd>
[   16.452360] md: bind<sdc>
[   16.452538] md: bind<sdb>
[   16.452740] md: bind<sda>
[   16.461880] raid5: device sda operational as raid disk 0
[   16.461930] raid5: device sdb operational as raid disk 3
[   16.461977] raid5: device sdc operational as raid disk 2
[   16.462024] raid5: device sdd operational as raid disk 1
[   16.462527] raid5: allocated 4201kB for md0
[   16.462573] raid5: raid level 5 set md0 active with 4 out of 4 
devices, algorithm 2
[   16.462628] RAID5 conf printout:
[   16.462671]  --- rd:4 wd:4
[   16.462714]  disk 0, o:1, dev:sda
[   16.462757]  disk 1, o:1, dev:sdd
[   16.462801]  disk 2, o:1, dev:sdc
[   16.462845]  disk 3, o:1, dev:sdb
[   27.908026] ReiserFS: hda6: found reiserfs format "3.6" with standard 
journal
[   27.908096] ReiserFS: hda6: using ordered data mode
[   27.913232] ReiserFS: hda6: journal params: device hda6, size 8192, 
journal first block 18, max trans len 1024, max batch 900, max commit 
age 30, max trans age 30
[   27.914339] ReiserFS: hda6: checking transaction log (hda6)
[   27.963925] ReiserFS: hda6: Using r5 hash to sort names
[   29.028911] skge eth0: enabling interface
[   31.373805] skge eth0: Link is up at 1000 Mbps, full duplex, flow 
control both
[   36.881521] lp0: using parport0 (interrupt-driven).
[   36.900445] ppdev: user-space parallel port driver
[   47.206417] warning: `ntpd' uses 32-bit capabilities (legacy support 
in use)
[   82.450294] ondemand governor failed, too long transition latency of 
HW, fallback to performance governor
[  656.340149] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
action 0x6 frozen
[  656.340159] ata1: SError: { 10B8B Dispar BadCRC TrStaTrns }
[  656.340168] ata1.00: cmd c8/00:00:18:12:e6/00:00:00:00:00/e1 tag 0 
dma 131072 in
[  656.340169]          res 40/00:01:09:4f:c2/00:00:00:00:00/00 Emask 
0x4 (timeout)
[  656.340173] ata1.00: status: { DRDY }
[  656.340217] ata1: hard resetting link
[  661.730034] ata1: link is slow to respond, please be patient (ready=-19)
[  666.350033] ata1: COMRESET failed (errno=-16)
[  666.350064] ata1: hard resetting link
[  671.740095] ata1: link is slow to respond, please be patient (ready=-19)
[  676.361213] ata1: COMRESET failed (errno=-16)
[  676.361265] ata1: hard resetting link
[  681.750032] ata1: link is slow to respond, please be patient (ready=-19)
[  711.390029] ata1: COMRESET failed (errno=-16)
[  711.390042] ata1: limiting SATA link speed to 1.5 Gbps
[  711.390088] ata1: hard resetting link
[  716.430157] ata1: COMRESET failed (errno=-16)
[  716.430166] ata1: reset failed, giving up
[  716.430170] ata1.00: disabled
[  716.430185] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe 
frozen t4
[  716.430188] ata1: hotplug_status 0x80
[  716.430245] ata1: hard resetting link
[  722.220031] ata1: link is slow to respond, please be patient (ready=-19)
[  726.490037] ata1: COMRESET failed (errno=-16)
[  726.490095] ata1: hard resetting link
[  732.290034] ata1: link is slow to respond, please be patient (ready=-19)
[  736.553291] ata1: COMRESET failed (errno=-16)
[  736.553329] ata1: hard resetting link
[  742.340109] ata1: link is slow to respond, please be patient (ready=-19)
[  771.580032] ata1: COMRESET failed (errno=-16)
[  771.580043] ata1: limiting SATA link speed to 1.5 Gbps
[  771.580091] ata1: hard resetting link
[  776.590064] ata1: COMRESET failed (errno=-16)
[  776.590072] ata1: reset failed, giving up
[  776.590086] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe 
frozen t3
[  776.590088] ata1: hotplug_status 0x80
[  776.590147] ata1: hard resetting link
[  782.390031] ata1: link is slow to respond, please be patient (ready=-19)
[  786.650038] ata1: COMRESET failed (errno=-16)
[  786.650090] ata1: hard resetting link
[  792.450034] ata1: link is slow to respond, please be patient (ready=-19)
[  796.710042] ata1: COMRESET failed (errno=-16)
[  796.710086] ata1: hard resetting link
[  802.510034] ata1: link is slow to respond, please be patient (ready=-19)
[  831.730046] ata1: COMRESET failed (errno=-16)
[  831.730056] ata1: limiting SATA link speed to 1.5 Gbps
[  831.730096] ata1: hard resetting link
[  836.750045] ata1: COMRESET failed (errno=-16)
[  836.750054] ata1: reset failed, giving up
[  836.750066] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe 
frozen t2
[  836.750069] ata1: hotplug_status 0x80
[  836.750114] ata1: hard resetting link
[  842.550037] ata1: link is slow to respond, please be patient (ready=-19)
[  846.810033] ata1: COMRESET failed (errno=-16)
[  846.810070] ata1: hard resetting link
[  852.610037] ata1: link is slow to respond, please be patient (ready=-19)
[  856.871987] ata1: COMRESET failed (errno=-16)
[  856.872031] ata1: hard resetting link
[  862.670042] ata1: link is slow to respond, please be patient (ready=-19)
[  891.890038] ata1: COMRESET failed (errno=-16)
[  891.890049] ata1: limiting SATA link speed to 1.5 Gbps
[  891.890098] ata1: hard resetting link
[  896.900036] ata1: COMRESET failed (errno=-16)
[  896.900045] ata1: reset failed, giving up
[  896.900065] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe 
frozen t1
[  896.900067] ata1: hotplug_status 0x80
[  896.900126] ata1: hard resetting link
[  902.690520] ata1: link is slow to respond, please be patient (ready=-19)
[  906.950040] ata1: COMRESET failed (errno=-16)
[  906.950097] ata1: hard resetting link
[  912.750088] ata1: link is slow to respond, please be patient (ready=-19)
[  917.010039] ata1: COMRESET failed (errno=-16)
[  917.010089] ata1: hard resetting link
[  922.810085] ata1: link is slow to respond, please be patient (ready=-19)
[  952.030039] ata1: COMRESET failed (errno=-16)
[  952.030051] ata1: limiting SATA link speed to 1.5 Gbps
[  952.030084] ata1: hard resetting link
[  957.040071] ata1: COMRESET failed (errno=-16)
[  957.040080] ata1: reset failed, giving up
[  957.040087] ata1: EH pending after 5 tries, giving up
[  957.040102] sd 0:0:0:0: [sda] Result: hostbyte=0x00 driverbyte=0x08
[  957.040106] sd 0:0:0:0: [sda] Sense Key : 0xb [current] [descriptor]
[  957.040110] Descriptor sense data with sense descriptors (in hex):
[  957.040113]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[  957.040119]         00 00 00 09
[  957.040122] sd 0:0:0:0: [sda] ASC=0x0 ASCQ=0x0
[  957.040126] end_request: I/O error, dev sda, sector 31855128
[  957.040130] Buffer I/O error on device sda, logical block 3981891
[  957.040135] Buffer I/O error on device sda, logical block 3981892
[  957.040138] Buffer I/O error on device sda, logical block 3981893
[  957.040142] Buffer I/O error on device sda, logical block 3981894
[  957.040145] Buffer I/O error on device sda, logical block 3981895
[  957.040148] Buffer I/O error on device sda, logical block 3981896
[  957.040151] Buffer I/O error on device sda, logical block 3981897
[  957.040154] Buffer I/O error on device sda, logical block 3981898
[  957.040157] Buffer I/O error on device sda, logical block 3981899
[  957.040160] Buffer I/O error on device sda, logical block 3981900
[  957.040190] sd 0:0:0:0: rejecting I/O to offline device
[  957.040196] ata1: EH complete
[  957.040205] ata1.00: detaching (SCSI 0:0:0:0)
[  957.040294] sd 0:0:0:0: [sda] Result: hostbyte=0x01 driverbyte=0x00
[  957.040298] end_request: I/O error, dev sda, sector 31855384
[  957.040513] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  957.042102] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  957.042108] sd 0:0:0:0: [sda] Stopping disk
[  957.042115] sd 0:0:0:0: [sda] START_STOP FAILED
[  957.042117] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00

