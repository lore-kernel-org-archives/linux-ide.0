From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 04/14] sata_mv rename base to port_mmio
Date: Fri, 25 Jan 2008 23:11:15 -0500
Message-ID: <479AB2E3.7030406@pobox.com>
References: <4798FB68.70400@rtr.ca> <4798FC17.2000802@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52286 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbYAZELR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Jan 2008 23:11:17 -0500
In-Reply-To: <4798FC17.2000802@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> sata_mv rename base to port_mmio.
> 
> Use naming consistent with elsewhere in this driver.
> This will keep things less confusing when we later add "hc_mmio" in this 
> function.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> --- old/drivers/ata/sata_mv.c    2008-01-24 11:23:05.000000000 -0500
> +++ new/drivers/ata/sata_mv.c    2008-01-24 11:26:33.000000000 -0500
> @@ -834,19 +834,19 @@
>  *      LOCKING:
>  *      Inherited from caller.
>  */
> -static void mv_start_dma(void __iomem *base, struct mv_host_priv *hpriv,
> +static void mv_start_dma(void __iomem *port_mmio, struct mv_host_priv 
> *hpriv,
>              struct mv_port_priv *pp)
> {
>     if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN)) {
>         /* clear EDMA event indicators, if any */
> -        writelfl(0, base + EDMA_ERR_IRQ_CAUSE_OFS);
> +        writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
> 
> -        mv_set_edma_ptrs(base, hpriv, pp);
> +        mv_set_edma_ptrs(port_mmio, hpriv, pp);
> 
> -        writelfl(EDMA_EN, base + EDMA_CMD_OFS);
> +        writelfl(EDMA_EN, port_mmio + EDMA_CMD_OFS);
>         pp->pp_flags |= MV_PP_FLAG_EDMA_EN;
>     }
> -    WARN_ON(!(EDMA_EN & readl(base + EDMA_CMD_OFS)));
> +    WARN_ON(!(EDMA_EN & readl(port_mmio + EDMA_CMD_OFS)));

ACK patches 3-4


