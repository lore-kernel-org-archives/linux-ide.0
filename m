From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: problems with libata and ICH5 chipset.
Date: Sat, 19 Jun 2004 18:34:36 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40D4792C.5030702@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:24339 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S263475AbUFSRee (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Jun 2004 13:34:34 -0400
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-34.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1Bbjjd-0008Il-0Y
	for linux-ide@vger.kernel.org; Sat, 19 Jun 2004 18:34:33 +0100
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I am using kernel 2.6.7.
I enclose an extract from dmesg below.
I have 2 PATA devices, one DVD-ROM, one DVD-writer on ata1. (or hda and hdb)
I also have 2 SATA devices, both Hard Discs.
When I boot without libata enabled, and just use:-
ATA/ATAPI/MFM/RLL support ->  Intel PIIXn chipsets support
I get access to: -
hda - PATA DVD-Writer
hdb - PATA DVD-ROM
hdc - SATA HD
hdd - SATA HD.

If I then enable:
SCSI device support -> SCSI low-level drivers -> Serial ATA (SATA) 
support ->  Intel PIIX/ICH SATA support

No PATA devices are accessible. I get:
sda - SATA HD
sdb - SATA HD

Is there any way that I can fix this using kernel options.
It seems that below, the PATA devices are being recognised, but then are 
unable to be accessed.

Cheers
James


Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
libata version 1.02 loaded.
ata_piix version 1.02
ata_piix: combined mode detected
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata1: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 
88:0407
ata1: dev 0 ATAPI, max UDMA/33
ata1: dev 1 cfg 49:0b00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 
88:0407
ata1: dev 1 ATAPI, max UDMA/33
ata1: dev 0 configured for UDMA/33
ata1: dev 1 configured for UDMA/33
scsi0 : ata_piix
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 
88:207f
ata2: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata2: dev 1 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 
88:207f
ata2: dev 1 ATA, max UDMA/133, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/133
ata2: dev 1 configured for UDMA/133
scsi1 : ata_piix
   Vendor: ATA       Model: ST3160023AS       Rev: 3.18
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST3160023AS       Rev: 3.18
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
  /dev/scsi/host1/bus0/target0/lun0: p1 p2 < p5 >
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
  /dev/scsi/host1/bus0/target1/lun0: p1 p2 < p5 p6 >
Attached scsi disk sdb at scsi1, channel 0, id 1, lun 0
