From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH] Revert "ata: sata_mv: Convert to devm_ioremap_resource()"
Date: Wed, 24 May 2017 15:01:20 +0200
Message-ID: <87d1aywgrj.fsf@free-electrons.com>
References: <1495582775-3717-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:39707 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035433AbdEXNBX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 24 May 2017 09:01:23 -0400
In-Reply-To: <1495582775-3717-1-git-send-email-andrew@lunn.ch> (Andrew Lunn's
        message of "Wed, 24 May 2017 01:39:35 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tejun Heo <tj@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, linux-ide@vger.kernel.org

Hi Andrew,
 
 On mer., mai 24 2017, Andrew Lunn <andrew@lunn.ch> wrote:

> This reverts commit 368e5fbdfc60732643f34f538823ed4bc8829827.
>
> devm_ioremap_resource() enforces that there are no overlapping
> resources, where as devm_ioremap() does not. The sata phy driver needs
> a subset of the sata IO address space, so maps some of the sata
> address space. As a result, sata_mv now fails to probe, reporting it
> cannot get its resources, and so we don't have any SATA disks.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
For this patch as it fixes a regresssion:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

However, as the same set of register are accessed by two drivers, is
there a risk for a race condition ?

In this case we may consider to use a regmap.

Or maybe they never aces the same register ?

In this case it is safe to let the driver as is, but adding a comment
could be useful.

Thanks,

Gregory



> ---
>  drivers/ata/sata_mv.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index b66bcda88320..3b2246dded74 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -4067,7 +4067,6 @@ static int mv_platform_probe(struct platform_device *pdev)
>  	struct ata_host *host;
>  	struct mv_host_priv *hpriv;
>  	struct resource *res;
> -	void __iomem *mmio;
>  	int n_ports = 0, irq = 0;
>  	int rc;
>  	int port;
> @@ -4086,9 +4085,8 @@ static int mv_platform_probe(struct platform_device *pdev)
>  	 * Get the register base first
>  	 */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	mmio = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(mmio))
> -		return PTR_ERR(mmio);
> +	if (res == NULL)
> +		return -EINVAL;
>  
>  	/* allocate host */
>  	if (pdev->dev.of_node) {
> @@ -4132,7 +4130,12 @@ static int mv_platform_probe(struct platform_device *pdev)
>  	hpriv->board_idx = chip_soc;
>  
>  	host->iomap = NULL;
> -	hpriv->base = mmio - SATAHC0_REG_BASE;
> +	hpriv->base = devm_ioremap(&pdev->dev, res->start,
> +				   resource_size(res));
> +	if (!hpriv->base)
> +		return -ENOMEM;
> +
> +	hpriv->base -= SATAHC0_REG_BASE;
>  
>  	hpriv->clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(hpriv->clk))
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
