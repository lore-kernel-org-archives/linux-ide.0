From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [BUG 2.6.21-rc3] libata PATA CDROM detection problems
Date: Sat, 10 Mar 2007 16:21:10 +0100 (MET)
Message-ID: <200703101521.l2AFLAXI011952@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:32851 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933464AbXCJPVS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Mar 2007 10:21:18 -0500
Received: from harpo.it.uu.se (daemon@harpo.it.uu.se [130.238.12.34])
	by aun.it.uu.se (8.13.6/8.13.6) with ESMTP id l2AFLDGN000584
	for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 16:21:13 +0100 (MET)
Received: (from mikpe@localhost)
	by harpo.it.uu.se (8.13.8+Sun/8.13.7) id l2AFLAXI011952
	for linux-ide@vger.kernel.org; Sat, 10 Mar 2007 16:21:10 +0100 (MET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I tried to convert a machine with an Intel 815EP chipset
from IDE to libata. There's a single master disk on the
first channel, and a single master CDROM on the second.

With kernel 2.6.21-rc3 and the IDE PIIX driver things work fine:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 5
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC35L080AVVA07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: CRD-8320B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
...
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20

But with 2.6.21-rc3 and ata_piix only the disk is detected,
and there is a lot of EH activity on the second channel:

libata version 2.20 loaded.
...
ata_piix 0000:00:1f.1: version 2.10
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001f000 irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001f008 irq 15
scsi0 : ata_piix
ata1.00: ATA-5: IC35L080AVVA07-0, VA4OA52A, max UDMA/100
ata1.00: 160836480 sectors, multi 16: LBA 
ata1.00: configured for UDMA/100
scsi1 : ata_piix
ATA: abnormal status 0x7F on port 0x00010177
ATA: abnormal status 0x7F on port 0x00010177
ata2.00: ATAPI, max MWDMA2
ata2.00: configured for MWDMA2
scsi 0:0:0:0: Direct-Access     ATA      IC35L080AVVA07-0 VA4O PQ: 0 ANSI: 5
SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sd 0:0:0:0: Attached scsi disk sda
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: soft resetting port
ATA: abnormal status 0x7F on port 0x00010177
ATA: abnormal status 0x7F on port 0x00010177
ata2.00: configured for MWDMA2
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: soft resetting port
ATA: abnormal status 0x7F on port 0x00010177
ATA: abnormal status 0x7F on port 0x00010177
ata2.00: configured for MWDMA2
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: soft resetting port
ATA: abnormal status 0x7F on port 0x00010177
ATA: abnormal status 0x7F on port 0x00010177
ata2.00: configured for MWDMA2
ata2: EH complete
ata2.00: limiting speed to MWDMA1:PIO4
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: soft resetting port
ATA: abnormal status 0x7F on port 0x00010177
ATA: abnormal status 0x7F on port 0x00010177
ata2.00: configured for MWDMA1
ata2: EH complete

At this point libata gave up on the second channel.

With the CDROM connected to the PATA port on a Promise TX2plus,
things go a little better:

sata_promise 0000:02:02.0: version 2.00
sata_promise PATA port found
ata3: SATA max UDMA/133 cmd 0xe081e200 ctl 0xe081e238 bmdma 0x00000000 irq 22
ata4: SATA max UDMA/133 cmd 0xe081e280 ctl 0xe081e2b8 bmdma 0x00000000 irq 22
ata5: PATA max UDMA/133 cmd 0xe081e300 ctl 0xe081e338 bmdma 0x00000000 irq 22
scsi2 : sata_promise
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : sata_promise
ata4: SATA link down (SStatus 0 SControl 300)
scsi4 : sata_promise
ATA: abnormal status 0x58 on port 0xe081e31c
ATA: abnormal status 0x58 on port 0xe081e31c
ATA: abnormal status 0x58 on port 0xe081e31c
ATA: abnormal status 0x58 on port 0xe081e31c
ATA: abnormal status 0x58 on port 0xe081e31c
ata5.00: failed to IDENTIFY (I/O error, err_mask=0x101)
ata5.00: ATAPI, max MWDMA2
ata5.00: Drive reports diagnostics failure. This may indicate a drive
ata5.00: fault or invalid emulation. Contact drive vendor for information.
ata5.00: configured for MWDMA2
scsi 4:0:0:0: CD-ROM            GoldStar CD-ROM CRD-8320B 1.12 PQ: 0 ANSI: 5

but shortly thereafter EH triggers:

pdc_error_intr: port_status 0x20200000 serror 0x00000000
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (port_status 0x20200000)
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res ff/ff:ff:ff:ff:ff/00:00:00:00:00/ff Emask 0x3 (HSM violation)
ata5: soft resetting port
ata5.00: qc timeout (cmd 0xa1)
ata5.00: failed to IDENTIFY (I/O error, err_mask=0x104)
ata5.00: revalidation failed (errno=-5)
ata5: failed to recover some devices, retrying in 5 secs
ata5: soft resetting port
ata5.00: configured for MWDMA2
ata5: EH complete
pdc_error_intr: port_status 0x20200000 serror 0x00000000
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (port_status 0x20200000)
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res ff/ff:ff:ff:ff:ff/00:00:00:00:00/ff Emask 0x3 (HSM violation)
ata5: soft resetting port
ata5.00: qc timeout (cmd 0xa1)
ata5.00: failed to IDENTIFY (I/O error, err_mask=0x104)
ata5.00: revalidation failed (errno=-5)
ata5: failed to recover some devices, retrying in 5 secs
ata5: soft resetting port
ata5.00: configured for MWDMA2
ata5: EH complete
pdc_error_intr: port_status 0x20200000 serror 0x00000000
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (port_status 0x20200000)
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res ff/ff:ff:ff:ff:ff/00:00:00:00:00/ff Emask 0x3 (HSM violation)
ata5: soft resetting port
ata5.00: qc timeout (cmd 0xa1)
ata5.00: failed to IDENTIFY (I/O error, err_mask=0x104)
ata5.00: revalidation failed (errno=-5)
ata5: failed to recover some devices, retrying in 5 secs
ata5: soft resetting port
ata5.00: configured for MWDMA2
ata5: EH complete
pdc_error_intr: port_status 0x20200000 serror 0x00000000
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (port_status 0x20200000)
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res ff/ff:ff:ff:ff:ff/00:00:00:00:00/ff Emask 0x3 (HSM violation)
ata5: soft resetting port
ata5.00: qc timeout (cmd 0xa1)
ata5.00: failed to IDENTIFY (I/O error, err_mask=0x104)
ata5.00: revalidation failed (errno=-5)
ata5: failed to recover some devices, retrying in 5 secs
ata5: soft resetting port
ata5.00: configured for MWDMA2
ata5: EH complete
pdc_error_intr: port_status 0x20200000 serror 0x00000000
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (port_status 0x20200000)
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res ff/ff:ff:ff:ff:ff/00:00:00:00:00/ff Emask 0x3 (HSM violation)
ata5: soft resetting port
ata5.00: qc timeout (cmd 0xa1)
ata5.00: failed to IDENTIFY (I/O error, err_mask=0x104)
ata5.00: revalidation failed (errno=-5)
ata5: failed to recover some devices, retrying in 5 secs
ata5: soft resetting port
ata5.00: configured for MWDMA2
ata5: EH complete
pdc_error_intr: port_status 0x20200000 serror 0x00000000
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (port_status 0x20200000)
ata5.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 
         res ff/ff:ff:ff:ff:ff/00:00:00:00:00/ff Emask 0x3 (HSM violation)
ata5: soft resetting port

/Mikael
