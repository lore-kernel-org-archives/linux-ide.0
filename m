From: Jeff Garzik <jeff@garzik.org>
Subject: linux-2.6.git error messages
Date: Tue, 16 Oct 2007 01:06:28 -0400
Message-ID: <471446D4.6050803@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48670 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754966AbXJPFGa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Oct 2007 01:06:30 -0400
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IhedR-0003Yq-9X
	for linux-ide@vger.kernel.org; Tue, 16 Oct 2007 05:06:30 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

I get this on ICH5, modular kernel build:

libata version 3.00 loaded.
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata4294967295: failed to start port (errno=-19)
^^^^^^^^^^^^^

ACPI: PCI interrupt for device 0000:00:1f.1 disabled
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata4294967295: failed to start port (errno=-19)
^^^^^^^^^^^^^

ACPI: PCI interrupt for device 0000:00:1f.2 disabled
ata_piix 0000:00:1f.1: version 2.12
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.1 to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x24c0 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x24c8 irq 15
ata1.00: ATA-5: MAXTOR 6L080J4, A93.0500, max UDMA/133
ata1.00: 156301488 sectors, multi 16: LBA
ata1.00: configured for UDMA/100
ata2.00: ATAPI: HL-DT-ST CD-ROM GCR-8480B, 1.00, max MWDMA2
ata2.00: configured for MWDMA2
scsi 0:0:0:0: Direct-Access     ATA      MAXTOR 6L080J4   A93. PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO
  or FUA
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO
  or FUA
  sda: sda1 sda2
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: CD-ROM            HL-DT-ST CD-ROM GCR-8480B 1.00 PQ: 0 ANSI: 5
scsi 1:0:0:0: Attached scsi generic sg1 type 5
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0x24f0 ctl 0x2808 bmdma 0x24d0 irq 18
ata4: SATA max UDMA/133 cmd 0x24f8 ctl 0x280c bmdma 0x24d8 irq 18
ata4.00: ATA-6: ST380013AS, 3.05, max UDMA/133
ata4.00: 156301488 sectors, multi 16: LBA48
ata4.00: configured for UDMA/133
scsi 3:0:0:0: Direct-Access     ATA      ST380013AS       3.05 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdb] 156301488 512-byte hardware sectors (80026 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO
  or FUA
sd 3:0:0:0: [sdb] 156301488 512-byte hardware sectors (80026 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO
  or FUA
  sdb: sdb1 sdb2
sd 3:0:0:0: [sdb] Attached SCSI disk
sd 3:0:0:0: Attached scsi generic sg2 type 0
sata_sil 0000:05:09.0: version 2.3
ACPI: PCI Interrupt 0000:05:09.0[A] -> GSI 18 (level, low) -> IRQ 18
scsi4 : sata_sil
scsi5 : sata_sil
ata5: SATA max UDMA/100 mmio m512@0xf0410000 tf 0xf0410080 irq 18
ata6: SATA max UDMA/100 mmio m512@0xf0410000 tf 0xf04100c0 irq 18
ata5: SATA link down (SStatus 0 SControl 310)
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: ATA-6: HDS722580VLSA80, V32OA60A, max UDMA/100
ata6.00: 160836480 sectors, multi 16: LBA48
ata6.00: configured for UDMA/100
scsi 5:0:0:0: Direct-Access     ATA      HDS722580VLSA80  V32O PQ: 0 ANSI: 5
sd 5:0:0:0: [sdc] 160836480 512-byte hardware sectors (82348 MB)
sd 5:0:0:0: [sdc] Write Protect is off
sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't 
support DPO
  or FUA
sd 5:0:0:0: [sdc] 160836480 512-byte hardware sectors (82348 MB)
sd 5:0:0:0: [sdc] Write Protect is off
sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't 
support DPO
  or FUA
  sdc: sdc1 sdc2
sd 5:0:0:0: [sdc] Attached SCSI disk
sd 5:0:0:0: Attached scsi generic sg3 type 0
