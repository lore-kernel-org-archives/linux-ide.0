From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/9] ide: move rq->errors quirk out from ide_end_request()
Date: Mon, 09 Feb 2009 21:01:21 +0100
Message-ID: <20090209200121.7985.49242.sendpatchset@localhost.localdomain>
References: <20090209200042.7985.94247.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:43279 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757035AbZBIUAJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Feb 2009 15:00:09 -0500
In-Reply-To: <20090209200042.7985.94247.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: move rq->errors quirk out from ide_end_request()

Move rq->errors quirk out from ide_end_request() to its call sites.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-atapi.c  |    7 ++++++-
 drivers/ide/ide-cd.c     |    3 +++
 drivers/ide/ide-disk.c   |    2 ++
 drivers/ide/ide-eh.c     |    5 ++++-
 drivers/ide/ide-floppy.c |    2 ++
 drivers/ide/ide-io.c     |    5 ++---
 drivers/ide/ide-tape.c   |    2 ++
 7 files changed, 21 insertions(+), 5 deletions(-)

Index: b/drivers/ide/ide-atapi.c
===================================================================
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -393,8 +393,13 @@ static ide_startstop_t ide_pc_intr(ide_d
 		if (blk_special_request(rq)) {
 			rq->errors = 0;
 			ide_complete_rq(drive, 0);
-		} else
+		} else {
+			if (blk_fs_request(rq) == 0 && uptodate <= 0) {
+				if (rq->errors == 0)
+					rq->errors = -EIO;
+			}
 			ide_end_request(drive, uptodate, 0);
+		}
 
 		return ide_stopped;
 	}
Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -289,6 +289,9 @@ static void cdrom_end_request(ide_drive_
 	ide_debug_log(IDE_DBG_FUNC, "uptodate: 0x%x, nsectors: %d",
 				    uptodate, nsectors);
 
+	if (blk_fs_request(rq) == 0 && uptodate <= 0 && rq->errors == 0)
+		rq->errors = -EIO;
+
 	ide_end_request(drive, uptodate, nsectors);
 }
 
Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -184,6 +184,8 @@ static ide_startstop_t ide_do_rw_disk(id
 
 	if (!blk_fs_request(rq)) {
 		blk_dump_rq_flags(rq, "ide_do_rw_disk - bad command");
+		if (rq->errors == 0)
+			rq->errors = -EIO;
 		ide_end_request(drive, 0, 0);
 		return ide_stopped;
 	}
Index: b/drivers/ide/ide-eh.c
===================================================================
--- a/drivers/ide/ide-eh.c
+++ b/drivers/ide/ide-eh.c
@@ -146,8 +146,11 @@ static inline void ide_complete_drive_re
 {
 	struct request *rq = drive->hwif->rq;
 
-	if (rq && blk_special_request(rq) && rq->cmd[0] == REQ_DRIVE_RESET)
+	if (rq && blk_special_request(rq) && rq->cmd[0] == REQ_DRIVE_RESET) {
+		if (err <= 0 && rq->errors == 0)
+			rq->errors = -EIO;
 		ide_end_request(drive, err ? err : 1, 0);
+	}
 }
 
 /* needed below */
Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -296,6 +296,8 @@ static ide_startstop_t ide_floppy_do_req
 	return idefloppy_issue_pc(drive, pc);
 out_end:
 	drive->failed_pc = NULL;
+	if (blk_fs_request(rq) == 0 && rq->errors == 0)
+		rq->errors = -EIO;
 	ide_end_request(drive, 0, 0);
 	return ide_stopped;
 }
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -102,9 +102,6 @@ int ide_end_request (ide_drive_t *drive,
 	if (blk_noretry_request(rq) && uptodate <= 0)
 		nr_bytes = rq->hard_nr_sectors << 9;
 
-	if (blk_fs_request(rq) == 0 && uptodate <= 0 && rq->errors == 0)
-		rq->errors = -EIO;
-
 	if (uptodate <= 0)
 		error = uptodate ? uptodate : -EIO;
 
@@ -165,6 +162,8 @@ void ide_kill_rq(ide_drive_t *drive, str
 	} else {
 		if (media == ide_tape)
 			rq->errors = IDE_DRV_ERROR_GENERAL;
+		else if (blk_fs_request(rq) == 0 && rq->errors == 0)
+			rq->errors = -EIO;
 		ide_end_request(drive, 0, 0);
 	}
 }
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -760,6 +760,8 @@ static ide_startstop_t idetape_do_reques
 		/* We do not support buffer cache originated requests. */
 		printk(KERN_NOTICE "ide-tape: %s: Unsupported request in "
 			"request queue (%d)\n", drive->name, rq->cmd_type);
+		if (blk_fs_request(rq) == 0 && rq->errors == 0)
+			rq->errors = -EIO;
 		ide_end_request(drive, 0, 0);
 		return ide_stopped;
 	}
