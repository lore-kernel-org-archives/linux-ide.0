From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/6] libsas: use ata_is_ncq() and ata_has_dma() accessors
Date: Mon, 20 Jun 2016 11:40:16 -0400
Message-ID: <20160620154016.GJ3262@mtj.duckdns.org>
References: <1466422756-126637-1-git-send-email-hare@suse.de>
 <1466422756-126637-3-git-send-email-hare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34391 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782AbcFTQjt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2016 12:39:49 -0400
Received: by mail-yw0-f195.google.com with SMTP id l125so4044354ywb.1
        for <linux-ide@vger.kernel.org>; Mon, 20 Jun 2016 09:38:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1466422756-126637-3-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <damien.lemoal@hgst.com>, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>

On Mon, Jun 20, 2016 at 01:39:12PM +0200, Hannes Reinecke wrote:
> Use accessors instead of the raw protocol value.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/scsi/libsas/sas_ata.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> index 935c430..e1da52c 100644
> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -233,15 +233,10 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
>  	task->task_state_flags = SAS_TASK_STATE_PENDING;
>  	qc->lldd_task = task;
>  
> -	switch (qc->tf.protocol) {
> -	case ATA_PROT_NCQ:
> +	if (ata_is_ncq(qc->tf.protocol))
>  		task->ata_task.use_ncq = 1;
> -		/* fall through */
> -	case ATAPI_PROT_DMA:
> -	case ATA_PROT_DMA:
> +	if (ata_is_dma(qc->tf.protocol))
>  		task->ata_task.dma_xfer = 1;
> -		break;
> -	}

As you're cleaning it up anyway, can you please make ata_is_*()
functions return bool and do

	task->ata_task.use_ncq = ata_is_ncq()

instead?

-- 
tejun
