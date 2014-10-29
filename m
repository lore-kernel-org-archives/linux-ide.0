From: "Jason B. Akers" <jason.b.akers@intel.com>
Subject: [RFC PATCH 3/5] block: untangle ioprio from BLK_CGROUP and
 BLK_DEV_THROTTLING
Date: Wed, 29 Oct 2014 11:23:58 -0700
Message-ID: <20141029182358.4879.86399.stgit@stg-AndroidDev-VirtualBox>
References: <20141029180454.4879.75088.stgit@stg-AndroidDev-VirtualBox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141029180454.4879.75088.stgit@stg-AndroidDev-VirtualBox>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: axboe@fb.com, dan.j.williams@intel.com, kapil.karkra@intel.com, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

If BLK_CGROUP is disabled, still enable ionice to set advice on bios.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jason B. Akers <jason.b.akers@intel.com>
---
 block/bio.c         |   43 +++++++++++---------------------
 block/blk.h         |    2 ++
 include/linux/bio.h |   68 +++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 79 insertions(+), 34 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e133b5c..b93ae04 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1980,7 +1980,6 @@ struct bio_set *bioset_create_nobvec(unsigned int pool_size, unsigned int front_
 }
 EXPORT_SYMBOL(bioset_create_nobvec);
 
-#ifdef CONFIG_BLK_CGROUP
 /**
  * bio_associate_current - associate a bio with %current
  * @bio: target bio
@@ -1989,34 +1988,28 @@ EXPORT_SYMBOL(bioset_create_nobvec);
  * layer will treat @bio as if it were issued by %current no matter which
  * task actually issues it.
  *
- * This function takes an extra reference of @task's io_context and blkcg
- * which will be put when @bio is released.  The caller must own @bio,
- * ensure %current->io_context exists, and is responsible for synchronizing
- * calls to this function.
+ * When BLK_CGROUP=y this function takes an extra reference of @task's
+ * io_context and blkcg which will be put when @bio is released.  The caller
+ * must own @bio, ensure %current->io_context exists, and is responsible for
+ * synchronizing calls to this function.
+ *
+ * When BLK_CGROUP=n this function simply sets the bio priority and cache advice
  */
 int bio_associate_current(struct bio *bio)
 {
 	struct io_context *ioc;
-	struct cgroup_subsys_state *css;
-
-	if (bio->bi_ioc)
-		return -EBUSY;
+	int rc;
 
 	ioc = current->io_context;
 	if (!ioc)
 		return -ENOENT;
 
-	/* acquire active ref on @ioc and associate */
-	get_io_context_active(ioc);
-	bio->bi_ioc = ioc;
-	bio_set_prio(bio, ioprio_best(ioc->ioprio, bio_prio(bio)));
+	rc = bio_associate_ioc(bio, ioc);
+	if (rc)
+		return rc;
 
-	/* associate blkcg if exists */
-	rcu_read_lock();
-	css = task_css(current, blkio_cgrp_id);
-	if (css && css_tryget_online(css))
-		bio->bi_css = css;
-	rcu_read_unlock();
+	bio_associate_blkcg(bio, current);
+	bio_set_prio(bio, ioprio_best(ioc->ioprio, bio_prio(bio)));
 
 	return 0;
 }
@@ -2027,18 +2020,10 @@ int bio_associate_current(struct bio *bio)
  */
 void bio_disassociate_task(struct bio *bio)
 {
-	if (bio->bi_ioc) {
-		put_io_context(bio->bi_ioc);
-		bio->bi_ioc = NULL;
-	}
-	if (bio->bi_css) {
-		css_put(bio->bi_css);
-		bio->bi_css = NULL;
-	}
+	bio_disassociate_ioc(bio);
+	bio_disassociate_blkcg(bio);
 }
 
-#endif /* CONFIG_BLK_CGROUP */
-
 static void __init biovec_init_slabs(void)
 {
 	int i;
diff --git a/block/blk.h b/block/blk.h
index 43b0361..6d7c4df 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -274,6 +274,8 @@ extern void blk_throtl_exit(struct request_queue *q);
 #else /* CONFIG_BLK_DEV_THROTTLING */
 static inline bool blk_throtl_bio(struct request_queue *q, struct bio *bio)
 {
+	/* set prio, but don't throttle */
+	bio_associate_current(bio);
 	return false;
 }
 static inline void blk_throtl_drain(struct request_queue *q) { }
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7347f48..8419319 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -22,6 +22,7 @@
 
 #include <linux/highmem.h>
 #include <linux/mempool.h>
+#include <linux/cgroup.h>
 #include <linux/ioprio.h>
 #include <linux/bug.h>
 
@@ -469,13 +470,70 @@ extern struct bio_vec *bvec_alloc(gfp_t, int, unsigned long *, mempool_t *);
 extern void bvec_free(mempool_t *, struct bio_vec *, unsigned int);
 extern unsigned int bvec_nr_vecs(unsigned short idx);
 
-#ifdef CONFIG_BLK_CGROUP
 int bio_associate_current(struct bio *bio);
 void bio_disassociate_task(struct bio *bio);
-#else	/* CONFIG_BLK_CGROUP */
-static inline int bio_associate_current(struct bio *bio) { return -ENOENT; }
-static inline void bio_disassociate_task(struct bio *bio) { }
-#endif	/* CONFIG_BLK_CGROUP */
+
+#ifdef CONFIG_BLK_CGROUP
+static inline int bio_associate_ioc(struct bio *bio, struct io_context *ioc)
+{
+	if (bio->bi_ioc)
+		return -EBUSY;
+
+	/* acquire active ref on @ioc and associate */
+	get_io_context_active(ioc);
+	bio->bi_ioc = ioc;
+
+	return 0;
+}
+
+static inline void bio_associate_blkcg(struct bio *bio,
+					struct task_struct *task)
+{
+	struct cgroup_subsys_state *css;
+
+	/* associate blkcg if exists */
+	rcu_read_lock();
+	css = task_css(task, blkio_cgrp_id);
+	if (css && css_tryget(css))
+		bio->bi_css = css;
+	rcu_read_unlock();
+}
+
+static inline void bio_disassociate_ioc(struct bio *bio)
+{
+	if (bio->bi_ioc) {
+		put_io_context(bio->bi_ioc);
+		bio->bi_ioc = NULL;
+	}
+}
+
+static inline void bio_disassociate_blkcg(struct bio *bio)
+{
+	if (bio->bi_css) {
+		css_put(bio->bi_css);
+		bio->bi_css = NULL;
+	}
+}
+#else
+static inline int bio_associate_ioc(struct bio *bio, struct io_context *ioc)
+{
+	return 0;
+}
+
+static inline void bio_associate_blkcg(struct bio *bio,
+					struct task_struct *task)
+{
+}
+
+static inline void bio_disassociate_ioc(struct bio *bio)
+{
+}
+
+static inline void bio_disassociate_blkcg(struct bio *bio)
+{
+}
+
+#endif
 
 #ifdef CONFIG_HIGHMEM
 /*
