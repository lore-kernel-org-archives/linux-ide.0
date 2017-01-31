From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/10] mspro_block: remove pointless prep_fn
Date: Tue, 31 Jan 2017 16:57:26 +0100
Message-ID: <1485878251-6107-6-git-send-email-hch@lst.de>
References: <1485878251-6107-1-git-send-email-hch@lst.de>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1485878251-6107-1-git-send-email-hch@lst.de>
Sender: linux-scsi-owner@vger.kernel.org
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This driver will never see non-fs requests, and doesn't do anything
else in the prep_fn.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/memstick/core/mspro_block.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index fa0746d..c00d8a2 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -827,18 +827,6 @@ static void mspro_block_start(struct memstick_dev *card)
 	spin_unlock_irqrestore(&msb->q_lock, flags);
 }
 
-static int mspro_block_prepare_req(struct request_queue *q, struct request *req)
-{
-	if (req->cmd_type != REQ_TYPE_FS) {
-		blk_dump_rq_flags(req, "MSPro unsupported request");
-		return BLKPREP_KILL;
-	}
-
-	req->rq_flags |= RQF_DONTPREP;
-
-	return BLKPREP_OK;
-}
-
 static void mspro_block_submit_req(struct request_queue *q)
 {
 	struct memstick_dev *card = q->queuedata;
@@ -1228,7 +1216,6 @@ static int mspro_block_init_disk(struct memstick_dev *card)
 	}
 
 	msb->queue->queuedata = card;
-	blk_queue_prep_rq(msb->queue, mspro_block_prepare_req);
 
 	blk_queue_bounce_limit(msb->queue, limit);
 	blk_queue_max_hw_sectors(msb->queue, MSPRO_BLOCK_MAX_PAGES);
-- 
2.1.4

