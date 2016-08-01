From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4] Add support for SCT Write Same
Date: Mon, 1 Aug 2016 11:40:47 +0200
Message-ID: <20160801094047.GA14677@lst.de>
References: <1469815276-18423-1-git-send-email-shaun@tancheff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469815276-18423-1-git-send-email-shaun@tancheff.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shaun Tancheff <shaun@tancheff.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Tejun Heo <tj@kernel.org>, Josh Bingaman <josh.bingaman@seagate.com>, Shaun Tancheff <shaun.tancheff@seagate.com>
List-Id: linux-ide@vger.kernel.org

> +	u8 unmap = cdb[1] & 0x8;
> +	bool use_sct = unmap ? false : true;

I think this would be a bit easier to understand if the use_sct flag
goes away, and we instead just key off "if (unmap)" below.

> -	/* for now we only support WRITE SAME with the unmap bit set */
> -	if (unlikely(!(cdb[1] & 0x8))) {
> +	/*
> +	 * If UNMAP is not set and SCT write same is not available then fail.
> +	 */
> +	if (use_sct && !ata_id_sct_write_same(dev->id)) {
>  		fp = 1;
>  		bp = 3;
>  		goto invalid_fld;

I don't think the comment adds much value.  But now that we implement
WRITE SAME for both the unmap and non-unmap case we'll also need a similar
check here to reject a WRITE SAME with the unmap flag if TRIM isn't
supported, don't we?

> @@ -3304,26 +3315,56 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
>  	if (!scsi_sg_count(scmd))
>  		goto invalid_param_len;
>  
> -	buf = page_address(sg_page(scsi_sglist(scmd)));
> -	size = ata_set_lba_range_entries(buf, 512, block, n_block);
> +	sg = scsi_sglist(scmd);
> +	buf = page_address(sg_page(sg)) + sg->offset;

I still think that this is broken for arbitrary user space pass through
command (and probably was broken before you touched the code).  We really
need something that does a kmap here.  I think the safest think to do
is to rewrite ata_set_lba_range_entries to use sg_copy_from_buffer (
and move it out of the header while we're at it).  That should be
a prep patch to the SCT support.

> +	/*
> +	 * if we only have SCT then ignore the state of unmap request
> +	 * a zero the blocks.
> +	 */
> +	if (use_sct) {

The comment doesn't match what the code does.  It only uses SCT
if use_sct, aka !unmap is true.

>  /**
> + *	ata_scsiop_maint_in - Simulate a subset of MAINTENANCE_IN
> + *	@args: device MAINTENANCE_IN data / SCSI command of interest.
> + *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
> + *
> + *	Yields a subset to satisfy scsi_report_opcode()
> + *
> + *	LOCKING:
> + *	spin_lock_irqsave(host lock)



> +	switch (cdb[3]) {
> +	case INQUIRY:
> +	case FORMAT_UNIT:
> +	case MODE_SENSE:
> +	case MODE_SENSE_10:
> +	case READ_CAPACITY:
> +	case SERVICE_ACTION_IN_16:
> +	case REPORT_LUNS:
> +	case REQUEST_SENSE:
> +	case SYNCHRONIZE_CACHE:
> +	case REZERO_UNIT:
> +	case SEEK_6:
> +	case SEEK_10:
> +	case TEST_UNIT_READY:
> +	case SEND_DIAGNOSTIC:
> +		supported = 3;
> +		break;
> +	case MAINTENANCE_IN:
> +		supported = 3;
> +		break;
> +	case READ_6:
> +	case READ_10:
> +	case READ_16:
> +	case WRITE_6:
> +	case WRITE_10:
> +	case WRITE_16:
> +		supported = 3;
> +		break;

Please handle all the supported commands in a single fallthrough
statement.

Also please make supported a bool and do the conversion to the magic
SCSI format in a single place at the end of the function.

> +	case ZBC_IN:
> +	case ZBC_OUT:
> +		supported = 3;
> +		break;

Should we report this for non-ZBC devices?
