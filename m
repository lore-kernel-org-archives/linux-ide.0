From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 12/18] ide-cd: move request prep chunk from cdrom_do_newpc_cont to rq issue path
Date: Thu, 12 Jun 2008 08:41:04 +0200
Message-ID: <1213252870-20474-13-git-send-email-petkovbb@gmail.com>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757999AbYFLGr7@vger.kernel.org>
In-Reply-To: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>
List-Id: linux-ide@vger.kernel.org

Bart: As a nice side effect, this minimizes the IRQ handler execution time.

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index a5715b1..0cd23d4 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1167,9 +1167,6 @@ static ide_startstop_t cdrom_do_newpc_cont(ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
 
-	if (!rq->timeout)
-		rq->timeout = ATAPI_WAIT_PC;
-
 	return cdrom_transfer_packet_command(drive, rq, cdrom_newpc_intr);
 }
 
@@ -1253,11 +1250,18 @@ static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 		}
 		info->last_block = block;
 
-	} else if (blk_sense_request(rq) || blk_pc_request(rq) ||
+	} else if (blk_sense_request(rq) ||
+		   blk_pc_request(rq) ||
 		   rq->cmd_type == REQ_TYPE_ATA_PC) {
+
 		xferlen = rq->data_len;
 		fn = cdrom_do_newpc_cont;
+
+		if (!rq->timeout)
+			rq->timeout = ATAPI_WAIT_PC;
+
 		cdrom_do_block_pc(drive, rq);
+
 	} else if (blk_special_request(rq)) {
 		/* right now this can only be a reset... */
 		cdrom_end_request(drive, 1);
@@ -1271,8 +1275,6 @@ static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 	return cdrom_start_packet_command(drive, xferlen, fn);
 }
 
-
-
 /*
  * Ioctl handling.
  *
-- 
1.5.5.1
