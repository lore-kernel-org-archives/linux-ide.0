From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 01/14] libata: update atapi_eh_request_sense() such that
 lbam/lbah contains buffer size
Date: Tue, 04 Dec 2007 14:27:31 -0500
Message-ID: <4755AA23.7010108@garzik.org>
References: <1196346817387-git-send-email-htejun@gmail.com> <11963468181752-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58742 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbXLDT1e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 14:27:34 -0500
In-Reply-To: <11963468181752-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Tejun Heo wrote:
> While updating lbam/h for ATAPI commands, atapi_eh_request_sense() was
> left out.  Update it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-eh.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 77083b5..2e3d3a2 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1302,8 +1302,8 @@ static unsigned int atapi_eh_request_sense(struct ata_queued_cmd *qc)
>  		tf.feature |= ATAPI_PKT_DMA;
>  	} else {
>  		tf.protocol = ATA_PROT_ATAPI;
> -		tf.lbam = (8 * 1024) & 0xff;
> -		tf.lbah = (8 * 1024) >> 8;
> +		tf.lbam = SCSI_SENSE_BUFFERSIZE;
> +		tf.lbah = 0;

seems like #upstream-fixes material?


