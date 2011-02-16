From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 2/4] sata_dwc_460ex: fix return value of dma_dwc_xfer_setup()
Date: Wed, 16 Feb 2011 21:33:50 +0300
Message-ID: <4D5C188E.3090204@ru.mvista.com>
References: <201101282158.54462.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56133 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab1BPShE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2011 13:37:04 -0500
Received: by bwz15 with SMTP id 15so901785bwz.19
        for <linux-ide@vger.kernel.org>; Wed, 16 Feb 2011 10:37:03 -0800 (PST)
In-Reply-To: <201101282158.54462.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

I wrote:

> The caller expects this function to return the DMA channel number on success,
> while it returns 0...

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> The patch is against the recent Linus' tree.

>  drivers/ata/sata_dwc_460ex.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> Index: linux-2.6/drivers/ata/sata_dwc_460ex.c
> ===================================================================
> --- linux-2.6.orig/drivers/ata/sata_dwc_460ex.c
> +++ linux-2.6/drivers/ata/sata_dwc_460ex.c
> @@ -44,7 +44,7 @@
>  #undef	DRV_NAME
>  #undef	DRV_VERSION
>  #define DRV_NAME        "sata-dwc"
> -#define DRV_VERSION     "1.1"
> +#define DRV_VERSION     "1.2"
>  
>  /* SATA DMA driver Globals */
>  #define DMA_NUM_CHANS		1
> @@ -718,7 +718,7 @@ static int dma_dwc_xfer_setup(struct sca
>  	/* Program the CTL register with src enable / dst enable */
>  	out_le32(&(host_pvt.sata_dma_regs->chan_regs[dma_ch].ctl.low),
>  		 DMA_CTL_LLP_SRCEN | DMA_CTL_LLP_DSTEN);
> -	return 0;
> +	return dma_ch;
>  }

    Does not seem a real issue as DMA_NUM_CHANS is 1. How NCQ is going to work 
though with 1 DMA channel? :-O

WBR, Sergei
