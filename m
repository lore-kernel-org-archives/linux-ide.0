From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 2/3] block: add blk_rq_drain_size() API
Date: Mon, 04 Feb 2008 10:40:04 -0600
Message-ID: <1202143204.3096.31.camel@localhost.localdomain>
References: <1202142930.3096.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1202142930.3096.29.camel@localhost.localdomain>
Sender: linux-scsi-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Jens Axboe <Jens.Axboe@oracle.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-scsi <linux-scsi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/blkdev.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 90392a9..a526066 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -676,6 +676,11 @@ extern void blk_complete_request(struct request *);
 extern unsigned int blk_rq_bytes(struct request *rq);
 extern unsigned int blk_rq_cur_bytes(struct request *rq);
 
+static inline int blk_rq_drain_size(struct request *rq)
+{
+	return rq->q->dma_drain_size;
+}
+
 static inline void blkdev_dequeue_request(struct request *req)
 {
 	elv_dequeue_request(req->q, req);
-- 
1.5.3.8



