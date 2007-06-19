From: Theo Baumgartner <tbaumgartner@swissonline.ch>
Subject: sata_sil24 not configuring drive right?
Date: Tue, 19 Jun 2007 06:28:38 +0200
Message-ID: <200706190628.38377.tbaumgartner@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from viefep18-int.chello.at ([213.46.255.22]:51311 "EHLO
	viefep23-int.chello.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750833AbXFSE2n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jun 2007 00:28:43 -0400
Received: from 77-56-252-80.dclient.hispeed.ch ([77.56.252.80])
          by viefep23-int.chello.at
          (InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
          id <20070619042840.KOAM10701.viefep23-int.chello.at@77-56-252-80.dclient.hispeed.ch>
          for <linux-ide@vger.kernel.org>; Tue, 19 Jun 2007 06:28:40 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello

I've got a sil3124 card which doesn't seem to use the full speed of my drives.

-------------------------------------------------------------------------------------------------------------------
ata1: SATA max UDMA/100 cmd 0xe0850000 ctl 0x00000000 bmdma 0x00000000 irq 17
ata2: SATA max UDMA/100 cmd 0xe0852000 ctl 0x00000000 bmdma 0x00000000 irq 17
ata3: SATA max UDMA/100 cmd 0xe0854000 ctl 0x00000000 bmdma 0x00000000 irq 17
ata4: SATA max UDMA/100 cmd 0xe0856000 ctl 0x00000000 bmdma 0x00000000 irq 17
scsi0 : sata_sil24
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7: WDC WD3200YS-01PGB0, 21.00M21, max UDMA/133
ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 1)
ata1.00: configured for UDMA/100
scsi1 : sata_sil24
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7: WDC WD3200YS-01PGB0, 21.00M21, max UDMA/133
ata2.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 1)
ata2.00: configured for UDMA/100
scsi2 : sata_sil24
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-7: WDC WD3200YS-01PGB0, 21.00M21, max UDMA/133
ata3.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 1)
ata3.00: configured for UDMA/100
scsi3 : sata_sil24
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-7: WDC WD3200YS-01PGB0, 21.00M21, max UDMA/133
ata4.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 1)
ata4.00: configured for UDMA/100
-------------------------------------------------------------------------------------------------------------------

Why does it tell "max UDMA/133" but then just uses UDMA/100?
and what about the NCQ depth 1?

Theo
