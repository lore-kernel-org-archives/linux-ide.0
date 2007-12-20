From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 51/63] ide-cd: merge cdrom_do_packet_command() and cdrom_do_block_pc()
Date: Thu, 20 Dec 2007 02:31:18 +0100
Message-ID: <200712200231.18238.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:12465 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757026AbXLTBez (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:55 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389397ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:54 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Add REQ_TYPE_{SENSE,ATA_PC} requests handling to cdrom_do_block_pc()
and remove cdrom_do_packet_command().

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
-29 bytes
 drivers/ide/ide-cd.c |   25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1061,22 +1061,6 @@ static void ide_cd_request_sense_fixup(s
 		}
 }
 
-static ide_startstop_t cdrom_do_newpc_cont(ide_drive_t *);
-
-static ide_startstop_t cdrom_do_packet_command (ide_drive_t *drive)
-{
-	int len;
-	struct request *rq = HWGROUP(drive)->rq;
-	struct cdrom_info *info = drive->driver_data;
-
-	info->dma = 0;
-	rq->cmd_flags &= ~REQ_FAILED;
-	len = rq->data_len;
-
-	/* Start sending the command to the drive. */
-	return cdrom_start_packet_command(drive, len, cdrom_do_newpc_cont);
-}
-
 int ide_cd_queue_pc(ide_drive_t *drive, struct request *rq)
 {
 	struct request_sense sense;
@@ -1490,7 +1474,10 @@ static ide_startstop_t cdrom_do_block_pc
 {
 	struct cdrom_info *info = drive->driver_data;
 
-	rq->cmd_flags |= REQ_QUIET;
+	if (blk_pc_request(rq))
+		rq->cmd_flags |= REQ_QUIET;
+	else
+		rq->cmd_flags &= ~REQ_FAILED;
 
 	info->dma = 0;
 
@@ -1550,10 +1537,8 @@ ide_do_rw_cdrom (ide_drive_t *drive, str
 		}
 		info->last_block = block;
 		return action;
-	} else if (rq->cmd_type == REQ_TYPE_SENSE ||
+	} else if (blk_sense_request(rq) || blk_pc_request(rq) ||
 		   rq->cmd_type == REQ_TYPE_ATA_PC) {
-		return cdrom_do_packet_command(drive);
-	} else if (blk_pc_request(rq)) {
 		return cdrom_do_block_pc(drive, rq);
 	} else if (blk_special_request(rq)) {
 		/*
