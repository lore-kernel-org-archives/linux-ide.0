From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 1/2] sata_mv: use hpriv->base instead of the host->iomap
Date: Sat, 16 Feb 2008 09:05:31 -0500
Message-ID: <47B6EDAB.3000705@rtr.ca>
References: <12029369502995-git-send-email-saeed@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1872 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111AbYBPOFe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Feb 2008 09:05:34 -0500
In-Reply-To: <12029369502995-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: jeff@garzik.org, mlord@pobox.com, htejun@gmail.com, linux-ide@vger.kernel.org, saeed.bishara@gmail.com, nico@cam.org, byron.bbradley@gmail.com

Saeed Bishara wrote:
> this fixes crash bug as the iomap table is not valid for integrated controllers.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  drivers/ata/sata_mv.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 04b5717..9c9a5b0 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -870,7 +870,7 @@ static void mv_start_dma(struct ata_port *ap, void __iomem *port_mmio,
>  		struct mv_host_priv *hpriv = ap->host->private_data;
>  		int hard_port = mv_hardport_from_port(ap->port_no);
>  		void __iomem *hc_mmio = mv_hc_base_from_port(
> -				ap->host->iomap[MV_PRIMARY_BAR], hard_port);
> +					mv_host_base(ap->host), hard_port);
>  		u32 hc_irq_cause, ipending;
>  
>  		/* clear EDMA event indicators, if any */
..

This one looks fine.

Acked-by: Mark Lord <mlord@pobox.com>

Cheers
