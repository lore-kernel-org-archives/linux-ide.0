From: Tobias Ottmar <tottmar@gmx.de>
Subject: ATAPI drive and libata / 3114 problems
Date: Tue, 26 Oct 2004 03:28:08 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1098754088.5645.13.camel@first>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.de ([213.165.64.20]:22673 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262046AbUJZB2H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Oct 2004 21:28:07 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi there,
I have a problem and hope that you might have a clue what I could try to
get my setup work. It's like that:

I have a regular PATA LG DVD ROM drive. I want this drive to be
connected to my Silicon Image 3114 PCI Controller and have therefore
bought a SATA/IDE Adapter which I mounted to the CDROM drive.

The 3114 works okay for my two "real"-SATA Maxtor harddisks, but for the
DVD drive it won't work. What troubles me is that the driver finds the
drive but does not attach a device to to it (at least it seems to me to
be like this).

This is the output of dmesg:

SCSI subsystem initialized
libata version 1.02 loaded.
sata_sil version 0.54
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 19 (level, low) -> IRQ 19
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


And that's it - shouldn't it be assigning /dev/sdc to my DVD drive?

I am running Fedora Core 2 with a self-compiled 2.6.9 kernel, I have
also tried applying the two patches for libata from
/pub/linux/kernel/people/jgarzik/patchkits/2.6/ but the problem is still
there.

I hope I did make myself clear, please ask again if I didn't!

Many thanks in advance

Tobias Ottmar



