From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH 08/11] ide-cd: use blk_get_request in the ide_do_drive_cmd path
Date: Tue, 22 Apr 2008 09:26:39 +0900
Message-ID: <1208824002-3596-9-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
 <1208824002-3596-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo10.iij4u.or.jp ([210.138.174.78]:49530 "EHLO mo10.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759221AbYDVA2B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Apr 2008 20:28:01 -0400
In-Reply-To: <1208824002-3596-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This replaces struct request on the stack with blk_get_request in the
ide_do_drive_cmd path that uses ide_wait.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd_ioctl.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index 57dda1f..8739893 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -295,13 +295,14 @@ int ide_cdrom_reset(struct cdrom_device_info *cdi)
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
+	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	rq->rq_disk = cd->disk;
+	rq->cmd_type = REQ_TYPE_SPECIAL;
+	rq->cmd_flags = REQ_QUIET;
+	ret = ide_do_drive_cmd(drive, rq, ide_wait);
 	if (ret)
 		ret = -EIO;
 	/*
-- 
1.5.4.2

