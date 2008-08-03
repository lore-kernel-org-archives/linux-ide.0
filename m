From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Fix a large collection of DMA mode mismatches
Date: Sun, 03 Aug 2008 13:45:51 +0900
Message-ID: <489537FF.7050106@kernel.org>
References: <20080801091834.5ca39334@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36182 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183AbYHCEqf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Aug 2008 00:46:35 -0400
In-Reply-To: <20080801091834.5ca39334@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: =?UTF-8?B?RGF2aWQgTcO8bGxlcg==?= <dave.mueller@gmx.ch>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello, Alan.

Yeap, this approach looks much better.  Just few nits.

Alan Cox wrote:
> @@ -1427,6 +1427,28 @@ static inline unsigned long ata_deadline(unsigned long from_jiffies,
>  	return from_jiffies + msecs_to_jiffies(timeout_msecs);
>  }
>  
> +/* Don't open code these in drivers as there are traps. Firstly the range may
> +   change in future hardware and specs, secondly 0xFF means 'no DMA' but is
> +   > UDMA_0. Dyma ddreigiau */

I suppose "Dyma ddreigiau" is just contamination?  Also, can you please
use similar patch formatting as other comments for consistency?

> +static inline int ata_using_mwdma(struct ata_device *adev)
> +{
> +	if (adev->dma_mode >= XFER_MW_DMA_0 && adev->dma_mode <= XFER_MW_DMA_4)
> +		return 1;
> +	return 0;
> +}
> +
> +static inline int ata_using_udma(struct ata_device *adev)
> +{
> +	if (adev->dma_mode >= XFER_UDMA_0 && adev->dma_mode <= XFER_UDMA_7)
> +		return 1;
> +	return 0;
> +}
> +
> +static inline int ata_dma_enabled(struct ata_device *adev)
> +{
> +	return (adev->dma_mode == 0xFF ? 0 : 1);
> +}

Wouldn't it be better to use ata_using_dma() instead like the other two?

Thanks.

-- 
tejun
