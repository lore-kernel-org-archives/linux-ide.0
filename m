From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 14/16] ide: move drive->crc_count check out from check_dma_crc()
Date: Tue, 22 Jan 2008 00:32:12 +0100
Message-ID: <20080121233212.30311.71098.sendpatchset@localhost.localdomain>
References: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:43625 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761035AbYAUXTH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 18:19:07 -0500
Received: by ug-out-1314.google.com with SMTP id z38so975308ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 15:19:06 -0800 (PST)
In-Reply-To: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -968,13 +968,10 @@ static ide_startstop_t reset_pollfunc (i
 static void check_dma_crc(ide_drive_t *drive)
 {
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	if (drive->crc_count) {
-		ide_dma_off_quietly(drive);
-		ide_set_xfer_rate(drive, ide_auto_reduce_xfer(drive));
-		if (drive->current_speed >= XFER_SW_DMA_0)
-			ide_dma_on(drive);
-	} else
-		ide_dma_off(drive);
+	ide_dma_off_quietly(drive);
+	ide_set_xfer_rate(drive, ide_auto_reduce_xfer(drive));
+	if (drive->current_speed >= XFER_SW_DMA_0)
+		ide_dma_on(drive);
 #endif
 }
 
@@ -999,17 +996,20 @@ static void pre_reset(ide_drive_t *drive
 	else
 		drive->post_reset = 1;
 
-	if (!drive->keep_settings) {
-		if (drive->using_dma) {
+	if (drive->using_dma) {
+		if (drive->crc_count)
 			check_dma_crc(drive);
-		} else {
+		else
+			ide_dma_off(drive);
+	}
+
+	if (!drive->keep_settings) {
+		if (!drive->using_dma) {
 			drive->unmask = 0;
 			drive->io_32bit = 0;
 		}
 		return;
 	}
-	if (drive->using_dma)
-		check_dma_crc(drive);
 
 	if (HWIF(drive)->pre_reset != NULL)
 		HWIF(drive)->pre_reset(drive);
