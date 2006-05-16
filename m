From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 08:23:25 +0900
Message-ID: <446A5EED.7020902@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A4721.3030506@emc.com> <446A4BF5.7080006@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090603080503080100020107"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:53868 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932265AbWEPXWq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 19:22:46 -0400
Received: by wr-out-0506.google.com with SMTP id i3so89359wra
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 16:22:46 -0700 (PDT)
In-Reply-To: <446A4BF5.7080006@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: ric@emc.com, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

This is a multi-part message in MIME format.
--------------090603080503080100020107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> Ric Wheeler wrote:
>>
>> One other note, it seems like this patch set has broken the write 
>> barrier support - is that a side effect of enabling NCQ still?
>>
>> I see messages that claim flush barriers are enabled:
>>
>> [root@c001n01 root]# mount -o 
>> barrier=flush,rw,noatime,nodiratime,data=ordered,notail /dev/sda10 /mnt/1
>> May 16 22:21:56 centera kernel: ReiserFS: sda10: found reiserfs format 
>> "3.6" with standard journal
>> [root@c001n01 root]# May 16 22:21:58 centera kernel: ReiserFS: sda10: 
>> using ordered data mode
>> May 16 22:21:58 centera kernel: reiserfs: using flush barriers
>> May 16 22:21:58 centera kernel: ReiserFS: sda10: journal params: 
>> device sda10, size 8192, journal first block 18, max trans len 1024, 
>> max batch 900, max commit age 30, max trans age 30
>> May 16 22:21:58 centera kernel: ReiserFS: sda10: checking transaction 
>> log (sda10)
>> May 16 22:21:58 centera kernel: ReiserFS: sda10: Using r5 hash to sort 
>> names
>>
>> But when I test with my synchronous write load, I am going at 6 times 
>> the normal rate (i.e., the rate I see with barriers disabled) ;-)
> 
> Well, NCQ read/write commands have a 'FUA' bit...  though maybe the NCQ 
> code forgot to check the global libata_fua.
> 

Hmmm.. The only place FUA is checked is ata_dev_supports_fua() 
regardless of NCQ, but I've seen FUA enabled with NCQ in another bug 
report, so I might have screwed up.  Ric, can you post the boot dmesg 
such that we know whether FUA is enabled or not?

I'm attaching a patch to print the progress of ordered sequence.  I've 
just tested with a NCQ drive loaded with 20 IO requests and it works. 
All requests are drained, preflush, barrier, then postflush.  Running 
the same test with the attached patch will tell us how barrier is working.

@ I can't believe this.  Last night two disks failed - one testing, one 
production.  Man, my harddrives are falling like flies.  Four test 
drives and one production drive failed during last two months.  Maybe 
they are striking back at me.  :-(

-- 
tejun

--------------090603080503080100020107
Content-Type: text/x-patch;
 name="ordered_debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ordered_debug.patch"

diff --git a/block/elevator.c b/block/elevator.c
index 8768a36..5cbd2b3 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -40,6 +40,8 @@ #include <asm/uaccess.h>
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
 
+#define pd(fmt, args...) 	printk("[%-24s]: " fmt, __FUNCTION__ , ##args);
+
 /*
  * can we safely merge with this request?
  */
@@ -548,6 +550,11 @@ struct request *elv_next_request(request
 		}
 	}
 
+	if (rq && (rq == &q->pre_flush_rq || rq == &q->post_flush_rq ||
+		   rq == &q->bar_rq))
+		pd("%p (%s)\n", rq,
+		   rq == &q->pre_flush_rq ?
+			"pre" : (rq == &q->post_flush_rq ? "post" : "bar"));
 	return rq;
 }
 
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index eac48be..eb1325c 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -30,6 +30,8 @@ #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/blktrace_api.h>
 
+#define pd(fmt, args...) 	printk("[%-24s]: " fmt, __FUNCTION__ , ##args);
+
 /*
  * for max sense size
  */
