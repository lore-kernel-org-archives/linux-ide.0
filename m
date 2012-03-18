From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] drivers/ata/pata_mpc52xx.c: drop unneeded devm cleanup functions
Date: Sun, 18 Mar 2012 20:58:19 +0000
Message-ID: <20120318205820.013643E07BF@localhost>
References: <1331415352-10260-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1331415352-10260-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Jeff Garzik <jgarzik@pobox.com>
Cc: kernel-janitors@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, w.sang@pengutronix.de
List-Id: linux-ide@vger.kernel.org

On Sat, 10 Mar 2012 22:35:52 +0100, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> There is no need to call the devm cleanup functions on failure of a probe
> or remove function.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> 
> ---
> Changed subject.  Included Wolfram's ACK.
> 
>  drivers/ata/pata_mpc52xx.c |   11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 00748ae..1f02008 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -806,17 +806,12 @@ mpc52xx_ata_probe(struct platform_device *op)
>  	return 0;
>  
>   err:
> -	devm_release_mem_region(&op->dev, res_mem.start, sizeof(*ata_regs));
>  	if (ata_irq)
>  		irq_dispose_mapping(ata_irq);
>  	if (task_irq)
>  		irq_dispose_mapping(task_irq);
>  	if (dmatsk)
>  		bcom_ata_release(dmatsk);
> -	if (ata_regs)
> -		devm_iounmap(&op->dev, ata_regs);
> -	if (priv)
> -		devm_kfree(&op->dev, priv);
>  	return rv;
>  }
>  
> @@ -835,12 +830,6 @@ mpc52xx_ata_remove(struct platform_device *op)
>  	bcom_ata_release(priv->dmatsk);
>  	irq_dispose_mapping(priv->ata_irq);
>  
> -	/* Clear up IO allocations */
> -	devm_iounmap(&op->dev, priv->ata_regs);
> -	devm_release_mem_region(&op->dev, priv->ata_regs_pa,
> -				sizeof(*priv->ata_regs));
> -	devm_kfree(&op->dev, priv);
> -
>  	return 0;
>  }
>  
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.
