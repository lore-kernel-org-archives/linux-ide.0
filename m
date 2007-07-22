From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/11] ide-pmac: remove control register messing from pmac_ide_dma_check()
Date: Sun, 22 Jul 2007 20:23:29 +0200
Message-ID: <200707222023.29972.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:34860 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758121AbXGVSTF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jul 2007 14:19:05 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1001371ugf
        for <linux-ide@vger.kernel.org>; Sun, 22 Jul 2007 11:19:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


pmac_ide_do_setfeature() contains matching nIEN setting/clearing so this
Device Control register messing in pmac_ide_dma_check() is totally unnecessary.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1784,7 +1784,7 @@ pmac_ide_dma_check(ide_drive_t *drive)
 			drive->using_dma = pmac_ide_udma_enable(drive, mode);
 		else if (mode >= XFER_MW_DMA_0)
 			drive->using_dma = pmac_ide_mdma_enable(drive, mode);
-		hwif->OUTB(0, IDE_CONTROL_REG);
+
 		/* Apply settings to controller */
 		pmac_ide_do_update_timings(drive);
 	}
