From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA ATAPI work in progress
Date: Wed, 12 May 2004 16:40:22 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A28BB6.7090204@pobox.com>
References: <1084393233.3999.2.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53129 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265222AbUELUki
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 May 2004 16:40:38 -0400
In-Reply-To: <1084393233.3999.2.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
>>>From: [offline]
>>>1) atapi_scsi_queuecmd() should be deleted,
>>>and instead a translation function should be
>>>supplied for ata_scsi_translate() for all
>>>ATAPI devices, resulting in a PACKET
>>>taskfile.
> 
> 
> For 2.6.6-bk1 I wrote the following trivial patch.
> 
> Is my patch a step forward?

Yeah, it's a decent first step.


> Given ATA_ENABLE_ATAPI ATA_DEBUG ATA_VERBOSE_DEBUG, then now the initial
> op x12 Inquiry now instead chokes via:
> 
> kernel: ata2: DMA timeout, stat 0x21
> kernel: ata_dma_complete: ENTER
> kernel: ata_dma_complete: host 2, host_stat==0x21, drv_stat==0x58
> kernel: ATA: abnormal status 0x58 on port 0xE007
> 
> Looks like I've asked to start the Data DMA In before my PIO Command
> Out?  Left to myself, maybe next I'll go digging in ata_tf_load_pio and
> ata_exec_command_pio.

Well first, you need to make sure your ATAPI device supports ultra DMA, 
as you don't want to bother with PIO or [SM]WDMA right now.

But yeah, after that, it's time to go digging.  I generally use 
drivers/ide and Hale Landis's ATADRVR (http://www.ata-atapi.com/) for 
comparing IO write-for-write, to make sure I have the steps and the 
state machine correct.  And of course the state machine docs itself, in 
ATA/ATAPI7.

>>From: linux-2.6.6-bk1/
> 
> 
> `modprobe -r ata-piix; modprobe ata-piix` now seemingly work without
> reboot, thank you.
> 
> 
>>>From: [offline]
>>>2) Issue and process a REQUEST SENSE
>>>internally, based on the PACKET ... returns.
> 
> 
> This means "auto sense", I think.
> 
> 
>>>based on the PACKET sense key returns.
> 
> 
> This means auto sense when (x1F1 Error & xF0 SK) are nonzero, I think.
> 
> This design choice surprises me.  I vote we auto sense when (x3F6
> AlternateStatus & x01 ERR) is nonzero, so that still we see sense even
> when SK ASC ASCQ is zero, in particular when ASC ASCQ is nonzero in
> combination with zero SK.  Also we thus duck trusting the redundant copy
> of SK.

libata should provide the illusion that an ATAPI device always provides 
autosense on each command.  For various reasons, we can't let the SCSI 
layer just call REQUEST SENSE as it does for scsi-1/2 devices during 
scsi_unjam_host().


