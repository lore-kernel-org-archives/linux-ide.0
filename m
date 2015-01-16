From: Shaohua Li <shli@fb.com>
Subject: [PATCH v3 2/3] blk-mq: add tag allocation policy
Date: Thu, 15 Jan 2015 17:32:26 -0800
Message-ID: <f8cfbf4737483bf8f9ab887303ef6ac2f6111f1f.1421371412.git.shli@fb.com>
References: <81b8ef84122544faa1f37a404cf2e7c71791d961.1421371412.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42698 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754547AbbAPBcb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2015 20:32:31 -0500
Received: from pps.filterd (m0004346 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id t0G1TNX4027873
	for <linux-ide@vger.kernel.org>; Thu, 15 Jan 2015 17:32:31 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0a-00082601.pphosted.com with ESMTP id 1rxqn2r48c-3
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
	for <linux-ide@vger.kernel.org>; Thu, 15 Jan 2015 17:32:31 -0800
Received: from facebook.com (2401:db00:20:7003:face:0:4d:0)	by
 mx-out.facebook.com (10.212.232.63) with ESMTP	id
 885c627a9d1f11e4ac310002c992ebde-ce6d1390 for <linux-ide@vger.kernel.org>;
	Thu, 15 Jan 2015 17:32:28 -0800
In-Reply-To: <81b8ef84122544faa1f37a404cf2e7c71791d961.1421371412.git.shli@fb.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Kernel-team@fb.com, dan.j.williams@intel.com, Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@infradead.org>

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
 block/blk-mq-tag.c      | 39 ++++++++++++++++++++++++---------------
 block/blk-mq-tag.h      |  4 +++-
 block/blk-mq.c          |  3 ++-
 drivers/scsi/scsi_lib.c |  2 ++
 include/linux/blk-mq.h  |  8 ++++++++
 5 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 60c9d4a..231e1bc 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -140,10 +140,11 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	return atomic_read(&hctx->nr_active) < depth;
 }
 
-static int __bt_get_word(struct blk_align_bitmap *bm, unsigned int last_tag)
+static int __bt_get_word(struct blk_align_bitmap *bm, unsigned int last_tag,
+			 bool nowrap)
 {
 	int tag, org_last_tag, end;
-	bool wrap = last_tag != 0;
+	bool wrap = last_tag != 0 && !nowrap;
 
 	org_last_tag = last_tag;
 	end = bm->depth;
@@ -169,6 +170,8 @@ static int __bt_get_word(struct blk_align_bitmap *bm, unsigned int last_tag)
 	return tag;
 }
 
