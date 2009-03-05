From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata-rb532-cf: platform_get_irq() failure ignored
Date: Thu, 05 Mar 2009 07:23:22 -0500
Message-ID: <49AFC43A.3040206@garzik.org>
References: <49AD2ADA.5030109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44585 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890AbZCEMXc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Mar 2009 07:23:32 -0500
In-Reply-To: <49AD2ADA.5030109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: jgarzik@redhat.com, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Phil Sutter <n0-1@freewrt.org>, Florian Fainelli <florian@openwrt.org>

Roel Kluin wrote:
> ------------------------------>8-------------8<---------------------------------
> platform_get_irq() can return -ENXIO, but since 'irq' is an unsigned int, it
> does not show when the IRQ resource wasn't found.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
> index ebfcda2..fe8178c 100644
> --- a/drivers/ata/pata_rb532_cf.c
> +++ b/drivers/ata/pata_rb532_cf.c
> @@ -173,11 +173,12 @@ static __devinit int rb532_pata_driver_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret <= 0) {
>  		dev_err(&pdev->dev, "no IRQ resource found\n");
>  		return -ENOENT;
>  	}
> +	irq = ret;
>  
>  	gpio = irq_to_gpio(irq);

ACK from Phil or Florian?

