From: Yuri Kirsanov <flash@rccb.ru>
Subject: TX4000 RAID and sata_promise
Date: Sun, 28 Aug 2005 21:08:20 +0400
Message-ID: <15736083109.20050828210820@rccb.ru>
Reply-To: Yuri Kirsanov <flash@rccb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.85.106.102] ([213.85.106.102]:23495 "EHLO rccb.ru")
	by vger.kernel.org with ESMTP id S1750797AbVH1RIT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Aug 2005 13:08:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

Yes, with another hard drive, which is error-free everything works
just fine, with one exception:

libata version 1.11 loaded.
sata_promise version 1.01
PCI: Found IRQ 5 for device 0000:01:0a.0
ata1: SATA max UDMA/133 cmd 0xCC802200 ctl 0xCC802238 bmdma 0x0 irq 5
ata2: SATA max UDMA/133 cmd 0xCC802280 ctl 0xCC8022B8 bmdma 0x0 irq 5
ata3: PATA max UDMA/133 cmd 0xCC802300 ctl 0xCC802338 bmdma 0x0 irq 5
ata4: PATA max UDMA/133 cmd 0xCC802380 ctl 0xCC8023B8 bmdma 0x0 irq 5
ata1: dev 0 cfg 49:0f00 82:346b 83:5b01 84:4003 85:3469 86:1a01 87:4003 88:407f
ata1: dev 0 ATA-5, max UDMA/133, 40132503 sectors: LBA
ata1: dev 0 configured for UDMA/133
scsi0 : sata_promise
ATA: abnormal status 0x8 on port 0xCC80229C
ata2: disabling port
scsi1 : sata_promise
ATA: abnormal status 0x8 on port 0xCC80231C
ata3: disabling port
scsi2 : sata_promise
ATA: abnormal status 0x8 on port 0xCC80239C
ata4: disabling port
scsi3 : sata_promise
  Vendor: ATA       Model: MAXTOR 6L020J1    Rev: A93.
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 40132503 512-byte hdwr sectors (20548 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 40132503 512-byte hdwr sectors (20548 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: unknown partition table
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0

As you can see, only one hard drive is connected to my TX4000, and
because I disabled sata check I get abnormal status on another ports.
But my hard drive works just fine! I'm looking forward to attach
another hard drive and create RAID in TX4000 BIOS. I wonder, will
sata_promise detect two disks on two ports, or just one thru BIOS?

