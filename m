From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 1/3] ide-cd: debug log enhancements
Date: Mon, 29 Sep 2008 08:29:57 +0200
Message-ID: <1222669799-6565-2-git-send-email-petkovbb@gmail.com>
References: <1222669799-6565-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:64088 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbYI2GaF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 02:30:05 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1881587fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 28 Sep 2008 23:30:03 -0700 (PDT)
In-Reply-To: <1222669799-6565-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Add some more verbosity to key function calls in ide-cd debug code. While at it,
delete a superfluous comment.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |   33 +++++++++++++++++++++------------
 1 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 474bb1d..9ffce7f 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -340,8 +340,8 @@ static int cdrom_decode_status(ide_drive_t *drive, int good_stat, int *stat_ret)
 	}
 
 	ide_debug_log(IDE_DBG_RQ, "%s: stat: 0x%x, good_stat: 0x%x, "
-		      "rq->cmd_type: 0x%x, err: 0x%x\n", __func__, stat,
-		      good_stat, rq->cmd_type, err);
+		      "rq->cmd[0]: 0x%x, rq->cmd_type: 0x%x, err: 0x%x\n",
+		      __func__, stat, good_stat, rq->cmd[0], rq->cmd_type, err);
 
 	if (blk_sense_request(rq)) {
 		/*
@@ -849,7 +849,8 @@ static void ide_cd_restore_request(ide_drive_t *drive, struct request *rq)
 static void ide_cd_request_sense_fixup(ide_drive_t *drive, struct request *rq)
 {
 
-	ide_debug_log(IDE_DBG_FUNC, "Call %s\n", __func__);
+	ide_debug_log(IDE_DBG_FUNC, "Call %s, rq->cmd[0]: 0x%x\n",
+		      __func__, rq->cmd[0]);
 
 	/*
 	 * Some of the trailing request sense fields are optional,
@@ -876,7 +877,7 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 	if (!sense)
 		sense = &local_sense;
 
-	ide_debug_log(IDE_DBG_PC, "Call %s, rq->cmd[0]: 0x%x, write: 0x%x, "
+	ide_debug_log(IDE_DBG_PC, "Call %s, cmd[0]: 0x%x, write: 0x%x, "
 		      "timeout: %d, cmd_flags: 0x%x\n", __func__, cmd[0], write,
 		      timeout, cmd_flags);
 
@@ -1177,8 +1178,9 @@ static ide_startstop_t cdrom_start_rw(ide_drive_t *drive, struct request *rq)
 	unsigned short sectors_per_frame =
 		queue_hardsect_size(drive->queue) >> SECTOR_BITS;
 
-	ide_debug_log(IDE_DBG_RQ, "Call %s, write: 0x%x, secs_per_frame: %u\n",
-		      __func__, write, sectors_per_frame);
+	ide_debug_log(IDE_DBG_RQ, "Call %s, rq->cmd[0]: 0x%x, write: 0x%x, "
+		      "secs_per_frame: %u\n",
+		      __func__, rq->cmd[0], write, sectors_per_frame);
 
 	if (write) {
 		/* disk has become write protected */
@@ -1221,7 +1223,8 @@ static ide_startstop_t cdrom_do_newpc_cont(ide_drive_t *drive)
 static void cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
 {
 
-	ide_debug_log(IDE_DBG_PC, "Call %s, rq->cmd_type: 0x%x\n", __func__,
+	ide_debug_log(IDE_DBG_PC, "Call %s, rq->cmd[0]: 0x%x, "
+		      "rq->cmd_type: 0x%x\n", __func__, rq->cmd[0],
 		      rq->cmd_type);
 
 	if (blk_pc_request(rq))
@@ -1257,9 +1260,6 @@ static void cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
 	}
 }
 
-/*
- * cdrom driver request routine.
- */
 static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 					sector_t block)
 {
@@ -1267,8 +1267,10 @@ static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 	ide_handler_t *fn;
 	int xferlen;
 
-	ide_debug_log(IDE_DBG_RQ, "Call %s, rq->cmd_type: 0x%x, block: %llu\n",
-		      __func__, rq->cmd_type, (unsigned long long)block);
+	ide_debug_log(IDE_DBG_RQ, "Call %s, rq->cmd[0]: 0x%x, "
+		      "rq->cmd_type: 0x%x, block: %llu\n",
+		      __func__, rq->cmd[0], rq->cmd_type,
+		      (unsigned long long)block);
 
 	if (blk_fs_request(rq)) {
 		if (drive->atapi_flags & IDE_AFLAG_SEEKING) {
@@ -1412,6 +1414,10 @@ static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
 
 	*capacity = 1 + be32_to_cpu(capbuf.lba);
 	*sectors_per_frame = blocklen >> SECTOR_BITS;
+
+	ide_debug_log(IDE_DBG_PROBE, "%s: cap: %lu, sectors_per_frame: %lu\n",
+		      __func__, *capacity, *sectors_per_frame);
+
 	return 0;
 }
 
@@ -1643,6 +1649,9 @@ void ide_cdrom_update_speed(ide_drive_t *drive, u8 *buf)
 		maxspeed = be16_to_cpup((__be16 *)&buf[8 + 8]);
 	}
 
+	ide_debug_log(IDE_DBG_PROBE, "%s: curspeed: %u, maxspeed: %u\n",
+		      __func__, curspeed, maxspeed);
+
 	cd->current_speed = (curspeed + (176/2)) / 176;
 	cd->max_speed = (maxspeed + (176/2)) / 176;
 }
-- 
1.5.5.4

