From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/2] pmac: remove needless pmac_ide_destroy_dmatable() wrapper
Date: Tue, 2 Sep 2008 20:31:22 +0200
Message-ID: <200809022031.22922.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.190]:10259 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbYIBSdz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Sep 2008 14:33:55 -0400
Received: by gv-out-0910.google.com with SMTP id e6so67510gvc.37
        for <linux-ide@vger.kernel.org>; Tue, 02 Sep 2008 11:33:53 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

hwif->sg_nents is always != 0 when this function is called
and there is also no need to explicitely zero hwif->sg_nents.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1523,18 +1523,6 @@ use_pio_instead:
 	return 0; /* revert to PIO for this request */
 }
 
-/* Teardown mappings after DMA has completed.  */
-static void
-pmac_ide_destroy_dmatable (ide_drive_t *drive)
-{
-	ide_hwif_t *hwif = drive->hwif;
-
-	if (hwif->sg_nents) {
-		ide_destroy_dmatable(drive);
-		hwif->sg_nents = 0;
-	}
-}
-
 /*
  * Prepare a DMA transfer. We build the DMA table, adjust the timings for
  * a read on KeyLargo ATA/66 and mark us as waiting for DMA completion
@@ -1606,7 +1594,9 @@ pmac_ide_dma_end (ide_drive_t *drive)
 	drive->waiting_for_dma = 0;
 	dstat = readl(&dma->status);
 	writel(((RUN|WAKE|DEAD) << 16), &dma->control);
-	pmac_ide_destroy_dmatable(drive);
+
+	ide_destroy_dmatable(drive);
+
 	/* verify good dma status. we don't check for ACTIVE beeing 0. We should...
 	 * in theory, but with ATAPI decices doing buffer underruns, that would
 	 * cause us to disable DMA, which isn't what we want
