From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/3] sata_mv: increase PIO IORDY timeout
Date: Wed, 24 Jun 2009 04:33:08 -0400
Message-ID: <4A41E4C4.7050508@garzik.org>
References: <1245771838-1332-1-git-send-email-saeed@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57984 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936AbZFXIcf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Jun 2009 04:32:35 -0400
In-Reply-To: <1245771838-1332-1-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca, saeed.bishara@gmail.com

Saeed Bishara wrote:
> The old value (0xbc) in cycles of the IORDY timeout is suitable for
> devices with core clock of 166 MHz, but some SoC controllers have
> faster core clocks. The new value will make the IORDY timeout large
> enough also for all SoC devices.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  drivers/ata/sata_mv.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 23714ae..644436e 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -3368,7 +3368,7 @@ static void mv_soc_reset_hc_port(struct mv_host_priv *hpriv,
>  	ZERO(0x024);		/* respq outp */
>  	ZERO(0x020);		/* respq inp */
>  	ZERO(0x02c);		/* test control */
> -	writel(0xbc, port_mmio + EDMA_IORDY_TMOUT);
> +	writel(0x800, port_mmio + EDMA_IORDY_TMOUT);

Do we really want to increase the timeout for older devices?  How does 
this change behavior for existing devices?

	Jeff




