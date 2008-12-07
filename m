From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 4/4] ide: remove the last ide-scsi remnants
Date: Sun,  7 Dec 2008 18:21:11 +0100
Message-ID: <1228670471-3435-5-git-send-email-petkovbb@gmail.com>
References: <1228670471-3435-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:26453 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbYLGRVT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Dec 2008 12:21:19 -0500
Received: by fk-out-0910.google.com with SMTP id 18so868088fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 07 Dec 2008 09:21:17 -0800 (PST)
In-Reply-To: <1228670471-3435-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c  |    3 +--
 drivers/ide/ide-io.c     |    3 ---
 drivers/ide/ide-ioctls.c |    3 +--
 drivers/ide/ide-probe.c  |    2 --
 include/linux/ide.h      |   28 +++++++++++++---------------
 5 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 7a04509..d412bd2 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -17,8 +17,7 @@
 
 static inline int dev_is_idecd(ide_drive_t *drive)
 {
-	return (drive->media == ide_cdrom || drive->media == ide_optical) &&
-		!(drive->dev_flags & IDE_DFLAG_SCSI);
+	return drive->media == ide_cdrom || drive->media == ide_optical;
 }
 
 /*
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 7743b0f..4136164 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -426,9 +426,6 @@ void ide_map_sg(ide_drive_t *drive, struct request *rq)
 	ide_hwif_t *hwif = drive->hwif;
 	struct scatterlist *sg = hwif->sg_table;
 
-	if (hwif->sg_mapped)	/* needed by ide-scsi */
-		return;
-
 	if (rq->cmd_type != REQ_TYPE_ATA_TASKFILE) {
 		hwif->sg_nents = blk_rq_map_sg(drive->queue, rq, sg);
 	} else {
diff --git a/drivers/ide/ide-ioctls.c b/drivers/ide/ide-ioctls.c
index 28232c6..1be263e 100644
--- a/drivers/ide/ide-ioctls.c
+++ b/drivers/ide/ide-ioctls.c
@@ -95,8 +95,7 @@ static int ide_set_nice_ioctl(ide_drive_t *drive, unsigned long arg)
 		return -EPERM;
 
 	if (((arg >> IDE_NICE_DSC_OVERLAP) & 1) &&
-	    (drive->media != ide_tape ||
-	     (drive->dev_flags & IDE_DFLAG_SCSI)))
+	    (drive->media != ide_tape))
 		return -EPERM;
 
 	if ((arg >> IDE_NICE_DSC_OVERLAP) & 1)
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 966b74c..c5adb7b 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1141,8 +1141,6 @@ static struct kobject *ata_probe(dev_t dev, int *part, void *data)
 
 	if (drive->media == ide_disk)
 		request_module("ide-disk");
-	if (drive->dev_flags & IDE_DFLAG_SCSI)
-		request_module("ide-scsi");
 	if (drive->media == ide_cdrom || drive->media == ide_optical)
 		request_module("ide-cd");
 	if (drive->media == ide_tape)
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 257524e..ad57a44 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -559,28 +559,26 @@ enum {
 	IDE_DFLAG_NODMA			= (1 << 16),
 	/* powermanagment told us not to do anything, so sleep nicely */
 	IDE_DFLAG_BLOCKED		= (1 << 17),
-	/* ide-scsi emulation */
-	IDE_DFLAG_SCSI			= (1 << 18),
 	/* sleeping & sleep field valid */
-	IDE_DFLAG_SLEEPING		= (1 << 19),
-	IDE_DFLAG_POST_RESET		= (1 << 20),
-	IDE_DFLAG_UDMA33_WARNED		= (1 << 21),
-	IDE_DFLAG_LBA48			= (1 << 22),
+	IDE_DFLAG_SLEEPING		= (1 << 18),
+	IDE_DFLAG_POST_RESET		= (1 << 19),
+	IDE_DFLAG_UDMA33_WARNED		= (1 << 20),
+	IDE_DFLAG_LBA48			= (1 << 21),
 	/* status of write cache */
-	IDE_DFLAG_WCACHE		= (1 << 23),
+	IDE_DFLAG_WCACHE		= (1 << 22),
 	/* used for ignoring ATA_DF */
-	IDE_DFLAG_NOWERR		= (1 << 24),
+	IDE_DFLAG_NOWERR		= (1 << 23),
 	/* retrying in PIO */
-	IDE_DFLAG_DMA_PIO_RETRY		= (1 << 25),
-	IDE_DFLAG_LBA			= (1 << 26),
+	IDE_DFLAG_DMA_PIO_RETRY		= (1 << 24),
+	IDE_DFLAG_LBA			= (1 << 25),
 	/* don't unload heads */
-	IDE_DFLAG_NO_UNLOAD		= (1 << 27),
+	IDE_DFLAG_NO_UNLOAD		= (1 << 26),
 	/* heads unloaded, please don't reset port */
-	IDE_DFLAG_PARKED		= (1 << 28),
-	IDE_DFLAG_MEDIA_CHANGED		= (1 << 29),
+	IDE_DFLAG_PARKED		= (1 << 27),
+	IDE_DFLAG_MEDIA_CHANGED		= (1 << 28),
 	/* write protect */
-	IDE_DFLAG_WP			= (1 << 30),
-	IDE_DFLAG_FORMAT_IN_PROGRESS	= (1 << 31),
+	IDE_DFLAG_WP			= (1 << 29),
+	IDE_DFLAG_FORMAT_IN_PROGRESS	= (1 << 30),
 };
 
 struct ide_drive_s {
-- 
1.6.0.4

