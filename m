From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH v2 02/13] ide-cd: convert ide_do_drive_cmd path to use blk_execute_rq
Date: Thu,  1 May 2008 21:27:59 +0900
Message-ID: <1209644890-12040-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1209644890-12040-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1209644890-12040-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:42765 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754999AbYEAM36 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2008 08:29:58 -0400
In-Reply-To: <1209644890-12040-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jens.axboe@oracle.com, bzolnier@gmail.com, petkovbb@gmail.com, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

This converts the ide_do_drive_cmd path using ide_wait to use
blk_execute_rq.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Borislav Petkov <petkovbb@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd_ioctl.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index 9c044da..4571b4f 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -295,14 +295,14 @@ int ide_cdrom_reset(struct cdrom_device_info *cdi)
 	ide_drive_t *drive = cdi->handle;
 	struct cdrom_info *cd = drive->driver_data;
 	struct request_sense sense;
-	struct request req;
+	struct request *rq;
 	int ret;
 
-	ide_cd_init_rq(drive, &req);
-	req.cmd_type = REQ_TYPE_SPECIAL;
-	req.cmd_flags = REQ_QUIET;
-	ret = ide_do_drive_cmd(drive, &req, ide_wait);
-
+	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	rq->cmd_type = REQ_TYPE_SPECIAL;
+	rq->cmd_flags = REQ_QUIET;
+	ret = blk_execute_rq(drive->queue, cd->disk, rq, 0);
+	blk_put_request(rq);
 	/*
 	 * A reset will unlock the door. If it was previously locked,
 	 * lock it again.
-- 
1.5.4.2

