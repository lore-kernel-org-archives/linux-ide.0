From: Kovid Goyal <kovid@theory.caltech.edu>
Subject: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Mon, 11 Dec 2006 10:03:39 -0800
Message-ID: <200612111003.39928.kovid@theory.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from theory.caltech.edu ([131.215.116.2]:41125 "EHLO
	theory.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937431AbWLKSDp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2006 13:03:45 -0500
Received: from [192.168.1.100] (DHCP-7-75.caltech.edu [131.215.7.75])
	by theory.caltech.edu (Postfix) with ESMTP id A102D1B87FD
	for <linux-ide@vger.kernel.org>; Mon, 11 Dec 2006 10:03:42 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I'm having problems booting from a SATA disk with 2.6.19.
Grub loads fine, but when the kernel boots, it *sometimes* ends up with
VFS: Cannot open root device "sda5" or unknown-block(0,0). 

This issue appears to be identical with the one reported in 
http://lkml.org/lkml/2006/10/19/327 except that 2.6.19 did not fix it for me. 
In fact, it made it worse. The timeouts reported in that thread are still 
present and with 2.6.19 the fraction of unsuccessful boots has increased from 
30% to 80%. I often have to reboot my machine 3 times in a row before it 
succeeds. I have tried both vanilla 2.6.19 and gentoo-sources-2.6.19-r1

To summarize: My machine stalls for nearly a minute on all boots and the root 
filesystem fails to mount on 80% of the boots. This problem first manifested 
itself when I switched to 2.6.18 and has become worse with 2.6.19. 

The controller:
00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA 
Controller (rev 03)

I don't know how to get the logs from an unsuccessful boot. Here is
an extract from the logs of a successful boot (in which the timeout is 
present):

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
hda: PHILIPS DVD+/-RW DVD8631, ATAPI CD/DVD-ROM drive
input: ImExPS/2 Logitech MX Mouse as /class/input/input2
Probing IDE interface ide1...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ata_piix 0000:00:1f.1: version 2.00ac6
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 16
ata: 0x1F0 IDE port busy
ata: conflict with ide0
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: DUMMY
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
scsi0 : ata_piix
scsi1 : ata_piix
ata2: port disabled. ignoring.
ATA: abnormal status 0xFF on port 0x177
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata3: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 17
ata4: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 17
scsi2 : ata_piix
ata3.00: ATA-6, max UDMA/133, 156250000 sectors: LBA48 
ata3.00: ata3: dev 0 multi count 8
ata3.01: ATA-6, max UDMA/133, 156301488 sectors: LBA48 
ata3.01: ata3: dev 1 multi count 8
ata3.00: configured for UDMA/133
ata3.01: configured for UDMA/133
scsi3 : ata_piix
ata4: port is slow to respond, please be patient (Status 0xff)
ata4: port failed to respond (30 secs, Status 0xff)
ata4: SRST failed (status 0xFF)
ata4: SRST failed (err_mask=0x100)
ata4: softreset failed, retrying in 5 secs
ata4: SRST failed (status 0xFF)
ata4: SRST failed (err_mask=0x100)
ata4: softreset failed, retrying in 5 secs
ata4: SRST failed (status 0xFF)
ata4: SRST failed (err_mask=0x100)
ata4: reset failed, giving up
scsi 2:0:0:0: Direct-Access     ATA      ST380013AS       8.05 PQ: 0 ANSI: 5
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sd 2:0:0:0: Attached scsi disk sda
scsi 2:0:1:0: Direct-Access     ATA      ST380013AS       3.18 PQ: 0 ANSI: 5
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3
sd 2:0:1:0: Attached scsi disk sdb

The relevant sections from my kernel configuration:
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SX4 is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set
CONFIG_SATA_INTEL_COMBINED=y

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_IDEPNP is not set
# CONFIG_BLK_DEV_IDEPCI is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_BLK_DEV_IDEDMA is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_CD_NO_IDESCSI is not set

Thanks,

Kovid.

-- 
_____________________________________

Kovid Goyal  MC 452-48
California Institute of Technology
1200 E California Blvd
Pasadena, CA 91125

home  : +01 626 390 8699
office: +01 626 395 6595 (449 Lauritsen)
email : kovid@theory.caltech.edu
web   : http://www.kovidgoyal.net
_____________________________________
