From: "Spencer Tuttle" <rodeojones@fastmail.fm>
Subject: Marvell MV88SX6041 SATA Driver PIO4 Mode Not DMA
Date: Thu, 10 Nov 2005 11:48:38 -0700
Message-ID: <1131648518.26701.247242836@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:22224 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751203AbVKJSsk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Nov 2005 13:48:40 -0500
Received: from frontend1.internal (mysql-sessions.internal [10.202.2.149])
	by frontend1.messagingengine.com (Postfix) with ESMTP id 0E7FDCDB975
	for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 13:48:38 -0500 (EST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have just compiled the new 2.6.14 kernel from the gentoo-sources tree.

I can access the drives just fine, but it seems really slow.  Here is
the dmesg output when I load the kernel module

libata version 1.12 loaded.
sata_mv version 0.12
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 9 (level, low) -> IRQ 9
ata1: SATA max PIO4 cmd 0x0 ctl 0xF89A2120 bmdma 0x0 irq 9
ata2: SATA max PIO4 cmd 0x0 ctl 0xF89A4120 bmdma 0x0 irq 9
ata3: SATA max PIO4 cmd 0x0 ctl 0xF89A6120 bmdma 0x0 irq 9
ata4: SATA max PIO4 cmd 0x0 ctl 0xF89A8120 bmdma 0x0 irq 9
ata1: dev 0 cfg 49:2f00 82:7869 83:7d09 84:4003 85:7869 86:3c01 87:4003
88:203f
ata1: dev 0 ATA, max UDMA/100, 156301488 sectors: lba48
ata1: dev 0 configured for PIO4
scsi0 : sata_mv
ata2: dev 0 cfg 49:2f00 82:7869 83:7d09 84:4003 85:7869 86:3c01 87:4003
88:203f
ata2: dev 0 ATA, max UDMA/100, 156301488 sectors: lba48
ata2: dev 0 configured for PIO4
scsi1 : sata_mv
ata3: dev 0 cfg 49:2f00 82:7869 83:7d09 84:4003 85:7869 86:3c01 87:4003
88:203f
ata3: dev 0 ATA, max UDMA/100, 156301488 sectors: lba48
ata3: dev 0 configured for PIO4
scsi2 : sata_mv
ata4: dev 0 cfg 49:2f00 82:7869 83:7d09 84:4003 85:7869 86:3c01 87:4003
88:203f
ata4: dev 0 ATA, max UDMA/100, 156301488 sectors: lba48
ata4: dev 0 configured for PIO4
scsi3 : sata_mv
blk_queue_max_hw_segments: set to minimum 1
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
blk_queue_max_hw_segments: set to minimum 1
=============<repeated 31 more times>==================

  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
blk_queue_max_hw_segments: set to minimum 1
=============<repeated 31 more times>==================

  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
blk_queue_max_hw_segments: set to minimum 1
=============<repeated 31 more times>==================

  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1
Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
Attached scsi generic sg3 at scsi3, channel 0, id 0, lun 0,  type 0
blk_queue_max_hw_segments: set to minimum 1
=============<repeated 31 more times>==================


Anyone have any ideas for me?

-- 
http://www.fastmail.fm - Access your email from home and the web

