From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 13/22] libata: implement qc->result_tf
Date: Thu, 18 May 2006 15:10:29 +0800
Message-ID: <446C1DE5.5080000@tw.ibm.com>
References: <11473487911193-git-send-email-htejun@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:57813 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751306AbWERHKz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 May 2006 03:10:55 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4I7AWt5010854
	for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 03:10:32 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4I7AWRI250682
	for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 01:10:32 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k4I7AVWR030375
	for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 01:10:32 -0600
In-Reply-To: <11473487911193-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Add qc->result_tf and ATA_QCFLAG_RESULT_TF.  This moves the
> responsibility of loading result TF from post-compltion path to qc
> execution path.  qc->result_tf is loaded if explicitly requested or
> the qc failsa.  This allows more efficient completion implementation
> and correct handling of result TF for controllers which don't have
> global TF representation such as sil3124/32.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-core.c |    4 ++--
>  drivers/scsi/libata-scsi.c |   18 +++++++-----------
>  include/linux/libata.h     |   16 ++++++++++++++--
>  3 files changed, 23 insertions(+), 15 deletions(-)
> 
> 46a93ec2cb1124f507e0cad7dcb65794a15af844
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 464fd46..4cb7828 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -955,7 +955,6 @@ void ata_qc_complete_internal(struct ata
>  {
>  	struct completion *waiting = qc->private_data;
>  
> -	qc->ap->ops->tf_read(qc->ap, &qc->tf);
>  	complete(waiting);
>  }
>  
> @@ -997,6 +996,7 @@ unsigned ata_exec_internal(struct ata_po
>  	qc->tf = *tf;
>  	if (cdb)
>  		memcpy(qc->cdb, cdb, ATAPI_CDB_LEN);
> +	qc->flags |= ATA_QCFLAG_RESULT_TF;
>  	qc->dma_dir = dma_dir;
>  	if (dma_dir != DMA_NONE) {
>  		ata_sg_init_one(qc, buf, buflen);
> @@ -1034,7 +1034,7 @@ unsigned ata_exec_internal(struct ata_po
>  	/* finish up */
>  	spin_lock_irqsave(&ap->host_set->lock, flags);
>  
> -	*tf = qc->tf;
> +	*tf = qc->result_tf;
>  	err_mask = qc->err_mask;
>  
>  	ata_qc_free(qc);
> diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
> index b0c83c2..ce90b63 100644
> --- a/drivers/scsi/libata-scsi.c
> +++ b/drivers/scsi/libata-scsi.c
> @@ -537,7 +537,7 @@ void ata_to_sense_error(unsigned id, u8 
>  void ata_gen_ata_desc_sense(struct ata_queued_cmd *qc)
>  {
>  	struct scsi_cmnd *cmd = qc->scsicmd;
> -	struct ata_taskfile *tf = &qc->tf;
> +	struct ata_taskfile *tf = &qc->result_tf;
>  	unsigned char *sb = cmd->sense_buffer;
>  	unsigned char *desc = sb + 8;
>  
> @@ -608,7 +608,7 @@ void ata_gen_ata_desc_sense(struct ata_q
>  void ata_gen_fixed_sense(struct ata_queued_cmd *qc)
>  {
>  	struct scsi_cmnd *cmd = qc->scsicmd;
> -	struct ata_taskfile *tf = &qc->tf;
> +	struct ata_taskfile *tf = &qc->result_tf;
>  	unsigned char *sb = cmd->sense_buffer;
>  
>  	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
> @@ -1199,14 +1199,11 @@ static void ata_scsi_qc_complete(struct 
>  	 */
>  	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
>   	    ((cdb[2] & 0x20) || need_sense)) {
> -		qc->ap->ops->tf_read(qc->ap, &qc->tf);
>   		ata_gen_ata_desc_sense(qc);
>  	} else {
>  		if (!need_sense) {
>  			cmd->result = SAM_STAT_GOOD;
>  		} else {
> -			qc->ap->ops->tf_read(qc->ap, &qc->tf);
> -
>  			/* TODO: decide which descriptor format to use
>  			 * for 48b LBA devices and call that here
>  			 * instead of the fixed desc, which is only
> @@ -1217,10 +1214,8 @@ static void ata_scsi_qc_complete(struct 
>  		}
>  	}
>  
> -	if (need_sense) {
> -		/* The ata_gen_..._sense routines fill in tf */
> -		ata_dump_status(qc->ap->id, &qc->tf);
> -	}
> +	if (need_sense)
> +		ata_dump_status(qc->ap->id, &qc->result_tf);
>  
>  	qc->scsidone(cmd);
>  
> @@ -2004,7 +1999,6 @@ static void atapi_sense_complete(struct 
>  		 * a sense descriptors, since that's only
>  		 * correct for ATA, not ATAPI
>  		 */
> -		qc->ap->ops->tf_read(qc->ap, &qc->tf);
>  		ata_gen_ata_desc_sense(qc);
>  	}
>  
> @@ -2080,7 +2074,6 @@ static void atapi_qc_complete(struct ata
>  		 * a sense descriptors, since that's only
>  		 * correct for ATA, not ATAPI
>  		 */
> -		qc->ap->ops->tf_read(qc->ap, &qc->tf);
>  		ata_gen_ata_desc_sense(qc);
>  	} else {
>  		u8 *scsicmd = cmd->cmnd;
> @@ -2361,6 +2354,9 @@ ata_scsi_pass_thru(struct ata_queued_cmd
>  	 */
>  	qc->nsect = cmd->bufflen / ATA_SECT_SIZE;
>  
> +	/* request result TF */
> +	qc->flags |= ATA_QCFLAG_RESULT_TF;
> +
>  	return 0;
>  
>   invalid_fld:
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index a117ca2..3d15c00 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -162,7 +162,9 @@ enum {
>  	ATA_QCFLAG_SINGLE	= (1 << 2), /* no s/g, just a single buffer */
>  	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
>  	ATA_QCFLAG_IO		= (1 << 3), /* standard IO command */
> -	ATA_QCFLAG_EH_SCHEDULED = (1 << 4), /* EH scheduled */
> +	ATA_QCFLAG_RESULT_TF	= (1 << 4), /* result TF requested */
> +
> +	ATA_QCFLAG_EH_SCHEDULED = (1 << 16), /* EH scheduled */
>  
>  	/* host set flags */
>  	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host_set only */
> @@ -343,7 +345,7 @@ struct ata_queued_cmd {
>  	struct scatterlist	*__sg;
>  
>  	unsigned int		err_mask;
> -
> +	struct ata_taskfile	result_tf;
>  	ata_qc_cb_t		complete_fn;
>  
>  	void			*private_data;
> @@ -824,6 +826,10 @@ static inline void ata_qc_reinit(struct 
>  	qc->err_mask = 0;
>  
>  	ata_tf_init(qc->ap, &qc->tf, qc->dev->devno);
> +
> +	/* init result_tf such that it indicates normal completion */
> +	qc->result_tf.command = ATA_DRDY;

Normally 0x50 is seen with normal completion, not 0x40.
Do we really have to fake qc->result_tf here? Maybe just keep it zero or garbage
is good enough: if err_mask == 0 and ATA_QCFLAG_RESULT_TF is not set, qc->result_tf
shouldn't be used anyway.

--
albert

