From: Shaohua Li <shli@fb.com>
Subject: [PATCH v2 1/3] block: support different tag allocation policy
Date: Thu, 18 Dec 2014 10:46:20 -0800
Message-ID: <e8fb0a8f15f291f6dae88d51295432a2fa7ad71b.1418928090.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36241 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751215AbaLRSq1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2014 13:46:27 -0500
Received: from pps.filterd (m0004348 [127.0.0.1])
	by m0004348.ppops.net (8.14.5/8.14.5) with SMTP id sBIIhhF8029800
	for <linux-ide@vger.kernel.org>; Thu, 18 Dec 2014 10:46:27 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
	by m0004348.ppops.net with ESMTP id 1rc39607ej-4
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
	for <linux-ide@vger.kernel.org>; Thu, 18 Dec 2014 10:46:26 -0800
Received: from facebook.com (2401:db00:20:7003:face:0:4d:0)	by
 mx-out.facebook.com (10.223.100.99) with ESMTP	id
 29b5966486e611e4bdbf24be05956610-8dfd6390 for <linux-ide@vger.kernel.org>;
	Thu, 18 Dec 2014 10:46:23 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Kernel-team@fb.com, Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@infradead.org>

The libata tag allocation is using a round-robin policy. Next patch will
make libata use block generic tag allocation, so let's add a policy to
tag allocation.

Currently two policies: FIFO (default) and round-robin.

Cc: Jens Axboe <axboe@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-tag.c          | 33 +++++++++++++++++++++++++--------
 drivers/block/osdblk.c   |  2 +-
 drivers/scsi/scsi_scan.c |  3 ++-
 include/linux/blkdev.h   |  8 ++++++--
 include/scsi/scsi_host.h |  3 +++
 include/scsi/scsi_tcq.h  |  3 ++-
 6 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/block/blk-tag.c b/block/blk-tag.c
