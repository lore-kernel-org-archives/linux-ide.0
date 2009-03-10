From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ide: identify data word 53 bit 1 doesn't cover words 62 and 63 (take 3)
Date: Tue, 10 Mar 2009 18:44:54 +0400
Message-ID: <200903101744.54938.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.79.90.228] ([213.79.90.228]:1455 "EHLO
	buildserver.ru.mvista.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755250AbZCJOoP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Mar 2009 10:44:15 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

The IDE code assumed for years that the bit 1 of the identify data word 53 also
covers the validity of the SW/MW DMA information in words 62 and 63, but it has
always covered only words 64 thru 70, with words 62 and 63 being defined in the
original ATA spec, not in ATA-2...

This fix however should only concern *very* old hard disks and rather old CF
cards...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the recent Linus' tree...
I failed to notice that this change is needed not only in generic code but in
the couple of drivers too -- hence another take...

 drivers/ide/cs5530.c      |    3 +--
 drivers/ide/ide-dma-sff.c |    7 +++----
 drivers/ide/ide-dma.c     |   32 ++++++++++++++------------------
 drivers/ide/sc1200.c      |    3 +--
 4 files changed, 19 insertions(+), 26 deletions(-)

Index: linux-2.6/drivers/ide/cs5530.c
===================================================================
--- linux-2.6.orig/drivers/ide/cs5530.c
+++ linux-2.6/drivers/ide/cs5530.c
@@ -92,8 +92,7 @@ static u8 cs5530_udma_filter(ide_drive_t
 		if ((mateid[ATA_ID_FIELD_VALID] & 4) &&
 		    (mateid[ATA_ID_UDMA_MODES] & 7))
 			goto out;
-		if ((mateid[ATA_ID_FIELD_VALID] & 2) &&
-		    (mateid[ATA_ID_MWDMA_MODES] & 7))
+		if (mateid[ATA_ID_MWDMA_MODES] & 7)
 			mask = 0;
 	}
 out:
Index: linux-2.6/drivers/ide/ide-dma-sff.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-dma-sff.c
+++ linux-2.6/drivers/ide/ide-dma-sff.c
@@ -38,10 +38,9 @@ int config_drive_for_dma(ide_drive_t *dr
 	 * Enable DMA on any drive that has mode2 DMA
 	 * (multi or single) enabled
 	 */
-	if (id[ATA_ID_FIELD_VALID] & 2)	/* regular DMA */
-		if ((id[ATA_ID_MWDMA_MODES] & 0x404) == 0x404 ||
-		    (id[ATA_ID_SWDMA_MODES] & 0x404) == 0x404)
-			return 1;
+	if ((id[ATA_ID_MWDMA_MODES] & 0x404) == 0x404 ||
+	    (id[ATA_ID_SWDMA_MODES] & 0x404) == 0x404)
+		return 1;
 
 	/* Consult the list of known "good" drives */
 	if (ide_dma_good_drive(drive))
Index: linux-2.6/drivers/ide/ide-dma.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-dma.c
+++ linux-2.6/drivers/ide/ide-dma.c
@@ -238,12 +238,11 @@ static unsigned int ide_get_mode_mask(id
 	case XFER_UDMA_0:
 		if ((id[ATA_ID_FIELD_VALID] & 4) == 0)
 			break;
-
+		mask = id[ATA_ID_UDMA_MODES];
 		if (port_ops && port_ops->udma_filter)
-			mask = port_ops->udma_filter(drive);
+			mask &= port_ops->udma_filter(drive);
 		else
-			mask = hwif->ultra_mask;
-		mask &= id[ATA_ID_UDMA_MODES];
+			mask &= hwif->ultra_mask;
 
 		/*
 		 * avoid false cable warning from eighty_ninty_three()
@@ -254,18 +253,15 @@ static unsigned int ide_get_mode_mask(id
 		}
 		break;
 	case XFER_MW_DMA_0:
-		if ((id[ATA_ID_FIELD_VALID] & 2) == 0)
-			break;
+		mask = id[ATA_ID_MWDMA_MODES];
 		if (port_ops && port_ops->mdma_filter)
-			mask = port_ops->mdma_filter(drive);
+			mask &= port_ops->mdma_filter(drive);
 		else
-			mask = hwif->mwdma_mask;
-		mask &= id[ATA_ID_MWDMA_MODES];
+			mask &= hwif->mwdma_mask;
 		break;
 	case XFER_SW_DMA_0:
-		if (id[ATA_ID_FIELD_VALID] & 2) {
-			mask = id[ATA_ID_SWDMA_MODES] & hwif->swdma_mask;
-		} else if (id[ATA_ID_OLD_DMA_MODES] >> 8) {
+		mask = id[ATA_ID_SWDMA_MODES];
+		if (!(mask & ATA_SWDMA2) && (id[ATA_ID_OLD_DMA_MODES] >> 8)) {
 			u8 mode = id[ATA_ID_OLD_DMA_MODES] >> 8;
 
 			/*
@@ -273,8 +269,9 @@ static unsigned int ide_get_mode_mask(id
 			 * (the maximum allowed mode is XFER_SW_DMA_2)
 			 */
 			if (mode <= 2)
-				mask = ((2 << mode) - 1) & hwif->swdma_mask;
+				mask = (2 << mode) - 1;
 		}
+		mask &= hwif->swdma_mask;
 		break;
 	default:
 		BUG();
@@ -391,11 +388,10 @@ int ide_id_dma_bug(ide_drive_t *drive)
 		if ((id[ATA_ID_UDMA_MODES] >> 8) &&
 		    (id[ATA_ID_MWDMA_MODES] >> 8))
 			goto err_out;
-	} else if (id[ATA_ID_FIELD_VALID] & 2) {
-		if ((id[ATA_ID_MWDMA_MODES] >> 8) &&
-		    (id[ATA_ID_SWDMA_MODES] >> 8))
-			goto err_out;
-	}
+	} else if ((id[ATA_ID_MWDMA_MODES] >> 8) &&
+		   (id[ATA_ID_SWDMA_MODES] >> 8))
+		goto err_out;
+
 	return 0;
 err_out:
 	printk(KERN_ERR "%s: bad DMA info in identify block\n", drive->name);
Index: linux-2.6/drivers/ide/sc1200.c
===================================================================
--- linux-2.6.orig/drivers/ide/sc1200.c
+++ linux-2.6/drivers/ide/sc1200.c
@@ -115,8 +115,7 @@ static u8 sc1200_udma_filter(ide_drive_t
 		if ((mateid[ATA_ID_FIELD_VALID] & 4) &&
 		    (mateid[ATA_ID_UDMA_MODES] & 7))
 			goto out;
-		if ((mateid[ATA_ID_FIELD_VALID] & 2) &&
-		    (mateid[ATA_ID_MWDMA_MODES] & 7))
+		if (mateid[ATA_ID_MWDMA_MODES] & 7)
 			mask = 0;
 	}
 out:

