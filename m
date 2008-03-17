From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 4/4] disk-protect: Add a generic block layer queue freezing facility
Date: Tue, 18 Mar 2008 00:00:17 +0100
Message-ID: <87k5k1klby.fsf@denkblock.local>
References: <87skzgd1zk.fsf@denkblock.local> <20080226123946.75dbe3d2@core>
	<87mypl8p49.fsf@denkblock.local> <20080228111349.6831925c@core>
	<87bq5qfm2v.fsf@denkblock.local>
	<20080307181750.9981.1330.stgit@denkblock.local>
	<20080315124952.GC4669@ucw.cz> <87ve3mfxv0.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:50663 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896AbYCQXAQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Mar 2008 19:00:16 -0400
In-Reply-To: <87ve3mfxv0.fsf@denkblock.local> (Elias Oltmanns's message of
	"Sun, 16 Mar 2008 17:16:19 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

--=-=-=

Elias Oltmanns <eo@nebensachen.de> wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
>> On Fri 2008-03-07 19:26:41, Elias Oltmanns wrote:
>>> This patch provides a generic way to freeze the request queue of a block
>>> device temporarily. This functionality is exposed to user space via sysfs.
>>> 
>>> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
[...]
>>> +/*
>>> + * When reading the 'protect' attribute, we return seconds remaining
>>> + * before the unfreeze timeout expires.
>>> + */
>>> +static ssize_t queue_protect_show(struct request_queue *q, char *page)
>>> +{
>>> +	unsigned int seconds = 0;
>>> +
>>> +	if (blk_queue_stopped(q) && timer_pending(&q->unfreeze_timer))
>>> +		/*
>>> +		 * Adding 1 in order to guarantee nonzero value until timer
>>> +		 * has actually expired.
>>> +		 */
>>> +		seconds = jiffies_to_msecs(q->unfreeze_timer.expires
>>> +					   - jiffies) / 1000 + 1;
>>
>> Is it okay to read expires without locking? 
>
> No, I have been a bit careless with regard to locking in this patch. See
> the revised version below.

Come to think of it, the lock really shouldn't be released between
modding / checking the timer and issuing the respective command. This
makes the whole thing a bit messy because allocating a request the
standard way is done before acquiring the spin_lock. Since we don't know
at that time whether a command is actually going to be enqueued, this
looks rather suboptimal to me. A better idea anyone?

Regards,

Elias


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=04-block-freeze-queue.patch

---

 block/ll_rw_blk.c      |  142 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |    7 ++
 2 files changed, 149 insertions(+), 0 deletions(-)

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 8b91994..112af66 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -39,6 +39,8 @@
 
 static void blk_unplug_work(struct work_struct *work);
 static void blk_unplug_timeout(unsigned long data);
+static void blk_unfreeze_work(struct work_struct *work);
+static void blk_unfreeze_timeout(unsigned long data);
 static void drive_stat_acct(struct request *rq, int new_io);
 static void init_request_from_bio(struct request *req, struct bio *bio);
 static int __make_request(struct request_queue *q, struct bio *bio);
@@ -231,6 +233,13 @@ void blk_queue_make_request(struct request_queue * q, make_request_fn * mfn)
 	q->unplug_timer.function = blk_unplug_timeout;
 	q->unplug_timer.data = (unsigned long)q;
 
+	q->max_unfreeze = 30;
+
+	INIT_WORK(&q->unfreeze_work, blk_unfreeze_work);
+
+	q->unfreeze_timer.function = blk_unfreeze_timeout;
+	q->unfreeze_timer.data = (unsigned long)q;
+
 	/*
 	 * by default assume old behaviour and bounce for any highmem page
 	 */
@@ -1861,6 +1870,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	}
 
 	init_timer(&q->unplug_timer);
+	init_timer(&q->unfreeze_timer);
 
 	kobject_set_name(&q->kobj, "%s", "queue");
 	q->kobj.ktype = &queue_ktype;
@@ -1975,6 +1985,92 @@ int blk_get_queue(struct request_queue *q)
 
 EXPORT_SYMBOL(blk_get_queue);
 
+static void issue_queue_freeze_cmd(struct request_queue *q,
+				   struct request *rq, int thaw)
+{
+	rq->cmd_type = REQ_TYPE_LINUX_BLOCK;
+	rq->cmd_len = 1;
+	rq->cmd_flags |= REQ_NOMERGE | REQ_SOFTBARRIER;
+	if (thaw)
+		rq->cmd[0] = REQ_LB_OP_THAW;
+	else
+		rq->cmd[0] = REQ_LB_OP_FREEZE;
+	rq->rq_disk = NULL;
+	rq->sense = NULL;
+	rq->sense_len = 0;
+	rq->retries = 5;
+	rq->timeout = HZ;
+	__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);
+	if (thaw)
+		blk_start_queue(q);
+	else {
+		blk_stop_queue(q);
+		q->request_fn(q);
+	}
+}
+
+static void blk_unfreeze_work(struct work_struct *work)
+{
+	struct request_queue *q = container_of(work, struct request_queue,
+					       unfreeze_work);
+	struct request *rq;
+
+	rq = blk_get_request(q, 0, __GFP_WAIT);
+	spin_lock_irq(q->queue_lock);
+	if (!timer_pending(&q->unfreeze_timer))
+		issue_queue_freeze_cmd(q, rq, 1);
+	else
+		__blk_put_request(q, rq);
+	spin_unlock_irq(q->queue_lock);
+}
+
+static void blk_unfreeze_timeout(unsigned long data)
+{
+	struct request_queue *q = (struct request_queue *) data;
+
+	kblockd_schedule_work(&q->unfreeze_work);
+}
+
+/**
+ * blk_freeze_queue - (un)freeze queue and manage the queue unfreeze timer
+ * @q:		queue to be (un)frozen
+ * @second:	number of seconds to freeze the queue for
+ *
+ * Description: This function (re)sets the unfreeze timer of a request
+ *    queue. When a timer is started / stopped (not just modified),
+ *    then low level drivers are notified about this event.
+ */
+static int blk_freeze_queue(struct request_queue *q, unsigned int seconds)
+{
+	struct request *rq;
+	int rc;
+
+	rq = blk_get_request(q, 0, __GFP_HIGH | __GFP_WAIT);
+	spin_lock_irq(q->queue_lock);
+	if (seconds > 0) {
+		if (seconds > q->max_unfreeze)
+			seconds = q->max_unfreeze;
+		/* set / reset the thaw timer */
+		rc = !mod_timer(&q->unfreeze_timer,
+				msecs_to_jiffies(seconds * 1000) + jiffies);
+		if (rc && blk_queue_stopped(q)) {
+			/* Someone else has stopped the queue already.
+			 * Best leave it alone.
+			 */
+			del_timer(&q->unfreeze_timer);
+			rc = 0;
+		}
+	} else
+		rc = del_timer(&q->unfreeze_timer);
+	if (rc)
+		issue_queue_freeze_cmd(q, rq, !seconds);
+	else
+		__blk_put_request(q, rq);
+	spin_unlock_irq(q->queue_lock);
+
+	return rc;
+}
+
 static inline void blk_free_request(struct request_queue *q, struct request *rq)
 {
 	if (rq->cmd_flags & REQ_ELVPRIV)
@@ -4080,6 +4176,45 @@ static ssize_t queue_max_hw_sectors_show(struct request_queue *q, char *page)
 	return queue_var_show(max_hw_sectors_kb, (page));
 }
 
