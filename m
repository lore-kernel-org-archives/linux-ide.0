From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Delegate nonrot flag setting to SCSI
Date: Wed, 24 Jun 2009 21:36:29 -0400
Message-ID: <4A42D49D.1070100@garzik.org>
References: <yq1eit9rurq.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47280 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601AbZFYBfx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Jun 2009 21:35:53 -0400
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

Does the existence of this code cause any problems or regressions today?

It looks correct vis a vis current drivers/scsi/sd.c, but given that the 
merge window just closed, I lean towards classifying this as a cleanup 
(thus, 2.6.32).

	Jeff




