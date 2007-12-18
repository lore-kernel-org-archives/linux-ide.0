From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 01/15] libata: make atapi_request_sense() use sg
Date: Tue, 18 Dec 2007 16:30:26 -0500
Message-ID: <47683BF2.8090604@garzik.org>
References: <11968405951262-git-send-email-htejun@gmail.com> <11968405951137-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36653 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbXLRVac (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Dec 2007 16:30:32 -0500
In-Reply-To: <11968405951137-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Rusty Russel <rusty@rustcorp.com.au>

Tejun Heo wrote:
> atapi_request_sense() is now the only left user of ata_sg_init_one().
> Convert it to use sg interface.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Rusty Russel <rusty@rustcorp.com.au>
> ---
>  drivers/ata/libata-scsi.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index a1ec970..29e8336 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2340,7 +2340,9 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
>  
>  	ata_qc_reinit(qc);
>  
> -	ata_sg_init_one(qc, cmd->sense_buffer, sizeof(cmd->sense_buffer));
> +	/* setup sg table and init transfer direction */
> +	sg_init_one(&qc->sgent, cmd->sense_buffer, sizeof(cmd->sense_buffer));
> +	ata_sg_init(qc, &qc->sgent, 1);
>  	qc->dma_dir = DMA_FROM_DEVICE;

applied 1-4 to #upstream, although patch #3 was imported from 
upstream-fixes (update atapi buffersize in request-sense)

	Jeff



