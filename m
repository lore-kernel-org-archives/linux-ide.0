From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB
Date: Tue, 13 Nov 2007 11:25:51 +0900
Message-ID: <47390B2F.7090105@gmail.com>
References: <4738DE21.8090702@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:34990 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbXKMC0B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 21:26:01 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1138205nze
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 18:26:01 -0800 (PST)
In-Reply-To: <4738DE21.8090702@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Hello, Robert.

Robert Hancock wrote:
> @@ -747,11 +748,29 @@
>  		   on the port. */
>  		adma_enable = 0;
>  		nv_adma_register_mode(ap);
> +		if (!(pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE)) {
> +			/* Transitioning to legacy mode. Free the pad buffer. */
> +			ata_pad_free(ap, ap->host->dev);
> +			ap->pad = NULL;
> +			ap->pad_dma = 0;
> +		}
>  	} else {
> -		bounce_limit = *ap->dev->dma_mask;
> +		bounce_limit = pp->adma_dma_mask;
>  		segment_boundary = NV_ADMA_DMA_BOUNDARY;
>  		sg_tablesize = NV_ADMA_SGTBL_TOTAL_LEN;
>  		adma_enable = 1;
> +
> +		if (pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE) {
> +			/* Transitioning to ADMA mode. Free legacy PRD table
> +			   and the pad buffer. */
> +			ata_pad_free(ap, ap->host->dev);
> +			ap->pad = NULL;
> +			ap->pad_dma = 0;
> +			dmam_free_coherent(ap->host->dev, ATA_PRD_TBL_SZ,
> +				ap->prd, ap->prd_dma);
> +			ap->prd = NULL;
> +			ap->prd_dma = 0;
> +		}

How about always initialize DMA mask to ATA_DMA_MASK regardless of ADMA
mode such that PRD and PAD buffers are always accessible by register
mode and just raising PCI dma mask and queue bounce limit if ADMA mode
is active?

> +	/* Set appropriate DMA mask. */
> +	pci_set_dma_mask(pdev, bounce_limit);
> +	pci_set_consistent_dma_mask(pdev, bounce_limit);

These can fail.

Also, please separate out the result TF handling to a separate patch.  I
know it's a small change but as both introduces important behavior
changes, I think it would be nice to have a bisection point inbetween.

Thanks.

-- 
tejun
