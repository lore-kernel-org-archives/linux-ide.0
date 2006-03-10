From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH/RFC 3/5] libata-dev: Let ata_hsm_move() work with both irq-pio and polling pio
Date: Fri, 10 Mar 2006 18:31:29 +0900
Message-ID: <20060310093128.GC20207@htj.dyndns.org>
References: <440FEA4B.10500@tw.ibm.com> <440FEC98.4010500@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:11109 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752197AbWCJJ4F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Mar 2006 04:56:05 -0500
Received: by zproxy.gmail.com with SMTP id 14so703178nzn
        for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 01:56:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <440FEC98.4010500@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

On Thu, Mar 09, 2006 at 04:51:36PM +0800, Albert Lee wrote:
[--- snip ---]
> +
> +static int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
> +			u8 status, int in_wq)

IMHO, polling would be a slightly better name than in_wq.

>  {
> +	unsigned long flags = 0;
> +	int poll_next;
> +
>  	WARN_ON(qc == NULL);
>  	WARN_ON((qc->flags & ATA_QCFLAG_ACTIVE) == 0);
>  
> +	WARN_ON(in_wq != ((qc->tf.flags & ATA_TFLAG_POLLING) ||
> +			  (ap->hsm_task_state == HSM_ST_FIRST &&
> +			   ((qc->tf.protocol == ATA_PROT_PIO &&
> +			     (qc->tf.flags & ATA_TFLAG_WRITE)) ||
> +			    (is_atapi_taskfile(&qc->tf) &&
> +			     !(qc->dev->flags & ATA_DFLAG_CDB_INTR))))));
> +

I think this is a little bit excessive.  Can't we get away with
WARN_ON(in_wq != !in_irq()) or just trust what the caller says?  It's
not like this function has a lot of callers.

>  	/* check error */
>  	if (unlikely(status & (ATA_ERR | ATA_DF))) {
>  		qc->err_mask |= AC_ERR_DEV;
> @@ -3643,6 +3664,13 @@ static void ata_hsm_move(struct ata_port
>  fsm_start:
>  	switch (ap->hsm_task_state) {
>  	case HSM_ST_FIRST:
> +		/* Send first data block or PACKET CDB */
> +
> +		/* if polling, we will stay in the work queue after sending the data.
> +		 * otherwise, interrupt handler takes over after sending the data.
> +		 */
> +		poll_next = (qc->tf.flags & ATA_TFLAG_POLLING);
> +
>  		/* check device status */
>  		if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
>  			/* Wrong status. Let EH handle this */
> @@ -3651,8 +3679,35 @@ fsm_start:
>  			goto fsm_start;
>  		}
>  
> -		atapi_send_cdb(ap, qc);
> +		/* Send the CDB (atapi) or the first data block (ata pio out).
> +		 * During the state transition, interrupt handler shouldn't
> +		 * be invoked before the data transfer is complete and
> +		 * hsm_task_state is changed. Hence, the following locking.
> +		 */
> +		if (in_wq)
> +			spin_lock_irqsave(&ap->host_set->lock, flags);
> +
> +		if (qc->tf.protocol == ATA_PROT_PIO) {
> +			/* PIO data out protocol.
> +			 * send first data block.
> +			 */
> +
> +			/* ata_pio_sectors() might change the state to HSM_ST_LAST.
> +			 * so, the state is changed here before ata_pio_sectors().
> +			 */
> +			ap->hsm_task_state = HSM_ST;
> +			ata_pio_sectors(qc);
> +			ata_altstatus(ap); /* flush */
> +		} else
> +			/* send CDB */
> +			atapi_send_cdb(ap, qc);
>  
> +		if (in_wq)
> +			spin_unlock_irqrestore(&ap->host_set->lock, flags);
> +
> +		/* if polling, ata_pio_task() handles the rest.
> +		 * otherwise, interrupt handler takes over from here.
> +		 */
>  		break;
>  

For ATA PIO write transfers, the first transfer and n'th transfers
aren't really different.  The code would be simpler if it handles the
first ATA PIO write in HSM_ST.  And if we do that, HSM_ST_FIRST can be
renamed to HSM_ST_CDB.  Hmmm.. Maybe this should be done in separate
series of patches.

-- 
tejun
