From: Mikael Pettersson <mikpe@it.uu.se>
Subject: 2.6.22-rc5 libata/ata_piix failure with older CDROM
Date: Sat, 23 Jun 2007 15:46:34 +0200 (MEST)
Message-ID: <200706231346.l5NDkYm5018432@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:49748 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753745AbXFWNqj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Jun 2007 09:46:39 -0400
Received: from harpo.it.uu.se (daemon@harpo.it.uu.se [130.238.12.34])
	by aun.it.uu.se (8.13.6/8.13.6) with ESMTP id l5NDkZwt017403
	for <linux-ide@vger.kernel.org>; Sat, 23 Jun 2007 15:46:35 +0200 (MEST)
Received: (from mikpe@localhost)
	by harpo.it.uu.se (8.13.8+Sun/8.13.7) id l5NDkYm5018432
	for linux-ide@vger.kernel.org; Sat, 23 Jun 2007 15:46:34 +0200 (MEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I tried (again) to convert an Intel i815EP-chipset
machine from IDE to libata, but libata still fails
to initialise the CDROM on the machine.

With 2.6.22-rc5, IDE says:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 5
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: IC35L080AVVA07-0, ATA DISK drive
hda: selected mode 0x45
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: CRD-8320B, ATAPI CD/DVD-ROM drive
hdd: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
hdc: selected mode 0x22
hdd: selected mode 0x42
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >

Switching to libata (ata_piix) results in:

ata_piix 0000:00:1f.1: version 2.11
PCI: Setting latency timer of device 0000:00:1f.1 to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001f000 irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001f008 irq 15
ata1.00: ata_hpa_resize 1: sectors = 160836480, hpa_sectors = 160836480
ata1.00: ATA-5: IC35L080AVVA07-0, VA4OA52A, max UDMA/100
ata1.00: 160836480 sectors, multi 16: LBA 
ata1.00: ata_hpa_resize 1: sectors = 160836480, hpa_sectors = 160836480
ata1.00: configured for UDMA/100
ata2.00: ATAPI: CRD-8320B, 1.12, max MWDMA2
ata2.01: ATAPI: Hewlett-Packard CD-Writer Plus 9100, 1.0c, max UDMA/33
ata2.00: configured for MWDMA2
ata2.01: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      IC35L080AVVA07-0 VA4O PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 160836480 512-byte hardware sectors (82348 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 160836480 512-byte hardware sectors (82348 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sd 0:0:0:0: [sda] Attached SCSI disk
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: device not ready (errno=-16), forcing hardreset
ata2: BUG: prereset() requested invalid reset type
ata2: soft resetting port
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x1)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: soft resetting port
ata2.00: configured for MWDMA2
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: device not ready (errno=-16), forcing hardreset
ata2: BUG: prereset() requested invalid reset type
ata2: soft resetting port
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x1)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: soft resetting port
ata2.00: configured for MWDMA2
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: device not ready (errno=-16), forcing hardreset
ata2: BUG: prereset() requested invalid reset type
ata2: soft resetting port
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x1)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: soft resetting port
ata2.00: configured for MWDMA2
ata2.01: configured for UDMA/33
ata2: EH complete
ata2.00: limiting speed to MWDMA1:PIO4
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: device not ready (errno=-16), forcing hardreset
ata2: BUG: prereset() requested invalid reset type
ata2: soft resetting port
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ATA: abnormal status 0x80 on port 0x00010177
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x1)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: soft resetting port
ata2.00: configured for MWDMA1
ata2.01: configured for UDMA/33
ata2: EH complete
...
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:1:0: Attached scsi CD-ROM sr0

/Mikael
