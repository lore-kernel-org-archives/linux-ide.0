From: Citroklar <citroklar@amule.org>
Subject: Bug or my setup?
Date: Thu, 28 Oct 2004 19:53:57 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1098986037.4933.6.camel@first>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [82.149.231.169] ([82.149.231.169]:42971 "EHLO
	nsi16.miniserver.de") by vger.kernel.org with ESMTP id S261740AbUJ1RyA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Oct 2004 13:54:00 -0400
Received: from [192.168.0.7] (pd9e60b64.dip.t-dialin.net [217.230.11.100])
	by nsi16.miniserver.de (nsi16.miniserver.de) with ESMTP id D695C8AC1F3
	for <linux-ide@vger.kernel.org>; Thu, 28 Oct 2004 19:46:40 +0200 (CEST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi there,

I posted that before, but I didn't get an answer, so I post again, this
time with a more recent kernel (2.6.10-rc1-bk6). I wonder if this is a
bug or just my setup.

I have a dvd writer (parallel ata) connected to a PATA/SATA converter
which in turn is connected to a Silicon Image 3114 PCI Card.

Now, funny thing is, the device gets detected somehow, but no /dev/sd*
is attached to it!

this is the dmesg output that troubles me:

ata1: SATA max UDMA/100 cmd 0xE881AC80 ctl 0xE881AC8A bmdma 0xE881AC00
irq 19
ata2: SATA max UDMA/100 cmd 0xE881ACC0 ctl 0xE881ACCA bmdma 0xE881AC08
irq 19
ata3: SATA max UDMA/100 cmd 0xE881AE80 ctl 0xE881AE8A bmdma 0xE881AE00
irq 19
ata4: SATA max UDMA/100 cmd 0xE881AEC0 ctl 0xE881AECA bmdma 0xE881AE08
irq 19
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003
88:207f
ata1: dev 0 ATA, max UDMA/133, 320173056 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003
88:207f
ata2: dev 0 ATA, max UDMA/133, 320173056 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata3: dev 0 cfg 49:0f00 82:421c 83:0000 84:0000 85:0000 86:0000 87:0000
88:0007
ata3: dev 0 ATAPI, max UDMA/33
ata3: dev 0 configured for UDMA/33
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
  Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 >
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0

And that's it. no attaching scsi cdrom drive at scsi2. :(

Is it a bug or is it a feature that will come later or is it just my
setup?

thanks,
Tobias Ottmar

