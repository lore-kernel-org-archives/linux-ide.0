From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] libata: switch to using block layer tagging support
Date: Wed, 20 May 2009 20:53:37 +0900
Message-ID: <4A13EF41.3060304@gmail.com>
References: <20090520065942.GD11363@kernel.dk> <20090520070038.GE11363@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:53942 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209AbZETLxl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2009 07:53:41 -0400
Received: by wa-out-1112.google.com with SMTP id j5so87339wah.21
        for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 04:53:41 -0700 (PDT)
In-Reply-To: <20090520070038.GE11363@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Hello, Jens.

Jens Axboe wrote:
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 2733b0c..04f7a8d 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -742,7 +742,11 @@ static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
>  {
>  	struct ata_queued_cmd *qc;
>  
> -	qc = ata_qc_new_init(dev);
> +	if (cmd->request->tag != -1)
> +		qc = ata_qc_new_init(dev, cmd->request->tag);
> +	else
> +		qc = ata_qc_new_init(dev, 0);
> +
>  	if (qc) {
>  		qc->scsicmd = cmd;
>  		qc->scsidone = done;
> @@ -1137,7 +1141,17 @@ static int ata_scsi_dev_config(struct scsi_device *sdev,
>  
>  		depth = min(sdev->host->can_queue, ata_id_queue_depth(dev->id));
>  		depth = min(ATA_MAX_QUEUE - 1, depth);
> -		scsi_adjust_queue_depth(sdev, MSG_SIMPLE_TAG, depth);
> +
> +		/*
> +		 * If this device is behind a port multiplier, we have
> +		 * to share the tag map between all devices on that PMP.
> +		 * Set up the shared tag map here and we get automatic.
> +		 */
> +		if (dev->link->ap->pmp_link)
> +			scsi_init_shared_tag_map(sdev->host, ATA_MAX_QUEUE - 1);
> +
> +		scsi_set_tag_type(sdev, MSG_SIMPLE_TAG);
> +		scsi_activate_tcq(sdev, depth);
>  	}

I don't think this is quite correct.  If a !NCQ device is behind PMP,
the queue won't be tagged and all requests for the device would get -1
blk tag which gets translated to 0 libata tag, which may be in use by
other NCQ or non-NCQ device behind the same PMP.

Thanks.

-- 
tejun
