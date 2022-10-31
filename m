Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A13FA3740
	for <linux-ide@archiver.kernel.org>; Mon, 31 Oct 2022 05:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJaFqZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Oct 2022 01:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaFqZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Oct 2022 01:46:25 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00FEA186
        for <linux-ide@vger.kernel.org>; Sun, 30 Oct 2022 22:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667195180; x=1698731180;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kw5WVDheaT4abpviVXxRq7vxgC1kJcugKS9M3lKgvYI=;
  b=o3g+PPNpKT9anRhii1rw5p6QH8py0A0d3J10wY2vUAdZQaiwRg+OdYWv
   sm7IFvKsKJEAaLLjgMV9LRe8Ud+KB+hwczn7vJmhS6ZhZDt+YUNK3kSOO
   77e8pOjbuJATRKxO22bf3INwcje4wWboWnpnXsPtyuI4i6W0fOeohZHvn
   wGGNi4NxsdLyckCe/H2n0RgCjfsuOyjthiVQycEBBZhLDu0R/Sg2qx63A
   UMRpzP8rudiIz+knviueAY3AMDGvymr+Q1n+Opz9lOxe5MMvaq9TEqGJj
   FDeRedVKRPDQmmOpsqoAqQD1AXGzsgKnE0GWhzedSPFDtLu0/qrWCnuzA
   w==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="213400017"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 13:46:19 +0800
IronPort-SDR: iNTnAs+I8iTLb8E1ZO9qzO18SPQVVnGFw5qBmacMptSebA7H2PBxSsRDDZWJyPRXSHrFUS8J6Y
 XLiZ0Z9QG+hfDQoDYOqU5IvlSJFX+y8+QMQimmRg0aXg8VQy5ykoVZzzY0hXmXAZj5dtd5Ltr7
 W+BObWxQNlJNGO+0vCuCtQSH2rh80nkz0jJDNUUZXjESXcgGM1sXwuwU0ChTugR5szweFUt0lg
 c3sBpMJjUT792mwkrSPpUPfz47EGTCCsK08mtoGFLJ2z2nru+oX4ZUrKWcz4FbToy33OiQTHac
 xnXBdsjc1kJs0l1UDf2oF9Ia
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 21:59:52 -0700
IronPort-SDR: Gbn2rrn0ywVa+33to5voFs7hnkt3QQY9fjklf4FE2DIMPNONILxSYTmRHcoN4fsto/R32lHstS
 YaEyRpAOOhHwXzL+I7IZ8hLHLHEJePScp/CtNVE5q5FcpjJ4prV2dkFJiwVwJlOL7quBBschwC
 6h3K2O9wFUOk5sk6Wfj+AfZNooQaOj/WPgbqfBjoH6dNVII11b5akcqPrv5f89JR5GjZ8pqNs0
 fkQ5zoFk135ysshFoqu5o9qziZF873Li0arQpg5vg+JVDR9mkkpmfbHcQsh1c4ROFJrTROKt+G
 xzw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 22:46:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N12Fl1tf0z1Rwrq
        for <linux-ide@vger.kernel.org>; Sun, 30 Oct 2022 22:46:19 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667195178; x=1669787179; bh=kw5WVDheaT4abpviVXxRq7vxgC1kJcugKS9
        M3lKgvYI=; b=a8KzAlosFGrCyDiy748MtGtTbG8aBZd0fJGJ3YMel69Gs5iRRfT
        OZt20tn2a8Cg5lIHa8VGMe3KIq46rVcwtzyPg+K2REGaRvM6lm3AcOVlc/6rczUm
        I3dXUOj/m/vr6MTxJu3bviHvnajPzVMWAaBRVXRBjapzLzF5Ek8SeAIdJ6bfcdOo
        lJIGLRXsX79KnThFDI4T0TwPD75ew7HaSiexhazoAxoxTmbw4l6TEN/ral/8yZdt
        wG9wbPq+yiNW5hm3Zn2zucKOHmZVcQ9Xhxx/G8aDURyaSqg7IcMGI4yHupySpOaE
        sG+UTlH3JkCHSwb0bK4cB7fdUOiPeJM1hHg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wXk1BcHkh-Y3 for <linux-ide@vger.kernel.org>;
        Sun, 30 Oct 2022 22:46:18 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N12Fk0DRwz1RvLy;
        Sun, 30 Oct 2022 22:46:17 -0700 (PDT)
Message-ID: <491dfec9-b6c5-5f20-a3f0-2a339e2d528c@opensource.wdc.com>
Date:   Mon, 31 Oct 2022 14:46:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RESEND] ata: palmld: fix return value check in
 palmld_pata_probe()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-ide@vger.kernel.org
Cc:     s.shtylyov@omp.ru, arnd@arndb.de
References: <20221029074931.3189275-1-yangyingliang@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221029074931.3189275-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/29/22 16:49, Yang Yingliang wrote:
> If devm_platform_ioremap_resource() fails, it never return
> NULL pointer, replace the check with IS_ERR().
> 
> Fixes: 57bf0f5a162d ("ARM: pxa: use pdev resource for palmld mmio")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
> The previous patch link:
> https://lore.kernel.org/lkml/15e09c18-792b-931c-11c7-5ef284490eba@huawei.com/T/#t
> ---
>  drivers/ata/pata_palmld.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_palmld.c b/drivers/ata/pata_palmld.c
> index 400e65190904..51caa2a427dd 100644
> --- a/drivers/ata/pata_palmld.c
> +++ b/drivers/ata/pata_palmld.c
> @@ -63,8 +63,8 @@ static int palmld_pata_probe(struct platform_device *pdev)
>  
>  	/* remap drive's physical memory address */
>  	mem = devm_platform_ioremap_resource(pdev, 0);
> -	if (!mem)
> -		return -ENOMEM;
> +	if (IS_ERR(mem))
> +		return PTR_ERR(mem);
>  
>  	/* request and activate power and reset GPIOs */
>  	lda->power = devm_gpiod_get(dev, "power", GPIOD_OUT_HIGH);

Arnd has a series of patches that removes this driver from the kernel in
6.2. Do you need this fix for a stable release ?

-- 
Damien Le Moal
Western Digital Research

