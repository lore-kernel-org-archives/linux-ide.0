From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/12] ata_generic: unindent loop in generic_set_mode()
Date: Tue,  6 Nov 2007 14:38:59 +0900
Message-ID: <11943275502487-git-send-email-htejun@gmail.com>
References: <1194327550227-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:7419 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752179AbXKFFjN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Nov 2007 00:39:13 -0500
In-Reply-To: <1194327550227-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Unindent loop body in generic_set_mode().  This is to ease future
change.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_generic.c |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 9032998..fb5434c 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -54,21 +54,22 @@ static int generic_set_mode(struct ata_link *link, struct ata_device **unused)
 		dma_enabled = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 
 	ata_link_for_each_dev(dev, link) {
-		if (ata_dev_enabled(dev)) {
-			/* We don't really care */
-			dev->pio_mode = XFER_PIO_0;
-			dev->dma_mode = XFER_MW_DMA_0;
-			/* We do need the right mode information for DMA or PIO
-			   and this comes from the current configuration flags */
-			if (dma_enabled & (1 << (5 + dev->devno))) {
-				ata_id_to_dma_mode(dev, XFER_MW_DMA_0);
-				dev->flags &= ~ATA_DFLAG_PIO;
-			} else {
-				ata_dev_printk(dev, KERN_INFO, "configured for PIO\n");
-				dev->xfer_mode = XFER_PIO_0;
-				dev->xfer_shift = ATA_SHIFT_PIO;
-				dev->flags |= ATA_DFLAG_PIO;
-			}
+		if (!ata_dev_enabled(dev))
+			continue;
+
+		/* We don't really care */
+		dev->pio_mode = XFER_PIO_0;
+		dev->dma_mode = XFER_MW_DMA_0;
+		/* We do need the right mode information for DMA or PIO
+		   and this comes from the current configuration flags */
+		if (dma_enabled & (1 << (5 + dev->devno))) {
+			ata_id_to_dma_mode(dev, XFER_MW_DMA_0);
+			dev->flags &= ~ATA_DFLAG_PIO;
+		} else {
+			ata_dev_printk(dev, KERN_INFO, "configured for PIO\n");
+			dev->xfer_mode = XFER_PIO_0;
+			dev->xfer_shift = ATA_SHIFT_PIO;
+			dev->flags |= ATA_DFLAG_PIO;
 		}
 	}
 	return 0;
-- 
1.5.2.4

