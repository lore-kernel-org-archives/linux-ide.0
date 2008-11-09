From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 01/11] ide: respect current DMA setting during resume
Date: Sun, 09 Nov 2008 17:22:19 +0100
Message-ID: <20081109162219.18999.74912.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:60863 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755820AbYKIQYT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 11:24:19 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: respect current DMA setting during resume

Respect current DMA setting during resume, otherwise PIO timings
may get destroyed if host uses shared PIO/MWDMA timings.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -192,10 +192,8 @@ static ide_startstop_t ide_start_power_s
 		 */
 		if (drive->hwif->dma_ops == NULL)
 			break;
-		/*
-		 * TODO: respect IDE_DFLAG_USING_DMA
-		 */
-		ide_set_dma(drive);
+		if (drive->dev_flags & IDE_DFLAG_USING_DMA)
+			ide_set_dma(drive);
 		break;
 	}
 
