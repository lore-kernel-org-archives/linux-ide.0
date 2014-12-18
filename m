From: Shaohua Li <shli@fb.com>
Subject: [PATCH v2 2/3] blk-mq: add tag allocation policy
Date: Thu, 18 Dec 2014 10:46:21 -0800
Message-ID: <be6eb099c483f26e63dc43080055e7644bc2bcad.1418928090.git.shli@fb.com>
References: <e8fb0a8f15f291f6dae88d51295432a2fa7ad71b.1418928090.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45079 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751057AbaLRSq1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2014 13:46:27 -0500
Received: from pps.filterd (m0004347 [127.0.0.1])
	by m0004347.ppops.net (8.14.5/8.14.5) with SMTP id sBIIk4ZZ020910
	for <linux-ide@vger.kernel.org>; Thu, 18 Dec 2014 10:46:26 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
	by m0004347.ppops.net with ESMTP id 1rc4g6r01n-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
	for <linux-ide@vger.kernel.org>; Thu, 18 Dec 2014 10:46:26 -0800
Received: from facebook.com (2401:db00:20:7003:face:0:4d:0)	by
 mx-out.facebook.com (10.223.101.97) with ESMTP	id
 29bbf04a86e611e4a6b324be0595f910-cf7f5390 for <linux-ide@vger.kernel.org>;
	Thu, 18 Dec 2014 10:46:23 -0800
In-Reply-To: <e8fb0a8f15f291f6dae88d51295432a2fa7ad71b.1418928090.git.shli@fb.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Kernel-team@fb.com, Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@infradead.org>

This is the blk-mq part to support tag allocation policy. The default
allocation policy isn't changed (though it's not a strict FIFO). The new
policy is round-robin for libata. But it's a try-best implementation. If
multiple tasks are competing, the tags returned will be mixed (which is
unavoidable even with !mq, as requests from different tasks can be
mixed in queue)

Cc: Jens Axboe <axboe@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-mq-tag.c      | 35 +++++++++++++++++++++++++----------
 block/blk-mq-tag.h      |  4 +++-
 block/blk-mq.c          |  3 ++-
 drivers/scsi/scsi_lib.c |  2 ++
 include/linux/blk-mq.h  |  8 ++++++++
 5 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 32e8dbb..d4d7fa1 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -134,10 +134,13 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	return atomic_read(&hctx->nr_active) < depth;
 }
 
