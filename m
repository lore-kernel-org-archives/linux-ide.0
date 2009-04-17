From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/15] ide-floppy: block pc always uses bio
Date: Fri, 17 Apr 2009 18:33:14 +0900
Message-ID: <1239960802-31978-8-git-send-email-tj@kernel.org>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39986 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759134AbZDQJdo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 05:33:44 -0400
In-Reply-To: <1239960802-31978-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Impact: remove unnecessary code path

Block pc requests always use bio and rq->data is always NULL.  No need
to worry about !rq->bio cases in idefloppy_block_pc_cmd().  Note that
ide-atapi uses ide_pio_bytes() for bio PIO transfer which handle sg
fine.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/ide/ide-floppy.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 2b4868d..3b22e06 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -216,15 +216,13 @@ static void idefloppy_blockpc_cmd(struct ide_disk_obj *floppy,
 	ide_init_pc(pc);
 	memcpy(pc->c, rq->cmd, sizeof(pc->c));
 	pc->rq = rq;
-	if (rq->data_len && rq_data_dir(rq) == WRITE)
-		pc->flags |= PC_FLAG_WRITING;
-	pc->buf = rq->data;
-	if (rq->bio)
+	if (rq->data_len) {
 		pc->flags |= PC_FLAG_DMA_OK;
-	/*
-	 * possibly problematic, doesn't look like ide-floppy correctly
-	 * handled scattered requests if dma fails...
-	 */
+		if (rq_data_dir(rq) == WRITE)
+			pc->flags |= PC_FLAG_WRITING;
+	}
+	/* pio will be performed by ide_pio_bytes() which handles sg fine */
+	pc->buf = NULL;
 	pc->req_xfer = pc->buf_size = rq->data_len;
 }
 
-- 
1.6.0.2

