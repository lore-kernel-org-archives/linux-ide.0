From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 06/10] trm290: use custom ->dma_{start,end} to handle trm290_prepare_drive()
Date: Fri, 20 Feb 2009 18:12:22 +0100
Message-ID: <20090220171222.25429.23636.sendpatchset@localhost.localdomain>
References: <20090220171139.25429.26702.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:36537 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757213AbZBTRK1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Feb 2009 12:10:27 -0500
In-Reply-To: <20090220171139.25429.26702.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] trm290: use custom ->dma_{start,end} to handle trm290_prepare_drive()

Use custom ->dma_{start,end} methods to handle trm290_prepare_drive()
there instead of in ->dma_setup method.

There should be no functional changes caused by this patch
(DMA support is disabled currently in trm290.c).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/trm290.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: b/drivers/ide/trm290.c
===================================================================
--- a/drivers/ide/trm290.c
+++ b/drivers/ide/trm290.c
@@ -184,7 +184,6 @@ static int trm290_dma_setup(ide_drive_t 
 	if (cmd->tf_flags & IDE_TFLAG_WRITE) {
 #ifdef TRM290_NO_DMA_WRITES
 		/* always use PIO for writes */
-		trm290_prepare_drive(drive, 0);	/* select PIO xfer */
 		return 1;
 #endif
 		rw = 1;
@@ -195,11 +194,8 @@ static int trm290_dma_setup(ide_drive_t 
 	if (count == 0) {
 		ide_map_sg(drive, cmd);
 		/* try PIO instead of DMA */
-		trm290_prepare_drive(drive, 0); /* select PIO xfer */
 		return 1;
 	}
-	/* select DMA xfer */
-	trm290_prepare_drive(drive, 1);
 	outl(hwif->dmatable_dma | rw, hwif->dma_base);
 	drive->waiting_for_dma = 1;
 	/* start DMA */
@@ -209,6 +205,7 @@ static int trm290_dma_setup(ide_drive_t 
 
 static void trm290_dma_start(ide_drive_t *drive)
 {
+	trm290_prepare_drive(drive, 1);
 }
 
 static int trm290_dma_end(ide_drive_t *drive)
@@ -219,6 +216,8 @@ static int trm290_dma_end(ide_drive_t *d
 
 	status = inw(drive->hwif->dma_base + 2);
 
+	trm290_prepare_drive(drive, 0);
+
 	return status != 0x00ff;
 }
 
