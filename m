From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ATAPI error handling work
Date: Thu, 6 Oct 2005 14:35:29 +0900
Message-ID: <20051006053529.GA25976@htj.dyndns.org>
References: <43443CC7.5040706@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.197]:47248 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751232AbVJFFfi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2005 01:35:38 -0400
Received: by wproxy.gmail.com with SMTP id 57so176300wri
        for <linux-ide@vger.kernel.org>; Wed, 05 Oct 2005 22:35:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <43443CC7.5040706@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Douglas Gilbert <dougg@torque.net>

 Hello, Jeff.

On Wed, Oct 05, 2005 at 04:51:19PM -0400, Jeff Garzik wrote:
> This is a work-in-progress, attempting to fix the death of libata 
> whenever there is a SCSI error thrown to us...   IOW this fixes libata 
> EH to properly fake autosensing, rather than kicking over to the SCSI EH 
> thread for that purpose.
> 

 Great.  I just have a few questions.  Oh.. BTW, against which head is
the patch generated?  I couldn't get it applied cleanly to either
upstream or ALL.

[- snip -]
> @@ -3174,17 +3106,35 @@ out:
>  void ata_eng_timeout(struct ata_port *ap)
>  {
>  	struct ata_queued_cmd *qc;
> +	struct ata_host_set *host_set = ap->host_set;
> +	unsigned long flags;
> +	int printed_message = 0;
>  
>  	DPRINTK("ENTER\n");
>  
> +	spin_lock_irqsave(&host_set->lock, flags);
> +	while (ap->flags & ATA_FLAG_IN_EH) {
> +		spin_unlock_irqrestore(&host_set->lock, flags);
> +
> +		if (!printed_message++)
> +			printk(KERN_INFO "ata%u: waiting in timeout handler for EH\n",
> +				ap->id);
> +
> +		msleep(250);
> +
> +		spin_lock_irqsave(&host_set->lock, flags);
> +	}
> +	spin_unlock_irqrestore(&host_set->lock, flags);
> +


 I'm not really sure if synchronization around reqsense with
ATA_FLAG_IN_EH is such a good idea for the following reasons.

* IMHO, tugging in request sense into the timeout window of the
  original command is okay (or even better).

* As long as we grab host_set lock while submitting request sense,
  which we already does, the synchronization can be done safely in EH
  proper.  libata EH isn't currently ready for this but other commands
  are dealt the same way and fixing EH is the correct way, IMHO.

 Note that we really don't have to do anything special for timing out
during request sense.  Once we fix EH/interrupt handler race, it can
be handled the same way without any speical casing.


>  	qc = ata_qc_from_tag(ap, ap->active_tag);
> -	if (!qc) {
> +	if (qc)
> +		ata_qc_timeout(qc);
> +	else {
>  		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
>  		       ap->id);
>  		goto out;
>  	}
>  
> -	ata_qc_timeout(qc);
>  
>  out:
>  	DPRINTK("EXIT\n");


 I think you were trying to kill goto out and the label by moving
ata_qc_timeout() into if condition, no?  Currently, the goto out seem
a bit funny.


> diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
> --- a/drivers/scsi/libata-scsi.c
> +++ b/drivers/scsi/libata-scsi.c
> @@ -225,7 +225,7 @@ void ata_to_sense_error(struct ata_queue
>  	};
>  	int i = 0;
>  
> -	cmd->result = SAM_STAT_CHECK_CONDITION;
> +	cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
>  
>  	/*
>  	 *	Is this an error we can process/parse
> @@ -1468,7 +1468,7 @@ unsigned int ata_scsiop_report_luns(stru
>  void ata_scsi_badcmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *), u8 asc, u8 ascq)
>  {
>  	DPRINTK("ENTER\n");
> -	cmd->result = SAM_STAT_CHECK_CONDITION;
> +	cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
>  
>  	cmd->sense_buffer[0] = 0x70;
>  	cmd->sense_buffer[2] = ILLEGAL_REQUEST;
> @@ -1479,28 +1479,81 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
>  	done(cmd);
>  }
>  
> +static int atapi_qc_complete_sense(struct ata_queued_cmd *qc, u8 drv_stat)
> +{
> +	struct scsi_cmnd *cmd = qc->scsicmd;
> +
> +	if (ata_ok(drv_stat))
> +		cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
> +	else
> +		ata_to_sense_error(qc, drv_stat);
> +
> +	qc->ap->flags &= ~ATA_FLAG_IN_EH;
> +	qc->scsidone(cmd);
> +	return 0;
> +}
> +
> +static void atapi_request_sense(struct ata_queued_cmd *qc)
> +{
> +	struct ata_port *ap = qc->ap;
> +	struct scsi_cmnd *cmd = qc->scsicmd;
> +	int rc;
> +
> +	DPRINTK("ATAPI request sense\n");
> +
> +	/* FIXME: is this needed? */
> +	memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));


 This is just a side note as this part seems to be just copied from
