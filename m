From: "Rus V. Brushkoff" <rus@SoyuzKT.Od.UA>
Subject: 2.6.9 hangs completely on ICH5 chipset
Date: Fri, 5 Nov 2004 13:30:35 +0200 (EET)
Message-ID: <Pine.LNX.4.53.0411051322360.11269@Soyuz-KT.TeNet.Odessa.UA>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Soyuz-KT.TeNeT.Odessa.UA ([195.138.79.66]:46312 "EHLO
	Soyuz-KT.Odessa.UA") by vger.kernel.org with ESMTP id S262650AbUKELam
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 06:30:42 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com


	Hi.

 Tried 2.6.9-libata1* patches, no success. The system is Intel m/b P4
3ghz, ICH5, one WD 200GB SATA drive. The kernel freezes completely (sysrq
doesn't working) after such lines :

..............
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:DMA
hdd: LITE-ON COMBO SOHC-5232K, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
libata version 1.02 loaded.
ata_piix version 1.02
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 18
ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 18
ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003
88:203f
ata1: dev 0 ATA, max UDMA/100, 390721968 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
ata2: SATA port has no device.
scsi1 : ata_piix
  Vendor: ATA       Model: WDC WD2000JD-00G  Rev: 02.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
 sda:
.................

 These lines copied from 2.6.8 output which works fine with this h/w
setup. I can supply any debug info if needed.



		Rus
