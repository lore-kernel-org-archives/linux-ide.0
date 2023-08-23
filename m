Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F03C3DA66
	for <linux-ide@archiver.kernel.org>; Wed, 23 Aug 2023 23:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbjHWXHb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Aug 2023 19:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbjHWXHb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Aug 2023 19:07:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1520E51;
        Wed, 23 Aug 2023 16:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ADB0611CF;
        Wed, 23 Aug 2023 23:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06946C433C7;
        Wed, 23 Aug 2023 23:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692832046;
        bh=ZvPiminCOsELeBtIIeJltI5yvcvIv6w3DE0K33apG3Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pRzIDz5ocvFqDnTfxPJYp8Ib9jodQxSmtwvXuYdbXUDEpFURAxUwOle3uYJigkAr4
         jW+YzuWLoIpioAYArPIxYow+Rhk/Gbk9ANx5efk8708HwREGiu9EmUwnHuHIB4SbFk
         sBeQOhlA5gdMjBsfeXMvfBKtFg/Pd+vyPkiHkYDCJxQUnlMulCZrWlc+7szZqoNRmv
         iDrNGDtc6EUwimR4Gg6JdPwXs9OEQa2Oau/3CoIRC9qTNh3AhE8R3v4Ga3QFQ794cu
         739gjVACrsgd9CLusxQvcJeSb6OlT5MXn/BE6ewu1IhTdGNmw04caNwydNu9iP8Gio
         RvCnl2FTVJrlw==
Message-ID: <00462bc7-43ee-784a-3296-8051d69575df@kernel.org>
Date:   Thu, 24 Aug 2023 08:07:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] ata: pata_ep93xx: fix error return code in probe
Content-Language: en-US
To:     nikita.shubin@maquefel.me, Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230823-ep93xx_pata_fixes-v1-0-d7e7229be148@maquefel.me>
 <20230823-ep93xx_pata_fixes-v1-1-d7e7229be148@maquefel.me>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230823-ep93xx_pata_fixes-v1-1-d7e7229be148@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/23/23 18:47, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Return -ENOMEM from ep93xx_pata_probe() if devm_kzalloc() or
> ata_host_alloc() fails.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Doesn't this need a Fixes tag and Cc: stable ?

This is not really a bug fix, but might as well be complete with the fix :)

> ---
>  drivers/ata/pata_ep93xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index c6e043e05d43..4ce0f37c7a89 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
> @@ -939,7 +939,7 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
>  
>  	drv_data = devm_kzalloc(&pdev->dev, sizeof(*drv_data), GFP_KERNEL);
>  	if (!drv_data) {
> -		err = -ENXIO;
> +		err = -ENOMEM;
>  		goto err_rel_gpio;
>  	}
>  
> @@ -952,7 +952,7 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
>  	/* allocate host */
>  	host = ata_host_alloc(&pdev->dev, 1);
>  	if (!host) {
> -		err = -ENXIO;
> +		err = -ENOMEM;
>  		goto err_rel_dma;
>  	}
>  
> 

-- 
Damien Le Moal
Western Digital Research

