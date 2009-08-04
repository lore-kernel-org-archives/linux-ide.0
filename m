From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 9/10] drivers/ata: introduce missing kfree
Date: Tue, 04 Aug 2009 13:49:16 +0900
Message-ID: <4A77BDCC.1070502@kernel.org>
References: <Pine.LNX.4.64.0908011055050.23408@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54969 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867AbZHDEtg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Aug 2009 00:49:36 -0400
In-Reply-To: <Pine.LNX.4.64.0908011055050.23408@ask.diku.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, geomatsi@gmail.com

Julia Lawall wrote:
...
> ---
>  drivers/ata/pata_at91.c             |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
> index 5702aff..46fb883 100644
> --- a/drivers/ata/pata_at91.c
> +++ b/drivers/ata/pata_at91.c
> @@ -261,7 +261,8 @@ static int __devinit pata_at91_probe(struct platform_device *pdev)
>  
>  	if (IS_ERR(info->mck)) {
>  		dev_err(dev, "failed to get access to mck clock\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto err_clk_get;
>  	}
>  
>  	info->cs    = board->chipselect;
> @@ -308,6 +309,7 @@ err_alt_ioremap:
>  
>  err_ide_ioremap:
>  	clk_put(info->mck);
> +err_clk_get:
>  	kfree(info);

cc'ing Matyukevich Sergey.  Matyukevich, is it possible to use
devm_kzalloc() instead?

Thanks.

-- 
tejun
