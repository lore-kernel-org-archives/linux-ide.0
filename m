From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 14/16] ide-scsi: convert to using the new dev_flags
Date: Sun, 29 Jun 2008 12:59:17 +0200
Message-ID: <1214737159-1078-15-git-send-email-petkovbb@gmail.com>
References: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:56648 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757131AbYF2K7T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jun 2008 06:59:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so564620fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 29 Jun 2008 03:59:18 -0700 (PDT)
In-Reply-To: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Remove unused IDESCSI_PC_RQ while at it.

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/scsi/ide-scsi.c |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index c637520..5d7e283 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -84,7 +84,6 @@ typedef struct ide_scsi_obj {
 	struct Scsi_Host	*host;
 
 	struct ide_atapi_pc *pc;		/* Current packet command */
-	unsigned long flags;			/* Status/Action flags */
 	unsigned long transform;		/* SCSI cmd translation layer */
 	unsigned long log;			/* log flags */
 } idescsi_scsi_t;
@@ -126,16 +125,6 @@ static inline idescsi_scsi_t *drive_to_idescsi(ide_drive_t *ide_drive)
 }
 
 /*
- *	Per ATAPI device status bits.
- */
-#define IDESCSI_DRQ_INTERRUPT		0	/* DRQ interrupt device */
-
-/*
- *	ide-scsi requests.
- */
-#define IDESCSI_PC_RQ			90
-
-/*
  *	PIO data transfer routine using the scatter gather table.
  */
 static void ide_scsi_io_buffers(ide_drive_t *drive, struct ide_atapi_pc *pc,
@@ -434,10 +423,6 @@ static ide_startstop_t idescsi_do_request (ide_drive_t *drive, struct request *r
 
 	if (blk_sense_request(rq) || blk_special_request(rq)) {
 		struct ide_atapi_pc *pc = (struct ide_atapi_pc *)rq->special;
-		idescsi_scsi_t *scsi = drive_to_idescsi(drive);
-
-		if (test_bit(IDESCSI_DRQ_INTERRUPT, &scsi->flags))
-			pc->flags |= PC_FLAG_DRQ_INTERRUPT;
 
 		if (drive->using_dma && !idescsi_map_sg(drive, pc))
 			pc->flags |= PC_FLAG_DMA_OK;
@@ -473,7 +458,7 @@ static inline void idescsi_add_settings(ide_drive_t *drive) { ; }
 static void idescsi_setup (ide_drive_t *drive, idescsi_scsi_t *scsi)
 {
 	if (drive->id && (drive->id->config & 0x0060) == 0x20)
-		set_bit (IDESCSI_DRQ_INTERRUPT, &scsi->flags);
+		set_bit(IDE_FLAG_DRQ_INTERRUPT, &drive->dev_flags);
 	clear_bit(IDESCSI_SG_TRANSFORM, &scsi->transform);
 #if IDESCSI_DEBUG_LOG
 	set_bit(IDESCSI_LOG_CMD, &scsi->log);
-- 
1.5.5.4