@@ -395,6 +397,9 @@ void blk_ordered_complete_seq(request_qu
 	struct request *rq;
 	int uptodate;
 
+	pd("ordseq=%02x seq=%02x orderr=%d error=%d\n",
+	   q->ordseq, seq, q->orderr, error);
+
 	if (error && !q->orderr)
 		q->orderr = error;
 
@@ -407,6 +412,7 @@ void blk_ordered_complete_seq(request_qu
 	/*
 	 * Okay, sequence complete.
 	 */
+	pd("sequence complete\n");
 	rq = q->orig_bar_rq;
 	uptodate = q->orderr ? q->orderr : 1;
 
@@ -461,6 +467,17 @@ static void queue_flush(request_queue_t 
 static inline struct request *start_ordered(request_queue_t *q,
 					    struct request *rq)
 {
+	struct bio *bio;
+	pd("%p -> %p,%p,%p infl=%u\n",
+	   rq, &q->pre_flush_rq, &q->bar_rq, &q->post_flush_rq, q->in_flight);
+	pd("%p %d %llu %lu %u %u %u %p\n", rq->bio, rq->errors,
+	   (unsigned long long)rq->hard_sector, rq->hard_nr_sectors,
+	   rq->current_nr_sectors, rq->nr_phys_segments, rq->nr_hw_segments,
+	   rq->buffer);
+	for (bio = rq->bio; bio; bio = bio->bi_next)
+		pd("BIO %p %llu %u\n",
+		   bio, (unsigned long long)bio->bi_sector, bio->bi_size);
+
 	q->bi_size = 0;
 	q->orderr = 0;
 	q->ordered = q->next_ordered;
@@ -499,6 +516,7 @@ static inline struct request *start_orde
 	} else
 		q->ordseq |= QUEUE_ORDSEQ_PREFLUSH;
 
+	pd("ordered=%x in_flight=%u\n", q->ordered, q->in_flight);
 	if ((q->ordered & QUEUE_ORDERED_TAG) || q->in_flight == 0)
 		q->ordseq |= QUEUE_ORDSEQ_DRAIN;
 	else
@@ -518,8 +536,10 @@ int blk_do_ordered(request_queue_t *q, s
 
 		if (q->next_ordered != QUEUE_ORDERED_NONE) {
 			*rqp = start_ordered(q, rq);
+			pd("start_ordered %p->%p\n", rq, *rqp);
 			return 1;
 		} else {
+			pd("ORDERED_NONE, seen barrier\n");
 			/*
 			 * This can happen when the queue switches to
 			 * ORDERED_NONE while this request is on it.
@@ -553,6 +573,7 @@ int blk_do_ordered(request_queue_t *q, s
 			*rqp = NULL;
 	}
 
+	pd("seq=%02x %p->%p\n", blk_ordered_cur_seq(q), rq, *rqp);
 	return 1;
 }
 
@@ -585,6 +606,9 @@ static int flush_dry_bio_endio(struct bi
 	bio->bi_sector -= (q->bi_size >> 9);
 	q->bi_size = 0;
 
+	pd("BIO %p %llu %u\n",
+	   bio, (unsigned long long)bio->bi_sector, bio->bi_size);
+
 	return 0;
 }
 
@@ -598,6 +622,7 @@ static inline int ordered_bio_endio(stru
 	if (&q->bar_rq != rq)
 		return 0;
 
+	pd("q->orderr=%d error=%d\n", q->orderr, error);
 	/*
 	 * Okay, this is the barrier request in progress, dry finish it.
 	 */
@@ -2864,6 +2889,7 @@ static int __make_request(request_queue_
 
 	barrier = bio_barrier(bio);
 	if (unlikely(barrier) && (q->next_ordered == QUEUE_ORDERED_NONE)) {
+		pd("ORDERED_NONE, seen barrier\n");
 		err = -EOPNOTSUPP;
 		goto end_io;
 	}

--------------090603080503080100020107--
