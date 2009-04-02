From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH] ide-cd: cdrom_decode_status: simplify do_end_request logic
Date: Thu,  2 Apr 2009 08:58:39 +0200
Message-ID: <1238655519-10074-3-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:53588 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbZDBG6r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Apr 2009 02:58:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Set do_end_request per default which results in several lines removed
and simplifying code flow. Also, add defines for cdrom_decode_status's
return codes instead of naked numbers.

There should be no functional change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |   40 +++++++++++++++-------------------------
 drivers/ide/ide-cd.h |    9 ++++++---
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 8387dbf..27d04c1 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -297,17 +297,11 @@ static int ide_cd_breathe(ide_drive_t *drive, struct request *rq)
 	}
 }
 
-/*
- * Returns:
- * 0: if the request should be continued.
- * 1: if the request will be going through error recovery.
- * 2: if the request should be ended.
- */
 static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = hwif->rq;
-	int err, sense_key, do_end_request;
+	int err, sense_key, do_end_request = 1;
 
 	/* get the IDE error register */
 	err = ide_read_error(drive);
@@ -324,32 +318,31 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 		 * Just give up.
 		 */
 		rq->cmd_flags |= REQ_FAILED;
-		return 2;
+		return REQ_FAIL;
 	}
 
 	/* if we got an error, pass CHECK_CONDITION as the scsi status byte */
 	if (blk_pc_request(rq) && !rq->errors)
 		rq->errors = SAM_STAT_CHECK_CONDITION;
 
-	if (blk_noretry_request(rq))
-			do_end_request = 1;
+	if (!blk_noretry_request(rq))
+			do_end_request = 0;
 
 	switch (sense_key) {
 	case NOT_READY:
 		if (blk_fs_request(rq) && (rq_data_dir(rq) == WRITE)) {
 			if (!ide_cd_breathe(drive, rq))
-				return 1;
+				return REQ_RECOVER;
 		} else {
 			cdrom_saw_media_change(drive);
 			printk(KERN_ERR PFX "%s: tray open\n", drive->name);
 		}
-		do_end_request = 1;
 		break;
 
 	case UNIT_ATTENTION:
 		cdrom_saw_media_change(drive);
 		if (blk_pc_request(rq) || rq->cmd_type == REQ_TYPE_ATA_PC)
-			return 0;
+			return REQ_CONT;
 		break;
 
 	case ILLEGAL_REQUEST:
@@ -361,10 +354,10 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 		 *
 		 * cdrom_log_sense() knows this!
 		 */
-		if (rq->cmd[0] != GPCMD_START_STOP_UNIT) {
+		if (rq->cmd[0] != GPCMD_START_STOP_UNIT)
 			ide_dump_status(drive, "command error", stat);
-			do_end_request = 1;
-		}
+		else
+			do_end_request = 0;
 		break;
 
 	case MEDIUM_ERROR:
@@ -373,27 +366,24 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 		 * got here the error is not correctable.
 		 */
 		ide_dump_status(drive, "media error (bad sector)", stat);
-		do_end_request = 1;
 		break;
 
 	case BLANK_CHECK:
 		/* disk appears blank ?? */
 		ide_dump_status(drive, "media error (blank)", stat);
-		do_end_request = 1;
 		break;
 
 	default:
 		if (err & ~ATA_ABORTED) {
 			/* go to the default handler for other errors */
 			ide_error(drive, "cdrom_decode_status", stat);
-			return 1;
+			return REQ_RECOVER;
 		}
 
 		if (!(rq->cmd_flags & REQ_QUIET)) {
 			ide_dump_status(drive, "command error", stat);
 			blk_dump_rq_flags(rq, PFX "failing rq");
 		}
-		do_end_request = 1;
 		break;
 	}
 
@@ -410,7 +400,7 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 	if (stat & ATA_ERR)
 		cdrom_queue_request_sense(drive, NULL, NULL);
 
-	return 1;
+	return REQ_RECOVER;
 
 end_request:
 	if (stat & ATA_ERR) {
@@ -424,9 +414,9 @@ end_request:
 		hwif->rq = NULL;
 
 		cdrom_queue_request_sense(drive, rq->sense, rq);
-		return 1;
-	} else
-		return 2;
+		return REQ_RECOVER;
+	}
+	return REQ_FAIL;
 }
 
 /*
@@ -619,7 +609,7 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
 	if (!OK_STAT(stat, 0, BAD_R_STAT)) {
 		rc = cdrom_decode_status(drive, stat);
 		if (rc) {
-			if (rc == 2)
+			if (rc == REQ_FAIL)
 				goto out_end;
 			return ide_stopped;
 		}
diff --git a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
index 1d97101..164218c 100644
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -18,15 +18,18 @@
 
 #define ATAPI_WAIT_WRITE_BUSY	(10 * HZ)
 
-/************************************************************************/
-
-#define SECTOR_BITS 		9
+#define SECTOR_BITS		9
 #ifndef SECTOR_SIZE
 #define SECTOR_SIZE		(1 << SECTOR_BITS)
 #endif
 #define SECTORS_PER_FRAME	(CD_FRAMESIZE >> SECTOR_BITS)
 #define SECTOR_BUFFER_SIZE	(CD_FRAMESIZE * 32)
 
+/* internal decode_status codes */
+#define REQ_CONT		0
+#define REQ_RECOVER		1
+#define REQ_FAIL		2
+
 /* Capabilities Page size including 8 bytes of Mode Page Header */
 #define ATAPI_CAPABILITIES_PAGE_SIZE		(8 + 20)
 #define ATAPI_CAPABILITIES_PAGE_PAD_SIZE	4
-- 
1.6.2.1