+#define BT_ALLOC_RR(tags) (tags->alloc_policy == BLK_TAG_ALLOC_RR)
+
 /*
  * Straight forward bitmap tag implementation, where each bit is a tag
  * (cleared == free, and set == busy). The small twist is using per-cpu
@@ -181,7 +184,7 @@ static int __bt_get_word(struct blk_align_bitmap *bm, unsigned int last_tag)
  * until the map is exhausted.
  */
 static int __bt_get(struct blk_mq_hw_ctx *hctx, struct blk_mq_bitmap_tags *bt,
-		    unsigned int *tag_cache)
+		    unsigned int *tag_cache, struct blk_mq_tags *tags)
 {
 	unsigned int last_tag, org_last_tag;
 	int index, i, tag;
@@ -193,7 +196,8 @@ static int __bt_get(struct blk_mq_hw_ctx *hctx, struct blk_mq_bitmap_tags *bt,
 	index = TAG_TO_INDEX(bt, last_tag);
 
 	for (i = 0; i < bt->map_nr; i++) {
-		tag = __bt_get_word(&bt->map[index], TAG_TO_BIT(bt, last_tag));
+		tag = __bt_get_word(&bt->map[index], TAG_TO_BIT(bt, last_tag),
+				    BT_ALLOC_RR(tags));
 		if (tag != -1) {
 			tag += (index << bt->bits_per_word);
 			goto done;
@@ -212,7 +216,7 @@ static int __bt_get(struct blk_mq_hw_ctx *hctx, struct blk_mq_bitmap_tags *bt,
 	 * up using the specific cached tag.
 	 */
 done:
-	if (tag == org_last_tag) {
+	if (tag == org_last_tag || unlikely(BT_ALLOC_RR(tags))) {
 		last_tag = tag + 1;
 		if (last_tag >= bt->depth - 1)
 			last_tag = 0;
@@ -241,13 +245,13 @@ static struct bt_wait_state *bt_wait_ptr(struct blk_mq_bitmap_tags *bt,
 static int bt_get(struct blk_mq_alloc_data *data,
 		struct blk_mq_bitmap_tags *bt,
 		struct blk_mq_hw_ctx *hctx,
-		unsigned int *last_tag)
+		unsigned int *last_tag, struct blk_mq_tags *tags)
 {
 	struct bt_wait_state *bs;
 	DEFINE_WAIT(wait);
 	int tag;
 
-	tag = __bt_get(hctx, bt, last_tag);
+	tag = __bt_get(hctx, bt, last_tag, tags);
 	if (tag != -1)
 		return tag;
 
@@ -258,7 +262,7 @@ static int bt_get(struct blk_mq_alloc_data *data,
 	do {
 		prepare_to_wait(&bs->wait, &wait, TASK_UNINTERRUPTIBLE);
 
-		tag = __bt_get(hctx, bt, last_tag);
+		tag = __bt_get(hctx, bt, last_tag, tags);
 		if (tag != -1)
 			break;
 
@@ -273,7 +277,7 @@ static int bt_get(struct blk_mq_alloc_data *data,
 		 * Retry tag allocation after running the hardware queue,
 		 * as running the queue may also have found completions.
 		 */
-		tag = __bt_get(hctx, bt, last_tag);
+		tag = __bt_get(hctx, bt, last_tag, tags);
 		if (tag != -1)
 			break;
 
@@ -304,7 +308,7 @@ static unsigned int __blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	int tag;
 
 	tag = bt_get(data, &data->hctx->tags->bitmap_tags, data->hctx,
-			&data->ctx->last_tag);
+			&data->ctx->last_tag, data->hctx->tags);
 	if (tag >= 0)
 		return tag + data->hctx->tags->nr_reserved_tags;
 
@@ -320,7 +324,8 @@ static unsigned int __blk_mq_get_reserved_tag(struct blk_mq_alloc_data *data)
 		return BLK_MQ_TAG_FAIL;
 	}
 
-	tag = bt_get(data, &data->hctx->tags->breserved_tags, NULL, &zero);
+	tag = bt_get(data, &data->hctx->tags->breserved_tags, NULL, &zero,
+		data->hctx->tags);
 	if (tag < 0)
 		return BLK_MQ_TAG_FAIL;
 
@@ -392,7 +397,8 @@ void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, unsigned int tag,
 
 		BUG_ON(real_tag >= tags->nr_tags);
 		bt_clear_tag(&tags->bitmap_tags, real_tag);
-		*last_tag = real_tag;
+		if (likely(tags->alloc_policy == BLK_TAG_ALLOC_FIFO))
+			*last_tag = real_tag;
 	} else {
 		BUG_ON(tag >= tags->nr_reserved_tags);
 		bt_clear_tag(&tags->breserved_tags, tag);
@@ -529,10 +535,12 @@ static void bt_free(struct blk_mq_bitmap_tags *bt)
 }
 
 static struct blk_mq_tags *blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
-						   int node)
+						   int node, int alloc_policy)
 {
 	unsigned int depth = tags->nr_tags - tags->nr_reserved_tags;
 
+	tags->alloc_policy = alloc_policy;
+
 	if (bt_alloc(&tags->bitmap_tags, depth, node, false))
 		goto enomem;
 	if (bt_alloc(&tags->breserved_tags, tags->nr_reserved_tags, node, true))
@@ -546,7 +554,8 @@ static struct blk_mq_tags *blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
 }
 
 struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
-				     unsigned int reserved_tags, int node)
+				     unsigned int reserved_tags,
+				     int node, int alloc_policy)
 {
 	struct blk_mq_tags *tags;
 
@@ -562,7 +571,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
 
-	return blk_mq_init_bitmap_tags(tags, node);
+	return blk_mq_init_bitmap_tags(tags, node, alloc_policy);
 }
 
 void blk_mq_free_tags(struct blk_mq_tags *tags)
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index a6fa0fc..90767b3 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -42,10 +42,12 @@ struct blk_mq_tags {
 
 	struct request **rqs;
 	struct list_head page_list;
+
+	int alloc_policy;
 };
 
 
-extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int reserved_tags, int node);
+extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int reserved_tags, int node, int alloc_policy);
 extern void blk_mq_free_tags(struct blk_mq_tags *tags);
 
 extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2f95747..fffbb83 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1423,7 +1423,8 @@ static struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
 	size_t rq_size, left;
 
 	tags = blk_mq_init_tags(set->queue_depth, set->reserved_tags,
-				set->numa_node);
+				set->numa_node,
+				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags));
 	if (!tags)
 		return NULL;
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 9ea95dd..49ab115 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2188,6 +2188,8 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 	shost->tag_set.cmd_size = cmd_size;
 	shost->tag_set.numa_node = NUMA_NO_NODE;
 	shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
+	shost->tag_set.flags |=
+		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
 	shost->tag_set.driver_data = shost;
 
 	return blk_mq_alloc_tag_set(&shost->tag_set);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 5735e71..623d61d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -146,6 +146,8 @@ enum {
 	BLK_MQ_F_SG_MERGE	= 1 << 2,
 	BLK_MQ_F_SYSFS_UP	= 1 << 3,
 	BLK_MQ_F_DEFER_ISSUE	= 1 << 4,
+	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
+	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 
 	BLK_MQ_S_STOPPED	= 0,
 	BLK_MQ_S_TAG_ACTIVE	= 1,
@@ -154,6 +156,12 @@ enum {
 
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

