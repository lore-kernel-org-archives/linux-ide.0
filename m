From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH,RFC] sata_mv: don't avoid clearing interrupt status on
 SoC host adapters
Date: Tue, 26 Aug 2008 09:50:23 -0400
Message-ID: <48B40A1F.6090703@rtr.ca>
References: <20080824030429.GA10230@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:33684 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753838AbYHZNuY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Aug 2008 09:50:24 -0400
In-Reply-To: <20080824030429.GA10230@xi.wantstofly.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Saeed Bishara <saeed@marvell.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Lennert Buytenhek wrote:
> For some reason, sata_mv doesn't clear interrupt status during init
> when it's running on an SoC host adapter.  If the bootloader has
> touched the SATA controller before starting Linux, Linux can end up
> enabling the SATA interrupt with events pending, which will cause the
> interrupt to be marked as spurious and then be disabled, which then
> breaks all further accesses to the controller.
> 
> This patch makes the SoC path clear interrupt status on init like in
> the non-SoC case.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>
> ---
>  drivers/ata/sata_mv.c |   21 ++++++++++-----------
>  1 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index ad169ff..e829a3a 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -3131,19 +3131,18 @@ static int mv_init_host(struct ata_host *host, unsigned int board_idx)
>  		writelfl(0, hc_mmio + HC_IRQ_CAUSE_OFS);
>  	}
>  
> -	if (!IS_SOC(hpriv)) {
> -		/* Clear any currently outstanding host interrupt conditions */
> -		writelfl(0, mmio + hpriv->irq_cause_ofs);
> +	/* Clear any currently outstanding host interrupt conditions */
> +	writelfl(0, mmio + hpriv->irq_cause_ofs);
>  
> -		/* and unmask interrupt generation for host regs */
> -		writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
> +	/* and unmask interrupt generation for host regs */
> +	writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
> +
> +	/*
> +	 * enable only global host interrupts for now.
> +	 * The per-port interrupts get done later as ports are set up.
> +	 */
> +	mv_set_main_irq_mask(host, 0, PCI_ERR);
>  
> -		/*
> -		 * enable only global host interrupts for now.
> -		 * The per-port interrupts get done later as ports are set up.
> -		 */
> -		mv_set_main_irq_mask(host, 0, PCI_ERR);
> -	}
>  done:
>  	return rc;
>  }


Looks fine to me -- Saeed Bishara did the SOC stuff, and Marvell refuses to show
me any documentation for it.  So if it works for you, then let's put it in there.
Or maybe get Saeed's sign-off first.

Cheers
