From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA ATAPI work in progress
Date: Thu, 13 May 2004 17:16:05 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A3E595.8000003@pobox.com>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com> <1084403654.3196.31.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63933 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264976AbUEMVQU
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 May 2004 17:16:20 -0400
In-Reply-To: <1084403654.3196.31.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
> The dmesg tell me my guess below of how to do this actually ended up
> writing the x1F7 Command = xA0 Packet twice, whoops.
> 
> Please choose for me from:
> 
> 1) Keep only the atapi_start/ ata_tf_to_host_nolock/
> ata_exec_command_pio.
> 
> 2) Keep only the worker_thread/ atapi_packet_task/ ata_bmdma_start_pio/
> ata_exec_command_pio.
> 
> 3) Try something else entirely.


You are close:

For an ATA device, we
* write the taskfile, except for command
* set up the DMA engine
* write the command
* write DMA-start bit

And the functions used by the low-level drivers, ata_bmdma_start_mmio 
and ata_bmdma_start_pio, are hardcoded to use this ordering.  By 
contrast, for ATAPI you should do:
* set up DMA engine
* write entire taskfile, including command
* proceed through state diagram until DRQ==1
* write SCSI CDB
* write DMA-start bit


>>as you don't want
>>to bother with PIO or [SM]WDMA right now.
> 
> 
> I'm happy starting with SATA PIO, if you like that better.
> 
> I do eventually want to talk SATA UDMA because I hope to end by
> achieving burst rates more like the 133 MB/s of UDMA, well above the
> 16.7 MB/s limit of PATA PIO 4.
> 
> For ATAPI myself I recommend DMA only for well-known block ops, in order
> to get the exact byte counting of PIO otherwise.

I prefer starting with Ultra DMA, since that will not only be common 
case, but it is also how the engine is set up right now.

There are a few internal, to-be-removed limitations if you do not use 
ultra DMA.


> diff -Nurp linux-2.6.6-bk1/drivers/scsi/libata-scsi.c linux-2.6.6-bk1-pel/drivers/scsi/libata-scsi.c
> --- linux-2.6.6-bk1/drivers/scsi/libata-scsi.c	2004-05-12 09:57:09.000000000 -0600
> +++ linux-2.6.6-bk1-pel/drivers/scsi/libata-scsi.c	2004-05-12 15:51:10.000000000 -0600
> @@ -215,6 +215,45 @@ int ata_scsi_error(struct Scsi_Host *hos
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
> + *	Choose ATAPI PIO BCL from:
> + *
> + *		0x2000 = 8 Ki = one SATA FIS
> + *		0xFFFE = largest specified in oldest public docs
> + *		0xFFFF = first massively distributed (Win 95B)
> + *
> + *	RETURNS:
> + *	Zero on success, non-zero on error.
> + */
> +
> +static unsigned int atapi_xlat(struct ata_queued_cmd *qc, u8 *scsicmd)
> +{
> +	int bcl = (8 * 0x400); /* PIO "byte count limit" */

Make this a more obvious "8 * 1024".

For the sake of correctness, I prefer to call this "DRQ block size" 
rather than the more ambigous "byte count limit".

This is important because some AHCI SATA controllers can only transfer a 
_single_ DRQ block per disk transaction.  In anticipation of the demise 
of PIO, no doubt :)


> +	struct ata_taskfile *tf = &qc->tf;
> +	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
> +	tf->protocol = qc->dev->xfer_protocol;
> +	tf->command = ATA_CMD_PACKET; /* often 0xA0 */

kill the comment, this should be obvious to anyone who reads the public 
specs.  That's why we have the constant, after all...


> +	if (qc->flags & ATA_QCFLAG_DMA) {
> +		DPRINTK("DMA ATAPI 0x%lX %d\n", qc->flags, qc->tf.protocol);
> +		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
> +		tf->feature = ATAPI_PKT_DMA; /* often x01 */

kill the comment


> +	} else {
> +		DPRINTK("PIO ATAPI 0x%lX %d\n", qc->flags, qc->tf.protocol);
> +		qc->tf.protocol = ATA_PROT_ATAPI;
> +		tf->lbam = bcl >> 8;
> +		tf->lbah = bcl;
> +	}
> +	qc->flags |= ATA_QCFLAG_ATAPI;
> +	return 0;
>  }

key flags that should be used, but are just being deleted in the 
previous chunk:
ATA_QCFLAG_SG
ATA_NIEN
ATA_QCFLAG_POLL

Their proper placement is left as an exercise to the reader, who seems 
to be doing well so far :)


>  /**
> @@ -885,78 +924,6 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
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
> -}
> -
> -/**
>   *	ata_scsi_find_dev - lookup ata_device from scsi_cmnd
>   *	@ap: ATA port to which the device is attached
>   *	@cmd: SCSI command to be sent to the device
> @@ -1010,8 +977,12 @@ ata_scsi_find_dev(struct ata_port *ap, s
>   *	Pointer to translation function if possible, %NULL if not.
>   */
>  
> -static inline ata_xlat_func_t ata_get_xlat_func(u8 cmd)
> +static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
>  {
> +	if (dev->class == ATA_DEV_ATAPI) { /* (thus != ATA_DEV_ATAPI_UNSUP) */
> +		return atapi_xlat;
> +	}
> +
>  	switch (cmd) {
>  	case READ_6:
>  	case READ_10:

Remove the extraneous braces and the comment :)

otherwise OK.


> @@ -1072,6 +1043,7 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
>  {
>  	struct ata_port *ap;
>  	struct ata_device *dev;
> +	ata_xlat_func_t xlat_func;
>  
>  	ap = (struct ata_port *) &cmd->device->host->hostdata[0];
>  

OK


> @@ -1084,15 +1056,11 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
>  		goto out_unlock;
>  	}
>  
> -	if (dev->class == ATA_DEV_ATA) {
> -		ata_xlat_func_t xlat_func = ata_get_xlat_func(cmd->cmnd[0]);
> -
> -		if (xlat_func)
> -			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
> -		else
> -			ata_scsi_simulate(ap, dev, cmd, done);
> -	} else
> -		atapi_scsi_queuecmd(ap, dev, cmd, done);
> +	xlat_func = ata_get_xlat_func(dev, cmd->cmnd[0]);
> +	if (xlat_func)
> +		ata_scsi_translate(ap, dev, cmd, done, xlat_func);
> +	else
> +		ata_scsi_simulate(ap, dev, cmd, done);

OK


