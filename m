From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 3/3] ide-cd: shorten ide_cd_request_sense_fixup's param list
Date: Mon, 29 Sep 2008 08:29:59 +0200
Message-ID: <1222669799-6565-4-git-send-email-petkovbb@gmail.com>
References: <1222669799-6565-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:3130 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbYI2GaF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 02:30:05 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1881581fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 28 Sep 2008 23:30:03 -0700 (PDT)
In-Reply-To: <1222669799-6565-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

... since HWGROUP(drive)->rq points to the same rq as in the irq handler. While
at it, remove stale comment.

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index e41b94d..bf92cd6 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -843,12 +843,11 @@ static void ide_cd_restore_request(ide_drive_t *drive, struct request *rq)
 	rq->q->prep_rq_fn(rq->q, rq);
 }
 
-/*
- * All other packet commands.
- */
-static void ide_cd_request_sense_fixup(ide_drive_t *drive, struct request *rq)
+static void ide_cd_request_sense_fixup(ide_drive_t *drive)
 {
 
+	struct request *rq = HWGROUP(drive)->rq;
+
 	ide_debug_log(IDE_DBG_FUNC, "Call %s, rq->cmd[0]: 0x%x\n",
 		      __func__, rq->cmd[0]);
 
@@ -1021,7 +1020,7 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
 			cdrom_end_request(drive, uptodate);
 			return ide_stopped;
 		} else if (!blk_pc_request(rq)) {
-			ide_cd_request_sense_fixup(drive, rq);
+			ide_cd_request_sense_fixup(drive);
 			/* complain if we still have data left to transfer */
 			uptodate = rq->data_len ? 0 : 1;
 		}
-- 
1.5.5.4

