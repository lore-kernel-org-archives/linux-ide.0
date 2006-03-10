From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH/RFC 4/5] libata-dev: Convert ata_pio_task() to use the new ata_hsm_move()
Date: Fri, 10 Mar 2006 18:35:37 +0900
Message-ID: <20060310093537.GD20207@htj.dyndns.org>
References: <440FEA4B.10500@tw.ibm.com> <440FED5C.1010503@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.195]:51848 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751421AbWCJJfn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Mar 2006 04:35:43 -0500
Received: by zproxy.gmail.com with SMTP id 14so699974nzn
        for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 01:35:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <440FED5C.1010503@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

On Thu, Mar 09, 2006 at 04:54:52PM +0800, Albert Lee wrote:
> --- 03_support_wq/drivers/scsi/libata-core.c	2006-03-09 15:14:00.000000000 +0800
> +++ 04_pio_task/drivers/scsi/libata-core.c	2006-03-09 15:14:41.000000000 +0800
> @@ -725,6 +725,8 @@ static unsigned int ata_pio_modes(const 
>  static inline void
>  ata_queue_pio_task(struct ata_port *ap)
>  {
> +	ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
> +
>  	if (!(ap->flags & ATA_FLAG_FLUSH_PIO_TASK))
>  		queue_work(ata_wq, &ap->pio_task);
>  }

I don't think we really need pio_task_timeout.  Generic EH now handles
polling timeouts correctly and I can't see any advantage of
pio_task_timeout.

> @@ -3804,44 +3806,55 @@ fsm_start:
>  static void ata_pio_task(void *_data)
>  {
>  	struct ata_port *ap = _data;
> -	unsigned long timeout;
> -	int has_next;
> +	struct ata_queued_cmd *qc;
> +	u8 status;
> +	int poll_next;
>  
>  fsm_start:
> -	timeout = 0;
> -	has_next = 1;
> +	WARN_ON(ap->hsm_task_state == HSM_ST_IDLE);
>  
> -	switch (ap->hsm_task_state) {
> -	case HSM_ST_FIRST:
> -		has_next = ata_pio_first_block(ap);
> -		break;
> +	qc = ata_qc_from_tag(ap, ap->active_tag);
> +	WARN_ON(qc == NULL);
>  
> -	case HSM_ST:
> -		ata_pio_block(ap);
> -		break;
> +	/*
> +	 * This is purely heuristic.  This is a fast path.
> +	 * Sometimes when we enter, BSY will be cleared in
> +	 * a chk-status or two.  If not, the drive is probably seeking
> +	 * or something.  Snooze for a couple msecs, then
> +	 * chk-status again.  If still busy, timeout or queue delayed work.
> +	 */
> +	status = ata_busy_wait(ap, ATA_BUSY, 5);
> +	if (status & ATA_BUSY) {
> +		msleep(2);
> +		status = ata_busy_wait(ap, ATA_BUSY, 10);
> +		if (status & ATA_BUSY) {
> +			if (time_before(jiffies, ap->pio_task_timeout)) {
> +				ata_queue_delayed_pio_task(ap, ATA_SHORT_PAUSE);
> +				return;
> +			}
>  
> -	case HSM_ST_LAST:
> -		has_next = ata_pio_complete(ap);
> -		break;
> +			/* timeout. Let EH handle it later. 
> +			 * FIXME: should we remove ap->pio_task_timeout?
> +			 */
> +			printk(KERN_ERR "ata%u: polling time out\n", ap->id);
> +			qc->err_mask |= AC_ERR_TIMEOUT;
> +			ap->hsm_task_state = HSM_ST_TMOUT;
> +			return; 
> +		}
> +	}
>  
> -	case HSM_ST_POLL:
> -	case HSM_ST_LAST_POLL:
> -		timeout = ata_pio_poll(ap);
> -		break;
> +	/* FIXME: check if EH is active */

No, you don't need to.  Generic EH already does the right thing.  No
need to worry about EH in polling task.

-- 
tejun