-static int __bt_get_word(struct blk_align_bitmap *bm, unsigned int last_tag)
+#define BT_ALLOC_RR(bt) (atomic_read(&bt->rr_next) != -1)
+
+static int __bt_get_word(struct blk_align_bitmap *bm, unsigned int last_tag,
+			 bool nowrap)
 {
 	int tag, org_last_tag, end;
-	bool wrap = last_tag != 0;
+	bool wrap = last_tag != 0 && !nowrap;
 
 	org_last_tag = last_tag;
 	end = bm->depth;
@@ -183,11 +186,15 @@ static int __bt_get(struct blk_mq_hw_ctx *hctx, struct blk_mq_bitmap_tags *bt,
 	if (!hctx_may_queue(hctx, bt))
 		return -1;
 
-	last_tag = org_last_tag = *tag_cache;
+	if (unlikely(BT_ALLOC_RR(bt)))
+		last_tag = org_last_tag = atomic_read(&bt->rr_next);
+	else
+		last_tag = org_last_tag = *tag_cache;
 	index = TAG_TO_INDEX(bt, last_tag);
 
 	for (i = 0; i < bt->map_nr; i++) {
-		tag = __bt_get_word(&bt->map[index], TAG_TO_BIT(bt, last_tag));
+		tag = __bt_get_word(&bt->map[index], TAG_TO_BIT(bt, last_tag),
+				    BT_ALLOC_RR(bt));
 		if (tag != -1) {
 			tag += (index << bt->bits_per_word);
 			goto done;
@@ -206,6 +213,8 @@ static int __bt_get(struct blk_mq_hw_ctx *hctx, struct blk_mq_bitmap_tags *bt,
 	 * up using the specific cached tag.
 	 */
 done:
+	if (unlikely(BT_ALLOC_RR(bt)))
+		atomic_set(&bt->rr_next, (tag + 1) % bt->depth);
 	if (tag == org_last_tag) {
 		last_tag = tag + 1;
 		if (last_tag >= bt->depth - 1)
@@ -463,7 +472,7 @@ static void bt_update_count(struct blk_mq_bitmap_tags *bt,
 }
 
 static int bt_alloc(struct blk_mq_bitmap_tags *bt, unsigned int depth,
-			int node, bool reserved)
+			int node, bool reserved, int alloc_policy)
 {
 	int i;
 
@@ -513,6 +522,10 @@ static int bt_alloc(struct blk_mq_bitmap_tags *bt, unsigned int depth,
 		atomic_set(&bt->bs[i].wait_cnt, bt->wake_cnt);
 	}
 
+	if (alloc_policy == BLK_TAG_ALLOC_RR)
+		atomic_set(&bt->rr_next, 0);
+	else
+		atomic_set(&bt->rr_next, -1);
 	return 0;
 }
 
@@ -523,13 +536,14 @@ static void bt_free(struct blk_mq_bitmap_tags *bt)
 }
 
 static struct blk_mq_tags *blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
-						   int node)
+						   int node, int alloc_policy)
 {
 	unsigned int depth = tags->nr_tags - tags->nr_reserved_tags;
 
-	if (bt_alloc(&tags->bitmap_tags, depth, node, false))
+	if (bt_alloc(&tags->bitmap_tags, depth, node, false, alloc_policy))
 		goto enomem;
-	if (bt_alloc(&tags->breserved_tags, tags->nr_reserved_tags, node, true))
+	if (bt_alloc(&tags->breserved_tags, tags->nr_reserved_tags, node,
+		     true, alloc_policy))
 		goto enomem;
 
 	return tags;
@@ -540,7 +554,8 @@ static struct blk_mq_tags *blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
 }
 
 struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
-				     unsigned int reserved_tags, int node)
+				     unsigned int reserved_tags,
+				     int node, int alloc_policy)
 {
 	struct blk_mq_tags *tags;
 
@@ -556,7 +571,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
 
-	return blk_mq_init_bitmap_tags(tags, node);
+	return blk_mq_init_bitmap_tags(tags, node, alloc_policy);
 }
 
 void blk_mq_free_tags(struct blk_mq_tags *tags)
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 6206ed1..3ffa336 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -26,6 +26,8 @@ struct blk_mq_bitmap_tags {
 
 	atomic_t wake_index;
 	struct bt_wait_state *bs;
+
+	atomic_t rr_next;
 };
 
 /*
@@ -45,7 +47,7 @@ struct blk_mq_tags {
 };
 
 
-extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int reserved_tags, int node);
+extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int reserved_tags, int node, int alloc_policy);
 extern void blk_mq_free_tags(struct blk_mq_tags *tags);
 
 extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index da1ab56..7bf3656 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1359,7 +1359,8 @@ static struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
 	size_t rq_size, left;
 
 	tags = blk_mq_init_tags(set->queue_depth, set->reserved_tags,
-				set->numa_node);
+				set->numa_node,
+				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags));
 	if (!tags)
 		return NULL;
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 43318d5..7fd8d17 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2186,6 +2186,8 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 	shost->tag_set.cmd_size = cmd_size;
 	shost->tag_set.numa_node = NUMA_NO_NODE;
 	shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
+	shost->tag_set.flags |=
+		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
 	shost->tag_set.driver_data = shost;
 
 	return blk_mq_alloc_tag_set(&shost->tag_set);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8aded9a..b4bf93a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -147,6 +147,8 @@ enum {
 	BLK_MQ_F_SG_MERGE	= 1 << 2,
 	BLK_MQ_F_SYSFS_UP	= 1 << 3,
 	BLK_MQ_F_DEFER_ISSUE	= 1 << 4,
+	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
+	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 
 	BLK_MQ_S_STOPPED	= 0,
 	BLK_MQ_S_TAG_ACTIVE	= 1,
@@ -155,6 +157,12 @@ enum {
 
 	BLK_MQ_CPU_WORK_BATCH	= 8,
 };
+#define BLK_MQ_FLAG_TO_ALLOC_POLICY(flags) \
+	((flags >> BLK_MQ_F_ALLOC_POLICY_START_BIT) & \
+		((1 << BLK_MQ_F_ALLOC_POLICY_BITS) - 1))
+#define BLK_ALLOC_POLICY_TO_MQ_FLAG(policy) \
+	((policy & ((1 << BLK_MQ_F_ALLOC_POLICY_BITS) - 1)) \
+		<< BLK_MQ_F_ALLOC_POLICY_START_BIT)
 
 struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *);
 void blk_mq_finish_init(struct request_queue *q);
-- 
1.8.1

