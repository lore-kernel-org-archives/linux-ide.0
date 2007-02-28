From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: pata_pcmcia takes long time to detect certain cf cards
Date: Wed, 28 Feb 2007 09:16:20 +0100
Message-ID: <20070228081620.GA24442@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:3026 "EHLO
	roarinelk.homelinux.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbXB1IXF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Feb 2007 03:23:05 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

pata_pcmcia takes a very long time to recognize a 1.0GB SanDisk CF card
(MIPS, Au1200, linux-2.6.21-rc1):

pccard: PCMCIA card inserted into slot 0
pcmcia: registering new device pcmcia0.0
ata1: PATA max PIO0 cmd 0xC0054000 ctl 0xC005400E bmdma 0x0 irq 5
scsi0 : pata_pcmcia
ata1.00: CFA, max PIO4, 2001888 sectors: LBA
ata1.00: ata1: dev 0 multi count 0
< time passes >
ata1.01: qc timeout (cmd 0xec)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: failed to recover some devices, retrying in 5 secs
< time passes >
ata1.01: qc timeout (cmd 0xec)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: failed to recover some devices, retrying in 5 secs
< time passes >
ata1.01: qc timeout (cmd 0xec)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1: failed to recover some devices, retrying in 5 secs
< time passes >
ata1.00: configured for PIO0
isa bounce pool size: 16 pages
scsi 0:0:0:0: Direct-Access     ATA      SanDisk SDCFB-10 Rev  PQ: 0 ANSI: 5
SCSI device sda: 2001888 512-byte hdwr sectors (1025 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through
SCSI device sda: 2001888 512-byte hdwr sectors (1025 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi removable disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0


Another, older SanDisk 32MB card is detected instantly:

pccard: PCMCIA card inserted into slot 0
pcmcia: registering new device pcmcia0.0
ata2: PATA max PIO0 cmd 0xC0054000 ctl 0xC005400E bmdma 0x0 irq 5
scsi1 : pata_pcmcia
ata2.00: CFA, max PIO4, 62720 sectors: LBA
ata2.00: ata2: dev 0 multi count 0
ata2.00: configured for PIO0
scsi 1:0:0:0: Direct-Access     ATA      SanDisk SDCFB-32 Vdg  PQ: 0 ANSI: 5
SCSI device sda: 62720 512-byte hdwr sectors (32 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through
SCSI device sda: 62720 512-byte hdwr sectors (32 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through
 sda: sda1 sda2
sd 1:0:0:0: Attached scsi removable disk sda
sd 1:0:0:0: Attached scsi generic sg0 type 0


Any help very appreciated!

Thanks,

-- 
 ml.
 
