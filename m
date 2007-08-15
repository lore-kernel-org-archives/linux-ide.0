From: Lieven Marchand <mal@wyrd.be>
Subject: Re: regression problem with Maxtor disk
Date: Wed, 15 Aug 2007 23:22:25 +0200
Message-ID: <87wsvw8pda.fsf@wyrd.be>
References: <87tzr4zvpt.fsf@wyrd.be> <46C17AE0.5090601@gmail.com>
	<46C23746.6030203@shaw.ca> <878x8dl07z.fsf@wyrd.be>
	<46C2B0FD.5030101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 213.219.137.158.adsl.dyn.edpnet.net ([213.219.137.158]:50639
	"EHLO black" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753385AbXHOVjw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 17:39:52 -0400
In-Reply-To: <46C2B0FD.5030101@gmail.com> (Tejun Heo's message of "Wed, 15 Aug 2007 16:53:33 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Tejun Heo <htejun@gmail.com> writes:

> It seems klogd clipped some messages.  Can you please turn on printk
> timestamp, enlarge printk log buffersize and post the result of 'dmesg'
> after errors?

[   33.587986] libata version 2.21 loaded.
[   33.592361] ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
[   33.592411] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 21 (level, low) -> IRQ 18
[   33.592508] PCI: Setting latency timer of device 0000:00:0a.0 to 64
[   33.592516] forcedeth: using HIGHDMA
[   33.633334] hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
[   33.633558] Uniform CD-ROM driver Revision: 3.20
[   33.638683] hdb: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(66)
[   34.109811] eth0: forcedeth.c: subsystem: 01695:1010 bound to 0000:00:0a.0
[   34.109949] sata_nv 0000:00:07.0: version 3.4
[   34.110368] ACPI: PCI Interrupt Link [APSI] enabled at IRQ 20
[   34.110414] ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 20 (level, low) -> IRQ 19
[   34.110509] sata_nv 0000:00:07.0: Using ADMA mode
[   34.110587] PCI: Setting latency timer of device 0000:00:07.0 to 64
[   34.110849] scsi0 : sata_nv
[   34.110922] scsi1 : sata_nv
[   34.110973] ata1: SATA max UDMA/133 cmd 0xf883e480 ctl 0xf883e4a0 bmdma 0x0001cc00 irq 19
[   34.111026] ata2: SATA max UDMA/133 cmd 0xf883e580 ctl 0xf883e5a0 bmdma 0x0001cc08 irq 19
[   34.129549] usb 2-1: new high speed USB device using ehci_hcd and address 2
[   34.322380] usb 2-1: configuration #1 chosen from 1 choice
[   34.336790] Initializing USB Mass Storage driver...
[   34.560984] usb 2-2: new high speed USB device using ehci_hcd and address 3
[   34.576963] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   34.586151] ata1.00: ATA-7: Maxtor 7H500F0, HA431DN0, max UDMA/133
[   34.586191] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   34.602085] ata1.00: configured for UDMA/133
[   34.695412] usb 2-2: configuration #1 chosen from 1 choice
[   34.932499] usb 2-4: new high speed USB device using ehci_hcd and address 4
[   35.068325] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   35.116969] ata2.00: ATA-7: MAXTOR STM3320820AS, 3.AAE, max UDMA/133
[   35.117010] ata2.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   35.147355] usb 2-4: configuration #1 chosen from 1 choice
[   35.149712] scsi2 : SCSI emulation for USB Mass Storage devices
[   35.149993] usb-storage: device found at 2
[   35.149995] usb-storage: waiting for device to settle before scanning
[   35.150009] scsi3 : SCSI emulation for USB Mass Storage devices
[   35.150201] usb-storage: device found at 3
[   35.150203] usb-storage: waiting for device to settle before scanning
[   35.150216] scsi4 : SCSI emulation for USB Mass Storage devices
[   35.150406] usbcore: registered new interface driver usb-storage
[   35.150447] USB Mass Storage support registered.
[   35.150491] usb-storage: device found at 4
[   35.150493] usb-storage: waiting for device to settle before scanning
[   35.183534] ata2.00: configured for UDMA/133
[   35.183676] scsi 0:0:0:0: Direct-Access     ATA      Maxtor 7H500F0   HA43 PQ: 0 ANSI: 5
[   35.183734] ata1: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
[   35.184076] scsi 1:0:0:0: Direct-Access     ATA      MAXTOR STM332082 3.AA PQ: 0 ANSI: 5
[   35.184130] ata2: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
[   35.184627] ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 23
[   35.184668] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 23 (level, low) -> IRQ 16
[   35.184764] sata_nv 0000:00:08.0: Using ADMA mode
[   35.184843] PCI: Setting latency timer of device 0000:00:08.0 to 64
[   35.184933] scsi5 : sata_nv
[   35.184996] scsi6 : sata_nv
[   35.185050] ata3: SATA max UDMA/133 cmd 0xf88a0480 ctl 0xf88a04a0 bmdma 0x0001b800 irq 16
[   35.185102] ata4: SATA max UDMA/133 cmd 0xf88a0580 ctl 0xf88a05a0 bmdma 0x0001b808 irq 16
[   35.651571] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   35.660568] ata3.00: ATA-7: Maxtor 6B300S0, BANC1980, max UDMA/133
[   35.660608] ata3.00: 586114704 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   35.676553] ata3.00: configured for UDMA/133
[   35.987125] ata4: SATA link down (SStatus 0 SControl 300)
[   35.987235] scsi 5:0:0:0: Direct-Access     ATA      Maxtor 6B300S0   BANC PQ: 0 ANSI: 5
[   35.987289] ata3: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
[   36.023244] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
[   36.023297] sd 0:0:0:0: [sda] Write Protect is off
[   36.023336] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   36.023347] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   36.023439] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
[   36.023484] sd 0:0:0:0: [sda] Write Protect is off
[   36.023522] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   36.023531] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   36.023584]  sda: sda1 sda2 < sda5 sda6 sda7 >
[   36.075908] sd 0:0:0:0: [sda] Attached SCSI disk
[   36.076642] sd 1:0:0:0: [sdb] 625142448 512-byte hardware sectors (320073 MB)
[   36.078107] sd 1:0:0:0: [sdb] Write Protect is off
[   36.078145] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   36.078155] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   36.078230] sd 1:0:0:0: [sdb] 625142448 512-byte hardware sectors (320073 MB)
[   36.078274] sd 1:0:0:0: [sdb] Write Protect is off
[   36.078312] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   36.078322] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   36.078374]  sdb: sdb1
[   36.096793] sd 1:0:0:0: [sdb] Attached SCSI disk
[   36.097148] sd 5:0:0:0: [sdc] 586114704 512-byte hardware sectors (300091 MB)
[   36.097193] sd 5:0:0:0: [sdc] Write Protect is off
[   36.097231] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   36.097241] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   36.097318] sd 5:0:0:0: [sdc] 586114704 512-byte hardware sectors (300091 MB)
[   36.097363] sd 5:0:0:0: [sdc] Write Protect is off
[   36.097401] sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   36.097410] sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   36.097462]  sdc: sdc1 sdc2
[   36.116596] sd 5:0:0:0: [sdc] Attached SCSI disk
[   36.488949] Probing IDE interface ide1...
[   37.067405] md: raid1 personality registered for level 1
[   37.082723] md: md0 stopped.
[   37.112993] md: bind<sdc2>
[   37.113130] md: bind<sda7>
[   37.123391] raid1: raid set md0 active with 2 out of 2 mirrors
[   37.302653] device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
[   37.905627] kjournald starting.  Commit interval 5 seconds
[   37.905678] EXT3-fs: mounted filesystem with ordered data mode.
[   39.355192] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x4c00
[   39.355256] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x4c40
[   40.023669] Real Time Clock Driver v1.12ac
[   40.047120] input: PC Speaker as /class/input/input1
[   40.079840] irda_init()
[   40.079860] NET: Registered protocol family 23
[   40.108430] ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 22
[   40.108475] ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCJ] -> GSI 22 (level, low) -> IRQ 17
[   40.108588] PCI: Setting latency timer of device 0000:00:04.0 to 64
[   40.141895] usb-storage: device scan complete
[   40.142136] usb-storage: device scan complete
[   40.142171] usb-storage: device scan complete
[   40.144889] scsi 3:0:0:0: Direct-Access     Seagate  External Drive        PQ: 0 ANSI: 0
[   40.157610] scsi 2:0:0:0: Direct-Access     USB 2.0  Storage Device   0100 PQ: 0 ANSI: 0 CCS
[   40.163346] sd 2:0:0:0: [sdd] 320173056 512-byte hardware sectors (163929 MB)
[   40.165091] sd 2:0:0:0: [sdd] Write Protect is off
[   40.165129] sd 2:0:0:0: [sdd] Mode Sense: 08 00 00 00
[   40.165132] sd 2:0:0:0: [sdd] Assuming drive cache: write through
[   40.170335] sd 2:0:0:0: [sdd] 320173056 512-byte hardware sectors (163929 MB)
[   40.172150] sd 2:0:0:0: [sdd] Write Protect is off
[   40.172188] sd 2:0:0:0: [sdd] Mode Sense: 08 00 00 00
[   40.172190] sd 2:0:0:0: [sdd] Assuming drive cache: write through
[   40.172230]  sdd:<5>scsi 4:0:0:0: Direct-Access     ST332082 0A               3.AA PQ: 0 ANSI: 0
[   40.181832]  sdd1
[   40.181923] sd 2:0:0:0: [sdd] Attached SCSI disk
[   40.184193] sd 4:0:0:0: [sde] 625142448 512-byte hardware sectors (320073 MB)
[   40.187065] sd 4:0:0:0: [sde] Write Protect is off
[   40.187103] sd 4:0:0:0: [sde] Mode Sense: 03 00 00 00
[   40.187105] sd 4:0:0:0: [sde] Assuming drive cache: write through
[   40.189186] sd 4:0:0:0: [sde] 625142448 512-byte hardware sectors (320073 MB)
[   40.191059] sd 4:0:0:0: [sde] Write Protect is off
[   40.191097] sd 4:0:0:0: [sde] Mode Sense: 03 00 00 00
[   40.191099] sd 4:0:0:0: [sde] Assuming drive cache: write through
[   40.191138]  sde:<6>intel8x0_measure_ac97_clock: measured 54811 usecs
[   40.429398] intel8x0: clocking to 46981
[   40.919334] input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
[   40.922844] parport_pc 00:0a: reported by Plug and Play ACPI
[   40.922929] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[   43.511331] Adding 3036244k swap on /dev/sda5.  Priority:-1 extents:1 across:3036244k
[   43.952498] EXT3 FS on dm-0, internal journal
[   44.020016]  sde1
[   44.020140] sd 4:0:0:0: [sde] Attached SCSI disk
[   44.025003] sd 3:0:0:0: [sdf] 312581808 512-byte hardware sectors (160042 MB)
[   44.028710] sd 3:0:0:0: [sdf] Write Protect is off
[   44.028756] sd 3:0:0:0: [sdf] Mode Sense: 27 00 00 00
[   44.028759] sd 3:0:0:0: [sdf] Assuming drive cache: write through
[   44.032707] sd 3:0:0:0: [sdf] 312581808 512-byte hardware sectors (160042 MB)
[   44.035706] sd 3:0:0:0: [sdf] Write Protect is off
[   44.035745] sd 3:0:0:0: [sdf] Mode Sense: 27 00 00 00
[   44.035748] sd 3:0:0:0: [sdf] Assuming drive cache: write through
[   44.035788]  sdf: sdf1 sdf2 sdf3
[   44.057279] sd 3:0:0:0: [sdf] Attached SCSI disk
[   44.417152] f71805f: Found F71872F/FG chip at 0x290, revision 33
[   48.251624] kjournald starting.  Commit interval 5 seconds
[   48.301077] EXT3 FS on dm-4, internal journal
[   48.301138] EXT3-fs: mounted filesystem with ordered data mode.
[   48.315828] kjournald starting.  Commit interval 5 seconds
[   48.324360] EXT3 FS on dm-3, internal journal
[   48.324419] EXT3-fs: mounted filesystem with ordered data mode.
[   48.351268] kjournald starting.  Commit interval 5 seconds
[   48.361585] EXT3 FS on dm-1, internal journal
[   48.361644] EXT3-fs: mounted filesystem with ordered data mode.
[   48.393085] kjournald starting.  Commit interval 5 seconds
[   48.399449] EXT3 FS on dm-2, internal journal
[   48.399508] EXT3-fs: mounted filesystem with ordered data mode.
[   48.422368] kjournald starting.  Commit interval 5 seconds
[   48.432338] EXT3 FS on sda1, internal journal
[   48.432397] EXT3-fs: mounted filesystem with ordered data mode.
[   48.454943] kjournald starting.  Commit interval 5 seconds
[   48.455094] EXT3 FS on sdc1, internal journal
[   48.455152] EXT3-fs: mounted filesystem with ordered data mode.
[   48.470571] kjournald starting.  Commit interval 5 seconds
[   48.475025] EXT3 FS on sdb1, internal journal
[   48.475083] EXT3-fs: mounted filesystem with ordered data mode.
[   48.501723] kjournald starting.  Commit interval 5 seconds
[   48.510507] EXT3 FS on sda6, internal journal
[   48.510567] EXT3-fs: mounted filesystem with ordered data mode.
[   48.994556] ata1: timeout waiting for ADMA IDLE, stat=0x440
[   49.147577] ata1: failed to read log page 10h (errno=-2)
[   49.149046] ata1.00: exception Emask 0x1 SAct 0xff SErr 0x0 action 0x0
[   49.149086] ata1.00: (CPB resp_flags 0x11: CMD error)
[   49.149129] ata1.00: cmd 61/06:00:bc:bf:df/00:00:16:00:00/40 tag 0 cdb 0x0 data 3072 out
[   49.149131]          res 51/04:00:16:00:00/04:00:16:00:00/40 Emask 0x1 (device error)
[   49.149234] ata1.00: cmd 61/04:08:c4:bf:df/00:00:16:00:00/40 tag 1 cdb 0x0 data 2048 out
[   49.149236]          res 51/04:00:16:00:00/04:00:16:00:00/40 Emask 0x1 (device error)
[   49.149338] ata1.00: cmd 61/02:10:d6:bf:df/00:00:16:00:00/40 tag 2 cdb 0x0 data 1024 out
[   49.149340]          res 51/04:00:16:00:00/04:00:16:00:00/40 Emask 0x1 (device error)
[   49.149443] ata1.00: cmd 61/04:18:dc:bf:df/00:00:16:00:00/40 tag 3 cdb 0x0 data 2048 out
[   49.149445]          res 51/04:00:16:00:00/04:00:16:00:00/40 Emask 0x1 (device error)
[   49.149547] ata1.00: cmd 61/02:20:e8:bf:df/00:00:16:00:00/40 tag 4 cdb 0x0 data 1024 out
[   49.149549]          res 51/04:00:16:00:00/04:00:16:00:00/40 Emask 0x1 (device error)
[   49.149652] ata1.00: cmd 61/02:28:f2:bf:df/00:00:16:00:00/40 tag 5 cdb 0x0 data 1024 out
[   49.149653]          res 51/04:00:16:00:00/04:00:16:00:00/40 Emask 0x1 (device error)
[   49.149756] ata1.00: cmd 61/04:30:fa:bf:df/00:00:16:00:00/40 tag 6 cdb 0x0 data 2048 out
[   49.149758]          res 51/04:00:16:00:00/04:00:16:00:00/40 Emask 0x1 (device error)
[   49.149860] ata1.00: cmd 61/02:38:04:c0:df/00:00:16:00:00/40 tag 7 cdb 0x0 data 1024 out
[   49.149862]          res 51/04:00:16:00:00/04:00:16:00:00/40 Emask 0x1 (device error)
[   49.175045] ata1.00: configured for UDMA/133
[   49.175095] ata1: EH complete
[   49.175145] ata1: timeout waiting for ADMA LEGACY clear and IDLE, stat=0x440
[   49.175237] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
[   49.175285] sd 0:0:0:0: [sda] Write Protect is off
[   49.175323] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   49.175334] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   79.155040] ata1: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl 0x1501000 status 0x400 next cpb count 0x17 next cpb idx 0x0
[   79.155098] ata1: CPB 0: ctl_flags 0x1f, resp_flags 0x2
[   79.155136] ata1: CPB 1: ctl_flags 0x1f, resp_flags 0x0
[   79.155174] ata1: CPB 2: ctl_flags 0x1f, resp_flags 0x0
[   79.155212] ata1: CPB 3: ctl_flags 0x1f, resp_flags 0x0
[   79.155250] ata1: CPB 4: ctl_flags 0x1f, resp_flags 0x0
[   79.155288] ata1: CPB 5: ctl_flags 0x1f, resp_flags 0x0
[   79.155326] ata1: CPB 6: ctl_flags 0x1f, resp_flags 0x0
[   79.155364] ata1: CPB 7: ctl_flags 0x1f, resp_flags 0x0
[   79.155402] ata1: CPB 8: ctl_flags 0x1f, resp_flags 0x0
[   79.155440] ata1: CPB 9: ctl_flags 0x1f, resp_flags 0x0
[   79.155478] ata1: CPB 10: ctl_flags 0x1f, resp_flags 0x0
[   79.155517] ata1: CPB 11: ctl_flags 0x1f, resp_flags 0x0
[   79.155555] ata1: CPB 12: ctl_flags 0x1f, resp_flags 0x0
[   79.155593] ata1: CPB 13: ctl_flags 0x1f, resp_flags 0x0
[   79.155631] ata1: CPB 14: ctl_flags 0x1f, resp_flags 0x0
[   79.155669] ata1: CPB 15: ctl_flags 0x1f, resp_flags 0x0
[   79.155708] ata1: CPB 16: ctl_flags 0x1f, resp_flags 0x0
[   79.155746] ata1: CPB 17: ctl_flags 0x1f, resp_flags 0x0
[   79.155784] ata1: CPB 18: ctl_flags 0x1f, resp_flags 0x0
[   79.155828] ata1: timeout waiting for ADMA IDLE, stat=0x400
[   79.155873] ata1: timeout waiting for ADMA LEGACY, stat=0x400
[   79.155917] ata1.00: exception Emask 0x0 SAct 0x7ffff SErr 0x0 action 0x2 frozen
[   79.155971] ata1.00: cmd 61/02:00:02:c1:df/00:00:16:00:00/40 tag 0 cdb 0x0 data 1024 out
[   79.155973]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[   79.156075] ata1.00: cmd 61/04:08:fa:bf:df/00:00:16:00:00/40 tag 1 cdb 0x0 data 2048 out
[   79.156077]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[   79.156179] ata1.00: cmd 61/02:10:f2:bf:df/00:00:16:00:00/40 tag 2 cdb 0x0 data 1024 out
[   79.156180]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[   79.156282] ata1.00: cmd 61/02:18:e8:bf:df/00:00:16:00:00/40 tag 3 cdb 0x0 data 1024 out
[   79.156284]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[   79.156386] ata1.00: cmd 61/04:20:dc:bf:df/00:00:16:00:00/40 tag 4 cdb 0x0 data 2048 out
[   79.156388]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[   79.156490] ata1.00: cmd 61/02:28:d6:bf:df/00:00:16:00:00/40 tag 5 cdb 0x0 data 1024 out
[   79.156492]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[   79.156594] ata1.00: cmd 61/04:30:c4:bf:df/00:00:16:00:00/40 tag 6 cdb 0x0 data 2048 out
[   79.156596]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[   79.156698] ata1.00: cmd 61/06:38:bc:bf:df/00:00:16:00:00/40 tag 7 cdb 0x0 data 3072 out
[   79.156699]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[   79.156801] ata1.00: cmd 61/04:40:08:c0:df/00:00:16:00:00/40 tag 8 cdb 0x0 data 2048 out
[   79.156803]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   79.156905] ata1.00: cmd 61/04:48:ca:c0:df/00:00:16:00:00/40 tag 9 cdb 0x0 data 2048 out
[   79.156907]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   79.157009] ata1.00: cmd 61/06:50:d0:c0:df/00:00:16:00:00/40 tag 10 cdb 0x0 data 3072 out
[   79.157011]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   79.157113] ata1.00: cmd 61/02:58:d8:c0:df/00:00:16:00:00/40 tag 11 cdb 0x0 data 1024 out
[   79.157114]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   79.157216] ata1.00: cmd 61/02:60:e0:c0:df/00:00:16:00:00/40 tag 12 cdb 0x0 data 1024 out
[   79.157218]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   79.157320] ata1.00: cmd 61/02:68:f0:c0:df/00:00:16:00:00/40 tag 13 cdb 0x0 data 1024 out
[   79.157322]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   79.157424] ata1.00: cmd 61/02:70:f8:c0:df/00:00:16:00:00/40 tag 14 cdb 0x0 data 1024 out
[   79.157426]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   79.157528] ata1.00: cmd 61/04:78:fc:c0:df/00:00:16:00:00/40 tag 15 cdb 0x0 data 2048 out
[   79.157529]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   79.157631] ata1.00: cmd 61/02:80:06:c1:df/00:00:16:00:00/40 tag 16 cdb 0x0 data 1024 out
[   79.157633]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   79.157735] ata1.00: cmd 61/06:88:0a:c1:df/00:00:16:00:00/40 tag 17 cdb 0x0 data 3072 out
[   79.157737]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   79.157839] ata1.00: cmd 61/04:90:18:c1:df/00:00:16:00:00/40 tag 18 cdb 0x0 data 2048 out
[   79.157841]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   79.466629] ata1: soft resetting port
[   79.622437] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   79.647445] ata1.00: configured for UDMA/133
[   79.647494] ata1: EH complete
[   79.647538] ata1: timeout waiting for ADMA LEGACY clear and IDLE, stat=0x400
[   79.647602] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
[   79.647648] sd 0:0:0:0: [sda] Write Protect is off
[   79.647686] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   79.647697] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  109.607481] ata1: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl 0x1501000 status 0x400 next cpb count 0x12 next cpb idx 0x0
[  109.607538] ata1: CPB 0: ctl_flags 0x1f, resp_flags 0x2
[  109.607576] ata1: CPB 1: ctl_flags 0x1f, resp_flags 0x0
[  109.607614] ata1: CPB 2: ctl_flags 0x1f, resp_flags 0x0
[  109.607652] ata1: CPB 3: ctl_flags 0x1f, resp_flags 0x0
[  109.607690] ata1: CPB 4: ctl_flags 0x1f, resp_flags 0x0
[  109.607728] ata1: CPB 5: ctl_flags 0x1f, resp_flags 0x0
[  109.607766] ata1: CPB 6: ctl_flags 0x1f, resp_flags 0x0
[  109.607804] ata1: CPB 7: ctl_flags 0x1f, resp_flags 0x0
[  109.607842] ata1: CPB 8: ctl_flags 0x1f, resp_flags 0x0
[  109.607880] ata1: CPB 9: ctl_flags 0x1f, resp_flags 0x0
[  109.607919] ata1: CPB 10: ctl_flags 0x1f, resp_flags 0x0
[  109.607957] ata1: CPB 11: ctl_flags 0x1f, resp_flags 0x0
[  109.607995] ata1: CPB 12: ctl_flags 0x1f, resp_flags 0x0
[  109.608033] ata1: CPB 13: ctl_flags 0x1f, resp_flags 0x0
[  109.608071] ata1: CPB 14: ctl_flags 0x1f, resp_flags 0x0
[  109.608110] ata1: CPB 15: ctl_flags 0x1f, resp_flags 0x0
[  109.608148] ata1: CPB 16: ctl_flags 0x1f, resp_flags 0x0
[  109.608186] ata1: CPB 17: ctl_flags 0x1f, resp_flags 0x0
[  109.608224] ata1: CPB 18: ctl_flags 0x1f, resp_flags 0x0
[  109.608268] ata1: timeout waiting for ADMA IDLE, stat=0x400
[  109.608313] ata1: timeout waiting for ADMA LEGACY, stat=0x400
[  109.608356] ata1.00: exception Emask 0x0 SAct 0x7ffff SErr 0x0 action 0x2 frozen
[  109.608410] ata1.00: cmd 61/04:00:18:c1:df/00:00:16:00:00/40 tag 0 cdb 0x0 data 2048 out
[  109.608412]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[  109.609937] ata1.00: cmd 61/06:08:0a:c1:df/00:00:16:00:00/40 tag 1 cdb 0x0 data 3072 out
[  109.609938]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[  109.610041] ata1.00: cmd 61/02:10:06:c1:df/00:00:16:00:00/40 tag 2 cdb 0x0 data 1024 out
[  109.610042]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[  109.610145] ata1.00: cmd 61/04:18:fc:c0:df/00:00:16:00:00/40 tag 3 cdb 0x0 data 2048 out
[  109.610146]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[  109.610249] ata1.00: cmd 61/02:20:f8:c0:df/00:00:16:00:00/40 tag 4 cdb 0x0 data 1024 out
[  109.610250]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[  109.610353] ata1.00: cmd 61/02:28:f0:c0:df/00:00:16:00:00/40 tag 5 cdb 0x0 data 1024 out
[  109.610354]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[  109.610456] ata1.00: cmd 61/02:30:e0:c0:df/00:00:16:00:00/40 tag 6 cdb 0x0 data 1024 out
[  109.610458]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[  109.610560] ata1.00: cmd 61/02:38:d8:c0:df/00:00:16:00:00/40 tag 7 cdb 0x0 data 1024 out
[  109.610562]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[  109.610664] ata1.00: cmd 61/06:40:d0:c0:df/00:00:16:00:00/40 tag 8 cdb 0x0 data 3072 out
[  109.610666]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  109.610768] ata1.00: cmd 61/04:48:ca:c0:df/00:00:16:00:00/40 tag 9 cdb 0x0 data 2048 out
[  109.610769]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  109.610871] ata1.00: cmd 61/04:50:08:c0:df/00:00:16:00:00/40 tag 10 cdb 0x0 data 2048 out
[  109.610873]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  109.610975] ata1.00: cmd 61/06:58:bc:bf:df/00:00:16:00:00/40 tag 11 cdb 0x0 data 3072 out
[  109.610977]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  109.611079] ata1.00: cmd 61/04:60:c4:bf:df/00:00:16:00:00/40 tag 12 cdb 0x0 data 2048 out
[  109.611081]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  109.611183] ata1.00: cmd 61/02:68:d6:bf:df/00:00:16:00:00/40 tag 13 cdb 0x0 data 1024 out
[  109.611185]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  109.611287] ata1.00: cmd 61/04:70:dc:bf:df/00:00:16:00:00/40 tag 14 cdb 0x0 data 2048 out
[  109.611288]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  109.611391] ata1.00: cmd 61/02:78:e8:bf:df/00:00:16:00:00/40 tag 15 cdb 0x0 data 1024 out
[  109.611392]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  109.611497] ata1.00: cmd 61/02:80:f2:bf:df/00:00:16:00:00/40 tag 16 cdb 0x0 data 1024 out
[  109.611498]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  109.611601] ata1.00: cmd 61/04:88:fa:bf:df/00:00:16:00:00/40 tag 17 cdb 0x0 data 2048 out
[  109.611602]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  109.611704] ata1.00: cmd 61/02:90:02:c1:df/00:00:16:00:00/40 tag 18 cdb 0x0 data 1024 out
[  109.611706]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  109.923055] ata1: soft resetting port
[  110.078863] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  110.104389] ata1.00: configured for UDMA/133
[  110.104437] ata1: EH complete
[  110.104480] ata1: timeout waiting for ADMA LEGACY clear and IDLE, stat=0x400
[  110.104543] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
[  110.104588] sd 0:0:0:0: [sda] Write Protect is off
[  110.104625] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  110.104636] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  140.063908] ata1: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl 0x1501000 status 0x400 next cpb count 0x12 next cpb idx 0x0
[  140.063965] ata1: CPB 0: ctl_flags 0x1f, resp_flags 0x2
[  140.064003] ata1: CPB 1: ctl_flags 0x1f, resp_flags 0x0
[  140.064041] ata1: CPB 2: ctl_flags 0x1f, resp_flags 0x0
[  140.064079] ata1: CPB 3: ctl_flags 0x1f, resp_flags 0x0
[  140.064117] ata1: CPB 4: ctl_flags 0x1f, resp_flags 0x0
[  140.064156] ata1: CPB 5: ctl_flags 0x1f, resp_flags 0x0
[  140.064194] ata1: CPB 6: ctl_flags 0x1f, resp_flags 0x0
[  140.064232] ata1: CPB 7: ctl_flags 0x1f, resp_flags 0x0
[  140.064270] ata1: CPB 8: ctl_flags 0x1f, resp_flags 0x0
[  140.064308] ata1: CPB 9: ctl_flags 0x1f, resp_flags 0x0
[  140.064346] ata1: CPB 10: ctl_flags 0x1f, resp_flags 0x0
[  140.064384] ata1: CPB 11: ctl_flags 0x1f, resp_flags 0x0
[  140.064422] ata1: CPB 12: ctl_flags 0x1f, resp_flags 0x0
[  140.064460] ata1: CPB 13: ctl_flags 0x1f, resp_flags 0x0
[  140.064498] ata1: CPB 14: ctl_flags 0x1f, resp_flags 0x0
[  140.064537] ata1: CPB 15: ctl_flags 0x1f, resp_flags 0x0
[  140.064575] ata1: CPB 16: ctl_flags 0x1f, resp_flags 0x0
[  140.064613] ata1: CPB 17: ctl_flags 0x1f, resp_flags 0x0
[  140.064651] ata1: CPB 18: ctl_flags 0x1f, resp_flags 0x0
[  140.064695] ata1: timeout waiting for ADMA IDLE, stat=0x400
[  140.064740] ata1: timeout waiting for ADMA LEGACY, stat=0x400
[  140.064782] ata1.00: NCQ disabled due to excessive errors
[  140.064821] ata1.00: exception Emask 0x0 SAct 0x7ffff SErr 0x0 action 0x2 frozen
[  140.064875] ata1.00: cmd 61/02:00:02:c1:df/00:00:16:00:00/40 tag 0 cdb 0x0 data 1024 out
[  140.064877]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[  140.064979] ata1.00: cmd 61/04:08:fa:bf:df/00:00:16:00:00/40 tag 1 cdb 0x0 data 2048 out
[  140.064981]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[  140.065083] ata1.00: cmd 61/02:10:f2:bf:df/00:00:16:00:00/40 tag 2 cdb 0x0 data 1024 out
[  140.065085]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[  140.065187] ata1.00: cmd 61/02:18:e8:bf:df/00:00:16:00:00/40 tag 3 cdb 0x0 data 1024 out
[  140.065188]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[  140.065290] ata1.00: cmd 61/04:20:dc:bf:df/00:00:16:00:00/40 tag 4 cdb 0x0 data 2048 out
[  140.065292]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[  140.065394] ata1.00: cmd 61/02:28:d6:bf:df/00:00:16:00:00/40 tag 5 cdb 0x0 data 1024 out
[  140.065396]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[  140.065498] ata1.00: cmd 61/04:30:c4:bf:df/00:00:16:00:00/40 tag 6 cdb 0x0 data 2048 out
[  140.065500]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[  140.065602] ata1.00: cmd 61/06:38:bc:bf:df/00:00:16:00:00/40 tag 7 cdb 0x0 data 3072 out
[  140.065603]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[  140.065705] ata1.00: cmd 61/04:40:08:c0:df/00:00:16:00:00/40 tag 8 cdb 0x0 data 2048 out
[  140.065707]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  140.065809] ata1.00: cmd 61/04:48:ca:c0:df/00:00:16:00:00/40 tag 9 cdb 0x0 data 2048 out
[  140.065810]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  140.065912] ata1.00: cmd 61/06:50:d0:c0:df/00:00:16:00:00/40 tag 10 cdb 0x0 data 3072 out
[  140.065914]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  140.066016] ata1.00: cmd 61/02:58:d8:c0:df/00:00:16:00:00/40 tag 11 cdb 0x0 data 1024 out
[  140.066018]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  140.066120] ata1.00: cmd 61/02:60:e0:c0:df/00:00:16:00:00/40 tag 12 cdb 0x0 data 1024 out
[  140.066121]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  140.066224] ata1.00: cmd 61/02:68:f0:c0:df/00:00:16:00:00/40 tag 13 cdb 0x0 data 1024 out
[  140.066225]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  140.066327] ata1.00: cmd 61/02:70:f8:c0:df/00:00:16:00:00/40 tag 14 cdb 0x0 data 1024 out
[  140.066329]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  140.066431] ata1.00: cmd 61/04:78:fc:c0:df/00:00:16:00:00/40 tag 15 cdb 0x0 data 2048 out
[  140.066433]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  140.066535] ata1.00: cmd 61/02:80:06:c1:df/00:00:16:00:00/40 tag 16 cdb 0x0 data 1024 out
[  140.066537]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  140.066639] ata1.00: cmd 61/06:88:0a:c1:df/00:00:16:00:00/40 tag 17 cdb 0x0 data 3072 out
[  140.066641]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  140.066743] ata1.00: cmd 61/04:90:18:c1:df/00:00:16:00:00/40 tag 18 cdb 0x0 data 2048 out
[  140.066744]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  140.379482] ata1: soft resetting port
[  140.535289] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  140.560308] ata1.00: configured for UDMA/133
[  140.560356] ata1: EH complete
[  140.560400] ata1: timeout waiting for ADMA LEGACY clear and IDLE, stat=0x400
[  170.520332] ata1: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl 0x1501000 status 0x400 next cpb count 0x0 next cpb idx 0x0
[  170.520389] ata1: CPB 0: ctl_flags 0xd, resp_flags 0x0
[  170.520433] ata1: timeout waiting for ADMA IDLE, stat=0x400
[  170.520477] ata1: timeout waiting for ADMA LEGACY, stat=0x400
[  170.520521] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[  170.520565] ata1.00: cmd 35/00:04:18:c1:df/00:00:16:00:00/e0 tag 0 cdb 0x0 data 2048 out
[  170.520567]          res 40/00:00:16:00:00/04:00:16:00:00/40 Emask 0x4 (timeout)
[  170.831913] ata1: soft resetting port
[  170.987721] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  171.012723] ata1.00: configured for UDMA/133
[  171.012762] ata1: EH complete
[  171.162056] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
[  171.166591] sd 0:0:0:0: [sda] Write Protect is off
[  171.166629] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  171.178390] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  171.195572] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
[  171.204351] sd 0:0:0:0: [sda] Write Protect is off
[  171.204389] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  171.214556] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