index a185b86..f0344e6 100644
--- a/block/blk-tag.c
+++ b/block/blk-tag.c
@@ -119,7 +119,7 @@ init_tag_map(struct request_queue *q, struct blk_queue_tag *tags, int depth)
 }
 
 static struct blk_queue_tag *__blk_queue_init_tags(struct request_queue *q,
-						   int depth)
+						int depth, int alloc_policy)
 {
 	struct blk_queue_tag *tags;
 
@@ -131,6 +131,8 @@ static struct blk_queue_tag *__blk_queue_init_tags(struct request_queue *q,
 		goto fail;
 
 	atomic_set(&tags->refcnt, 1);
+	tags->alloc_policy = alloc_policy;
+	tags->next_tag = 0;
 	return tags;
 fail:
 	kfree(tags);
@@ -140,10 +142,11 @@ static struct blk_queue_tag *__blk_queue_init_tags(struct request_queue *q,
 /**
  * blk_init_tags - initialize the tag info for an external tag map
  * @depth:	the maximum queue depth supported
+ * @alloc_policy: tag allocation policy
  **/
-struct blk_queue_tag *blk_init_tags(int depth)
+struct blk_queue_tag *blk_init_tags(int depth, int alloc_policy)
 {
-	return __blk_queue_init_tags(NULL, depth);
+	return __blk_queue_init_tags(NULL, depth, alloc_policy);
 }
 EXPORT_SYMBOL(blk_init_tags);
 
@@ -152,19 +155,20 @@ EXPORT_SYMBOL(blk_init_tags);
  * @q:  the request queue for the device
  * @depth:  the maximum queue depth supported
  * @tags: the tag to use
+ * @alloc_policy: tag allocation policy
  *
  * Queue lock must be held here if the function is called to resize an
  * existing map.
  **/
 int blk_queue_init_tags(struct request_queue *q, int depth,
-			struct blk_queue_tag *tags)
+			struct blk_queue_tag *tags, int alloc_policy)
 {
 	int rc;
 
 	BUG_ON(tags && q->queue_tags && tags != q->queue_tags);
 
 	if (!tags && !q->queue_tags) {
-		tags = __blk_queue_init_tags(q, depth);
+		tags = __blk_queue_init_tags(q, depth, alloc_policy);
 
 		if (!tags)
 			return -ENOMEM;
@@ -344,9 +348,21 @@ int blk_queue_start_tag(struct request_queue *q, struct request *rq)
 	}
 
 	do {
-		tag = find_first_zero_bit(bqt->tag_map, max_depth);
-		if (tag >= max_depth)
-			return 1;
+		if (bqt->alloc_policy == BLK_TAG_ALLOC_FIFO) {
+			tag = find_first_zero_bit(bqt->tag_map, max_depth);
+			if (tag >= max_depth)
+				return 1;
+		} else {
+			int start = bqt->next_tag;
+			int size = min_t(int, bqt->max_depth, max_depth + start);
+			tag = find_next_zero_bit(bqt->tag_map, size, start);
+			if (tag >= size && start + size > bqt->max_depth) {
+				size = start + size - bqt->max_depth;
+				tag = find_first_zero_bit(bqt->tag_map, size);
+			}
+			if (tag >= size)
+				return 1;
+		}
 
 	} while (test_and_set_bit_lock(tag, bqt->tag_map));
 	/*
@@ -354,6 +370,7 @@ int blk_queue_start_tag(struct request_queue *q, struct request *rq)
 	 * See blk_queue_end_tag for details.
 	 */
 
+	bqt->next_tag = (tag + 1) % bqt->max_depth;
 	rq->cmd_flags |= REQ_QUEUED;
 	rq->tag = tag;
 	bqt->tag_index[tag] = rq;
diff --git a/drivers/block/osdblk.c b/drivers/block/osdblk.c
index 79aa179..e229425 100644
--- a/drivers/block/osdblk.c
+++ b/drivers/block/osdblk.c
@@ -423,7 +423,7 @@ static int osdblk_init_disk(struct osdblk_device *osdev)
 	}
 
 	/* switch queue to TCQ mode; allocate tag map */
-	rc = blk_queue_init_tags(q, OSDBLK_MAX_REQ, NULL);
+	rc = blk_queue_init_tags(q, OSDBLK_MAX_REQ, NULL, BLK_TAG_ALLOC_FIFO);
 	if (rc) {
 		blk_cleanup_queue(q);
 		put_disk(disk);
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 983aed1..921a8c8 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -290,7 +290,8 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	if (!shost_use_blk_mq(sdev->host) &&
 	    (shost->bqt || shost->hostt->use_blk_tags)) {
 		blk_queue_init_tags(sdev->request_queue,
-				    sdev->host->cmd_per_lun, shost->bqt);
+				    sdev->host->cmd_per_lun, shost->bqt,
+				    shost->hostt->tag_alloc_policy);
 	}
 	scsi_change_queue_depth(sdev, sdev->host->cmd_per_lun);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 92f4b4b..38b095d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -272,7 +272,11 @@ struct blk_queue_tag {
 	int max_depth;			/* what we will send to device */
 	int real_max_depth;		/* what the array can hold */
 	atomic_t refcnt;		/* map can be shared */
+	int alloc_policy;		/* tag allocation policy */
+	int next_tag;			/* next tag */
 };
+#define BLK_TAG_ALLOC_FIFO 0 /* allocate starting from 0 */
+#define BLK_TAG_ALLOC_RR 1 /* allocate starting from last allocated tag */
 
 #define BLK_SCSI_MAX_CMDS	(256)
 #define BLK_SCSI_CMD_PER_LONG	(BLK_SCSI_MAX_CMDS / (sizeof(long) * 8))
@@ -1139,11 +1143,11 @@ static inline bool blk_needs_flush_plug(struct task_struct *tsk)
 extern int blk_queue_start_tag(struct request_queue *, struct request *);
 extern struct request *blk_queue_find_tag(struct request_queue *, int);
 extern void blk_queue_end_tag(struct request_queue *, struct request *);
-extern int blk_queue_init_tags(struct request_queue *, int, struct blk_queue_tag *);
+extern int blk_queue_init_tags(struct request_queue *, int, struct blk_queue_tag *, int);
 extern void blk_queue_free_tags(struct request_queue *);
 extern int blk_queue_resize_tags(struct request_queue *, int);
 extern void blk_queue_invalidate_tags(struct request_queue *);
-extern struct blk_queue_tag *blk_init_tags(int);
+extern struct blk_queue_tag *blk_init_tags(int, int);
 extern void blk_free_tags(struct blk_queue_tag *);
 
 static inline struct request *blk_map_queue_find_tag(struct blk_queue_tag *bqt,
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index e939d2b..642884e 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -415,6 +415,9 @@ struct scsi_host_template {
 	 */
 	unsigned char present;
 
+	/* If use block layer to manage tags, this is tag allocation policy */
+	int tag_alloc_policy;
+
 	/*
 	 * Let the block layer assigns tags to all commands.
 	 */
diff --git a/include/scsi/scsi_tcq.h b/include/scsi/scsi_tcq.h
index fe4a702..80ae8f8 100644
--- a/include/scsi/scsi_tcq.h
+++ b/include/scsi/scsi_tcq.h
@@ -102,7 +102,8 @@ static inline int scsi_init_shared_tag_map(struct Scsi_Host *shost, int depth)
 	 * devices on the shared host (for libata)
 	 */
 	if (!shost->bqt) {
-		shost->bqt = blk_init_tags(depth);
+		shost->bqt = blk_init_tags(depth,
+			shost->hostt->tag_alloc_policy);
 		if (!shost->bqt)
 			return -ENOMEM;
 	}
-- 
1.8.1

