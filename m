From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 06/16] ide-floppy: pass packet command in rq->cmd
Date: Sun, 29 Jun 2008 12:59:09 +0200
Message-ID: <1214737159-1078-7-git-send-email-petkovbb@gmail.com>
References: <1214737159-1078-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:56959 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143AbYF2K7P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jun 2008 06:59:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so564623fgg.17
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
 drivers/ide/ide-floppy.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index b5b3191..37146d3 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -291,6 +291,7 @@ static void idefloppy_queue_pc_head(ide_drive_t *drive, struct ide_atapi_pc *pc,
 	rq->cmd_type = REQ_TYPE_SPECIAL;
 	rq->cmd_flags |= REQ_PREEMPT;
 	rq->rq_disk = floppy->disk;
+	memcpy(rq->cmd, pc->c, 12);
 	ide_do_drive_cmd(drive, rq);
 }
 
@@ -573,6 +574,8 @@ static void idefloppy_create_rw_cmd(idefloppy_floppy_t *floppy,
 	put_unaligned(cpu_to_be16(blocks), (unsigned short *)&pc->c[7]);
 	put_unaligned(cpu_to_be32(block), (unsigned int *) &pc->c[2]);
 
+	memcpy(rq->cmd, pc->c, 12);
+
 	pc->rq = rq;
 	pc->b_count = cmd == READ ? 0 : rq->bio->bi_size;
 	if (rq->cmd_flags & REQ_RW)
@@ -670,6 +673,7 @@ static int idefloppy_queue_pc_tail(ide_drive_t *drive, struct ide_atapi_pc *pc)
 	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
 	rq->buffer = (char *) pc;
 	rq->cmd_type = REQ_TYPE_SPECIAL;
+	memcpy(rq->cmd, pc->c, 12);
 	error = blk_execute_rq(drive->queue, floppy->disk, rq, 0);
 	blk_put_request(rq);
 
-- 
1.5.5.4

