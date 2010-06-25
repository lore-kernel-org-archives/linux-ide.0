From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] ahci_platform: Provide for vendor specific init
Date: Fri, 25 Jun 2010 11:49:04 +0400
Message-ID: <20100625074904.GA32340@oksana.dev.rtsoft.ru>
References: <1277441858-26993-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55074 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab0FYHtK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jun 2010 03:49:10 -0400
Received: by bwz7 with SMTP id 7so554478bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 25 Jun 2010 00:49:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1277441858-26993-1-git-send-email-jassisinghbrar@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, Jassi Brar <jassi.brar@samsung.com>

On Fri, Jun 25, 2010 at 01:57:38PM +0900, Jassi Brar wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> Some AHCI implementations may use Vendor Specific HBA[A0h, FFh]
> and/or Port[70h, 7Fh] registers to 'prepare' for initialization.
> For that, the platform needs memory mapped address of AHCI registers.
> 
> This patch adds the 'mmio' argument and reorders the call to
> platform init function.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

Thanks for the patch. Looks good, but see some comments below.
(Plus some comments on Jeff's reply)

> ---
>  drivers/ata/ahci_platform.c   |   23 +++++++++++++----------
>  include/linux/ahci_platform.h |    2 +-
>  2 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 5e11b16..4403941 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
[...]
> @@ -74,8 +68,17 @@ static int __init ahci_probe(struct platform_device *pdev)
>  	hpriv->mmio = devm_ioremap(dev, mem->start, resource_size(mem));
>  	if (!hpriv->mmio) {
>  		dev_err(dev, "can't map %pR\n", mem);
> -		rc = -ENOMEM;
> -		goto err0;
> +		devm_kfree(dev, hpriv);

You don't need to explicitly free devm_* resources.

> +		return -ENOMEM;
> +	}
> +
> +	if (pdata && pdata->init) {
> +		rc = pdata->init(dev, hpriv->mmio);
> +		if (rc) {
> +			devm_iounmap(dev, hpriv->mmio);
> +			devm_kfree(dev, hpriv);

Ditto, no need for iounmap and kfree.

> +			return rc;
> +		}
>  	}
>  
>  	ahci_save_initial_config(dev, hpriv,
> diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> index f7dd576..f7ffc4c 100644
> --- a/include/linux/ahci_platform.h
> +++ b/include/linux/ahci_platform.h
> @@ -19,7 +19,7 @@ struct device;
>  struct ata_port_info;
>  
>  struct ahci_platform_data {
> -	int (*init)(struct device *dev);
> +	int (*init)(struct device *dev, void __iomem *addr);

Please include linux/compiler.h for __iomem.

>  	void (*exit)(struct device *dev);
>  	const struct ata_port_info *ata_port_info;
>  	unsigned int force_port_map;

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
