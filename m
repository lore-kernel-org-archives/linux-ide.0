From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 3/3] ide-cd: fix DMA for non bio-backed requests
Date: Mon, 26 Jan 2009 21:40:40 +0100
Message-ID: <1233002440-4325-3-git-send-email-petkovbb@gmail.com>
References: <1233002440-4325-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:49604 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbZAZUkr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2009 15:40:47 -0500
In-Reply-To: <1233002440-4325-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

This one fixes http://bugzilla.kernel.org/show_bug.cgi?id=12320.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |    3 +++
 drivers/ide/ide-io.c |    9 ++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 94981f9..84bc370 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -784,6 +784,9 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
 		if (blk_fs_request(rq)) {
 			ide_end_request(drive, 1, rq->nr_sectors);
 			return ide_stopped;
+		} else if (rq->cmd_type == REQ_TYPE_ATA_PC && !rq->bio) {
+			ide_end_request(drive, 1, 1);
+			return ide_stopped;
 		}
 		goto end_request;
 	}
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 9927b03..615b6e7 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -291,11 +291,14 @@ void ide_map_sg(ide_drive_t *drive, struct request *rq)
 	ide_hwif_t *hwif = drive->hwif;
 	struct scatterlist *sg = hwif->sg_table;
 
-	if (rq->cmd_type != REQ_TYPE_ATA_TASKFILE) {
-		hwif->sg_nents = blk_rq_map_sg(drive->queue, rq, sg);
-	} else {
+	if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
 		sg_init_one(sg, rq->buffer, rq->nr_sectors * SECTOR_SIZE);
 		hwif->sg_nents = 1;
+	} else if (!rq->bio) {
+		sg_init_one(sg, rq->data, rq->data_len);
+		hwif->sg_nents = 1;
+	} else {
+		hwif->sg_nents = blk_rq_map_sg(drive->queue, rq, sg);
 	}
 }
 
-- 
1.6.0.4

