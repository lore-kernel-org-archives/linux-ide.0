From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: T10/04-262 ATA pass thru - another patch.
Date: Tue, 05 Oct 2004 23:10:55 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4163623F.4030407@pobox.com>
References: <20041005182049.E13871@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8074 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266793AbUJFDLN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Oct 2004 23:11:13 -0400
In-Reply-To: <20041005182049.E13871@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linux-ide@vger.kernel.org, John Linville <linville@redhat.com>, linville@tuxdriver.com, Pat LaVarre <p.lavarre@ieee.org>, Mark Lord <mlord@pobox.com>

Andy Warner wrote:
> Attached are two patchfiles, which implement the following
> features of libata ATA pass-thru:
> 
>  o check condition processing
>  o 12-byte CDB handling
> 
> patch.041005 can be applied to vanilla libata-2.6 trees
> patch-dev.041005 can be applied to libata-dev-2.6 trees

Make sure to split up patches into separate emails, and don't combine 
e.g. your error register patch with a passthru update patch.

Separate changes go into separate patches.

http://linux.yyz.us/patch-format.html
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt



> diff -ur -X /tmp/dontdiff libata-dev-2.6/drivers/scsi/libata-scsi.c hotplug/drivers/scsi/libata-scsi.c
> --- libata-dev-2.6/drivers/scsi/libata-scsi.c	2004-10-05 16:23:15.000000000 -0500
> +++ hotplug/drivers/scsi/libata-scsi.c	2004-10-05 16:41:26.459332921 -0500
> @@ -468,6 +315,85 @@
>  	}
>  }
>  
> +/*
> + *	ata_pass_thru_cc - Generate check condition sense block.
> + *	@qc: Command that completed.
> + *
> + *	Regardless of whether the command errored or not, return
> + *	a sense block. Copy all controller registers into
> + *	the sense block. Clear sense key, ASC & ASCQ if
> + *	there is no error.
> + *
> + *	LOCKING:
> + *	spin_lock_irqsave(host_set lock)
> + */
> +void ata_pass_thru_cc(struct ata_queued_cmd *qc, u8 drv_stat)
> +{
> +	struct scsi_cmnd *cmd = qc->scsicmd;
> +	struct ata_taskfile *tf = &qc->tf;
> +	unsigned char *sb = cmd->sense_buffer;
> +	unsigned char *desc = sb + 8 ;
> +
> +	cmd->result = SAM_STAT_CHECK_CONDITION;
> +
> +	/*
> +	 * Use ata_to_sense_error() to map status register bits
> +	 * onto sense key, asc & ascq. We will overwrite some
> +	 * (many) of the fields later.
> +	 *
> +	 * TODO: reorganise better, by splitting ata_to_sense_error()
> +	 */
> +	if (unlikely(drv_stat & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
> +		ata_to_sense_error(qc, drv_stat) ;
> +	} else {
> +		sb[3] = sb[2] = sb[1] = 0x00 ;
> +	}
> +
> +	/*
> +	 * Sense data is current and format is
> +	 * descriptor.
> +	 */
> +	sb[0] = 0x72 ;
> +
> +	desc[0] = 0x8e ;	/* TODO: replace with official value. */

prefer constants to magic numbers


> +	/*
> +	 * Set length of additional sense data.
> +	 * Since we only populate descriptor 0, the total
> +	 * length is the same (fixed) length as descriptor 0.
> +	 */
> +	desc[1] = sb[7] = 14 ;
> +
> +	/*
> +	 * Read the controller registers.
> +	 */
> +	qc->ap->ops->tf_read(qc->ap, tf);
> +
> +	/*
> +	 * Copy registers into sense buffer.
> +	 */
> +	desc[2] = 0x00 ;
> +	desc[3] = tf->feature ;	/* Note: becomes error register when read. */
> +	desc[5] = tf->nsect ;
> +	desc[7] = tf->lbal ;
> +	desc[9] = tf->lbam ;
> +	desc[11] = tf->lbah ;
> +	desc[12] = tf->device ;
> +	desc[13] = drv_stat ;
> +
> +	/*
> +	 * Fill in Extend bit, and the high order bytes
> +	 * if applicable.
> +	 */
> +	if (tf->flags & ATA_TFLAG_LBA48) {
> +		desc[2] |= 0x01 ;
> +		desc[4] = tf->hob_nsect ;
> +		desc[6] = tf->hob_lbal ;
> +		desc[8] = tf->hob_lbam ;
> +		desc[10] = tf->hob_lbah ;
> +	}
> +}
> +
>  /**
>   *	ata_scsi_slave_config - Set SCSI device attributes
>   *	@sdev: SCSI device to examine
> @@ -785,7 +711,7 @@
>  	 * ASCQ will all be zero.
>  	 */
>  	if ((cmd->cmnd[0] == ATA_16) && (cmd->cmnd[2] & 0x20)) {
> -/*DWD*/		printk("XX  0x%0lx/0x%0x\n", qc->tf.flags, qc->tf.protocol);
> +		ata_pass_thru_cc(qc, drv_stat) ;
>  	} else {
>  		if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
>  			ata_to_sense_error(qc, drv_stat);
> @@ -853,6 +779,7 @@
>  
>  	if (xlat_func(qc, scsicmd))
>  		goto err_out;
> +
>  	/* select device, send command to hardware */
>  	if (ata_qc_issue(qc))
>  		goto err_out;
> @@ -1533,9 +1460,11 @@
>  }
>  
>  /*
> - * ata_scsi_map_proto() -	Map the protocol specified
> - *				in the pass-thru CDB onto the
> - *				protocol values used by taskfiles.
> + *	ata_scsi_map_proto - Map pass-thru protocol value to taskfile value.
> + *	@byte1: Byte 1 from pass-thru CDB.
> + *
> + *	RETURNS:
> + *	ATA_PROT_UNKNOWN if mapping failed/unimplemented, protocol otherwise.
>   */
>  static u8
>  ata_scsi_map_proto(u8 byte1)
> @@ -1571,8 +1500,18 @@
>  	return ATA_PROT_UNKNOWN;
>  }
>  
> +/**
> + *	ata_scsi_pass_thru - convert ATA pass-thru CDB to taskfile
> + *	@qc: command structure to be initialized
> + *	@cmd: SCSI command to convert
> + *
> + *	Handles either 12 or 16-byte versions of the CDB.
> + *
> + *	RETURNS:
> + *	Zero on success, non-zero on failure.
> + */
>  static unsigned int
> -ata_scsi_pass_thru_16(struct ata_queued_cmd *qc, u8 *scsicmd)
> +ata_scsi_pass_thru(struct ata_queued_cmd *qc, u8 *scsicmd)
>  {
>  	struct ata_taskfile *tf = &(qc->tf);
>  	struct scsi_cmnd *cmd = qc->scsicmd;
> @@ -1582,45 +1521,70 @@
>  	}
>  
>  	/*
> -	 * If the CDB claims to contain extended
> -	 * ATA commands copy the upper byte register values.
> -	 * 
> -	 * NOTE: at present copy all register fields,
> -	 * regardless of which ones are valid according
> -	 * to the .En bits. TODO: research optimal
> -	 * algorithm for this.
> +	 * 12 and 16 byte CDBs use different offsets to
> +	 * provide the various register values.
>  	 */
> -	if (scsicmd[1] & 0x01) {
> -		tf->hob_feature = scsicmd[3];
> -		tf->hob_nsect = scsicmd[5];
> -		tf->hob_lbal = scsicmd[7];
> -		tf->hob_lbam = scsicmd[9];
> -		tf->hob_lbah = scsicmd[11];
> -		tf->flags |= ATA_TFLAG_LBA48 ;
> +	if (scsicmd[0] == ATA_16) {
> +		/*
> +		 * 16-byte CDB - may contain extended commands.
> +		 *
> +		 * If that is the case, copy the upper byte register values.
> +		 */
> +		if (scsicmd[1] & 0x01) {
> +			tf->hob_feature = scsicmd[3];
> +			tf->hob_nsect = scsicmd[5];
> +			tf->hob_lbal = scsicmd[7];
> +			tf->hob_lbam = scsicmd[9];
> +			tf->hob_lbah = scsicmd[11];
> +			tf->flags |= ATA_TFLAG_LBA48 ;
> +		} else {
> +			tf->flags &= ~ATA_TFLAG_LBA48 ;
> +		}

ATA_TFLAG_LBA48 is dependent on device capabilities, not just what the 
user inputs.

