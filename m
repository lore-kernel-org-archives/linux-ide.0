From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] pata_octeon_cf: fix ata_host_activate() failure handling
Date: Mon, 31 Mar 2014 14:26:54 -0700
Message-ID: <5339DD9E.5040202@roeck-us.net>
References: <5439252.0G82yiBcdS@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:50848 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbaCaV05 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Mar 2014 17:26:57 -0400
In-Reply-To: <5439252.0G82yiBcdS@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-ide@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/31/2014 10:53 AM, Bartlomiej Zolnierkiewicz wrote:
> Add missing kfree() call to ata_host_activate() failure path.
>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>   drivers/ata/pata_octeon_cf.c |    9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> Index: b/drivers/ata/pata_octeon_cf.c
> ===================================================================
> --- a/drivers/ata/pata_octeon_cf.c	2014-03-14 16:45:04.320724377 +0100
> +++ b/drivers/ata/pata_octeon_cf.c	2014-03-31 18:58:44.367604046 +0200
> @@ -1020,13 +1020,16 @@ static int octeon_cf_probe(struct platfo
>
>   	ata_port_desc(ap, "cmd %p ctl %p", base, ap->ioaddr.ctl_addr);
>
> -
>   	dev_info(&pdev->dev, "version " DRV_VERSION" %d bit%s.\n",
>   		 is_16bit ? 16 : 8,
>   		 cf_port->is_true_ide ? ", True IDE" : "");
>
> -	return ata_host_activate(host, irq, irq_handler,
> -				 IRQF_SHARED, &octeon_cf_sht);
> +	rv = ata_host_activate(host, irq, irq_handler,
> +			       IRQF_SHARED, &octeon_cf_sht);
> +	if (rv)
> +		goto free_cf_port;
> +

Just a few lines above:

         rv = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
         if (rv)
                 return rv;

So you don't really completely fix the leak, it be theoretic or not.

It might be better (and actually simplify the code) to use devm_kzalloc().

Guenter

> +	return 0;
>
>   free_cf_port:
>   	kfree(cf_port);
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
>

