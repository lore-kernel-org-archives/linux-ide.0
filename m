From: Niccolo Rigacci <niccolo@rigacci.org>
Subject: Sometimes ata_piix fails to detect second SATA disk
Date: Sun, 18 Jun 2006 16:06:50 +0200
Message-ID: <20060618140650.GA17986@rigacci.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host50-109-static.38-88-b.business.telecomitalia.it ([88.38.109.50]:65152
	"EHLO paros.rigacci.org") by vger.kernel.org with ESMTP
	id S932236AbWFROGz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Jun 2006 10:06:55 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>

I'm trying to debug a strange problem on an IBM xSeries 206m 
where I installed a Debian Testing with a self-compiled Linux 
kernel 2.6.15.

I have two SATA disks (Hitachi Deskstart HDS728080PLA380) 80 Gb, 
atatched to the ICH7 controller:

0000:00:1f.1 IDE interface: Intel Corporation 82801G
             (ICH7 Family) IDE Controller (rev 01)
0000:00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH
             (ICH7 Family) Serial ATA Storage Controllers
             cc=IDE (rev 01)

Sometimes the kernel at boot time does not detect the second hard 
disk, as in this case:

libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x30C8 ctl 0x30BE bmdma 0x3090 irq 225
ata2: SATA max UDMA/133 cmd 0x30C0 ctl 0x30BA bmdma 0x3098 irq 225
ata1: dev 0 cfg 49:2f00 82:346b 83:7fe9 84:4773 85:3469
      86:3c01 87:4763 88:207f
ata1: dev 0 ATA-7, max UDMA/133, 156312576 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: SATA port has no device.
scsi1 : ata_piix
  Vendor: ATA      Model: HDS728080PLA380  Rev: PF2O
  Type:   Direct-Access                    ANSI SCSI revision: 05
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda


Strange enough, the bug seems to appear only if ata_piix is 
compiled staically into the kernel. If I use a kernel with 
ata_piix compiled as a module, both disks are always detected 
(see below the log).

I tried to modify - into the ata_piix.c - the function 
piix_sata_phy_reset(): I repeated the piix_sata_probe() call up 
to 100 times if it fails, with an udelay(10) between.
No luck: the "SATA port has no device" message sometimes 
appears.

Any idea on how solve or debug this problem?

Thanks.

This is a log where both disks are detected:

ata_piix 0000:00:1f.2: version 1.05
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x30C8 ctl 0x30BE bmdma 0x3090 irq 50
ata2: SATA max UDMA/133 cmd 0x30C0 ctl 0x30BA bmdma 0x3098 irq 50
hda: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ata1: dev 0 cfg 49:2f00 82:346b 83:7fe9 84:4773 85:3469
      86:3c01 87:4763 88:207f
ata1: dev 0 ATA-7, max UDMA/133, 156312576 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:346b 83:7fe9 84:4773 85:3469
      86:3c01 87:4763 88:207f
ata2: dev 0 ATA-7, max UDMA/133, 156312576 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA      Model: HDS728080PLA380  Rev: PF2O
  Type:   Direct-Access                    ANSI SCSI revision: 05
  Vendor: ATA      Model: HDS728080PLA380  Rev: PF2O
  Type:   Direct-Access                    ANSI SCSI revision: 05
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156312576 512-byte hdwr sectors (80032 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 156312576 512-byte hdwr sectors (80032 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 156312576 512-byte hdwr sectors (80032 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 >
sd 1:0:0:0: Attached scsi disk sdb

-- 
Niccolo Rigacci
Firenze - Italy

Iraq, missione di pace: 38475 morti - www.iraqbodycount.net
