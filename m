From: Marc Bevand <mb@opensc.org>
Subject: [sata_sil24] disks not detected
Date: Sun, 13 Nov 2005 13:46:50 +0100
Message-ID: <20051113124650.GA21127@bam.epita.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from deliver.epitech.net ([163.5.255.125]:6918 "HELO
	deliver.epitech.net") by vger.kernel.org with SMTP id S932494AbVKMMrN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Nov 2005 07:47:13 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tejun,

Remember the patch you made to sata_sil24 to correctly detect disks
attached to the controller [1] ? At this time I was using only one
SiI3124 controller, and it worked well. But today I just tried to
use 2 controllers with 4 disks attached to each of them (8 total disks),
and 2 of the disks are not detected (see attached file "dmesg.new": ata6
and ata7 are not detected). I gave a try to the original v0.10 driver
and it detects all disks correctly (see "dmesg.orig").

Kernels used:
- dmesg.new: libata-dev, 'master' branch, current as of today
- dmesg.orig: libata-dev, 'sil24-original' branch, dating from the
  beginning of september

I wanted to try to examine the differences between the current sata_sil24
driver and the original one, but I cannot find a way to access the
sil24-original branch which has been deleted from the git repository...

[1] http://marc.theaimsgroup.com/?l=linux-ide&m=112643010008867&w=2

-- 
 Marc Bevand                              http://epita.fr/~bevand_m
 Computer Science School EPITA - System, Network and Security Dept.

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.new"

sata_sil24 0000:01:03.0: version 0.22
ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 28 (level, low) -> IRQ 193
ata5: SATA max UDMA/100 cmd 0xFFFFC20000490000 ctl 0x0 bmdma 0x0 irq 193
ata6: SATA max UDMA/100 cmd 0xFFFFC20000492000 ctl 0x0 bmdma 0x0 irq 193
ata7: SATA max UDMA/100 cmd 0xFFFFC20000494000 ctl 0x0 bmdma 0x0 irq 193
ata8: SATA max UDMA/100 cmd 0xFFFFC20000496000 ctl 0x0 bmdma 0x0 irq 193
ata5: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata5: dev 0 ATA-6, max UDMA/133, 312581808 sectors: LBA48
ata5: dev 0 configured for UDMA/100
scsi4 : sata_sil24
ata6: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
ata6: no dma
ata6: dev 0 not supported, ignoring
scsi5 : sata_sil24
ata7: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
ata7: no dma
ata7: dev 0 not supported, ignoring
scsi6 : sata_sil24
ata8: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata8: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata8: dev 0 configured for UDMA/100
scsi7 : sata_sil24
  Vendor: ATA       Model: ST3160023AS       Rev: 3.18
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
 sdb1: <bsd: sdb5 >
sd 4:0:0:0: Attached scsi disk sdb
sd 4:0:0:0: Attached scsi generic sg1 type 0
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc4
sd 7:0:0:0: Attached scsi disk sdc
sd 7:0:0:0: Attached scsi generic sg2 type 0
ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 29 (level, low) -> IRQ 201
ata9: SATA max UDMA/100 cmd 0xFFFFC200004A0000 ctl 0x0 bmdma 0x0 irq 201
ata10: SATA max UDMA/100 cmd 0xFFFFC200004A2000 ctl 0x0 bmdma 0x0 irq 201
ata11: SATA max UDMA/100 cmd 0xFFFFC200004A4000 ctl 0x0 bmdma 0x0 irq 201
ata12: SATA max UDMA/100 cmd 0xFFFFC200004A6000 ctl 0x0 bmdma 0x0 irq 201
ata9: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata9: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata9: dev 0 configured for UDMA/100
scsi8 : sata_sil24
ata10: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata10: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata10: dev 0 configured for UDMA/100
scsi9 : sata_sil24
ata11: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata11: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata11: dev 0 configured for UDMA/100
scsi10 : sata_sil24
ata12: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata12: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata12: dev 0 configured for UDMA/100
scsi11 : sata_sil24
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd4
sd 8:0:0:0: Attached scsi disk sdd
sd 8:0:0:0: Attached scsi generic sg3 type 0
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sde: drive cache: write back
SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sde: drive cache: write back
 sde: sde4
sd 9:0:0:0: Attached scsi disk sde
sd 9:0:0:0: Attached scsi generic sg4 type 0
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdf: drive cache: write back
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdf: drive cache: write back
 sdf: sdf4
sd 10:0:0:0: Attached scsi disk sdf
sd 10:0:0:0: Attached scsi generic sg5 type 0
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdg: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdg: drive cache: write back
SCSI device sdg: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdg: drive cache: write back
 sdg: sdg4
sd 11:0:0:0: Attached scsi disk sdg
sd 11:0:0:0: Attached scsi generic sg6 type 0

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.orig"

sata_sil24 version 0.10
ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 28 (level, low) -> IRQ 193
sata_sil24: mmio_base0=ffffc200000c8c00 base_len (hex)=80
sata_sil24: mmio_base=ffffc20000490000 base_len  (hex)=8000
sata_sil24: Found Port Ready
sata_sil24: Found Port Ready
sata_sil24: Found Port Ready
sata_sil24: Found Port Ready
sata_sil24: sil_port_start allocating Scatter Table, PRBs hex=840
sata_sil24: sil_port_start virtual=ffff8100339c9000 physical=339c9000
ata5: SATA max UDMA/100 cmd 0xFFFFC20000490000 ctl 0xFFFFC2000049000A bmdma 0xFFFFC20000490000 irq 193
sata_sil24: sil_port_start allocating Scatter Table, PRBs hex=840
sata_sil24: sil_port_start virtual=ffff8100339c7000 physical=339c7000
ata6: SATA max UDMA/100 cmd 0xFFFFC20000492000 ctl 0xFFFFC2000049200A bmdma 0xFFFFC20000490000 irq 193
sata_sil24: sil_port_start allocating Scatter Table, PRBs hex=840
sata_sil24: sil_port_start virtual=ffff8100339c5000 physical=339c5000
ata7: SATA max UDMA/100 cmd 0xFFFFC20000494000 ctl 0xFFFFC2000049400A bmdma 0xFFFFC20000490000 irq 193
sata_sil24: sil_port_start allocating Scatter Table, PRBs hex=840
sata_sil24: sil_port_start virtual=ffff8100339c3000 physical=339c3000
ata8: SATA max UDMA/100 cmd 0xFFFFC20000496000 ctl 0xFFFFC2000049600A bmdma 0xFFFFC20000490000 irq 193
sata_sil24: bus_probe ap=ffff810033825428 trying to identify dev=0
sata_sil24: sil_dev_identify speed=1
ata5: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata5: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
sata_sil24: bus_probe FOUND DEVICE
ata5: dev 0 configured for UDMA/100
scsi4 : sata_sil24
sata_sil24: bus_probe ap=ffff810033824428 trying to identify dev=0
sata_sil24: sil_dev_identify speed=1
ata6: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata6: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
sata_sil24: bus_probe FOUND DEVICE
ata6: dev 0 configured for UDMA/100
scsi5 : sata_sil24
sata_sil24: bus_probe ap=ffff810033827428 trying to identify dev=0
sata_sil24: sil_dev_identify speed=1
ata7: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata7: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
sata_sil24: bus_probe FOUND DEVICE
ata7: dev 0 configured for UDMA/100
scsi6 : sata_sil24
sata_sil24: bus_probe ap=ffff810033873428 trying to identify dev=0
sata_sil24: sil_dev_identify speed=1
ata8: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata8: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
sata_sil24: bus_probe FOUND DEVICE
ata8: dev 0 configured for UDMA/100
scsi7 : sata_sil24
  Vendor: ATA       Model: ST3160023AS       Rev: 3.18
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
 sdb1: <bsd: sdb5 >
Attached scsi disk sdb at scsi4, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi4, channel 0, id 0, lun 0,  type 0
  Vendor: ATA       Model: ST3160023AS       Rev: 3.18
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1
Attached scsi disk sdc at scsi5, channel 0, id 0, lun 0
Attached scsi generic sg2 at scsi5, channel 0, id 0, lun 0,  type 0
  Vendor: ATA       Model: ST3160023AS       Rev: 3.18
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1
Attached scsi disk sdd at scsi6, channel 0, id 0, lun 0
Attached scsi generic sg3 at scsi6, channel 0, id 0, lun 0,  type 0
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sde: drive cache: write back
SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sde: drive cache: write back
 sde: sde4
Attached scsi disk sde at scsi7, channel 0, id 0, lun 0
Attached scsi generic sg4 at scsi7, channel 0, id 0, lun 0,  type 0
sata_sil24: found 4 Ports
ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 29 (level, low) -> IRQ 201
sata_sil24: mmio_base0=ffffc200000e6800 base_len (hex)=80
sata_sil24: mmio_base=ffffc200004a0000 base_len  (hex)=8000
sata_sil24: Found Port Ready
sata_sil24: Found Port Ready
sata_sil24: Found Port Ready
sata_sil24: Found Port Ready
sata_sil24: sil_port_start allocating Scatter Table, PRBs hex=840
sata_sil24: sil_port_start virtual=ffff8100336de000 physical=336de000
ata9: SATA max UDMA/100 cmd 0xFFFFC200004A0000 ctl 0xFFFFC200004A000A bmdma 0xFFFFC200004A0000 irq 201
sata_sil24: sil_port_start allocating Scatter Table, PRBs hex=840
sata_sil24: sil_port_start virtual=ffff810033eb8000 physical=33eb8000
ata10: SATA max UDMA/100 cmd 0xFFFFC200004A2000 ctl 0xFFFFC200004A200A bmdma 0xFFFFC200004A0000 irq 201
sata_sil24: sil_port_start allocating Scatter Table, PRBs hex=840
sata_sil24: sil_port_start virtual=ffff810033480000 physical=33480000
ata11: SATA max UDMA/100 cmd 0xFFFFC200004A4000 ctl 0xFFFFC200004A400A bmdma 0xFFFFC200004A0000 irq 201
sata_sil24: sil_port_start allocating Scatter Table, PRBs hex=840
sata_sil24: sil_port_start virtual=ffff8100336e0000 physical=336e0000
ata12: SATA max UDMA/100 cmd 0xFFFFC200004A6000 ctl 0xFFFFC200004A600A bmdma 0xFFFFC200004A0000 irq 201
sata_sil24: bus_probe ap=ffff81003ec77428 trying to identify dev=0
sata_sil24: sil_dev_identify speed=1
ata9: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata9: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
sata_sil24: bus_probe FOUND DEVICE
ata9: dev 0 configured for UDMA/100
scsi8 : sata_sil24
sata_sil24: bus_probe ap=ffff81003b080428 trying to identify dev=0
sata_sil24: sil_dev_identify speed=1
ata10: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata10: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
sata_sil24: bus_probe FOUND DEVICE
ata10: dev 0 configured for UDMA/100
scsi9 : sata_sil24
sata_sil24: bus_probe ap=ffff8100334aa428 trying to identify dev=0
sata_sil24: sil_dev_identify speed=1
ata11: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata11: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
sata_sil24: bus_probe FOUND DEVICE
ata11: dev 0 configured for UDMA/100
scsi10 : sata_sil24
sata_sil24: bus_probe ap=ffff810033872428 trying to identify dev=0
sata_sil24: sil_dev_identify speed=1
ata12: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata12: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
sata_sil24: bus_probe FOUND DEVICE
ata12: dev 0 configured for UDMA/100
scsi11 : sata_sil24
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdf: drive cache: write back
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdf: drive cache: write back
 sdf: sdf4
Attached scsi disk sdf at scsi8, channel 0, id 0, lun 0
Attached scsi generic sg5 at scsi8, channel 0, id 0, lun 0,  type 0
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdg: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdg: drive cache: write back
SCSI device sdg: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdg: drive cache: write back
 sdg: sdg4
Attached scsi disk sdg at scsi9, channel 0, id 0, lun 0
Attached scsi generic sg6 at scsi9, channel 0, id 0, lun 0,  type 0
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdh: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdh: drive cache: write back
SCSI device sdh: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdh: drive cache: write back
 sdh: sdh4
Attached scsi disk sdh at scsi10, channel 0, id 0, lun 0
Attached scsi generic sg7 at scsi10, channel 0, id 0, lun 0,  type 0
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdi: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdi: drive cache: write back
SCSI device sdi: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdi: drive cache: write back
 sdi: sdi4
Attached scsi disk sdi at scsi11, channel 0, id 0, lun 0
Attached scsi generic sg8 at scsi11, channel 0, id 0, lun 0,  type 0
sata_sil24: found 4 Ports

--UugvWAfsgieZRqgk--
