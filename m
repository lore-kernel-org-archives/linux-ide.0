From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_mv: fix broken DSM/TRIM support (v2)
Date: Mon, 23 Aug 2010 10:22:44 +0200
Message-ID: <4C722FD4.2010305@kernel.org>
References: <1282267195.8909.6.camel@corey> <1282268444.9628.4.camel@corey>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38916 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325Ab0HWI1n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Aug 2010 04:27:43 -0400
In-Reply-To: <1282268444.9628.4.camel@corey>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

On 08/20/2010 03:40 AM, Mark Lord wrote:
> Fix DSM/TRIM commands in sata_mv (v2).
> These need to be issued using old-school "BM DMA",
> rather than via the EDMA host queue.
> 
> Since the chips don't have proper BM DMA status,
> we need to be more careful with setting the ATA_DMA_INTR bit,
> since DSM/TRIM often has a long delay between "DMA complete"
> and "command complete".
> 
> GEN_I chips don't have BM DMA, so no TRIM for them.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> 
> Re-issue of original patch, with fixes for GEN_I and GEN_II chipsets.
> (my apologies for broken mailers -- patch also attached in case inline is b0rked).
> 
> --- 2.6.35.2/drivers/ata/sata_mv.c	2010-08-01 18:11:14.000000000 -0400
> +++ linux/drivers/ata/sata_mv.c	2010-08-19 21:34:46.139766319 -0400
> @@ -1898,19 +1898,25 @@
>   *	LOCKING:
>   *	Inherited from caller.
>   */
> -static void mv_bmdma_stop(struct ata_queued_cmd *qc)
> +static void mv_bmdma_stop_ap(struct ata_port *ap)
>  {
> -	struct ata_port *ap = qc->ap;
>  	void __iomem *port_mmio = mv_ap_base(ap);
>  	u32 cmd;
>  
>  	/* clear start/stop bit */
>  	cmd = readl(port_mmio + BMDMA_CMD);
> -	cmd &= ~ATA_DMA_START;
> -	writelfl(cmd, port_mmio + BMDMA_CMD);
> +	if (cmd & ATA_DMA_START) {
> +		cmd &= ~ATA_DMA_START;
> +		writelfl(cmd, port_mmio + BMDMA_CMD);
>  
> -	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
> -	ata_sff_dma_pause(ap);
> +		/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
> +		ata_sff_dma_pause(ap);
> +	}
> +}

Don't we need this for other BMDMA commands too?  If so, maybe it's
better to make it two patches?

Thanks.

-- 
tejun
