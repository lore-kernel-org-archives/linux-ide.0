From: Michael Tokarev <mjt@tls.msk.ru>
Subject: pata_via refuses to detect one drive
Date: Wed, 17 Oct 2007 18:41:13 +0400
Message-ID: <47161F09.3040003@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.94.6]:21130 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758059AbXJQOu2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Oct 2007 10:50:28 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I tried switching one machine here from old IDE
modules to a new pata subsystem today.  And it
failed, for the first time I ever tried this
procedure.  Pata_via refuses to recognize one
of the drives.

Here's the dmesg with via82cxxx (2.6.20):

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 02) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x3c00-0x3c07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x3c08-0x3c0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Hitachi HDS721680PLAT80, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Hitachi HDS721680PLAT80, ATA DISK drive
hdd: FX4830T, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
loading module ide-disk
hda: max request size: 512KiB
hda: 160836480 sectors (82348 MB) w/7384KiB Cache, CHS=16383/255/63<6>hda: hw_config=600b
, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
hdc: max request size: 512KiB
hdc: 160836480 sectors (82348 MB) w/7384KiB Cache, CHS=16383/255/63, UDMA(33)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 >

(yes, the second IDE cable isn't UDMA one).

And here's the same when booted with pata_via module.  2.6.20
and 2.6.23 behaves the same way:

Oct 17 18:30:59 linux kernel: scsi0 : pata_via
Oct 17 18:30:59 linux kernel: scsi1 : pata_via
Oct 17 18:30:59 linux kernel: ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x00013c00 irq 14
Oct 17 18:30:59 linux kernel: ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x00013c08 irq 15
Oct 17 18:30:59 linux kernel: ata1.00: ATA-7: Hitachi HDS721680PLAT80, P21OA60A, max UDMA/133
Oct 17 18:30:59 linux kernel: ata1.00: 160836480 sectors, multi 16: LBA48
Oct 17 18:30:59 linux kernel: ata1.00: configured for UDMA/100
Oct 17 18:30:59 linux kernel: ata2: port is slow to respond, please be patient (Status 0x80)
Oct 17 18:30:59 linux kernel: ata2: SRST failed (errno=-16)
Oct 17 18:30:59 linux kernel: ata2.01: ATAPI: FX4830T, R02E, max UDMA/33
Oct 17 18:30:59 linux kernel: ata2.01: configured for UDMA/33
Oct 17 18:30:59 linux kernel: scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDS72168 P21O PQ: 0 ANSI: 5
Oct 17 18:30:59 linux kernel: ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
Oct 17 18:30:59 linux kernel: ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 36 in
Oct 17 18:30:59 linux kernel:          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
Oct 17 18:30:59 linux kernel: ata2: soft resetting port
Oct 17 18:30:59 linux kernel: ata2.01: configured for UDMA/33
Oct 17 18:30:59 linux kernel: ata2: EH complete
Oct 17 18:30:59 linux kernel: ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
Oct 17 18:30:59 linux kernel: ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 36 in
Oct 17 18:30:59 linux kernel:          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
Oct 17 18:30:59 linux kernel: ata2: soft resetting port
Oct 17 18:30:59 linux kernel: ata2.01: configured for UDMA/33
Oct 17 18:30:59 linux kernel: ata2: EH complete
Oct 17 18:30:59 linux kernel: ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
Oct 17 18:30:59 linux kernel: ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 36 in
Oct 17 18:30:59 linux kernel:          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
Oct 17 18:30:59 linux kernel: ata2: soft resetting port
Oct 17 18:30:59 linux kernel: ata2.01: configured for UDMA/33
Oct 17 18:30:59 linux kernel: ata2: EH complete
Oct 17 18:30:59 linux kernel: ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
Oct 17 18:30:59 linux kernel: ata2.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x12 data 36 in
Oct 17 18:30:59 linux kernel:          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
Oct 17 18:30:59 linux kernel: ata2: soft resetting port
Oct 17 18:30:59 linux kernel: ata2.01: configured for UDMA/33
Oct 17 18:30:59 linux kernel: ata2: EH complete
Oct 17 18:30:59 linux kernel: loading module sd_mod
Oct 17 18:30:59 linux kernel: sd 0:0:0:0: [sda] 160836480 512-byte hardware sectors (82348 MB)
Oct 17 18:30:59 linux kernel: sd 0:0:0:0: [sda] Write Protect is off
Oct 17 18:30:59 linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 17 18:30:59 linux kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct 17 18:30:59 linux kernel: sd 0:0:0:0: [sda] 160836480 512-byte hardware sectors (82348 MB)
Oct 17 18:30:59 linux kernel: sd 0:0:0:0: [sda] Write Protect is off
Oct 17 18:30:59 linux kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 17 18:30:59 linux kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct 17 18:30:59 linux kernel:  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Oct 17 18:30:59 linux kernel: sd 0:0:0:0: [sda] Attached SCSI disk

That's it - no sdb (or should it be sdc?) detected, only sda.

Any ideas?

Thanks.

P.S.  By the way, there are two lists - linux-ide@ and linux-scsi@.
Which one should be used to discuss pata- (and sata-) related stuff
like this?

/mjt
