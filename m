From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH] libata: implement ata_qc_exec_internal()
Date: Tue, 29 Nov 2005 15:41:57 +0800
Message-ID: <438C0645.3020301@tw.ibm.com>
References: <20051128164201.GA7530@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:42933 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750800AbVK2HmM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Nov 2005 02:42:12 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jAT7g6pV001666
	for <linux-ide@vger.kernel.org>; Tue, 29 Nov 2005 02:42:06 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jAT7fZCh109756
	for <linux-ide@vger.kernel.org>; Tue, 29 Nov 2005 00:41:36 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jAT7g5MR019549
	for <linux-ide@vger.kernel.org>; Tue, 29 Nov 2005 00:42:05 -0700
In-Reply-To: <20051128164201.GA7530@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Each user libata internal commands initializes a qc, issues it, waits
> for its completion and checks for errors.  This patch factors internal
> command execution sequence into ata_qc_exec_internal().  The function
> also removes race condition between irq and timeout handling.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index f1047a0..40c488e 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -1047,28 +1047,73 @@ static unsigned int ata_pio_modes(const 
>  	return modes;
>  }
>  
> -static int ata_qc_wait_err(struct ata_queued_cmd *qc,
> -			   struct completion *wait)
> +/**
> + *	ata_qc_exec_internal - execute libata internal command
> + *	@qc: Command to execute
> + *
> + *	Executes libata internal command with timeout.  Timeout and
> + *	error conditions are reported via return value.  No recovery
> + *	action is taken after a command times out.  It's caller's duty
> + *	to clean up after timeout.
> + *
> + *	Also, note that error condition is checked after the qc is
> + *	completed, meaning that if another command is issued before
> + *	checking the condition, we get the wrong values.  As internal
> + *	cmds are used only for initialization and recovery, this
> + *	shouldn't cause any problem.
> + *
> + *	LOCKING:
> + *	None.  Should be called with kernel context, might sleep.
> + */
> +
> +static unsigned ata_qc_exec_internal(struct ata_queued_cmd *qc)
>  {
> -	int rc = 0;
> +	struct ata_port *ap = qc->ap;
> +	DECLARE_COMPLETION(wait);
> +	unsigned long tmout_left;
> +	unsigned int err_mask;
> +	int rc;
>  
> -	if (wait_for_completion_timeout(wait, 30 * HZ) < 1) {
> -		/* timeout handling */
> -		unsigned int err_mask = ac_err_mask(ata_chk_status(qc->ap));
> +	if (ata_busy_sleep(ap, ATA_TMOUT_INTERNAL_QUICK, ATA_TMOUT_INTERNAL))
> +		return -ETIMEDOUT;
>  
> -		if (!err_mask) {
> +	qc->complete_fn = ata_qc_complete_noop;
> +	qc->waiting = &wait;
> +
> +	spin_lock_irq(&ap->host_set->lock);
> +	rc = ata_qc_issue(qc);
> +	spin_unlock_irq(&ap->host_set->lock);
> +
> +	if (rc)
> +		return AC_ERR_OTHER;
> +
> +	tmout_left = wait_for_completion_timeout(&wait, ATA_TMOUT_INTERNAL);
> +	err_mask = ac_err_mask(ata_chk_status(qc->ap));

Could we get the err_mask from the qc->complete_fn?
(For some case where the software finds something wrong, but the device ata_chk_status(qc->ap) is zero.)

Albert

> +
> +	if (!tmout_left) {
> +		/* timeout handling */
> +		if (!err_mask)
>  			printk(KERN_WARNING "ata%u: slow completion (cmd %x)\n",
>  			       qc->ap->id, qc->tf.command);
> -		} else {
> +		else
>  			printk(KERN_WARNING "ata%u: qc timeout (cmd %x)\n",
>  			       qc->ap->id, qc->tf.command);
> -			rc = -EIO;
> -		}
>  
> -		ata_qc_complete(qc, err_mask);
> +		spin_lock_irq(&ap->host_set->lock);
> +
> +		/* We're racing with irq here.  If we lose, the
> +		 * following test prevents us from completing the qc
> +		 * again.  If completion irq occurs after here but
> +		 * before the caller cleans up, it will result in a
> +		 * spurious interrupt.  We can live with that.
> +		 */
> +		if (qc->flags & ATA_QCFLAG_ACTIVE)
> +			ata_qc_complete(qc, err_mask);
> +
> +		spin_unlock_irq(&ap->host_set->lock);
>  	}
>  
> -	return rc;
> +	return err_mask;
>  }
>  

