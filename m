From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Delegate nonrot flag setting to SCSI
Date: Tue, 28 Jul 2009 21:16:57 -0400
Message-ID: <4A6FA309.3060106@garzik.org>
References: <yq1eit9rurq.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60145 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755060AbZG2BQ6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jul 2009 21:16:58 -0400
In-Reply-To: <yq1eit9rurq.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: jens.axboe@oracle.com, linux-ide@vger.kernel.org

Martin K. Petersen wrote:
> Now that the SCSI disk driver correctly handles non-rotational devices
> we can move setting the queue flag to SCSI.
> 
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> 
> ---
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1119,10 +1119,6 @@ static int ata_scsi_dev_config(struct sc
>  
>  		blk_queue_dma_drain(q, atapi_drain_needed, buf, ATAPI_MAX_DRAIN);
>  	} else {
> -		if (ata_id_is_ssd(dev->id))
> -			queue_flag_set_unlocked(QUEUE_FLAG_NONROT,
> -						sdev->request_queue);
> -
>  		/* ATA devices must be sector aligned */
>  		blk_queue_update_dma_alignment(sdev->request_queue,

applied


