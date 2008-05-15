From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH 1/2] ide-scsi: replace ide_do_drive_cmd with blk_execute_rq_nowait
Date: Thu, 15 May 2008 09:05:57 +0900
Message-ID: <1210809958-13881-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1210809958-13881-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo10.iij4u.or.jp ([210.138.174.78]:33749 "EHLO mo10.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759846AbYEOAGY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 May 2008 20:06:24 -0400
In-Reply-To: <1210809958-13881-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

All the callers of ide_do_drive_cmd() except for ide-scsi use
ide_preempt action argument. This converts ide-scsi to use
blk_execute_rq_nowait instead of ide_do_drive_cmd so that we can
remove the action argument in ide_do_drive_cmd and ide_action_t
typedef.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Borislav Petkov <petkovbb@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/scsi/ide-scsi.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index d7fd5e5..58e30ef 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -790,8 +790,7 @@ static int idescsi_queue (struct scsi_cmnd *cmd,
 	rq->special = (char *) pc;
 	rq->cmd_type = REQ_TYPE_SPECIAL;
 	spin_unlock_irq(host->host_lock);
-	rq->rq_disk = scsi->disk;
-	(void) ide_do_drive_cmd (drive, rq, ide_end);
+	blk_execute_rq_nowait(drive->queue, scsi->disk, rq, 0, NULL);
 	spin_lock_irq(host->host_lock);
 	return 0;
 abort:
-- 
1.5.4.2

