From: Shaohua Li <shli@fb.com>
Subject: Re: [PATCH v2 2/3] blk-mq: add tag allocation policy
Date: Fri, 2 Jan 2015 11:43:44 -0800
Message-ID: <20150102194344.GA2746087@devbig257.prn2.facebook.com>
References: <e8fb0a8f15f291f6dae88d51295432a2fa7ad71b.1418928090.git.shli@fb.com>
 <be6eb099c483f26e63dc43080055e7644bc2bcad.1418928090.git.shli@fb.com>
 <5498A85F.7090508@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34391 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750736AbbABToQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jan 2015 14:44:16 -0500
Content-Disposition: inline
In-Reply-To: <5498A85F.7090508@fb.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@fb.com>
Cc: linux-ide@vger.kernel.org, Kernel-team@fb.com, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@infradead.org>

On Mon, Dec 22, 2014 at 04:25:19PM -0700, Jens Axboe wrote:
> On 12/18/2014 11:46 AM, Shaohua Li wrote:
> >This is the blk-mq part to support tag allocation policy. The default
> >allocation policy isn't changed (though it's not a strict FIFO). The new
> >policy is round-robin for libata. But it's a try-best implementation. If
> >multiple tasks are competing, the tags returned will be mixed (which is
> >unavoidable even with !mq, as requests from different tasks can be
> >mixed in queue)
> 
> Can we get rid of the atomic_read() on non-rr? It's never set
> outside of initialization there.

How about this updated one? I'm not sure if a function pointer call is
faster than the condition statement I use in the patch (for different
policy), but if you prefer a function pointer, I can change it.


>From 3f722ee2cea2f8694157b92b6d1f068c15c36961 Mon Sep 17 00:00:00 2001
Message-Id: <3f722ee2cea2f8694157b92b6d1f068c15c36961.1420227455.git.shli@fb.com>
In-Reply-To: <01887310712e5ceb9ce7392f240ed311021fb779.1420227455.git.shli@fb.com>
References: <01887310712e5ceb9ce7392f240ed311021fb779.1420227455.git.shli@fb.com>
From: Shaohua Li <shli@fb.com>
Date: Tue, 16 Dec 2014 13:02:56 -0800
Subject: [PATCH 2/3] blk-mq: add tag allocation policy

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
index 32e8dbb..f9e751b 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -134,10 +134,11 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
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
@@ -163,6 +164,8 @@ static int __bt_get_word(struct blk_align_bitmap *bm, unsigned int last_tag)
 	return tag;
 }
 
+#define BT_ALLOC_RR(tags) (tags->alloc_policy == BLK_TAG_ALLOC_RR)
+
 /*
  * Straight forward bitmap tag implementation, where each bit is a tag
  * (cleared == free, and set == busy). The small twist is using per-cpu
@@ -175,7 +178,7 @@ static int __bt_get_word(struct blk_align_bitmap *bm, unsigned int last_tag)
  * until the map is exhausted.
  */
 static int __bt_get(struct blk_mq_hw_ctx *hctx, struct blk_mq_bitmap_tags *bt,
-		    unsigned int *tag_cache)
+		    unsigned int *tag_cache, struct blk_mq_tags *tags)
 {
 	unsigned int last_tag, org_last_tag;
 	int index, i, tag;
@@ -187,7 +190,8 @@ static int __bt_get(struct blk_mq_hw_ctx *hctx, struct blk_mq_bitmap_tags *bt,
 	index = TAG_TO_INDEX(bt, last_tag);
 
 	for (i = 0; i < bt->map_nr; i++) {
-		tag = __bt_get_word(&bt->map[index], TAG_TO_BIT(bt, last_tag));
+		tag = __bt_get_word(&bt->map[index], TAG_TO_BIT(bt, last_tag),
+				    BT_ALLOC_RR(tags));
 		if (tag != -1) {
 			tag += (index << bt->bits_per_word);
 			goto done;
@@ -206,7 +210,7 @@ static int __bt_get(struct blk_mq_hw_ctx *hctx, struct blk_mq_bitmap_tags *bt,
 	 * up using the specific cached tag.
 	 */
 done:
-	if (tag == org_last_tag) {
+	if (tag == org_last_tag || unlikely(BT_ALLOC_RR(tags))) {
 		last_tag = tag + 1;
 		if (last_tag >= bt->depth - 1)
 			last_tag = 0;
@@ -235,13 +239,13 @@ static struct bt_wait_state *bt_wait_ptr(struct blk_mq_bitmap_tags *bt,
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
 
@@ -252,7 +256,7 @@ static int bt_get(struct blk_mq_alloc_data *data,
 	do {
 		prepare_to_wait(&bs->wait, &wait, TASK_UNINTERRUPTIBLE);
 
-		tag = __bt_get(hctx, bt, last_tag);
+		tag = __bt_get(hctx, bt, last_tag, tags);
 		if (tag != -1)
 			break;
 
@@ -267,7 +271,7 @@ static int bt_get(struct blk_mq_alloc_data *data,
 		 * Retry tag allocation after running the hardware queue,
 		 * as running the queue may also have found completions.
 		 */
-		tag = __bt_get(hctx, bt, last_tag);
+		tag = __bt_get(hctx, bt, last_tag, tags);
 		if (tag != -1)
 			break;
 
@@ -298,7 +302,7 @@ static unsigned int __blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	int tag;
 
 	tag = bt_get(data, &data->hctx->tags->bitmap_tags, data->hctx,
-			&data->ctx->last_tag);
+			&data->ctx->last_tag, data->hctx->tags);
 	if (tag >= 0)
 		return tag + data->hctx->tags->nr_reserved_tags;
 
@@ -314,7 +318,8 @@ static unsigned int __blk_mq_get_reserved_tag(struct blk_mq_alloc_data *data)
 		return BLK_MQ_TAG_FAIL;
 	}
 
-	tag = bt_get(data, &data->hctx->tags->breserved_tags, NULL, &zero);
+	tag = bt_get(data, &data->hctx->tags->breserved_tags, NULL, &zero,
+		data->hctx->tags);
 	if (tag < 0)
 		return BLK_MQ_TAG_FAIL;
 
@@ -386,7 +391,8 @@ void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, unsigned int tag,
 
 		BUG_ON(real_tag >= tags->nr_tags);
 		bt_clear_tag(&tags->bitmap_tags, real_tag);
-		*last_tag = real_tag;
+		if (likely(tags->alloc_policy == BLK_TAG_ALLOC_FIFO))
+			*last_tag = real_tag;
 	} else {
 		BUG_ON(tag >= tags->nr_reserved_tags);
 		bt_clear_tag(&tags->breserved_tags, tag);
@@ -523,10 +529,12 @@ static void bt_free(struct blk_mq_bitmap_tags *bt)
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
@@ -540,7 +548,8 @@ static struct blk_mq_tags *blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
 }
 
 struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
-				     unsigned int reserved_tags, int node)
+				     unsigned int reserved_tags,
+				     int node, int alloc_policy)
 {
 	struct blk_mq_tags *tags;
 
@@ -556,7 +565,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
 
-	return blk_mq_init_bitmap_tags(tags, node);
+	return blk_mq_init_bitmap_tags(tags, node, alloc_policy);
 }
 
 void blk_mq_free_tags(struct blk_mq_tags *tags)
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 6206ed1..235e4c3 100644
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

