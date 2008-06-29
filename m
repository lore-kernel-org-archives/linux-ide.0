From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 09/16] ide-scsi: pass packet command in rq->cmd
Date: Sun, 29 Jun 2008 12:59:12 +0200
Message-ID: <1214737159-1078-10-git-send-email-petkovbb@gmail.com>
References: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:56179 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309AbYF2K7P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jun 2008 06:59:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so564619fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 29 Jun 2008 03:59:14 -0700 (PDT)
In-Reply-To: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Make a redundant copy of the packet command bits into rq->cmd.
Later, after all drivers have been converted, it'll be
switched to use that in the common code instead of pc->c.

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/scsi/ide-scsi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index a6c2c5f..c637520 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -236,6 +236,7 @@ static int idescsi_check_condition(ide_drive_t *drive,
 		ide_scsi_hex_dump(pc->c, 6);
 	}
 	rq->rq_disk = scsi->disk;
+	memcpy(rq->cmd, pc->c, 12);
 	ide_do_drive_cmd(drive, rq);
 	return 0;
 }
@@ -646,6 +647,7 @@ static int idescsi_queue (struct scsi_cmnd *cmd,
 	rq->special = (char *) pc;
 	rq->cmd_type = REQ_TYPE_SPECIAL;
 	spin_unlock_irq(host->host_lock);
+	memcpy(rq->cmd, pc->c, 12);
 	blk_execute_rq_nowait(drive->queue, scsi->disk, rq, 0, NULL);
 	spin_lock_irq(host->host_lock);
 	return 0;
-- 
1.5.5.4

