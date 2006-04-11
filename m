From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 08/13] sata_sil24: put port into known state before softresetting
Date: Tue, 11 Apr 2006 13:29:13 -0400
Message-ID: <443BE769.9060604@pobox.com>
References: <1144762339468-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40837 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751050AbWDKR3U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 13:29:20 -0400
In-Reply-To: <1144762339468-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Make sure the controller has no pending commands and ready for command
> before issuing SRST.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/sata_sil24.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> 538d286b508e9d611eeb1acdfeb0bfde395a0027
> diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
> index 722b287..fed47cf 100644
> --- a/drivers/scsi/sata_sil24.c
> +++ b/drivers/scsi/sata_sil24.c
> @@ -475,6 +475,12 @@ static int sil24_softreset(struct ata_po
>  	irq_enable = readl(port + PORT_IRQ_ENABLE_SET);
>  	writel(irq_enable, port + PORT_IRQ_ENABLE_CLR);
>  
> +	/* put the port into known state */
> +	if (sil24_init_port(ap)) {
> +		reason ="port not ready";
> +		goto err;

This was actually split up a little too much.  Unless the implementation 
of a new function is rather large, or using the new function requires 
updating multiple files, better to keep the function addition and usage 
in the same patch.

Minor complaint though, it turns out OK in the end.

	Jeff



