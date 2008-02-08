From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv: problems using it as a platform_driver
Date: Thu, 07 Feb 2008 23:35:40 -0500
Message-ID: <47ABDC1C.9050507@rtr.ca>
References: <alpine.DEB.1.00.0802080113560.16853@git.byronbradley.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4752 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760462AbYBHEfl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Feb 2008 23:35:41 -0500
In-Reply-To: <alpine.DEB.1.00.0802080113560.16853@git.byronbradley.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Byron Bradley <byron.bbradley@gmail.com>, saeed@marvell.com
Cc: linux-ide@vger.kernel.org, mlord@pobox.com, jeff@garzik.org, linux-arm-kernel@lists.arm.linux.org.uk

Byron Bradley wrote:
> I'm having problems getting the sata_mv driver working as a platform
> driver on the QNAP TS-209 and the Linkstation/Kurobox (both are Marvell
> Orion 88f5182 based devices). First of all it would oops in
> mv_port_start() while calling dma_pool_alloc(), the patch to fix this is
> at the end of this email.
..

Ouch.  I'd say this is proof-positive that Saeed did not even test his
latest patches.  Your fix below looks straightforward and correct.

..
> From: Byron Bradley <byron.bbradley@gmail.com>
> Subject: [PATCH] sata_mv: platform driver allocs dma without create
> 
> When the sata_mv driver is used as a platform driver,
> mv_create_dma_pools() is never called so it fails when trying
> to alloc in mv_pool_start().
> 
> Signed-off-by: Byron Bradley <byron.bbradley@gmail.com>
..

Signed-off-by: Mark Lord <mlord@pobox.com>

> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index f5333ce..04b5717 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -2881,6 +2881,26 @@ done:
>  	return rc;
>  }
> 
> +static int mv_create_dma_pools(struct mv_host_priv *hpriv, struct device *dev)
> +{
> +	hpriv->crqb_pool   = dmam_pool_create("crqb_q", dev, MV_CRQB_Q_SZ,
> +							     MV_CRQB_Q_SZ, 0);
> +	if (!hpriv->crqb_pool)
> +		return -ENOMEM;
> +
> +	hpriv->crpb_pool   = dmam_pool_create("crpb_q", dev, MV_CRPB_Q_SZ,
> +							     MV_CRPB_Q_SZ, 0);
> +	if (!hpriv->crpb_pool)
> +		return -ENOMEM;
> +
> +	hpriv->sg_tbl_pool = dmam_pool_create("sg_tbl", dev, MV_SG_TBL_SZ,
> +							     MV_SG_TBL_SZ, 0);
> +	if (!hpriv->sg_tbl_pool)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>  /**
>   *      mv_platform_probe - handle a positive probe of an soc Marvell
>   *      host
> @@ -2934,6 +2954,10 @@ static int mv_platform_probe(struct platform_device *pdev)
>  	hpriv->base = ioremap(res->start, res->end - res->start + 1);
>  	hpriv->base -= MV_SATAHC0_REG_BASE;
> 
> +	rc = mv_create_dma_pools(hpriv, &pdev->dev);
> +	if (rc)
> +		return rc;
> +
>  	/* initialize adapter */
>  	rc = mv_init_host(host, chip_soc);
>  	if (rc)
> @@ -3070,26 +3094,6 @@ static void mv_print_info(struct ata_host *host)
>  	       scc_s, (MV_HP_FLAG_MSI & hpriv->hp_flags) ? "MSI" : "INTx");
>  }
> 
> -static int mv_create_dma_pools(struct mv_host_priv *hpriv, struct device *dev)
> -{
> -	hpriv->crqb_pool   = dmam_pool_create("crqb_q", dev, MV_CRQB_Q_SZ,
> -							     MV_CRQB_Q_SZ, 0);
> -	if (!hpriv->crqb_pool)
> -		return -ENOMEM;
> -
> -	hpriv->crpb_pool   = dmam_pool_create("crpb_q", dev, MV_CRPB_Q_SZ,
> -							     MV_CRPB_Q_SZ, 0);
> -	if (!hpriv->crpb_pool)
> -		return -ENOMEM;
> -
> -	hpriv->sg_tbl_pool = dmam_pool_create("sg_tbl", dev, MV_SG_TBL_SZ,
> -							     MV_SG_TBL_SZ, 0);
> -	if (!hpriv->sg_tbl_pool)
> -		return -ENOMEM;
> -
> -	return 0;
> -}
> -
>  /**
>   *      mv_pci_init_one - handle a positive probe of a PCI Marvell host
>   *      @pdev: PCI device found