+/*
+ * When reading the 'protect' attribute, we return seconds remaining
+ * before the unfreeze timeout expires.
+ */
+static ssize_t queue_protect_show(struct request_queue *q, char *page)
+{
+	unsigned int seconds = 0;
+
+	spin_lock_irq(q->queue_lock);
+	if (blk_queue_stopped(q) && timer_pending(&q->unfreeze_timer))
+		/*
+		 * Adding 1 in order to guarantee nonzero value until timer
+		 * has actually expired.
+		 */
+		seconds = jiffies_to_msecs(q->unfreeze_timer.expires
+					   - jiffies) / 1000 + 1;
+	spin_unlock_irq(q->queue_lock);
+
+	return queue_var_show(seconds, (page));
+}
+
+/*
+ * When writing to the 'protect' attribute, input is the number of
+ * seconds to freeze the queue for. We call a helper function to park
+ * the heads and freeze/block the queue, then we make a block layer
+ * call to setup the thaw timeout. If input is 0, then the queue will
+ * be thawed by that helper function immediately.
+ */
+static ssize_t queue_protect_store(struct request_queue *q,
+				   const char *page, size_t count)
+{
+	unsigned long seconds;
+
+	queue_var_store(&seconds, page, count);
+	blk_freeze_queue(q, seconds);
+
+	return count;
+}
+
 
 static struct queue_sysfs_entry queue_requests_entry = {
 	.attr = {.name = "nr_requests", .mode = S_IRUGO | S_IWUSR },
@@ -4110,12 +4245,19 @@ static struct queue_sysfs_entry queue_iosched_entry = {
 	.store = elv_iosched_store,
 };
 
+static struct queue_sysfs_entry queue_protect_entry = {
+	.attr = { .name = "protect", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_protect_show,
+	.store = queue_protect_store,
+};
+
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
 	&queue_max_hw_sectors_entry.attr,
 	&queue_max_sectors_entry.attr,
 	&queue_iosched_entry.attr,
+	&queue_protect_entry.attr,
 	NULL,
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1854a69..082e2d3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -385,6 +385,13 @@ struct request_queue
 	unsigned long		unplug_delay;	/* After this many jiffies */
 	struct work_struct	unplug_work;
 
+	/*
+	 * Auto-unfreeze state
+	 */
+	struct timer_list	unfreeze_timer;
+	int			max_unfreeze;	/* At most this many seconds */
+	struct work_struct	unfreeze_work;
+
 	struct backing_dev_info	backing_dev_info;
 
 	/*

--=-=-=--
