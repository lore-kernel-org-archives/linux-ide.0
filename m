From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata: implement ata_exec_internal()
Date: Sat, 03 Dec 2005 20:50:18 -0500
Message-ID: <43924B5A.1070904@pobox.com>
References: <20051128164201.GA7530@htj.dyndns.org> <438C0645.3020301@tw.ibm.com> <20051129131717.GA8505@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:36589 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751309AbVLDBu1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Dec 2005 20:50:27 -0500
In-Reply-To: <20051129131717.GA8505@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Each user libata internal commands initializes a qc, issues it, waits
> for its completion and checks for errors.  This patch factors internal
> command execution sequence into ata_qc_exec_internal().  This change
> fixes the following bugs.
> 
> * qc not freed on issue failure
> * ap->qactive clearing could race with the next internal command
> * race between timeout handling and irq
> * ignoring error condition not represented in tf->status
> 
> Also, qc & hardware are not accessed anymore once it's completed,
> making internal commands more conformant with general semantics.  This
> change also makes it easy to issue internal commands from multiple
> threads if that becomes necessary.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

This is OK in concept, but there are problems in implementation...

General comment:  would be nice split up as 'implement 
ata.exec.internal' and 'use ata.exec.internal' patches.


> This is take #2 of ata_exec_internal().  qc allocation and tf
> reading-back have also been moved into ata_exec_internal().  Now all
> qc handling is done while properly holding host_set lock removing
> above mentioned rare race conditon (the second item).
> 
> Index: work/drivers/scsi/libata-core.c
> ===================================================================
> --- work.orig/drivers/scsi/libata-core.c	2005-11-29 22:04:15.000000000 +0900
> +++ work/drivers/scsi/libata-core.c	2005-11-29 22:06:20.000000000 +0900
> @@ -1047,28 +1047,119 @@ static unsigned int ata_pio_modes(const 
>  	return modes;
>  }
>  
> -static int ata_qc_wait_err(struct ata_queued_cmd *qc,
> -			   struct completion *wait)
> +struct ata_exec_internal_arg {
> +	unsigned int err_mask;
> +	struct ata_taskfile *tf;
> +	struct completion *waiting;
> +};
> +
> +int ata_qc_complete_internal(struct ata_queued_cmd *qc, unsigned int err_mask)
>  {
> -	int rc = 0;
> +	struct ata_exec_internal_arg *arg = qc->complete_data;

This is what private_data is for.  No need to add 'complete_data'.


> +	struct completion *waiting = arg->waiting;
>  
> -	if (wait_for_completion_timeout(wait, 30 * HZ) < 1) {
> -		/* timeout handling */
> -		unsigned int err_mask = ac_err_mask(ata_chk_status(qc->ap));
> -
> -		if (!err_mask) {
> -			printk(KERN_WARNING "ata%u: slow completion (cmd %x)\n",
> -			       qc->ap->id, qc->tf.command);
> -		} else {
> -			printk(KERN_WARNING "ata%u: qc timeout (cmd %x)\n",
> -			       qc->ap->id, qc->tf.command);
> -			rc = -EIO;
> -		}
> +	if (!(err_mask & ~AC_ERR_DEV))
> +		qc->ap->ops->tf_read(qc->ap, arg->tf);
> +	arg->err_mask = err_mask;
> +	arg->waiting = NULL;
> +	complete(waiting);
> +
> +	return 0;
> +}
> +
> +/**
> + *	ata_exec_internal - execute libata internal command
> + *	@ap: Port to which the command is sent
> + *	@dev: Device to which the command is sent
> + *	@tf: Taskfile registers for the command and the result
> + *	@dma_dir: Data tranfer direction of the command
> + *	@buf: Data buffer of the command
> + *	@buflen: Length of data buffer
> + *
> + *	Executes libata internal command with timeout.  @tf contains
> + *	command on entry and result on return.  Timeout and error
> + *	conditions are reported via return value.  No recovery action
> + *	is taken after a command times out.  It's caller's duty to
> + *	clean up after timeout.
> + *
> + *	LOCKING:
> + *	None.  Should be called with kernel context, might sleep.
> + */
> +
> +static unsigned
> +ata_exec_internal(struct ata_port *ap, struct ata_device *dev,
> +		  struct ata_taskfile *tf,
> +		  int dma_dir, void *buf, unsigned int buflen)
> +{
> +	u8 command = tf->command;
> +	struct ata_queued_cmd *qc;
> +	DECLARE_COMPLETION(wait);
> +	unsigned long flags;
> +	struct ata_exec_internal_arg arg;
> +
> +	if (ata_busy_sleep(ap, ATA_TMOUT_INTERNAL_QUICK, ATA_TMOUT_INTERNAL))
> +		return AC_ERR_OTHER;

NAK.  This sort of thing really belongs in the execution engine for each 
driver.  Advanced controllers have zero need for this.

Moreover, why are you adding this, anyway?  This is a distinct 
regression from the nice "do everything inside ata_qc_issue" model 
that's been sprouting.


> +	spin_lock_irqsave(&ap->host_set->lock, flags);
> +
> +	qc = ata_qc_new_init(ap, dev);
> +	BUG_ON(qc == NULL);
> +
> +	qc->tf = *tf;
> +	qc->dma_dir = dma_dir;
> +	if (dma_dir != DMA_NONE) {
> +		ata_sg_init_one(qc, buf, buflen);
> +		qc->nsect = buflen / ATA_SECT_SIZE;
> +		printk("dma_dir=%d buflen=%u nsect=%d\n",
> +		       dma_dir, buflen, qc->nsect);
> +	}
> +
> +	arg.waiting = &wait;
> +	arg.tf = tf;
> +	qc->complete_data = &arg;
> +	qc->complete_fn = ata_qc_complete_internal;
> +
> +	if (ata_qc_issue(qc))
> +		goto issue_fail;
> +
> +	spin_unlock_irqrestore(&ap->host_set->lock, flags);
> +
> +	if (!wait_for_completion_timeout(&wait, ATA_TMOUT_INTERNAL)) {
> +		int timedout;
> +
> +		spin_lock_irqsave(&ap->host_set->lock, flags);
> +
> +		/* We're racing with irq here.  If we lose, the
> +		 * following test prevents us from completing the qc
> +		 * again.  If completion irq occurs after here but
> +		 * before the caller cleans up, it will result in a
> +		 * spurious interrupt.  We can live with that.
> +		 */
> +		timedout = arg.waiting != NULL;
> +		if (timedout)
> +			ata_qc_complete(qc, 0);

This is not very wise, to pass 'nothing is wrong' to ata_qc_complete() 
upon timeout.


> +		spin_unlock_irqrestore(&ap->host_set->lock, flags);
>  
> -		ata_qc_complete(qc, err_mask);
> +		if (timedout) {
> +			arg.err_mask = ac_err_mask(tf->command);
> +			if (!arg.err_mask)
> +				printk(KERN_WARNING
> +				       "ata%u: slow completion (cmd %x)\n",
> +				       ap->id, command);
> +			else
> +				printk(KERN_WARNING
> +				       "ata%u: qc timeout (cmd %x)\n",
> +				       ap->id, command);
> +		}
>  	}
>  
> -	return rc;
> +	return arg.err_mask;
> +
> + issue_fail:
> +	ata_qc_free(qc);
> +	spin_unlock_irqrestore(&ap->host_set->lock, flags);
> +	return AC_ERR_OTHER;
>  }
>  
>  /**
> @@ -1100,9 +1191,8 @@ static void ata_dev_identify(struct ata_
>  	u16 tmp;
>  	unsigned long xfer_modes;
>  	unsigned int using_edd;
> -	DECLARE_COMPLETION(wait);
> -	struct ata_queued_cmd *qc;
> -	unsigned long flags;
> +	struct ata_taskfile tf;
> +	unsigned int err_mask;
>  	int rc;
>  
>  	if (!ata_dev_present(dev)) {
> @@ -1123,40 +1213,26 @@ static void ata_dev_identify(struct ata_
>  
>  	ata_dev_select(ap, device, 1, 1); /* select device 0/1 */
>  
> -	qc = ata_qc_new_init(ap, dev);
> -	BUG_ON(qc == NULL);
> -
> -	ata_sg_init_one(qc, dev->id, sizeof(dev->id));
> -	qc->dma_dir = DMA_FROM_DEVICE;
> -	qc->tf.protocol = ATA_PROT_PIO;
> -	qc->nsect = 1;
> -
>  retry:
> +	ata_tf_init(ap, &tf, device);
>  	if (dev->class == ATA_DEV_ATA) {
> -		qc->tf.command = ATA_CMD_ID_ATA;
> +		tf.command = ATA_CMD_ID_ATA;
>  		DPRINTK("do ATA identify\n");
>  	} else {
> -		qc->tf.command = ATA_CMD_ID_ATAPI;
> +		tf.command = ATA_CMD_ID_ATAPI;
>  		DPRINTK("do ATAPI identify\n");
>  	}
>  
> -	qc->waiting = &wait;
> -	qc->complete_fn = ata_qc_complete_noop;
> +	tf.protocol = ATA_PROT_PIO;
>  
> -	spin_lock_irqsave(&ap->host_set->lock, flags);
> -	rc = ata_qc_issue(qc);
> -	spin_unlock_irqrestore(&ap->host_set->lock, flags);
> +	err_mask = ata_exec_internal(ap, dev, &tf, DMA_FROM_DEVICE,
> +				     dev->id, sizeof(dev->id));
>  
> -	if (rc)
> -		goto err_out;
> -	else
> -		ata_qc_wait_err(qc, &wait);
> -
> -	spin_lock_irqsave(&ap->host_set->lock, flags);
> -	ap->ops->tf_read(ap, &qc->tf);
> -	spin_unlock_irqrestore(&ap->host_set->lock, flags);
> +	if (err_mask) {
> +		if (err_mask & ~AC_ERR_DEV)
> +			goto err_out;
>  
> -	if (qc->tf.command & ATA_ERR) {
>  		/*
>  		 * arg!  EDD works for all test cases, but seems to return
>  		 * the ATA signature for some ATAPI devices.  Until the
> @@ -1169,13 +1245,9 @@ retry:
>  		 * to have this problem.
>  		 */
>  		if ((using_edd) && (dev->class == ATA_DEV_ATA)) {
> -			u8 err = qc->tf.feature;
> +			u8 err = tf.feature;
>  			if (err & ATA_ABORTED) {
>  				dev->class = ATA_DEV_ATAPI;
> -				qc->cursg = 0;
> -				qc->cursg_ofs = 0;
> -				qc->cursect = 0;
> -				qc->nsect = 1;
>  				goto retry;
>  			}
>  		}
> @@ -2288,34 +2360,23 @@ static int ata_choose_xfer_mode(const st
>  
>  static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev)
>  {
> -	DECLARE_COMPLETION(wait);
> -	struct ata_queued_cmd *qc;
> -	int rc;
> -	unsigned long flags;
> +	struct ata_taskfile tf;
>  
>  	/* set up set-features taskfile */
>  	DPRINTK("set features - xfer mode\n");
>  
> -	qc = ata_qc_new_init(ap, dev);
> -	BUG_ON(qc == NULL);
> -
> -	qc->tf.command = ATA_CMD_SET_FEATURES;
> -	qc->tf.feature = SETFEATURES_XFER;
> -	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
> -	qc->tf.protocol = ATA_PROT_NODATA;
> -	qc->tf.nsect = dev->xfer_mode;
> -
> -	qc->waiting = &wait;
> -	qc->complete_fn = ata_qc_complete_noop;
> -
> -	spin_lock_irqsave(&ap->host_set->lock, flags);
> -	rc = ata_qc_issue(qc);
> -	spin_unlock_irqrestore(&ap->host_set->lock, flags);
> +	ata_tf_init(ap, &tf, dev->devno);
> +	tf.command = ATA_CMD_SET_FEATURES;
> +	tf.feature = SETFEATURES_XFER;
> +	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
> +	tf.protocol = ATA_PROT_NODATA;
> +	tf.nsect = dev->xfer_mode;
>  
> -	if (rc)
> +	if (ata_exec_internal(ap, dev, &tf, DMA_NONE, NULL, 0)) {
> +		printk(KERN_ERR "ata%u: failed to set xfermode, disabled\n",
> +		       ap->id);
>  		ata_port_disable(ap);
> -	else
> -		ata_qc_wait_err(qc, &wait);
> +	}
>  
>  	DPRINTK("EXIT\n");
>  }
> @@ -2330,41 +2391,25 @@ static void ata_dev_set_xfermode(struct 
>  
>  static void ata_dev_reread_id(struct ata_port *ap, struct ata_device *dev)
>  {
> -	DECLARE_COMPLETION(wait);
> -	struct ata_queued_cmd *qc;
> -	unsigned long flags;
> -	int rc;
> -
> -	qc = ata_qc_new_init(ap, dev);
> -	BUG_ON(qc == NULL);
> +	struct ata_taskfile tf;
>  
> -	ata_sg_init_one(qc, dev->id, sizeof(dev->id));
> -	qc->dma_dir = DMA_FROM_DEVICE;
> +	ata_tf_init(ap, &tf, dev->devno);
>  
>  	if (dev->class == ATA_DEV_ATA) {
> -		qc->tf.command = ATA_CMD_ID_ATA;
> +		tf.command = ATA_CMD_ID_ATA;
>  		DPRINTK("do ATA identify\n");
>  	} else {
> -		qc->tf.command = ATA_CMD_ID_ATAPI;
> +		tf.command = ATA_CMD_ID_ATAPI;
>  		DPRINTK("do ATAPI identify\n");
>  	}
>  
> -	qc->tf.flags |= ATA_TFLAG_DEVICE;
> -	qc->tf.protocol = ATA_PROT_PIO;
> -	qc->nsect = 1;
> -
> -	qc->waiting = &wait;
> -	qc->complete_fn = ata_qc_complete_noop;
> +	tf.flags |= ATA_TFLAG_DEVICE;
> +	tf.protocol = ATA_PROT_PIO;
>  
> -	spin_lock_irqsave(&ap->host_set->lock, flags);
> -	rc = ata_qc_issue(qc);
> -	spin_unlock_irqrestore(&ap->host_set->lock, flags);
> -
> -	if (rc)
> +	if (ata_exec_internal(ap, dev, &tf, DMA_FROM_DEVICE,
> +			      dev->id, sizeof(dev->id)))
>  		goto err_out;
>  
> -	ata_qc_wait_err(qc, &wait);
> -
>  	swap_buf_le16(dev->id, ATA_ID_WORDS);
>  
>  	ata_dump_id(dev);
> @@ -2373,6 +2418,7 @@ static void ata_dev_reread_id(struct ata
>  
>  	return;
>  err_out:
> +	printk(KERN_ERR "ata%u: failed to reread ID, disabled\n", ap->id);
>  	ata_port_disable(ap);
>  }
>  
> @@ -2386,10 +2432,7 @@ err_out:
>  
>  static void ata_dev_init_params(struct ata_port *ap, struct ata_device *dev)
>  {
> -	DECLARE_COMPLETION(wait);
> -	struct ata_queued_cmd *qc;
> -	int rc;
> -	unsigned long flags;
> +	struct ata_taskfile tf;
>  	u16 sectors = dev->id[6];
>  	u16 heads   = dev->id[3];
>  
> @@ -2400,26 +2443,18 @@ static void ata_dev_init_params(struct a
>  	/* set up init dev params taskfile */
>  	DPRINTK("init dev params \n");
>  
> -	qc = ata_qc_new_init(ap, dev);
> -	BUG_ON(qc == NULL);
> -
> -	qc->tf.command = ATA_CMD_INIT_DEV_PARAMS;
> -	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
> -	qc->tf.protocol = ATA_PROT_NODATA;
> -	qc->tf.nsect = sectors;
> -	qc->tf.device |= (heads - 1) & 0x0f; /* max head = num. of heads - 1 */
> -
> -	qc->waiting = &wait;
> -	qc->complete_fn = ata_qc_complete_noop;
> -
> -	spin_lock_irqsave(&ap->host_set->lock, flags);
> -	rc = ata_qc_issue(qc);
> -	spin_unlock_irqrestore(&ap->host_set->lock, flags);
> +	ata_tf_init(ap, &tf, dev->devno);
> +	tf.command = ATA_CMD_INIT_DEV_PARAMS;
> +	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
> +	tf.protocol = ATA_PROT_NODATA;
> +	tf.nsect = sectors;
> +	tf.device |= (heads - 1) & 0x0f; /* max head = num. of heads - 1 */
>  
> -	if (rc)
> +	if (ata_exec_internal(ap, dev, &tf, DMA_NONE, NULL, 0)) {
> +		printk(KERN_ERR "ata%u: failed to init parameters, disabled\n",
> +		       ap->id);
>  		ata_port_disable(ap);
> -	else
> -		ata_qc_wait_err(qc, &wait);
> +	}
>  
>  	DPRINTK("EXIT\n");