the original request_sense function.  Anyways, I think this isn't
needed anymore.  SCSI ML seems to clear things pretty thoroughly these
days.


> +
> +	ata_sg_init_one(qc, cmd->sense_buffer, sizeof(cmd->sense_buffer));
> +	qc->dma_dir = DMA_FROM_DEVICE;
> +
> +	memset(&qc->cdb, 0, ap->cdb_len);
> +	qc->cdb[0] = REQUEST_SENSE;
> +	qc->cdb[4] = SCSI_SENSE_BUFFERSIZE;
> +
> +	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
> +	qc->tf.command = ATA_CMD_PACKET;
> +
> +	qc->tf.protocol = ATA_PROT_ATAPI;
> +	qc->tf.lbam = (8 * 1024) & 0xff;
> +	qc->tf.lbah = (8 * 1024) >> 8;
> +	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
> +
> +	qc->complete_fn = atapi_qc_complete_sense;
> +
> +	rc = ata_qc_issue(qc);
> +
> +	if (rc) {
> +		/* FIXME: complete failing command with an error */
> +		ata_port_disable(ap);
> +	}
> +
> +	/* FIXME: add timer for timeout of this command */
> +	/* control flow continues in atapi_qc_complete_sense() */
> +
> +	DPRINTK("EXIT\n");
> +}
> +
>  static int atapi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
>  {
> +	struct ata_port *ap = qc->ap;
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  
> +	rmb();


 I'm having difficult time understanding this rmb().  What is it
protecting against?


> +	if (ap->host->eh_active)
> +		return 1;
> +
>  	if (unlikely(drv_stat & (ATA_BUSY | ATA_DRQ)))
>  		ata_to_sense_error(qc, drv_stat);
> +
>  	else if (unlikely(drv_stat & ATA_ERR)) {
>  		DPRINTK("request check condition\n");
> -
> -		/* FIXME: command completion with check condition
> -		 * but no sense causes the error handler to run,
> -		 * which then issues REQUEST SENSE, fills in the sense 
> -		 * buffer, and completes the command (for the second
> -		 * time).  We need to issue REQUEST SENSE some other
> -		 * way, to avoid completing the command twice.
> -		 */
> -		cmd->result = SAM_STAT_CHECK_CONDITION;
> -
> -		qc->scsidone(cmd);
> -
> +		ap->flags |= ATA_FLAG_IN_EH;
> +		atapi_request_sense(qc);
>  		return 1;
> -	} else {
> +	}
> +
> +	else {
>  		u8 *scsicmd = cmd->cmnd;
>  
>  		if (scsicmd[0] == INQUIRY) {
> @@ -1535,6 +1588,7 @@ static int atapi_qc_complete(struct ata_
>  
>  	return 0;
>  }
> +
>  /**
>   *	atapi_xlat - Initialize PACKET taskfile
>   *	@qc: command structure to be initialized
> diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -118,6 +118,7 @@ enum {
>  	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
>  	ATA_FLAG_NOINTR		= (1 << 9), /* FIXME: Remove this once
>  					     * proper HSM is in place. */
> +	ATA_FLAG_IN_EH		= (1 << 10),
>  
>  	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
>  	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */

 Thanks.  :-)

-- 
tejun
