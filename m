From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: old ide driver incompatible with new flush implementation
	 (was: conflicting commits (block flush vs. ide))
Date: Tue, 15 Feb 2011 16:20:16 +0000
Message-ID: <4D5AB5D0020000780003207A@vpn.id2.novell.com>
References: <4D5A75650200007800031F9C@vpn.id2.novell.com>
 <20110215151314.GJ3160@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20110215151314.GJ3160@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

>>> On 15.02.11 at 16:13, Tejun Heo <tj@kernel.org> wrote:
> On Tue, Feb 15, 2011 at 11:45:25AM +0000, Jan Beulich wrote:
>> >>> On 15.02.11 at 10:35, Jan Beulich wrote:
>> > BUG: scheduling while atomic: swapper/0/0x10010000
>> 
>> Actually, the situation is worse. While the patch sent previously
>> allowed that system to boot, it died the moment it tried to
>> access its secondary disk (which supports flushes, while the
>> primary doesn't):
>> 
>> BUG: scheduling while atomic: swapper/0/0x10010000
>> Process swapper (pid: 0, ti=ec004000 task=c04c14e0 task.ti=c04b0000)
>> Stack:
>> Call Trace:
>> Code: cc cc cc cc b8 1c 00 00 00 cd 82 c3 cc cc cc cc cc cc cc cc cc cc cc 
> cc cc cc cc cc cc cc cc cc cc cc cc cc b8 1d 00 00 00 cd 82 <c3> cc cc cc cc cc 
> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 
>> Kernel panic - not syncing: scheduling while atomic
>> Pid: 0, comm: swapper Not tainted 2.6.37-2011-01-22-xen0 #4
>> Call Trace:
>>  [<c010827b>] try_stack_unwind+0x14b/0x170
>>  [<c010636f>] dump_trace+0x3f/0xf0
>>  [<c0107e8b>] show_trace_log_lvl+0x4b/0x60
>>  [<c0107eb8>] show_trace+0x18/0x20
>>  [<c037104b>] dump_stack+0x6d/0x72
>>  [<c03710a7>] panic+0x57/0x15b
>>  [<c0129008>] __schedule_bug+0x58/0x60
>>  [<c0371786>] schedule+0x466/0x5a0
>>  [<c037199f>] _cond_resched+0x2f/0x50
>>  [<c02cb8e5>] do_ide_request+0x55/0x450
>>  [<c0228698>] __generic_unplug_device+0x28/0x30
>>  [<c022ab2c>] blk_flush_complete_seq+0xbc/0x1a0		-> queue_next_fseq() -> 
> elv_insert()
> 
> Yeah, right.  blk_flush_complete_seq_end_io() is on completion path
> and shouldn't call directly into request_fn.  Can you please test
> whether the following patch fixes the problem?

Isn't that rather meant to deal with the first of the two cases (i.e.
not the one above, where the problem is with the direct call to
request_fn from __generic_unplug_device())?

Jan

