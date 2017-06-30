From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] pata_imx: print error message on platform_get_irq
 failure
Date: Sat, 1 Jul 2017 00:37:36 +0300
Message-ID: <d0a70345-1d28-2218-098f-bdd700530f10@cogentembedded.com>
References: <20170630213056.GA12695@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36663 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbdF3Vhk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jun 2017 17:37:40 -0400
Received: by mail-lf0-f45.google.com with SMTP id h22so76949367lfk.3
        for <linux-ide@vger.kernel.org>; Fri, 30 Jun 2017 14:37:40 -0700 (PDT)
In-Reply-To: <20170630213056.GA12695@embeddedgus>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

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

    Removing empty line here doesn't seem a good idea...

>  	priv = devm_kzalloc(&pdev->dev,
>  				sizeof(struct pata_imx_priv), GFP_KERNEL);
>  	if (!priv)

MBR, Sergei

