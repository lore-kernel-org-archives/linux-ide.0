From: Marc Singer <elf@buici.com>
Subject: VIA SATA not recognizing drives
Date: Sat, 8 May 2004 12:31:00 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040508193100.GA31122@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from florence.buici.com ([206.124.142.26]:25988 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264138AbUEHTb0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 May 2004 15:31:26 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

In using a BK pull from linus's tree (Sat May 8) and applying Jeff
Garzik's Apr 26 patch, I'm not seeing my SATA drives.  I've tried
several kernel versions, from 2.6.3 up to this patched 2.6.6-rc?
version. 

The dmesg's seem to indicate that the driver is loading.

  Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
  ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
  VP_IDE: IDE controller at PCI slot 0000:00:0f.1
  VP_IDE: chipset revision 6
  VP_IDE: not 100% native mode: will probe irqs later
  VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
  ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
  ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
  hda: ST380021A, ATA DISK drive
  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
  hdc: TOSHIBA CD-ROM XM-6202B, ATAPI CD/DVD-ROM drive
  ide1 at 0x170-0x177,0x376 on irq 15
  hda: max request size: 128KiB
  hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
  hda: hda1
  libata version 1.02 loaded.
  sata_via version 0.20
  sata_via(0000:00:0f.0): routed to hard irq line 10
  ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 10
  ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 10
  ata1: no device found (phy stat 00000000)
  ata1: thread exiting
  scsi0 : sata_via
  ata2: no device found (phy stat 00000000)
  ata2: thread exiting
  scsi1 : sata_via

Is there something else I should check?
