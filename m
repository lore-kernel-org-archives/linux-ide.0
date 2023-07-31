Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1B5C001DF
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jul 2023 11:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjGaLO2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Jul 2023 07:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjGaLO0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jul 2023 07:14:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321D8E75
        for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2023 04:14:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FE3E601D0
        for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2023 11:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884BEC433CA;
        Mon, 31 Jul 2023 11:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690802064;
        bh=cPry8CnKh4Yb6v+9yimdyaATAmBjnhpRPU6a8PxgjB4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=StNsssyJXe0g4pvNl+LvBa7BdpBD5kpq+ONNNOuBLhmBKgN6xUcs2fevHj4NLxb0T
         NRtPVIDkLvnf5uALbtGjJaqW+Dv5EUl/AJwII/0EdxYjGcsNAMUTHdMO+ABLY4xPkb
         gANcP+CvCoFaJCikoaON9l6ZwQl5GXQKnjS+Mc2oh/QBwhV7UFh6KcKw1jiQzI90wR
         z5MnG1bcXgqMr11pgNCJDVCEjzdw/x2FgIU5d+DLSmaWmoeg9Ped3Hz9f0uI+EIkYi
         Wny8+8dE+x9L0laQMgJJ/2Ssa6FCJQPbrmmNBnfwv395bN46nFs9T3dLcKiQHmbVdn
         Q/mZCHZ8WM99Q==
Message-ID: <ab359d01-2712-827b-c3cc-06538108b917@kernel.org>
Date:   Mon, 31 Jul 2023 20:14:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/12] ata/pata_mpc52xx: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        kernel@pengutronix.de
References: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
 <20230731091636.693193-6-u.kleine-koenig@pengutronix.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230731091636.693193-6-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/31/23 18:16, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/ata/pata_mpc52xx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 66c9dea4ea6e..bca7f552e2b5 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -800,7 +800,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
>  	return rv;
>  }
>  
> -static int
> +static void
>  mpc52xx_ata_remove(struct platform_device *op)

While at it, it would be nice to remove the unusual line break here. Will do
that when applying.

>  {
>  	struct ata_host *host = platform_get_drvdata(op);
> @@ -815,8 +815,6 @@ mpc52xx_ata_remove(struct platform_device *op)
>  	irq_dispose_mapping(task_irq);
>  	bcom_ata_release(priv->dmatsk);
>  	irq_dispose_mapping(priv->ata_irq);
> -
> -	return 0;
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -857,7 +855,7 @@ static const struct of_device_id mpc52xx_ata_of_match[] = {
>  
>  static struct platform_driver mpc52xx_ata_of_platform_driver = {
>  	.probe		= mpc52xx_ata_probe,
> -	.remove		= mpc52xx_ata_remove,
> +	.remove_new	= mpc52xx_ata_remove,
>  #ifdef CONFIG_PM_SLEEP
>  	.suspend	= mpc52xx_ata_suspend,
>  	.resume		= mpc52xx_ata_resume,

-- 
Damien Le Moal
Western Digital Research

