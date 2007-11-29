From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 01/14] libata: update atapi_eh_request_sense() such that
 lbam/lbah contains buffer size
Date: Thu, 29 Nov 2007 15:51:40 +0000
Message-ID: <20071129155140.656e7d5e@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<11963468181752-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36919 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755820AbXK2P5G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 10:57:06 -0500
In-Reply-To: <11963468181752-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Tejun Heo <htejun@gmail.com>

On Thu, 29 Nov 2007 23:33:24 +0900
Tejun Heo <htejun@gmail.com> wrote:

> While updating lbam/h for ATAPI commands, atapi_eh_request_sense() was
> left out.  Update it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>

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
>  	}
>  
>  	return ata_exec_internal(dev, &tf, cdb, DMA_FROM_DEVICE,


-- 
--
	"Alan, I'm getting a bit worried about you."
				-- Linus Torvalds
