From: Mikael Pettersson <mikpe@it.uu.se>
Subject: 2.6.23-rc1: pata_via cable detection differs from via82cxxx
Date: Fri, 3 Aug 2007 20:28:39 +0200 (MEST)
Message-ID: <200708031828.l73ISdY9022725@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:60247 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262AbXHCS2n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Aug 2007 14:28:43 -0400
Received: from harpo.it.uu.se (daemon@harpo.it.uu.se [130.238.12.34])
	by aun.it.uu.se (8.13.6/8.13.6) with ESMTP id l73ISdEq018377
	for <linux-ide@vger.kernel.org>; Fri, 3 Aug 2007 20:28:39 +0200 (MEST)
Received: (from mikpe@localhost)
	by harpo.it.uu.se (8.13.8+Sun/8.13.7) id l73ISdY9022725
	for linux-ide@vger.kernel.org; Fri, 3 Aug 2007 20:28:39 +0200 (MEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The machine is an Athlon64 laptop with a K8T800 chipset. With the IDE
VIA driver the disk is detected as udma/100:

VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt Link [ALKA] disabled and referenced, BIOS bug
ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 23
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [ALKA] -> GSI 23 (level, low) -> IRQ 17
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x1ce0-0x1ce7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1ce8-0x1cef, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK6021GAS, ATA DISK drive
hda: selected mode 0x45
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA ODD-DVD SD-R6372, ATAPI CD/DVD-ROM drive
hdc: selected mode 0x42
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB), CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >

However, the libata pata_via driver complains about the cable and
drops the disk to udma/33:

pata_via 0000:00:11.1: version 0.3.1
ACPI: PCI Interrupt Link [ALKA] disabled and referenced, BIOS bug
ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 23
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [ALKA] -> GSI 23 (level, low) -> IRQ 17
scsi0 : pata_via
scsi1 : pata_via
ata1: PATA max UDMA/133 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x00011ce0 irq 14
ata2: PATA max UDMA/133 cmd 0x00010170 ctl 0x00010376 bmdma 0x00011ce8 irq 15
ata1.00: ATA-5: TOSHIBA MK6021GAS, GA024A, max UDMA/100
ata1.00: 117210240 sectors, multi 16: LBA 
ata1.00: limited to UDMA/33 due to 40-wire cable
ata1.00: configured for UDMA/33
ata2.00: ATAPI: TOSHIBA ODD-DVD SD-R6372, 1030, max UDMA/33
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA MK6021GA GA02 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 117210240 512-byte hardware sectors (60012 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 117210240 512-byte hardware sectors (60012 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: CD-ROM            TOSHIBA  ODD-DVD SD-R6372 1030 PQ: 0 ANSI: 5

hdparm -i confirms this: with the IDE driver it lists udma5 as
the current mode, with pata_via it lists udma2 as the current mode.

/Mikael
