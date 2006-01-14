From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Subject: maximum ide request size reduced with 2.5.15-git?
Date: Sat, 14 Jan 2006 20:17:11 +0100
Message-ID: <43C94E37.9090909@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.21]:60078 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750818AbWANTRQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jan 2006 14:17:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

it seems that the maximum request size for my hard drive was
reduced with one of the patches between 2.6.15 and 2.6.15-git10.

diff between 2.6.15 and 2.6.15-git10 follows:
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 ICH4: IDE controller at PCI slot 0000:00:1f.1
 PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
 ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
 ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
 ICH4: chipset revision 3
 ICH4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
 Probing IDE interface ide0...
 hda: SAMSUNG MP0804H, ATA DISK drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 Probing IDE interface ide1...
 hdc: DV-W24ES, ATAPI CD/DVD-ROM drive
 ide1 at 0x170-0x177,0x376 on irq 15
-hda: max request size: 1024KiB
+hda: max request size: 512KiB
 hda: 156368016 sectors (80060 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: cache flushes supported
  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
 hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2193kB Cache
 Uniform CD-ROM driver Revision: 3.20

Will this affect performance, and if so, how can I get the old
settings back?

Regards,
Carl-Daniel
