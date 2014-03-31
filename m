From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] pata_at91: fix ata_host_activate() failure handling
Date: Mon, 31 Mar 2014 21:59:38 +0400
Message-ID: <5339AD0A.6050404@cogentembedded.com>
References: <3354637.ASvWtLs5Rq@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:52431 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbaCaR7l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Mar 2014 13:59:41 -0400
Received: by mail-la0-f53.google.com with SMTP id b8so5994769lan.26
        for <linux-ide@vger.kernel.org>; Mon, 31 Mar 2014 10:59:40 -0700 (PDT)
In-Reply-To: <3354637.ASvWtLs5Rq@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello.

On 03/31/2014 09:51 PM, Bartlomiej Zolnierkiewicz wrote:

> Add missing clk_put() call to ata_host_activate() failure path.

> Cc: Andrew Victor <linux@maxim.org.za>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>   drivers/ata/pata_at91.c |   11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

> Index: b/drivers/ata/pata_at91.c
> ===================================================================
> --- a/drivers/ata/pata_at91.c	2014-03-14 16:45:04.196724381 +0100
> +++ b/drivers/ata/pata_at91.c	2014-03-31 17:46:40.127677782 +0200
> @@ -407,12 +407,13 @@ static int pata_at91_probe(struct platfo
>
>   	host->private_data = info;
>
> -	return ata_host_activate(host, gpio_is_valid(irq) ? gpio_to_irq(irq) : 0,
> -			gpio_is_valid(irq) ? ata_sff_interrupt : NULL,
> -			irq_flags, &pata_at91_sht);
> +	ret = ata_host_activate(host, gpio_is_valid(irq) ? gpio_to_irq(irq) : 0,
> +				gpio_is_valid(irq) ? ata_sff_interrupt : NULL,
> +				irq_flags, &pata_at91_sht);
> +	if (ret)
> +		goto err_put;
>
> -	if (!ret)
> -		return 0;
> +	return 0;

    Hm, I have once fixed that (see that *if* (!ret)) but looks like a later 
commit 477c87e90853d136b188c50c0e4a93d01cad872e (ARM: at91/pata: use 
gpio_is_valid to check the gpio) broke it again. :-( Would be good if the 
changelog did mention that...

MBR, Sergei

