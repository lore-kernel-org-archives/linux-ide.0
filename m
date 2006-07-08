From: David Lloyd <dmlloyd@flurg.com>
Subject: Alan's PATA patch vs. Gentoo-ized sata_promise
Date: Sat, 8 Jul 2006 12:31:00 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0607081230350.9190@ultros>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound2.mail.tds.net ([216.170.230.92]:63187 "EHLO
	outbound2.mail.tds.net") by vger.kernel.org with ESMTP
	id S964889AbWGHRbD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 13:31:03 -0400
Received: from outaamta01.mail.tds.net (outaamta01.mail.tds.net [216.170.230.31])
	by outbound2.mail.tds.net (8.13.6/8.13.4) with ESMTP id k68HV2UL029253
	for <linux-ide@vger.kernel.org>; Sat, 8 Jul 2006 12:31:02 -0500
Received: from localhost ([216.165.189.42]) by outaamta01.mail.tds.net
          with ESMTP
          id <20060708173102.CUOS16096.outaamta01.mail.tds.net@localhost>
          for <linux-ide@vger.kernel.org>; Sat, 8 Jul 2006 12:31:02 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a gentoo 2.6.16 kernel (which includes the changes to support 
pata+sata in promise_sata), and I applied alan's pata patch over it.

Initial results are great, except for one problem: the sata_promise 
controller acts as if it is no longer DMA-capable, reporting the following 
on detection:

sata_promise PATA port found
ata1: SATA max PIO4 cmd 0xF8804200 ctl 0xF8804238 bmdma 0x0 irq 16
ata2: SATA max PIO4 cmd 0xF8804280 ctl 0xF88042B8 bmdma 0x0 irq 16
ata3: PATA max PIO4 cmd 0xF8804300 ctl 0xF8804338 bmdma 0x0 irq 16
ata1: SATA link down (SStatus 0)
scsi0 : sata_promise
input: AT Translated Set 2 keyboard as /class/input/input0
ata2: SATA link down (SStatus 0)
scsi1 : sata_promise
ata3: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 88:203f
ata3: dev 0 ATA-6, max UDMA/100, 312581808 sectors: LBA48
ata3: dev 0 configured for PIO4
scsi2 : sata_promise
    Vendor: ATA       Model: WDC WD1600BB-00H  Rev: 15.0
    Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
   sda: sda1 sda2
sd 2:0:0:0: Attached scsi disk sda

The ata_piix driver did not have this problem:

ata4: PATA max UDMA/133 cmd 0xEFE0 ctl 0xEFAE bmdma 0xEF90 irq 20
ata5: PATA max UDMA/133 cmd 0xEFA0 ctl 0xEFAA bmdma 0xEF98 irq 20
ata4: dev 0 cfg 49:0f00 82:3469 83:4001 84:4000 85:3469 86:0001 87:4000 88:101f
ata4: dev 0 ATA-4, max UDMA/66, 12594960 sectors: LBA
ata4: dev 0 configured for UDMA/66
scsi3 : ata_piix
ata5: dev 0 cfg 49:0b00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0407
ata5: dev 0 ATAPI, max UDMA/33
ata5: dev 0 configured for UDMA/33
scsi4 : ata_piix
    Vendor: ATA       Model: QUANTUM FIREBALL  Rev: A5U.
    Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 12594960 512-byte hdwr sectors (6449 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 12594960 512-byte hdwr sectors (6449 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
   sdb: sdb1
sd 3:0:0:0: Attached scsi disk sdb
    Vendor: SONY      Model: CD-RW  CRX220E1   Rev: 6YS1
    Type:   CD-ROM                             ANSI SCSI revision: 05

My question is, what can cause the driver to suddenly think that it is not 
DMA-capable?  I didn't see any sata_promise changes in the patch so I 
assume that it's something in libata-core, but there's enough in there 
that I don't fully understand that I'm hoping that one of you guys will 
have a simple answer, or at least point me at a chunk of code to hack up.

Thanks!

- DML
