From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 4/4] scc_pata: make use of scc_dma_sff_read_status()
Date: Wed, 31 Dec 2008 23:00:13 +0400
Message-ID: <200812312200.13128.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:12321 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756450AbYLaS7r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Dec 2008 13:59:47 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Make consistent use of scc_dma_sff_read_status() throughout the driver.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of the current pata-2.6 series...

 drivers/ide/scc_pata.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/ide/scc_pata.c
===================================================================
--- linux-2.6.orig/drivers/ide/scc_pata.c
+++ linux-2.6/drivers/ide/scc_pata.c
@@ -292,7 +292,7 @@ static void scc_dma_host_set(ide_drive_t
 {
 	ide_hwif_t *hwif = drive->hwif;
 	u8 unit = drive->dn & 1;
-	u8 dma_stat = scc_ide_inb(hwif->dma_base + 4);
+	u8 dma_stat = scc_dma_sff_read_status(hwif);
 
 	if (on)
 		dma_stat |= (1 << (5 + unit));
@@ -338,7 +338,7 @@ static int scc_dma_setup(ide_drive_t *dr
 	out_be32((void __iomem *)hwif->dma_base, reading);
 
 	/* read DMA status for INTR & ERROR flags */
-	dma_stat = in_be32((void __iomem *)(hwif->dma_base + 4));
+	dma_stat = scc_dma_sff_read_status(hwif);
 
 	/* clear INTR & ERROR flags */
 	out_be32((void __iomem *)(hwif->dma_base + 4), dma_stat | 6);
@@ -367,7 +367,7 @@ static int __scc_dma_end(ide_drive_t *dr
 	/* stop DMA */
 	scc_ide_outb(dma_cmd & ~1, hwif->dma_base);
 	/* get DMA status */
-	dma_stat = scc_ide_inb(hwif->dma_base + 4);
+	dma_stat = scc_dma_sff_read_status(hwif);
 	/* clear the INTR & ERROR bits */
 	scc_ide_outb(dma_stat | 6, hwif->dma_base + 4);
 	/* purge DMA mappings */

