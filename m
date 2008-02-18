From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv: remove iounmap in mv_platform_remove and use
 devm_iomap
Date: Mon, 18 Feb 2008 13:57:56 -0500
Message-ID: <47B9D534.3090902@rtr.ca>
References: <12033601481951-git-send-email-saeed@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2841 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155AbYBRS56 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Feb 2008 13:57:58 -0500
In-Reply-To: <12033601481951-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: jeff@garzik.org, mlord@pobox.com, htejun@gmail.com, linux-ide@vger.kernel.org, saeed.bishara@gmail.com, byron.bbradley@gmail.com, tbm@cyrius.com

Saeed Bishara wrote:
> this will fix crash bug when doing rmmod to the driver, this is because the
> port_stop function get called later and it could access the device's registers.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  drivers/ata/sata_mv.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 9c9a5b0..f510448 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -2951,7 +2951,8 @@ static int mv_platform_probe(struct platform_device *pdev)
>  	hpriv->n_ports = n_ports;
>  
>  	host->iomap = NULL;
> -	hpriv->base = ioremap(res->start, res->end - res->start + 1);
> +	hpriv->base = devm_ioremap(&pdev->dev, res->start,
> +				   res->end - res->start + 1);
>  	hpriv->base -= MV_SATAHC0_REG_BASE;
>  
>  	rc = mv_create_dma_pools(hpriv, &pdev->dev);
> @@ -2983,11 +2984,8 @@ static int __devexit mv_platform_remove(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct ata_host *host = dev_get_drvdata(dev);
> -	struct mv_host_priv *hpriv = host->private_data;
> -	void __iomem *base = hpriv->base;
>  
>  	ata_host_detach(host);
> -	iounmap(base);
>  	return 0;
>  }
>  
..

Acked0by: Mark Lord <mlord@pobox.com>

Looks correct to me.
