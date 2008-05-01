From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH v2 09/13] ide: remove ide_init_drive_cmd
Date: Thu,  1 May 2008 21:28:06 +0900
Message-ID: <1209644890-12040-10-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1209644890-12040-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-9-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo10.iij4u.or.jp ([210.138.174.78]:49425 "EHLO mo10.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754803AbYEAM3U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2008 08:29:20 -0400
In-Reply-To: <1209644890-12040-9-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jens.axboe@oracle.com, bzolnier@gmail.com, petkovbb@gmail.com, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

ide_init_drive_cmd just calls blk_rq_init. This converts the users of
ide_init_drive_cmd to use blk_rq_init directly and removes
ide_init_drive_cmd.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Borislav Petkov <petkovbb@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c     |    2 +-
 drivers/ide/ide-floppy.c |    2 +-
 drivers/ide/ide-io.c     |   17 -----------------
 drivers/scsi/ide-scsi.c  |    4 ++--
 include/linux/ide.h      |    2 --
 5 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index cb573b9..069fd6e 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -193,7 +193,7 @@ void ide_cd_init_rq(ide_drive_t *drive, struct request *rq)
 {
 	struct cdrom_info *cd = drive->driver_data;
 
-	ide_init_drive_cmd(rq);
+	blk_rq_init(NULL, rq);
 	rq->cmd_type = REQ_TYPE_ATA_PC;
 	rq->rq_disk = cd->disk;
 }
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 6bd0021..1199579 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -286,7 +286,7 @@ static void idefloppy_queue_pc_head(ide_drive_t *drive, struct ide_atapi_pc *pc,
 {
 	struct ide_floppy_obj *floppy = drive->driver_data;
 
-	ide_init_drive_cmd(rq);
+	blk_rq_init(NULL, rq);
 	rq->buffer = (char *) pc;
 	rq->cmd_type = REQ_TYPE_SPECIAL;
 	rq->rq_disk = floppy->disk;
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index fae7c70..a913b4b 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1539,23 +1539,6 @@ irqreturn_t ide_intr (int irq, void *dev_id)
 }
 
 /**
- *	ide_init_drive_cmd	-	initialize a drive command request
- *	@rq: request object
- *
- *	Initialize a request before we fill it in and send it down to
- *	ide_do_drive_cmd. Commands must be set up by this function. Right
- *	now it doesn't do a lot, but if that changes abusers will have a
- *	nasty surprise.
- */
-
-void ide_init_drive_cmd (struct request *rq)
-{
-	blk_rq_init(NULL, rq);
-}
-
-EXPORT_SYMBOL(ide_init_drive_cmd);
-
-/**
  *	ide_do_drive_cmd	-	issue IDE special command
  *	@drive: device to issue command
  *	@rq: request to issue
diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index 44d8d51..68a1714 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -228,7 +228,7 @@ static int idescsi_check_condition(ide_drive_t *drive,
 		kfree(pc);
 		return -ENOMEM;
 	}
-	ide_init_drive_cmd(rq);
+	blk_rq_init(NULL, rq);
 	rq->special = (char *) pc;
 	pc->rq = rq;
 	pc->buf = buf;
@@ -785,7 +785,7 @@ static int idescsi_queue (struct scsi_cmnd *cmd,
 		}
 	}
 
-	ide_init_drive_cmd (rq);
+	blk_rq_init(NULL, rq);
 	rq->special = (char *) pc;
 	rq->cmd_type = REQ_TYPE_SPECIAL;
 	spin_unlock_irq(host->host_lock);
diff --git a/include/linux/ide.h b/include/linux/ide.h
index b0135b0..fbf352d 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -842,8 +842,6 @@ int ide_wait_stat(ide_startstop_t *, ide_drive_t *, u8, u8, unsigned long);
 
 extern ide_startstop_t ide_do_reset (ide_drive_t *);
 
-extern void ide_init_drive_cmd (struct request *rq);
-
 /*
  * "action" parameter type for ide_do_drive_cmd() below.
  */
-- 
1.5.4.2

