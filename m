From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_scc.c: Workaround for errata A308
Date: Fri, 13 Jul 2007 16:45:58 +0100
Message-ID: <20070713164558.6df8f03a@the-village.bc.nu>
References: <200707100929.l6A9TOR8025778@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44960 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759193AbXGMPjk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 11:39:40 -0400
In-Reply-To: <200707100929.l6A9TOR8025778@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: jeff@garzik.org, kou.ishizaki@toshiba.co.jp, linux-ide@vger.kernel.org

> +++ linux-powerpc-git.mod/drivers/ata/pata_scc.c	2007-07-10 17:13:01.000000000 +0900
> @@ -238,6 +238,12 @@ static void scc_set_dmamode (struct ata_
>  	else
>  		offset = 0;	/* 100MHz */
>  
> +	/* errata A308 workaround: limit ATAPI UDMA mode to UDMA4 */
> +	if (adev->class == ATA_DEV_ATAPI && speed > XFER_UDMA_4) {
> +		printk(KERN_INFO "%s: limit ATAPI UDMA to UDMA4\n", DRV_NAME);
> +		speed = XFER_UDMA_4;
> +	}
> +

NAK

You should not be modifying the speed you set in set_dmamode. Use the
mode_filter hook to mask the higher modes for ATAPI instead.


> +	/* errata A252,A308 workaround: Step4 */
> +	if (ata_altstatus(ap) & ATA_ERR && int_status & INTSTS_INTRQ)

Can we have more brackets here for clarity ?

> +		/* We don't check ATAPI DMA because it is limited to UDMA4 */
> +		if ((qc->tf.protocol == ATA_PROT_DMA &&
> +		     qc->dev->xfer_mode > XFER_UDMA_4)) {
> +			if (!(int_status & INTSTS_ACTEINT)) {
> +				printk(KERN_WARNING "ata%u: data lost occurred. (ACTEINT==0, retry:%d)\n",
> +				       ap->print_id, retry);

"data loss occurred", and even that sounds veyr scary so we should
probably try a more friendly message indicating that the user data has
not been lost but that the operation failed

> +				host_stat |= ATA_DMA_ERR;
> +				if (retry++)
> +					ap->udma_mask >>= 1;

NAK - you don't know that you can safely mess with modes this way.
udma_mask might contain holes. You need to do ap->udma_mask &= ~(1 <<
current UDMA mode);

Alan
