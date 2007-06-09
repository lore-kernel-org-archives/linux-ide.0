From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix pre-EIDE SWDMA support
Date: Sat, 9 Jun 2007 22:09:53 +0200
Message-ID: <200706092209.53489.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:56394 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758888AbXFIT5q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Jun 2007 15:57:46 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1192216ugf
        for <linux-ide@vger.kernel.org>; Sat, 09 Jun 2007 12:57:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


If the word 62 is not defined use the word 52 to get SWDMA mask
in ide_get_mode_mask().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/ide-dma.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -700,8 +700,22 @@ static unsigned int ide_get_mode_mask(id
 			mask = id->dma_mword & hwif->mwdma_mask;
 		break;
 	case XFER_SW_DMA_0:
-		if (id->field_valid & 2)
+		if (id->field_valid & 2) {
 			mask = id->dma_1word & hwif->swdma_mask;
+		} else if (id->tDMA) {
+			/*
+			 * ide_fix_driveid() doesn't convert ->tDMA to the
+			 * CPU endianness so we need to do it here
+			 */
+			u8 mode = le16_to_cpu(id->tDMA);
+
+			/*
+			 * if the mode is valid convert it to the mask
+			 * (the maximum allowed mode is XFER_SW_DMA_2)
+			 */
+			if (mode <= 2)
+				mask = ((2 << mode) - 1) & hwif->swdma_mask;
+		}
 		break;
 	default:
 		BUG();
