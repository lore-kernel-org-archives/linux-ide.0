From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/7] alim15x3: skip DMA initialization completely on revs < 0x20
Date: Sat, 8 Mar 2008 22:31:09 +0100
Message-ID: <200803082231.10085.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:55084 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbYCHVVf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Mar 2008 16:21:35 -0500
Received: by ug-out-1314.google.com with SMTP id z38so4632676ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 08 Mar 2008 13:21:33 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Skip DMA initialization completely on revs < 0x20 by setting IDE_HFLAG_NO_DMA
host flag and resetting DMA host masks in alim15x3_init_one() (currently
ide_hwif_setup_dma() will try to obtain DMA base and setup PCI bus-mastering
but init_dma_ali15x3() will fail).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/alim15x3.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -732,8 +732,6 @@ static void __devinit init_hwif_ali15x3 
 
 static void __devinit init_dma_ali15x3 (ide_hwif_t *hwif, unsigned long dmabase)
 {
-	if (m5229_revision < 0x20)
-		return;
 	if (!hwif->channel)
 		outb(inb(dmabase + 2) & 0x60, dmabase + 2);
 	ide_setup_dma(hwif, dmabase);
@@ -794,6 +792,10 @@ static int __devinit alim15x3_init_one(s
 			d.udma_mask = ATA_UDMA5;
 		else
 			d.udma_mask = ATA_UDMA6;
+	} else {
+		d.host_flags |= IDE_HFLAG_NO_DMA;
+
+		d.mwdma_mask = d.swdma_mask = 0;
 	}
 
 	if (idx == 0)