> diff -Nurp linux-2.6.6-bk1/drivers/scsi/libata-scsi.c linux-2.6.6-bk1-pel/drivers/scsi/libata-scsi.c
> --- linux-2.6.6-bk1/drivers/scsi/libata-scsi.c	2004-05-12 09:57:09.000000000 -0600
> +++ linux-2.6.6-bk1-pel/drivers/scsi/libata-scsi.c	2004-05-12 14:01:27.530354416 -0600
> @@ -215,6 +215,35 @@ int ata_scsi_error(struct Scsi_Host *hos
>  
>  	DPRINTK("EXIT\n");
>  	return 0;
> +} 
> +
> +/**
> + *	atapi_xlat - Pass SCSI r/w command thru to ATAPI
> + *	@qc: Storage for translated ATA taskfile
> + *	@scsicmd: SCSI command to translate
> + *
> + *	Trust caller already cleared *qc->tf (often via ata_tf_init),
> + *	deciding tf->device & (0x10 ATA_DEV1 | 0x07 SFF 8070i LUN), etc.
> + *
> + *	RETURNS:
> + *	Zero on success, non-zero on error.
> + */
> +
> +static unsigned int atapi_xlat(struct ata_queued_cmd *qc, u8 *scsicmd)
> +{
> +	struct ata_taskfile *tf = &qc->tf;
> +	tf->flags &= ~ATA_TFLAG_LBA48;

I'm not sure you should bother with this.


> +	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
> +	tf->protocol = qc->dev->xfer_protocol;
> +#ifdef ATA_FORCE_PIO
> +#else
> +	tf->feature = ATAPI_PKT_DMA; /* often x01 */
> +#endif

don't use ifdef, test ATA_QCFLAG_DMA bit


> +	tf->lbam = 0xFE; /* PIO "byte count limit" */
> +	tf->lbah = 0xFF;

for DMA, set this to zero.

for PIO, set this to 8K (one SATA FIS).


> +	tf->command = ATA_CMD_PACKET; /* often 0xA0 */
> +	DPRINTK("ATAPI\n");
> +	return 0;
>  }
>  
>  /**
> @@ -885,78 +914,6 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
>  }
>  
>  /**
> - *	atapi_scsi_queuecmd - Send CDB to ATAPI device
> - *	@ap: Port to which ATAPI device is attached.
> - *	@dev: Target device for CDB.
> - *	@cmd: SCSI command being sent to device.
> - *	@done: SCSI command completion function.
> - *
> - *	Sends CDB to ATAPI device.  If the Linux SCSI layer sends a
> - *	non-data command, then this function handles the command
> - *	directly, via polling.  Otherwise, the bmdma engine is started.
> - *
> - *	LOCKING:
> - *	spin_lock_irqsave(host_set lock)
> - */
> -
> -static void atapi_scsi_queuecmd(struct ata_port *ap, struct ata_device *dev,
> -			       struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
> -{
> -	struct ata_queued_cmd *qc;
> -	u8 *scsicmd = cmd->cmnd;
> -
> -	VPRINTK("ENTER, drv_stat = 0x%x\n", ata_chk_status(ap));
> -
> -	if (cmd->sc_data_direction == SCSI_DATA_UNKNOWN) {
> -		DPRINTK("unknown data, scsicmd 0x%x\n", scsicmd[0]);
> -		ata_bad_cdb(cmd, done);
> -		return;
> -	}
> -
> -	switch(scsicmd[0]) {
> -	case READ_6:
> -	case WRITE_6:
> -	case MODE_SELECT:
> -	case MODE_SENSE:
> -		DPRINTK("read6/write6/modesel/modesense trap\n");
> -		ata_bad_scsiop(cmd, done);
> -		return;
> -
> -	default:
> -		/* do nothing */
> -		break;
> -	}
> -
> -	qc = ata_scsi_qc_new(ap, dev, cmd, done);
> -	if (!qc) {
> -		printk(KERN_ERR "ata%u: command queue empty\n", ap->id);
> -		return;
> -	}
> -
> -	qc->flags |= ATA_QCFLAG_ATAPI;
> -
> -	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
> -	if (cmd->sc_data_direction == SCSI_DATA_WRITE) {
> -		qc->tf.flags |= ATA_TFLAG_WRITE;
> -		DPRINTK("direction: write\n");
> -	}
> -
> -	qc->tf.command = ATA_CMD_PACKET;
> -
> -	if (cmd->sc_data_direction == SCSI_DATA_NONE) {
> -		qc->tf.protocol = ATA_PROT_ATAPI;
> -		qc->flags |= ATA_QCFLAG_POLL;
> -		qc->tf.ctl |= ATA_NIEN;	/* disable interrupts */
> -	} else {
> -		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
> -		qc->flags |= ATA_QCFLAG_SG; /* data is present; dma-map it */
> -		qc->tf.feature |= ATAPI_PKT_DMA;
> -	}
> -
> -	atapi_start(qc);

Note that by deleting this, there is no longer anything to start the 
ATAPI transfer really.

You must the latter half of the above code [the part you are deleting] 
either to ata_qc_issue_prot() or your new atapi_xlat().


>   *	ata_scsi_find_dev - lookup ata_device from scsi_cmnd
>   *	@ap: ATA port to which the device is attached
>   *	@cmd: SCSI command to be sent to the device
> @@ -1086,13 +1043,13 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
>  
>  	if (dev->class == ATA_DEV_ATA) {
>  		ata_xlat_func_t xlat_func = ata_get_xlat_func(cmd->cmnd[0]);
> -
>  		if (xlat_func)
>  			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
>  		else
>  			ata_scsi_simulate(ap, dev, cmd, done);
> -	} else
> -		atapi_scsi_queuecmd(ap, dev, cmd, done);
> +	} else {
> +		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
> +	}

Good guess, close.

At this point, just eliminate the dev->class test, and simplify the 
above code down to

	ata_xlat_func_t xlat_func = ata_get_xlat_func(cmd->cmnd[0]);

	if (xlat_func)
		ata_scsi_translate(ap, dev, cmd, done, xlat_func);
	else
		ata_scsi_simulate(ap, dev, cmd, done);

Thus, you must modify ata_get_xlat_func to return atapi_xlat when 
dev->class == ATAPI, and to execute the existing 'switch' statement for 
dev->class == ATA.

	Jeff




