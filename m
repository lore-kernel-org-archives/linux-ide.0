From: Sven Riedel <sr@gimp.org>
Subject: SATA command timeouts
Date: Sat, 8 Jul 2006 15:00:37 +0200
Message-ID: <20060708130037.GA22725@localnet>
Reply-To: sr@gimp.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kamp-dsl.de ([195.62.99.42]:51593 "HELO
	mailout.kamp-dsl.de") by vger.kernel.org with SMTP id S964810AbWGHNAl
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 09:00:41 -0400
Received: from dsl-mail.kamp.net (mail.kamp-dsl.de [195.62.99.42])
	by sponts.dsl-backup.kamp.de (SPONTS v6.3.6) with SMTP
	id 110C4E39B530-0
	for <linux-ide@vger.kernel.org>; Sat, 8 Jul 2006 13:00:40 +0000
Received: from mx01.kamp-dsl.de (mail.kamp-dsl.de [195.62.99.42])
	by sponts.dsl-backup.kamp.de (SPONTS v6.3.6) with ESMTP
	id 110C4E39B4D7-0
	for <linux-ide@vger.kernel.org>; Sat, 8 Jul 2006 13:00:40 +0000
Received: from mail.localnet (turing.localnet [192.168.13.1])
	by mx (Postfix) with ESMTP id 9CE4A1F85A
	for <linux-ide@vger.kernel.org>; Sat,  8 Jul 2006 13:00:38 +0000 (UTC)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
I hooked up new SATA disks to a machine yesterday and set up a software raid.
After copying roughly 25 GB of data onto the array all attached drives
reported command timeouts and wouldn't recover. Only a reboot would help. 
I tried the same again, this time the drives would timeout after 60 GB of data
written. I exchanged the CPU, but the same thing occurs. 

I'm currently in the process of testing the drives singly by writing 150GB of
data onto them and seeing if they will timeout singly (so far I had one
success and one complete system hang - even the CPU fan stopped spinning). My
next test will be doing write-heavy operations on all four drives
simulaneously, but without gathering them into a raid array.

Used hardware:
- 4 WD 400GB SATA RE2 drives
- Promise SATA300 TX4 controller

All of this was first running kernel 2.6.16.14, then after upgrading to 
2.6.17.4.

dmesg output is attached.

Is there anything else I can test to debug this problem?

Regs,
Sven


-- 
Sven Riedel                      sr@gimp.org

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg_timeout

Jul  7 22:26:05 planck kernel: ata1: status=0x50 { DriveReady SeekComplete }
Jul  7 22:26:05 planck kernel: sda: Current: sense key=0x0
Jul  7 22:26:05 planck kernel:     ASC=0x0 ASCQ=0x0
Jul  7 22:26:05 planck kernel: ata3: status=0x50 { DriveReady SeekComplete }
Jul  7 22:26:05 planck kernel: sdc: Current: sense key=0x0
Jul  7 22:26:05 planck kernel:     ASC=0x0 ASCQ=0x0
Jul  7 22:26:05 planck kernel: ata2: status=0x50 { DriveReady SeekComplete }
Jul  7 22:26:05 planck kernel: sdb: Current: sense key=0x0
Jul  7 22:26:05 planck kernel:     ASC=0x0 ASCQ=0x0
Jul  7 22:26:35 planck kernel: ata1: status=0x50 { DriveReady SeekComplete }
Jul  7 22:26:35 planck kernel: sda: Current: sense key=0x0
Jul  7 22:26:35 planck kernel:     ASC=0x0 ASCQ=0x0
Jul  7 22:26:35 planck kernel: ata4: status=0x50 { DriveReady SeekComplete }
Jul  7 22:26:35 planck kernel: sdd: Current: sense key=0x0
Jul  7 22:26:35 planck kernel:     ASC=0x0 ASCQ=0x0 
Jul  7 22:26:35 planck kernel: ata3: status=0x50 { DriveReady SeekComplete }
Jul  7 22:26:35 planck kernel: sdc: Current: sense key=0x0
Jul  7 22:26:35 planck kernel:     ASC=0x0 ASCQ=0x0


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg_boot

Jul  7 20:40:39 planck kernel: SCSI subsystem initialized
Jul  7 20:40:40 planck kernel: ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (le
vel, low) -> IRQ 201
Jul  7 20:40:40 planck kernel: ata1: SATA max UDMA/133 cmd 0xF8A80200 ctl 0xF8A8
0238 bmdma 0x0 irq 201
Jul  7 20:40:40 planck kernel: ata2: SATA max UDMA/133 cmd 0xF8A80280 ctl 0xF8A8
02B8 bmdma 0x0 irq 201
Jul  7 20:40:40 planck kernel: ata3: SATA max UDMA/133 cmd 0xF8A80300 ctl 0xF8A8
0338 bmdma 0x0 irq 201
Jul  7 20:40:40 planck kernel: ata4: SATA max UDMA/133 cmd 0xF8A80380 ctl 0xF8A8
03B8 bmdma 0x0 irq 201
Jul  7 20:40:40 planck kernel: ata1: SATA link up 1.5 Gbps (SStatus 113)
Jul  7 20:40:40 planck kernel: ata1: dev 0 ATA-7, max UDMA/133, 781422768 sector
s: LBA48
Jul  7 20:40:40 planck kernel: ata1: dev 0 configured for UDMA/133
Jul  7 20:40:40 planck kernel: scsi0 : sata_promise
Jul  7 20:40:40 planck kernel: ata2: SATA link up 1.5 Gbps (SStatus 113)
Jul  7 20:40:40 planck kernel: ata2: dev 0 ATA-7, max UDMA/133, 781422768 sector
s: LBA48
Jul  7 20:40:40 planck kernel: ata2: dev 0 configured for UDMA/133
Jul  7 20:40:40 planck kernel: scsi1 : sata_promise
Jul  7 20:40:41 planck kernel: ata3: SATA link up 1.5 Gbps (SStatus 113)
Jul  7 20:40:41 planck kernel: ata3: dev 0 ATA-7, max UDMA/133, 781422768 sector
s: LBA48
Jul  7 20:40:41 planck kernel: ata3: dev 0 configured for UDMA/133
Jul  7 20:40:41 planck kernel: scsi2 : sata_promise
Jul  7 20:40:41 planck kernel: ata4: SATA link up 1.5 Gbps (SStatus 113)
Jul  7 20:40:41 planck kernel: ata4: dev 0 ATA-7, max UDMA/133, 781422768 sector
s: LBA48
Jul  7 20:40:41 planck kernel: ata4: dev 0 configured for UDMA/133
Jul  7 20:40:41 planck kernel: scsi3 : sata_promise
Jul  7 20:40:41 planck kernel:   Vendor: ATA       Model: WDC WD4000YR-01P  Rev:
 01.0
Jul  7 20:40:41 planck kernel:   Type:   Direct-Access                      ANSI
 SCSI revision: 05
Jul  7 20:40:41 planck kernel:   Vendor: ATA       Model: WDC WD4000YR-01P  Rev:
 01.0
Jul  7 20:40:41 planck kernel:   Type:   Direct-Access                      ANSI
 SCSI revision: 05
Jul  7 20:40:41 planck kernel:   Vendor: ATA       Model: WDC WD4000YR-01P  Rev:
 01.0
Jul  7 20:40:41 planck kernel:   Type:   Direct-Access                      ANSI
 SCSI revision: 05
Jul  7 20:40:41 planck kernel:   Vendor: ATA       Model: WDC WD4000YR-01P  Rev:
 01.0
Jul  7 20:40:41 planck kernel:   Type:   Direct-Access                      ANSI
 SCSI revision: 05
Jul  7 20:40:42 planck kernel: SCSI device sda: 781422768 512-byte hdwr sectors 
(400088 MB)
Jul  7 20:40:42 planck kernel: sda: Write Protect is off
Jul  7 20:40:42 planck kernel: SCSI device sda: drive cache: write back
Jul  7 20:40:42 planck kernel: SCSI device sda: 781422768 512-byte hdwr sectors 
(400088 MB)
Jul  7 20:40:42 planck kernel: sda: Write Protect is off
Jul  7 20:40:42 planck kernel: SCSI device sda: drive cache: write back
Jul  7 20:40:42 planck kernel:  sda: unknown partition table
Jul  7 20:40:42 planck kernel: sd 0:0:0:0: Attached scsi disk sda
Jul  7 20:40:42 planck kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Jul  7 20:40:42 planck kernel: sdb: Write Protect is off
Jul  7 20:40:42 planck kernel: SCSI device sdb: drive cache: write back
Jul  7 20:40:42 planck kernel: SCSI device sdb: 781422768 512-byte hdwr sectors 
(400088 MB)
Jul  7 20:40:42 planck kernel: sdb: Write Protect is off
Jul  7 20:40:42 planck kernel: SCSI device sdb: drive cache: write back
Jul  7 20:40:42 planck kernel:  sdb: unknown partition table
Jul  7 20:40:42 planck kernel: sd 1:0:0:0: Attached scsi disk sdb
Jul  7 20:40:42 planck kernel: SCSI device sdc: 781422768 512-byte hdwr sectors 
(400088 MB)
Jul  7 20:40:42 planck kernel: sdc: Write Protect is off
Jul  7 20:40:42 planck kernel: SCSI device sdc: drive cache: write back
Jul  7 20:40:42 planck kernel: SCSI device sdc: 781422768 512-byte hdwr sectors 
(400088 MB)
Jul  7 20:40:42 planck kernel: sdc: Write Protect is off
Jul  7 20:40:42 planck kernel: SCSI device sdc: drive cache: write back
Jul  7 20:40:42 planck kernel:  sdc: unknown partition table
Jul  7 20:40:42 planck kernel: sd 2:0:0:0: Attached scsi disk sdc
Jul  7 20:40:42 planck kernel: SCSI device sdd: 781422768 512-byte hdwr sectors 
(400088 MB)


--xHFwDpU9dbj6ez1V--
