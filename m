From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH v2] pata_imx: print error message on platform_get_irq
 failure
Date: Sat, 1 Jul 2017 12:00:06 +0300
Message-ID: <ed8aba46-7cfc-a4e0-7eba-630519e788ad@mleia.com>
References: <20170630213056.GA12695@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:48216 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751400AbdGAJJc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sat, 1 Jul 2017 05:09:32 -0400
In-Reply-To: <20170630213056.GA12695@embeddedgus>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Gustavo,

On 07/01/2017 12:30 AM, Gustavo A. R. Silva wrote:
> Print error message on platform_get_irq failure before return.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
> Changes in v2:
>  Print the return value of platform_get_irq on failure.
> 
>  drivers/ata/pata_imx.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
> index d4caa23..66fb1ab 100644
> --- a/drivers/ata/pata_imx.c
> +++ b/drivers/ata/pata_imx.c
> @@ -132,9 +132,10 @@ static int pata_imx_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
>  		return irq;
> -
> +	}
>  	priv = devm_kzalloc(&pdev->dev,
>  				sizeof(struct pata_imx_priv), GFP_KERNEL);
>  	if (!priv)
> 

this patch is wrong, I've explained why at https://lkml.org/lkml/2017/6/30/144

Please handle -EPROBE_DEFER case, when your change adds the second (redundant)
error level message printed to the kernel log.

--
With best wishes,
Vladimir
