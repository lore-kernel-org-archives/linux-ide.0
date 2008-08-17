From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/9] ide: DMA_PIO_RETRY -> IDE_DFLAG_DMA_PIO_RETRY
Date: Sun, 17 Aug 2008 19:15:29 +0200
Message-ID: <20080817171529.27943.88937.sendpatchset@localhost.localdomain>
References: <20080817171454.27943.37234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:31116 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991AbYHQRRu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Aug 2008 13:17:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1455256fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 17 Aug 2008 10:17:49 -0700 (PDT)
In-Reply-To: <20080817171454.27943.37234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Add IDE_DFLAG_DMA_PIO_RETRY and use it instead of
ide_drive_t.state + DMA_PIO_RETRY.

There should be no functional changes cause by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    7 ++++---
 include/linux/ide.h  |    9 ++-------
 2 files changed, 6 insertions(+), 10 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -78,8 +78,9 @@ static int __ide_end_request(ide_drive_t
 	 * decide whether to reenable DMA -- 3 is a random magic for now,
 	 * if we DMA timeout more than 3 times, just stay in PIO
 	 */
-	if (drive->state == DMA_PIO_RETRY && drive->retry_pio <= 3) {
-		drive->state = 0;
+	if ((drive->dev_flags & IDE_DFLAG_DMA_PIO_RETRY) &&
+	    drive->retry_pio <= 3) {
+		drive->dev_flags &= ~IDE_DFLAG_DMA_PIO_RETRY;
 		ide_dma_on(drive);
 	}
 
@@ -1195,8 +1196,8 @@ static ide_startstop_t ide_dma_timeout_r
 	 * a timeout -- we'll reenable after we finish this next request
 	 * (or rather the first chunk of it) in pio.
 	 */
+	drive->dev_flags |= IDE_DFLAG_DMA_PIO_RETRY;
 	drive->retry_pio++;
-	drive->state = DMA_PIO_RETRY;
 	ide_dma_off_quietly(drive);
 
 	/*
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -48,12 +48,6 @@ typedef unsigned char	byte;	/* used ever
 #define ERROR_RESET	3	/* Reset controller every 4th retry */
 #define ERROR_RECAL	1	/* Recalibrate every 2nd retry */
 
-/*
- * state flags
- */
-
-#define DMA_PIO_RETRY	1	/* retrying in PIO */
-
 #define HWIF(drive)		((ide_hwif_t *)((drive)->hwif))
 #define HWGROUP(drive)		((ide_hwgroup_t *)(HWIF(drive)->hwgroup))
 
@@ -504,6 +498,8 @@ enum {
 	IDE_DFLAG_WCACHE		= (1 << 23),
 	/* used for ignoring ATA_DF */
 	IDE_DFLAG_NOWERR		= (1 << 24),
+	/* retrying in PIO */
+	IDE_DFLAG_DMA_PIO_RETRY		= (1 << 25),
 };
 
 struct ide_drive_s {
@@ -533,7 +529,6 @@ struct ide_drive_s {
 	select_t	select;		/* basic drive/head select reg value */
 
 	u8	retry_pio;		/* retrying dma capable host in pio */
-	u8	state;			/* retry state */
 	u8	waiting_for_dma;	/* dma currently in progress */
 
         u8	quirk_list;	/* considered quirky, set for a specific host */
