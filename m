Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A165EC433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 22:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhLIWxQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Dec 2021 17:53:16 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:9077 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbhLIWxQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2021 17:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639090182; x=1670626182;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=meD9UwDEvaPB0UppYvKmiGhMIwn82GUCVzJyp0aM/8Q=;
  b=N9fplvO7KGiwoCsC2QpfoSFeD85IIFqErs/JNCZMpDLBXWZD9XRa1cJm
   YL9KCf7IJuYz8wm2Dnttiq8yK4Cb7SNQAy2C/PdCujB3W0wIBVulKNj/3
   x5qeA8STBdi69YV68gD1uz4ZxlNM25PzLWkRq/+8FSLxXt6Fhhu+7S2Q0
   W3YMVyvtyRbReYvD68MwMnQo8smO1iz1OvRX1ol3omOX3rSPs3JGWuqHY
   Od8h2wupCKIiNh73QnvmtOaWFE4K2FIsM0JVCbmu33UjnXgdQXAiYB5tY
   w/fb5HPBmXfB4gMcJewlm2kSycCC4Nkppu6Yi3rW59221Zd4pv/fDqs7X
   w==;
X-IronPort-AV: E=Sophos;i="5.88,193,1635177600"; 
   d="scan'208";a="186865165"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2021 06:49:41 +0800
IronPort-SDR: 9Uxjc9agX9SSICX8zfGiK38z3aLV6khRTNIcjJx1wwckoeWqNX0ISrGrdYZW3Qu8Fi2T9zNAbr
 PQxVWitDdkcLhnkBRMKmnxEB64h+o0MbjKT/OFDvE6rKJSFEc0neFZmdUEzxPWGMeHT1IcSpAD
 jGZzn2/qNaI/HVaXYBo0OelY9P2x4nHOvkZ2jk8J6/b230WwI0H8XeNwlln2RV9lpKKbqntclf
 +REA1bz+VJtLCyS+ZDkjy83l5jaaciAjs9/x13ol6vGNpUPRDoKJVjoU9H4qWPBVVphuRGHLLp
 HWer01AcEDVzyB9MK5RO6Y5Q
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 14:22:43 -0800
IronPort-SDR: cnyoEMEM7phNuGUkLgkhUXTISLjbabq2J8iGGqX4nGzQ0Zmcpz56YmQ73Yr0uoE+mTUjYUlbOA
 ZJaTAo0J1Qpiz00IRY2dC478y/NdBXRkikiH4TClIej5k2bHoZkNmcESt2WQd82DBMyDMj6YYl
 b8Uj/WoWNo5lCQxTRJy55stAlkYP1rQYw6A688Z+L6s45aa1bYtwaOBDmPhQhxI6wS5dwq/YOL
 hDHcpf+BvMGn0uGQrhff2U7xZsPxJauyxhPDduwnLcrZ8NDpR52LJiDhhnKn/hS9ocCasvTfiJ
 Xr4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 14:49:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J98P11fNJz1Rwnv
        for <linux-ide@vger.kernel.org>; Thu,  9 Dec 2021 14:49:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639090180; x=1641682181; bh=meD9UwDEvaPB0UppYvKmiGhMIwn82GUCVzJ
        yp0aM/8Q=; b=aHqROgplyQ+4nC+RsXoQZg1A9a9bR9FzFbJeeuwbHY6SZd0Ue97
        Zet7lnW2gxmB2e++S0Ppzp8HOG1/L8MlI+65BoJ9V6Xt/T7useac85R2gxkNWGyV
        OE+vwNE/o7Ksr19oVllzKvxMhDSjOYMlfJVkfZTPP1rb14lFWS4mcUkTE8XNNyrs
        8EhAQowOMZXrfRI6AsYtaoXHUbk+LNRBLdYbd9KQRhVk9+ENqruEM1AeOqjA2jN7
        HwpmXecRB4K4IxNJOjuYSn6YBA/VUsydMmNTGpTBl4F0Jl9NJsItPPiAM4gb3rBS
        ksRxnEe4UYsWufkW/d6MzU38Uuha7HWy4VA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wT3QyA2heN7P for <linux-ide@vger.kernel.org>;
        Thu,  9 Dec 2021 14:49:40 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J98Nz6n9Vz1RtVG;
        Thu,  9 Dec 2021 14:49:39 -0800 (PST)
Message-ID: <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
Date:   Fri, 10 Dec 2021 07:49:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 23:59, Andy Shevchenko wrote:
> platform_get_irq() will print a message when it fails.
> No need to repeat this.
> 
> While at it, drop redundant check for 0 as platform_get_irq() spills
> out a big WARN() in such case.

The reason you should be able to remove the "if (!irq)" test is that
platform_get_irq() never returns 0. At least, that is what the function kdoc
says. But looking at platform_get_irq_optional(), which is called by
platform_get_irq(), the out label is:

	WARN(ret == 0, "0 is an invalid IRQ number\n");
	return ret;

So 0 will be returned as-is. That is rather weird. That should be fixed to
return -ENXIO:

	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
		return -ENXIO;
	return ret;

Otherwise, I do not think that removing the "if (!irq)" hunk is safe. no ?

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/ata/libahci_platform.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 0910441321f7..1af642c84e7b 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -579,13 +579,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
>  	int i, irq, n_ports, rc;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		if (irq != -EPROBE_DEFER)
> -			dev_err(dev, "no irq\n");
> +	if (irq < 0)
>  		return irq;
> -	}
> -	if (!irq)
> -		return -EINVAL;
>  
>  	hpriv->irq = irq;
>  


-- 
Damien Le Moal
Western Digital Research
