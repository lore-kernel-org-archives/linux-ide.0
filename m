Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC65AC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  9 Mar 2022 06:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiCIGZr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Mar 2022 01:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiCIGZr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Mar 2022 01:25:47 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734B412168C
        for <linux-ide@vger.kernel.org>; Tue,  8 Mar 2022 22:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646807087; x=1678343087;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=402p/cC9Q8pxSjYD8AYMP1zGXs05qRwp767H72pcxjQ=;
  b=C9PEsbyoB9RS9GKf63tczyikUvtFVFCRSZbjLvZ+0LlFL11joDwUvmzZ
   3IifnbUsRPOIL6+N7iwKYjwBZlyseb7HWHLb9FaMEvdUIr/5jGufeHKUo
   GvoqKDD/c4wVqjXCqmmR5azadrgAYf506mOa1vgXjVT/zhjIatAmTMroF
   fMvUOKgdQ+2zwPcZTFEDdkfa+odibjUlkWjFCI72LI3t9lS4Sw3gatwmV
   KYEi/eDYv6e+P+HQv/9NBKLo6k4PThpRfIGzdsHIU9dyS48P3Ln6zZdon
   FHAL3fBzBm2g/x99f+4XZV0th2rBPe5A4BEiQytcwz4UvvlSF2WD8qkep
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,166,1643644800"; 
   d="scan'208";a="194835488"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2022 14:24:47 +0800
IronPort-SDR: Z8TCPWGx0nz8rDJhibUfJwl5N7XdtbPWbs8d/UV1rzbLHdgRwNcLv7N4P1YLfz5KFTmh0wIUVo
 8v4O8mTCNToyGihU2n7myD3d589D2cuIV/oQqD61UVcdb5IG7MdKUGNjKEHrMOMw4lELR0mZ9L
 kPg2L0HRjcUqezG/n7sbabGOU0AJ76uVnunlZOeIvAHnngUpUljWN38ou+VhcBcaPv2VAtpcTO
 J9uQBNczmONzZ0xFrJIELLsMp7ULLZkTbKXn+er2c+miQN490A7n0AAwlL4YDB0s6q1cXYecS1
 KCHwIpWz1tfWgbSDzMOOQe7+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 21:56:01 -0800
IronPort-SDR: hv6UDyLXuBk72kL+K+zIHpECnmcTX8eKi06DqZ/PbwEumQ3sFAllUi4SC91JqMpLnEeMktrkSh
 cLaiT3xjou+Vu3mATvYfHh7mqXsFcGoaKh1LYyTkn8/FLqCJEoauDSi98uhX77RZWcchQGLO44
 RITKlJ0XSlXsUDyj27Fs+chyV4ib2khInN+ezx6FfNzyQSnBeHdDnlqgMFFGRGLxuCPmJ9li3O
 9OOp7JC7ay1wAfo8tV2a9xZhZXb1x83h6e9VsodWSCthaj8D1+w4ovK2fugAiZGPOpYxEjaZNl
 7OI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 22:24:46 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KD2H21s8Pz1SVny
        for <linux-ide@vger.kernel.org>; Tue,  8 Mar 2022 22:24:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646807085; x=1649399086; bh=402p/cC9Q8pxSjYD8AYMP1zGXs05qRwp767
        H72pcxjQ=; b=GIbZe5xGcclBgP/H4XXqchA/E/u8VrKvMhqFi2IPrY+aHQDCxgF
        C5DSl7EAttB/zyYmCGWUgRAfwzt6hyAht4Qyub4jWTLgGPryGlS526bSOk14Zu9m
        2zrLN7w3g6/1IsO3cZv4lAWqkidlc7ljK9+0fA7iu56/JQELqdm0Qqa+P0t0Xt+/
        BJ6sUnT5Hqhu35E+RJIArqZ7eKBThbZgh48qDk966Bq+z1GUevOcKLUvcg90KkPY
        0NLYbuIKxhxtYR61uf1LW0Nf9D7c7BSsf9YiG/nlMqyoP0ldXgnEGvz2rNBsZ6p+
        2uYKRGaJ9K9sa6PL8D+lvV9GFB8qULjCr4g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bR5dvLC_rAxo for <linux-ide@vger.kernel.org>;
        Tue,  8 Mar 2022 22:24:45 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KD2H056grz1Rvlx;
        Tue,  8 Mar 2022 22:24:44 -0800 (PST)
Message-ID: <d1dfb244-eda3-b5c6-c6bd-c0294a9a4a94@opensource.wdc.com>
Date:   Wed, 9 Mar 2022 15:24:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2] ata: pata_pxa: Use platform_get_irq() to get the
 interrupt
Content-Language: en-US
To:     cgel.zte@gmail.com, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220309055038.2081317-1-chi.minghao@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220309055038.2081317-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/9/22 14:50, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> v1->v2:
> 	- Use more specific in the subject: ata: pata_pxa:
> 	- Switch to returning 'irq'
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/ata/pata_pxa.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> index 41430f79663c..340b274d0cad 100644
> --- a/drivers/ata/pata_pxa.c
> +++ b/drivers/ata/pata_pxa.c
> @@ -164,10 +164,10 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	struct resource *cmd_res;
>  	struct resource *ctl_res;
>  	struct resource *dma_res;
> -	struct resource *irq_res;
>  	struct pata_pxa_pdata *pdata = dev_get_platdata(&pdev->dev);
>  	struct dma_slave_config	config;
>  	int ret = 0;
> +	int irq;
>  
>  	/*
>  	 * Resource validation, three resources are needed:
> @@ -205,9 +205,9 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	/*
>  	 * IRQ pin
>  	 */
> -	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (unlikely(irq_res == NULL))
> -		return -EINVAL;
> +	irq = platform_get_irq(pdev, 0);
> +	if (unlikely(irq < 0))

Please drop the unlikely() here. Not needed. This is not the hot path.

> +		return irq;
>  
>  	/*
>  	 * Allocate the host
> @@ -287,7 +287,7 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	/*
>  	 * Activate the ATA host
>  	 */
> -	ret = ata_host_activate(host, irq_res->start, ata_sff_interrupt,
> +	ret = ata_host_activate(host, irq, ata_sff_interrupt,
>  				pdata->irq_flags, &pxa_ata_sht);
>  	if (ret)
>  		dma_release_channel(data->dma_chan);


-- 
Damien Le Moal
Western Digital Research