> diff --git a/block/blk-core.c b/block/blk-core.c
> index 2f4002f..7f59923 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -352,7 +352,7 @@ void blk_start_queue(struct request_queue *q)
>  	WARN_ON(!irqs_disabled());
>  
>  	queue_flag_clear(QUEUE_FLAG_STOPPED, q);
> -	__blk_run_queue(q);
> +	__blk_run_queue(q, false);
>  }
>  EXPORT_SYMBOL(blk_start_queue);
>  
> @@ -403,13 +403,14 @@ EXPORT_SYMBOL(blk_sync_queue);
>  /**
>   * __blk_run_queue - run a single device queue
>   * @q:	The queue to run
> + * @force_kblockd: Don't run @q->request_fn directly.  Use kblockd.
>   *
>   * Description:
>   *    See @blk_run_queue. This variant must be called with the queue lock
>   *    held and interrupts disabled.
>   *
>   */
> -void __blk_run_queue(struct request_queue *q)
> +void __blk_run_queue(struct request_queue *q, bool force_kblockd)
>  {
>  	blk_remove_plug(q);
>  
> @@ -423,7 +424,7 @@ void __blk_run_queue(struct request_queue *q)
>  	 * Only recurse once to avoid overrunning the stack, let the unplug
>  	 * handling reinvoke the handler shortly if we already got there.
>  	 */
> -	if (!queue_flag_test_and_set(QUEUE_FLAG_REENTER, q)) {
> +	if (!force_kblockd && !queue_flag_test_and_set(QUEUE_FLAG_REENTER, q)) {
>  		q->request_fn(q);
>  		queue_flag_clear(QUEUE_FLAG_REENTER, q);
>  	} else {
> @@ -446,7 +447,7 @@ void blk_run_queue(struct request_queue *q)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(q->queue_lock, flags);
> -	__blk_run_queue(q);
> +	__blk_run_queue(q, false);
>  	spin_unlock_irqrestore(q->queue_lock, flags);
>  }
>  EXPORT_SYMBOL(blk_run_queue);
> @@ -1053,7 +1054,7 @@ void blk_insert_request(struct request_queue *q, struct 
> request *rq,
>  
>  	drive_stat_acct(rq, 1);
>  	__elv_add_request(q, rq, where, 0);
> -	__blk_run_queue(q);
> +	__blk_run_queue(q, false);
>  	spin_unlock_irqrestore(q->queue_lock, flags);
>  }
>  EXPORT_SYMBOL(blk_insert_request);
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 54b123d..e0bfce8 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -66,10 +66,12 @@ static void blk_flush_complete_seq_end_io(struct 
> request_queue *q,
>  
>  	/*
>  	 * Moving a request silently to empty queue_head may stall the
> -	 * queue.  Kick the queue in those cases.
> +	 * queue.  Kick the queue in those cases.  This function is called
> +	 * from request completion path and calling directly into
> +	 * request_fn may confuse the driver.  Always use kblockd.
>  	 */
>  	if (was_empty && next_rq)
> -		__blk_run_queue(q);
> +		__blk_run_queue(q, true);
>  }
>  
>  static void pre_flush_end_io(struct request *rq, int error)
> diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
> index 7be4c79..ea83a4f 100644
> --- a/block/cfq-iosched.c
> +++ b/block/cfq-iosched.c
> @@ -3355,7 +3355,7 @@ cfq_rq_enqueued(struct cfq_data *cfqd, struct cfq_queue 
> *cfqq,
>  			    cfqd->busy_queues > 1) {
>  				cfq_del_timer(cfqd, cfqq);
>  				cfq_clear_cfqq_wait_request(cfqq);
> -				__blk_run_queue(cfqd->queue);
> +				__blk_run_queue(cfqd->queue, false);
>  			} else {
>  				cfq_blkiocg_update_idle_time_stats(
>  						&cfqq->cfqg->blkg);
> @@ -3370,7 +3370,7 @@ cfq_rq_enqueued(struct cfq_data *cfqd, struct cfq_queue 
> *cfqq,
>  		 * this new queue is RT and the current one is BE
>  		 */
>  		cfq_preempt_queue(cfqd, cfqq);
> -		__blk_run_queue(cfqd->queue);
> +		__blk_run_queue(cfqd->queue, false);
>  	}
>  }
>  
> @@ -3731,7 +3731,7 @@ static void cfq_kick_queue(struct work_struct *work)
>  	struct request_queue *q = cfqd->queue;
>  
>  	spin_lock_irq(q->queue_lock);
> -	__blk_run_queue(cfqd->queue);
> +	__blk_run_queue(cfqd->queue, false);
>  	spin_unlock_irq(q->queue_lock);
>  }
>  
> diff --git a/block/elevator.c b/block/elevator.c
> index 2569512..236e93c 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -602,7 +602,7 @@ void elv_quiesce_start(struct request_queue *q)
>  	 */
>  	elv_drain_elevator(q);
>  	while (q->rq.elvpriv) {
> -		__blk_run_queue(q);
> +		__blk_run_queue(q, false);
>  		spin_unlock_irq(q->queue_lock);
>  		msleep(10);
>  		spin_lock_irq(q->queue_lock);
> @@ -651,7 +651,7 @@ void elv_insert(struct request_queue *q, struct request 
> *rq, int where)
>  		 *   with anything.  There's no point in delaying queue
>  		 *   processing.
>  		 */
> -		__blk_run_queue(q);
> +		__blk_run_queue(q, false);
>  		break;
>  
>  	case ELEVATOR_INSERT_SORT:
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 9045c52..fb2bb35 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -443,7 +443,7 @@ static void scsi_run_queue(struct request_queue *q)
>  					&sdev->request_queue->queue_flags);
>  		if (flagset)
>  			queue_flag_set(QUEUE_FLAG_REENTER, sdev->request_queue);
> -		__blk_run_queue(sdev->request_queue);
> +		__blk_run_queue(sdev->request_queue, false);
>  		if (flagset)
>  			queue_flag_clear(QUEUE_FLAG_REENTER, sdev->request_queue);
>  		spin_unlock(sdev->request_queue->queue_lock);
> diff --git a/drivers/scsi/scsi_transport_fc.c 
> b/drivers/scsi/scsi_transport_fc.c
> index 998c01b..5c3ccfc 100644
> --- a/drivers/scsi/scsi_transport_fc.c
> +++ b/drivers/scsi/scsi_transport_fc.c
> @@ -3829,7 +3829,7 @@ fc_bsg_goose_queue(struct fc_rport *rport)
>  		  !test_bit(QUEUE_FLAG_REENTER, &rport->rqst_q->queue_flags);
>  	if (flagset)
>  		queue_flag_set(QUEUE_FLAG_REENTER, rport->rqst_q);
> -	__blk_run_queue(rport->rqst_q);
> +	__blk_run_queue(rport->rqst_q, false);
>  	if (flagset)
>  		queue_flag_clear(QUEUE_FLAG_REENTER, rport->rqst_q);
>  	spin_unlock_irqrestore(rport->rqst_q->queue_lock, flags);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 4d18ff3..d5e444d 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -699,7 +699,7 @@ extern void blk_start_queue(struct request_queue *q);
>  extern void blk_stop_queue(struct request_queue *q);
>  extern void blk_sync_queue(struct request_queue *q);
>  extern void __blk_stop_queue(struct request_queue *q);
> -extern void __blk_run_queue(struct request_queue *);
> +extern void __blk_run_queue(struct request_queue *q, bool force_kblockd);
>  extern void blk_run_queue(struct request_queue *);
>  extern int blk_rq_map_user(struct request_queue *, struct request *,
>  			   struct rq_map_data *, void __user *, unsigned long,


