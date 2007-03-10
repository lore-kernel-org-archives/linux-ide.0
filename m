From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/13] ide: add missing validity checks for identify words 62 and 63
Date: Sat, 10 Mar 2007 22:11:28 +0100
Message-ID: <200703102211.28887.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:46176 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932341AbXCJVJR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 16:09:17 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1749119uga
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 13:09:16 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

[PATCH] ide: add missing validity checks for identify words 62 and 63

Check validity of identify words 62 and 63 before using them in
ide_get_mode_mask().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/ide-dma.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -731,10 +731,12 @@ static unsigned int ide_get_mode_mask(id
 			mask &= 0x07;
 		break;
 	case XFER_MW_DMA_0:
-		mask = id->dma_mword & hwif->mwdma_mask;
+		if (id->field_valid & 2)
+			mask = id->dma_mword & hwif->mwdma_mask;
 		break;
 	case XFER_SW_DMA_0:
-		mask = id->dma_1word & hwif->swdma_mask;
+		if (id->field_valid & 2)
+			mask = id->dma_1word & hwif->swdma_mask;
 		break;
 	default:
 		BUG();
