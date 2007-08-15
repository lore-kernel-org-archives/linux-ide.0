From: Lieven Marchand <mal@wyrd.be>
Subject: Re: regression problem with Maxtor disk
Date: Wed, 15 Aug 2007 09:34:56 +0200
Message-ID: <878x8dl07z.fsf@wyrd.be>
References: <87tzr4zvpt.fsf@wyrd.be> <46C17AE0.5090601@gmail.com>
	<46C23746.6030203@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 213.219.189.104.adsl.dyn.edpnet.net ([213.219.189.104]:47026
	"EHLO black" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753218AbXHOII1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 04:08:27 -0400
In-Reply-To: <46C23746.6030203@shaw.ca> (Robert Hancock's message of "Tue, 14 Aug 2007 17:14:14 -0600")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Robert Hancock <hancockr@shaw.ca> writes:

> It looks like there are some lines missing from this log, there should
> be a line before the "res" lines indicating what the failed command
> was..

There isn't. I snipped some irrelevant stuff but nothing about a
command. The full log is appended.

> My guess, though, is that NCQ is somehow busted on this drive, as is
> known to be the case with a number of other Maxtor disks..

Aug 11 10:27:51 black kernel: sata_nv 0000:00:07.0: Using ADMA mode
Aug 11 10:27:51 black kernel: scsi3 : sata_nv
Aug 11 10:27:51 black kernel: scsi4 : sata_nv
Aug 11 10:27:51 black kernel: ata1: SATA max UDMA/133 cmd 0xf8840480 ctl 0xf88404a0 bmdma 0x0001cc00 irq 19
Aug 11 10:27:51 black kernel: ata2: SATA max UDMA/133 cmd 0xf8840580 ctl 0xf88405a0 bmdma 0x0001cc08 irq 19
Aug 11 10:27:51 black kernel: hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Aug 11 10:27:51 black kernel: Uniform CD-ROM driver Revision: 3.20
Aug 11 10:27:51 black kernel: hdb: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(66)
Aug 11 10:27:51 black kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Aug 11 10:27:51 black kernel: ata1.00: ATA-7: MAXTOR STM3320820AS, 3.AAE, max UDMA/133
Aug 11 10:27:51 black kernel: ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32)
Aug 11 10:27:51 black kernel: ata1.00: configured for UDMA/133
Aug 11 10:27:51 black kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Aug 11 10:27:51 black kernel: ata2.00: ATA-7: Maxtor 7H500F0, HA431DN0, max UDMA/133
Aug 11 10:27:51 black kernel: ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
Aug 11 10:27:51 black kernel: scsi 3:0:0:0: Direct-Access     ATA      MAXTOR STM332082 3.AA PQ: 0 ANSI: 5
Aug 11 10:27:51 black kernel: ata1: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
Aug 11 10:27:51 black kernel: scsi 4:0:0:0: Direct-Access     ATA      Maxtor 7H500F0   HA43 PQ: 0 ANSI: 5
Aug 11 10:27:51 black kernel: ata2: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
Aug 11 10:27:51 black kernel: ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 23
Aug 11 10:27:51 black kernel: ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 23 (level, low) -> IRQ 16
Aug 11 10:27:51 black kernel: sata_nv 0000:00:08.0: Using ADMA mode
Aug 11 10:27:51 black kernel: scsi5 : sata_nv
Aug 11 10:27:51 black kernel: scsi6 : sata_nv
Aug 11 10:27:51 black kernel: ata3: SATA max UDMA/133 cmd 0xf88de480 ctl 0xf88de4a0 bmdma 0x0001b800 irq 16
Aug 11 10:27:51 black kernel: ata4: SATA max UDMA/133 cmd 0xf88de580 ctl 0xf88de5a0 bmdma 0x0001b808 irq 16
Aug 11 10:27:51 black kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Aug 11 10:27:51 black kernel: ata3.00: ATA-7: Maxtor 6Y200M0, YAR51HW0, max UDMA/133
Aug 11 10:27:51 black kernel: ata3.00: 398297088 sectors, multi 16: LBA48 
Aug 11 10:27:51 black kernel: ata3.00: configured for UDMA/133
Aug 11 10:27:51 black kernel: ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Aug 11 10:27:51 black kernel: ata4.00: ATA-7: Maxtor 6B300S0, BANC1980, max UDMA/133
Aug 11 10:27:51 black kernel: ata4.00: 586114704 sectors, multi 16: LBA48 NCQ (depth 31/32)
Aug 11 10:27:51 black kernel: ata4.00: configured for UDMA/133
Aug 11 10:27:51 black kernel: scsi 5:0:0:0: Direct-Access     ATA      Maxtor 6Y200M0   YAR5 PQ: 0 ANSI: 5
Aug 11 10:27:51 black kernel: ata3: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
Aug 11 10:27:51 black kernel: scsi 6:0:0:0: Direct-Access     ATA      Maxtor 6B300S0   BANC PQ: 0 ANSI: 5
Aug 11 10:27:51 black kernel: ata4: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
Aug 11 10:27:51 black kernel: sd 3:0:0:0: [sda] 625142448 512-byte hardware sectors (320073 MB)
Aug 11 10:27:51 black kernel: sd 3:0:0:0: [sda] Write Protect is off
Aug 11 10:27:51 black kernel: sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 11 10:27:51 black kernel: sd 3:0:0:0: [sda] 625142448 512-byte hardware sectors (320073 MB)
Aug 11 10:27:51 black kernel: sd 3:0:0:0: [sda] Write Protect is off
Aug 11 10:27:51 black kernel: sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 11 10:27:51 black kernel:  sda: sda1
Aug 11 10:27:51 black kernel: sd 3:0:0:0: [sda] Attached SCSI disk
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] Write Protect is off
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] Write Protect is off
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Aug 11 10:27:51 black kernel:  sdb: sdb1 sdb2 < sdb5 sdb6 >
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] Attached SCSI disk
Aug 11 10:27:51 black kernel: sd 5:0:0:0: [sdc] 398297088 512-byte hardware sectors (203928 MB)
Aug 11 10:27:51 black kernel: sd 5:0:0:0: [sdc] Write Protect is off
Aug 11 10:27:51 black kernel: sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 11 10:27:51 black kernel: sd 5:0:0:0: [sdc] 398297088 512-byte hardware sectors (203928 MB)
Aug 11 10:27:51 black kernel: sd 5:0:0:0: [sdc] Write Protect is off
Aug 11 10:27:51 black kernel: sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 11 10:27:51 black kernel:  sdc: sdc1 sdc2 sdc3 < sdc5 sdc6 >
Aug 11 10:27:51 black kernel: sd 5:0:0:0: [sdc] Attached SCSI disk
Aug 11 10:27:51 black kernel: sd 6:0:0:0: [sdd] 586114704 512-byte hardware sectors (300091 MB)
Aug 11 10:27:51 black kernel: sd 6:0:0:0: [sdd] Write Protect is off
Aug 11 10:27:51 black kernel: sd 6:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 11 10:27:51 black kernel: sd 6:0:0:0: [sdd] 586114704 512-byte hardware sectors (300091 MB)
Aug 11 10:27:51 black kernel: sd 6:0:0:0: [sdd] Write Protect is off
Aug 11 10:27:51 black kernel: sd 6:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Aug 11 10:27:51 black kernel:  sdd: sdd1 sdd2
Aug 11 10:27:51 black kernel: sd 6:0:0:0: [sdd] Attached SCSI disk
Aug 11 10:27:51 black kernel: device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
Aug 11 10:27:51 black kernel: kjournald starting.  Commit interval 5 seconds
Aug 11 10:27:51 black kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 11 10:27:51 black kernel: scsi 1:0:0:0: Direct-Access     Seagate  External Drive        PQ: 0 ANSI: 0
Aug 11 10:27:51 black kernel: scsi 0:0:0:0: Direct-Access     USB 2.0  Storage Device   0100 PQ: 0 ANSI: 0 CCS
Aug 11 10:27:51 black kernel: sd 0:0:0:0: [sde] 320173056 512-byte hardware sectors (163929 MB)
Aug 11 10:27:51 black kernel: sd 0:0:0:0: [sde] Write Protect is off
Aug 11 10:27:51 black kernel: sd 0:0:0:0: [sde] 320173056 512-byte hardware sectors (163929 MB)
Aug 11 10:27:51 black kernel: scsi 2:0:0:0: Direct-Access     ST332082 0A               3.AA PQ: 0 ANSI: 0
Aug 11 10:27:51 black kernel: sd 0:0:0:0: [sde] Write Protect is off
Aug 11 10:27:51 black kernel:  sde: sde1
Aug 11 10:27:51 black kernel: sd 0:0:0:0: [sde] Attached SCSI disk
Aug 11 10:27:51 black kernel: sd 2:0:0:0: [sdf] 625142448 512-byte hardware sectors (320073 MB)
Aug 11 10:27:51 black kernel: sd 2:0:0:0: [sdf] Write Protect is off
Aug 11 10:27:51 black kernel: sd 2:0:0:0: [sdf] 625142448 512-byte hardware sectors (320073 MB)
Aug 11 10:27:51 black kernel: sd 2:0:0:0: [sdf] Write Protect is off
Aug 11 10:27:51 black kernel:  sdf:<6>i2c-adapter i2c-0: nForce2 SMBus adapter at 0x4c00
Aug 11 10:27:51 black kernel: i2c-adapter i2c-1: nForce2 SMBus adapter at 0x4c40
Aug 11 10:27:51 black kernel: input: PC Speaker as /class/input/input1
Aug 11 10:27:51 black kernel: Real Time Clock Driver v1.12ac
Aug 11 10:27:51 black kernel: ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 22
Aug 11 10:27:51 black kernel: ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCJ] -> GSI 22 (level, low) -> IRQ 17
Aug 11 10:27:51 black kernel: NET: Registered protocol family 23
Aug 11 10:27:51 black kernel: intel8x0_measure_ac97_clock: measured 54821 usecs
Aug 11 10:27:51 black kernel: intel8x0: clocking to 46989
Aug 11 10:27:51 black kernel: input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
Aug 11 10:27:51 black kernel: parport_pc 00:0a: reported by Plug and Play ACPI
Aug 11 10:27:51 black kernel: parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
Aug 11 10:27:51 black kernel:  sdf1
Aug 11 10:27:51 black kernel: sd 2:0:0:0: [sdf] Attached SCSI disk
Aug 11 10:27:51 black kernel: sd 1:0:0:0: [sdg] 312581808 512-byte hardware sectors (160042 MB)
Aug 11 10:27:51 black kernel: sd 1:0:0:0: [sdg] Write Protect is off
Aug 11 10:27:51 black kernel: sd 1:0:0:0: [sdg] 312581808 512-byte hardware sectors (160042 MB)
Aug 11 10:27:51 black kernel: sd 1:0:0:0: [sdg] Write Protect is off
Aug 11 10:27:51 black kernel:  sdg: sdg1 sdg2 sdg3
Aug 11 10:27:51 black kernel: sd 1:0:0:0: [sdg] Attached SCSI disk
Aug 11 10:27:51 black kernel: Adding 3036244k swap on /dev/sdb5.  Priority:-1 extents:1 across:3036244k
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x440
Aug 11 10:27:51 black kernel:          res 51/04:00:00:00:00/04:00:00:00:00/40 Emask 0x1 (device error)
Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
Aug 11 10:27:51 black kernel: ata2: EH complete
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] Write Protect is off
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Aug 11 10:27:51 black kernel: EXT3 FS on dm-0, internal journal
Aug 11 10:27:51 black kernel: kjournald starting.  Commit interval 5 seconds
Aug 11 10:27:51 black kernel: EXT3 FS on sdb1, internal journal
Aug 11 10:27:51 black kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 11 10:27:51 black kernel: kjournald starting.  Commit interval 5 seconds
Aug 11 10:27:51 black kernel: EXT3 FS on dm-4, internal journal
Aug 11 10:27:51 black kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 11 10:27:51 black kernel: kjournald starting.  Commit interval 5 seconds
Aug 11 10:27:51 black kernel: EXT3 FS on dm-3, internal journal
Aug 11 10:27:51 black kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 11 10:27:51 black kernel: kjournald starting.  Commit interval 5 seconds
Aug 11 10:27:51 black kernel: EXT3 FS on dm-1, internal journal
Aug 11 10:27:51 black kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 11 10:27:51 black kernel: kjournald starting.  Commit interval 5 seconds
Aug 11 10:27:51 black kernel: EXT3 FS on dm-2, internal journal
Aug 11 10:27:51 black kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 11 10:27:51 black kernel: kjournald starting.  Commit interval 5 seconds
Aug 11 10:27:51 black kernel: EXT3 FS on sdd1, internal journal
Aug 11 10:27:51 black kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 11 10:27:51 black kernel: kjournald starting.  Commit interval 5 seconds
Aug 11 10:27:51 black kernel: EXT3 FS on sda1, internal journal
Aug 11 10:27:51 black kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 11 10:27:51 black kernel: kjournald starting.  Commit interval 5 seconds
Aug 11 10:27:51 black kernel: EXT3 FS on sdd2, internal journal
Aug 11 10:27:51 black kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x440
Aug 11 10:27:51 black kernel:          res 51/04:00:00:00:00/04:00:00:00:00/40 Emask 0x1 (device error)
Aug 11 10:27:51 black last message repeated 2 times
Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
Aug 11 10:27:51 black kernel: ata2: EH complete
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY clear and IDLE, stat=0x440
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] Write Protect is off
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x400
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY, stat=0x400
Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/04:00:00:00:00/40 Emask 0x4 (timeout)
Aug 11 10:27:51 black last message repeated 2 times
Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Aug 11 10:27:51 black kernel: ata2: soft resetting port
Aug 11 10:27:51 black kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
Aug 11 10:27:51 black kernel: ata2: EH complete
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY clear and IDLE, stat=0x400
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] Write Protect is off
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x400
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY, stat=0x400
Aug 11 10:27:51 black kernel: ata2.00: NCQ disabled due to excessive errors
Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/04:00:00:00:00/40 Emask 0x4 (timeout)
Aug 11 10:27:51 black last message repeated 2 times
Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Aug 11 10:27:51 black kernel: ata2: soft resetting port
Aug 11 10:27:51 black kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
Aug 11 10:27:51 black kernel: ata2: EH complete
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY clear and IDLE, stat=0x400
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA IDLE, stat=0x400
Aug 11 10:27:51 black kernel: ata2: timeout waiting for ADMA LEGACY, stat=0x400
Aug 11 10:27:51 black kernel:          res 40/00:00:00:00:00/04:00:00:00:00/40 Emask 0x4 (timeout)
Aug 11 10:27:51 black kernel: ata2: soft resetting port
Aug 11 10:27:51 black kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Aug 11 10:27:51 black kernel: ata2.00: configured for UDMA/133
Aug 11 10:27:51 black kernel: ata2: EH complete
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] Write Protect is off
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] Write Protect is off
Aug 11 10:27:51 black kernel: sd 4:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Aug 11 10:27:51 black kernel: input: Power Button (FF) as /class/input/input3
Aug 11 10:27:51 black kernel: ACPI: Power Button (FF) [PWRF]
Aug 11 10:27:51 black kernel: input: Power Button (CM) as /class/input/input4
Aug 11 10:27:51 black kernel: ACPI: Power Button (CM) [PWRB]
Aug 11 10:27:53 black kernel: NET: Registered protocol family 10
Aug 11 10:27:53 black kernel: lo: Disabled Privacy Extensions
Aug 11 10:28:35 black kernel: Linux agpgart interface v0.102 (c) Dave Jones
