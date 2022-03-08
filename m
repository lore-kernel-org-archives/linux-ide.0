Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD66C433F5
	for <linux-ide@archiver.kernel.org>; Tue,  8 Mar 2022 05:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiCHFvA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Mar 2022 00:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiCHFvA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Mar 2022 00:51:00 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FA5C1C
        for <linux-ide@vger.kernel.org>; Mon,  7 Mar 2022 21:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646718604; x=1678254604;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kehcbcYbbqv4Mc+VIdRnbHIfrlNDGyKgvl//coScXjs=;
  b=NA6Z+RWrATzDaOxLQBVQc0c2KHG11zBRNy7TdGioaRT7txZnayRCkq6U
   sGIrd8ZjvzLHFWwGOLmwRRbFF8mlNuGIGGA7MSf+5nbboW7AUNSwLtNgZ
   teL74V24XX303N4stuMs9GSomRc3B1LAJljK73Zx1oc1/zeGFt8JTOOEA
   hl4aN91qPa0+PU5Nw/YeldQbYMyiahx9aCh47dE2mf/5kUPM2hgD1z0xv
   t8MU9K4AdK6VlesXBWHv73mMx/Lkc88/4x8dfDsXk19S7skXvS4XF2YS+
   qPoj6RTQenT0uXBiSuIwH1yzYzn/4EcwUygetTW8Dm6gJ38/Ool6rWml9
   g==;
X-IronPort-AV: E=Sophos;i="5.90,163,1643644800"; 
   d="scan'208";a="306680745"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2022 13:50:03 +0800
IronPort-SDR: z3uTHS0US2mkiyKvZyHYyX2AldgO6YvjyRX/rjLNzHK64a6BlNGTF6Ps4+Ni8LSZ33EDxKWdR6
 T03OZCZ3veZVWq6sUdP6AQzvn4K8SrB3GdhCs2c4loarD1dMUPB1mQ+oVmL+JWPz6MfZAh35il
 ekXa2b91p7Ykz3U2H4J17E3NJ0TY4M+5bOk4LLhBDKJp/fQ39BtNtaQWlzir1cCrRKiv2ts6mw
 u6GG2l5cnJBHvLX/LP19Py9ocw3DoJ2SxcvIsiXzBywFOHCvzEF+jCONLQrPZ3wcI3evguP4YQ
 W1ZN8JC1oqntE1cVxigmizGC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 21:22:21 -0800
IronPort-SDR: S3Umax4pmsBYlEhub4DPSCD5fseeoCjNprLE6sXBxeZDEGi5jhv0QiMj5bK0OdjvTFoc3xy1NP
 phWa+a+BMznPx8hYTpeYxbgXsXYXF46Vr0afYNIsPG9e1WEC6My2FgZOLL5H4G4PZZc5uWPhvj
 QsPw/5jKgfs8lIpeKbntdizfSDNEJFkHC1FT9Mchj+ns+WkMDnwSg36sXqsLeV1nm201K2OJCH
 iC4d0JckuWwA+Z6nb1AtJ2TeuYIuc19qpfdFkhD3o/lVLAH82MpZxzUTKNZ4tTDscSKL9rfFmu
 J7o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 21:50:04 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KCPYR2xHwz1SVnx
        for <linux-ide@vger.kernel.org>; Mon,  7 Mar 2022 21:50:03 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646718602; x=1649310603; bh=kehcbcYbbqv4Mc+VIdRnbHIfrlNDGyKgvl/
        /coScXjs=; b=rBhI807HrS0lsFT1vp+rI7Ew6Fe9e8b2rcQCQh7DVRcJolyb9Yn
        rOPiln17mq26XRvzn4K9c1vK9sYWARPe8xydxFa1aYK9mueJinmFmsviCnRC7X9x
        18zKR1ohAU5NAea7SpolnwdELy8s+27RqnvQZL4Uf6L7JJ3UtDxza/Ew548ZKjl9
        eG6K0RY33l4WrkGMzXtIAEExXMK/8VfAg/tr4Bdi5CVd5Mq9r3sFmC8vduieeLUS
        2pWIVfyPQHDOY6EW5UUl52g/NOghXoceM7RvCEwXXGu2ndxuUQGdtHSsVWr3jx/n
        6VxWKMfJq1RahITkH6dyIgaZQyXH34KEolw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id daXiyyThQ2T0 for <linux-ide@vger.kernel.org>;
        Mon,  7 Mar 2022 21:50:02 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KCPYP1rJwz1Rvlx;
        Mon,  7 Mar 2022 21:50:01 -0800 (PST)
Message-ID: <1a6aa747-1609-467a-ac23-953387dc1a4e@opensource.wdc.com>
Date:   Tue, 8 Mar 2022 14:49:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: Use platform_get_irq() to get the interrupt
Content-Language: en-US
To:     cgel.zte@gmail.com, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220308025940.2077329-1-chi.minghao@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220308025940.2077329-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/8/22 11:59, cgel.zte@gmail.com wrote:
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> 
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypassed the hierarchical setup and messed up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> ---
>  drivers/ata/pata_pxa.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> index 41430f79663c..6394ab4cbc1b 100644
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
> @@ -205,8 +205,8 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	/*
>  	 * IRQ pin
>  	 */
> -	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (unlikely(irq_res == NULL))
> +	irq = platform_get_irq(pdev, 0);
> +	if (unlikely(irq < 0))

This is not the hot path, so let's simplify: drop the unlikely() from
this if.

>  		return -EINVAL;
>  
>  	/*
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
