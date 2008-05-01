From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH v2 10/13] ide-cd: remove ide_cd_init_rq
Date: Thu,  1 May 2008 21:28:07 +0900
Message-ID: <1209644890-12040-11-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1209644890-12040-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-9-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-10-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo10.iij4u.or.jp ([210.138.174.78]:49421 "EHLO mo10.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754683AbYEAM3T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2008 08:29:19 -0400
In-Reply-To: <1209644890-12040-10-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jens.axboe@oracle.com, bzolnier@gmail.com, petkovbb@gmail.com, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

ide_cd_init_rq is not used by ide-cd_ioctl any more. Only
cdrom_queue_request_sense use it. This converts
cdrom_queue_request_sense to use blk_rq_init directly and removes
ide_cd_init_rq.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Borislav Petkov <petkovbb@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |   14 +++-----------
 drivers/ide/ide-cd.h |    1 -
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 069fd6e..f1ee432 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -188,16 +188,6 @@ static void cdrom_analyze_sense_data(ide_drive_t *drive,
 	ide_cd_log_error(drive->name, failed_command, sense);
 }
 
-/* Initialize a ide-cd packet command request */
-void ide_cd_init_rq(ide_drive_t *drive, struct request *rq)
-{
-	struct cdrom_info *cd = drive->driver_data;
-
-	blk_rq_init(NULL, rq);
-	rq->cmd_type = REQ_TYPE_ATA_PC;
-	rq->rq_disk = cd->disk;
-}
-
 static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
 				      struct request *failed_command)
 {
@@ -208,7 +198,9 @@ static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
 		sense = &info->sense_data;
 
 	/* stuff the sense request in front of our current request */
-	ide_cd_init_rq(drive, rq);
+	blk_rq_init(NULL, rq);
+	rq->cmd_type = REQ_TYPE_ATA_PC;
+	rq->rq_disk = info->disk;
 
 	rq->data = sense;
 	rq->cmd[0] = GPCMD_REQUEST_SENSE;
diff --git a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
index 13918c5..a7971d7 100644
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -143,7 +143,6 @@ struct cdrom_info {
 void ide_cd_log_error(const char *, struct request *, struct request_sense *);
 
 /* ide-cd.c functions used by ide-cd_ioctl.c */
-void ide_cd_init_rq(ide_drive_t *, struct request *);
 int ide_cd_queue_pc(ide_drive_t *, const unsigned char *, int, void *, unsigned,
 		    struct request_sense *, int, unsigned int);
 int ide_cd_read_toc(ide_drive_t *, struct request_sense *);
-- 
1.5.4.2

