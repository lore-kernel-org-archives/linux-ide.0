From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/6] ide: remove dead code from __ide_dma_test_irq()
Date: Mon, 3 Dec 2007 22:51:00 +0100
Message-ID: <200712032251.01041.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:20741 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbXLCVrO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 16:47:14 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2458768ugc
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2007 13:47:12 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c |    6 ------
 1 file changed, 6 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -589,12 +589,6 @@ static int __ide_dma_test_irq(ide_drive_
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 dma_stat		= hwif->INB(hwif->dma_status);
 
-#if 0  /* do not set unless you know what you are doing */
-	if (dma_stat & 4) {
-		u8 stat = hwif->INB(IDE_STATUS_REG);
-		hwif->OUTB(hwif->dma_status, dma_stat & 0xE4);
-	}
-#endif
 	/* return 1 if INTR asserted */
 	if ((dma_stat & 4) == 4)
 		return 1;
