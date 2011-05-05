From: shaohua.li@intel.com
Subject: [patch v3 1/3] block: add a non-queueable flush flag
Date: Thu, 05 May 2011 09:59:33 +0800
Message-ID: <20110505020417.586891398@sli10-conroe.sh.intel.com>
References: <20110505015932.306763905@sli10-conroe.sh.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=blk-nonqueueable-flush-flag.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: jaxboe@fusionio.com, htejun@gmail.com, hch@infradead.org, jgarzik@pobox.com, djwong@us.ibm.com, sshtylyov@mvista.com, Shaohua Li <shaohua.li@intel.com>
List-Id: linux-ide@vger.kernel.org

flush request isn't queueable in some drives. Add a flag to let driver
notify block layer about this. We can optimize flush performance with the
knowledge.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 block/blk-settings.c   |    6 ++++++
 include/linux/blkdev.h |    7 +++++++
 2 files changed, 13 insertions(+)

Index: linux/include/linux/blkdev.h
===================================================================
--- linux.orig/include/linux/blkdev.h	2011-05-04 14:23:42.000000000 +0800
+++ linux/include/linux/blkdev.h	2011-05-05 09:05:18.000000000 +0800
@@ -364,6 +364,7 @@ struct request_queue
 	 * for flush operations
 	 */
 	unsigned int		flush_flags;
+	unsigned int		flush_not_queueable:1;
 	unsigned int		flush_pending_idx:1;
 	unsigned int		flush_running_idx:1;
 	unsigned long		flush_pending_since;
@@ -843,6 +844,7 @@ extern void blk_queue_softirq_done(struc
 extern void blk_queue_rq_timed_out(struct request_queue *, rq_timed_out_fn *);
 extern void blk_queue_rq_timeout(struct request_queue *, unsigned int);
 extern void blk_queue_flush(struct request_queue *q, unsigned int flush);
+extern void blk_queue_flush_queueable(struct request_queue *q, bool queueable);
 extern struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev);
 
 extern int blk_rq_map_sg(struct request_queue *, struct request *, struct scatterlist *);
@@ -1111,6 +1113,11 @@ static inline unsigned int block_size(st
 	return bdev->bd_block_size;
 }
 
+static inline bool queue_flush_queueable(struct request_queue *q)
+{
+	return !q->flush_not_queueable;
+}
+
 typedef struct {struct page *v;} Sector;
 
 unsigned char *read_dev_sector(struct block_device *, sector_t, Sector *);
Index: linux/block/blk-settings.c
===================================================================
--- linux.orig/block/blk-settings.c	2011-05-05 08:37:05.000000000 +0800
+++ linux/block/blk-settings.c	2011-05-05 09:02:16.000000000 +0800
@@ -790,6 +790,12 @@ void blk_queue_flush(struct request_queu
 }
 EXPORT_SYMBOL_GPL(blk_queue_flush);
 
+void blk_queue_flush_queueable(struct request_queue *q, bool queueable)
+{
+	q->flush_not_queueable = !queueable;
+}
+EXPORT_SYMBOL_GPL(blk_queue_flush_queueable);
+
 static int __init blk_settings_init(void)
 {
 	blk_max_low_pfn = max_low_pfn - 1;
