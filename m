Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092A4C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 17 Dec 2021 00:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhLQAXq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:23:46 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24073 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhLQAXq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 16 Dec 2021 19:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639700626; x=1671236626;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tQ6Kpy2HPH6xl4gMSUs5ik1YmyfyPdpEY2+hjik4JjA=;
  b=CDtzeMDrRhC9Ik8kioxt0ixk07+XqQEvKjxxvRTNolemm77Kc0tv30ca
   1kfzqKeJeTTInWg4/1GoWIjHyldEzX9KrN+BmhdI3wGSbgMVIOGMwYFy8
   4k6Jlsu1uiYrHJKg2n+U+Ep7HhUUhzKQOYBvU5FYRL7hH4h6KWK572NB3
   vXXpeVhwY2uONcBtw6U2cSZKP4douu7SnbCtlOYsYU+KPnkr9s8PhwMdq
   s/4Sbo2XRv8XvnHeXPkWM3k7TCE/nbBMJ5SQ5a/ntRx5XHp7Wh3HhoIb5
   O5JU6m32dS1pJXFOcCgxErV3hD7pCJ5JiCoYWepnMVgPZJR/xcjSgNdwx
   g==;
X-IronPort-AV: E=Sophos;i="5.88,212,1635177600"; 
   d="scan'208";a="300307903"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2021 08:23:45 +0800
IronPort-SDR: ospVU4jmqBpThWbj8eLNWCAcEYmntvyMjGEWwtF0AvHtmhuYw+kV6hv6DNh5LjPEf6tntXs32M
 dxxVRCS8Iw7Ig46lxInC1aRfpbHOOP/owB6LDw8nvgl65/k1iJd/t3GBhmsw5KxenT36GHhEyw
 sfGnnQSU2ZUhzG7zroBWHeZKE/LDT+A2pT+FybdGAqtAGIE7hX2m/SItYq+TPcrf1uWSADPK2I
 GZoPJvWK3B+3Qjb64aMC9+A/cBpBVYqOjyBqyRMGoWMwryoqfS0HxABF7y0NbzGMZMWgt2XQjX
 4T22hdiwIVG0Ur4FORTHGahN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 15:56:39 -0800
IronPort-SDR: w9Ku4CIIoYOymcSIcOoSpyqSDYSNDCja0QUps+yeLuTUGguBZ1RzxIiVwljK3KF2tQgqHs0fEV
 U1uTfAI7ENtIymQN3FQ8GuuVxkxxCL8FdEVl2GweeuBDQgA0DqAw/rvpoeZUECXVHzFaI04rpP
 1wkorRODBun9A2Bac5KNdNoVbAEwjs/s2MR23AaYhlGxVofrH4W7k20Ytvw5f5zqFeQmpwbcM+
 YQS2oooqAMBoTyqbsEijs23k4mwqWTydxM/xEqEh7tOf5xRTSNEs1GdnyTI/DZEWHTNfmhgjGZ
 iD4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 16:23:46 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JFV8K2Vqbz1Rwns
        for <linux-ide@vger.kernel.org>; Thu, 16 Dec 2021 16:23:45 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639700624; x=1642292625; bh=tQ6Kpy2HPH6xl4gMSUs5ik1YmyfyPdpEY2+
        hjik4JjA=; b=C4vl5x4MjowydunGkdrnkXMTmP+DxqtzbwjMu5pDrZSTcMxSJNE
        OOzGwTXnA7tdnk5W87CxnGbbjRS5suq5E2YSmisLrPx6yJcNQAF2Ih8L6AVoV2zy
        Xl5uWt9GMEyId9U5jeBg+PrXAK7lCgSxepxIbO5MCGHnVeslNG4qlJLboOAm2M5o
        mR/TZGOw1DchIV+08bqjDWKlutVtum5UMBJDHyoTZT67JUlTs6vWVibFt79CWfxh
        lr6zI0kjdS3bFkW3q+bEIubA/zVHuJ05VE8pyiGNdDFl94IQvRmD3UW6o/IcGIXJ
        QgqSEumm8DzinVHpZXm11rxDQKO6qtUaVpw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fp9oXjo6tkpc for <linux-ide@vger.kernel.org>;
        Thu, 16 Dec 2021 16:23:44 -0800 (PST)
Received: from [10.225.163.18] (unknown [10.225.163.18])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JFV8H5nvxz1RtVG;
        Thu, 16 Dec 2021 16:23:43 -0800 (PST)
Message-ID: <d25d6c6f-098a-1dbc-0c85-00f97f491e99@opensource.wdc.com>
Date:   Fri, 17 Dec 2021 09:23:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] ata: pata_of_platform: Use of_irq_to_resource() to
 populate IRQ resource
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-ide@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20211217001238.16298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211217001238.16298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/17/21 09:12, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypassed the hierarchical setup and messed up the

s/bypassed/bypasses
s/messed/messes

> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use of_irq_to_resource().
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi,
> 
> Dropping usage of platform_get_resource() was agreed based on
> the discussion [0].
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> 
> Cheers,
> Prabhakar
> ---
>  drivers/ata/pata_of_platform.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
> index 35aa158fc976..557f349eb533 100644
> --- a/drivers/ata/pata_of_platform.c
> +++ b/drivers/ata/pata_of_platform.c
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/ata_platform.h>
>  #include <linux/libata.h>
> @@ -25,11 +26,12 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
>  	struct device_node *dn = ofdev->dev.of_node;
>  	struct resource io_res;
>  	struct resource ctl_res;
> -	struct resource *irq_res;
> +	struct resource irq_res;
>  	unsigned int reg_shift = 0;
>  	int pio_mode = 0;
>  	int pio_mask;
>  	bool use16bit;
> +	int irq;
>  
>  	ret = of_address_to_resource(dn, 0, &io_res);
>  	if (ret) {
> @@ -45,7 +47,9 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
>  		return -EINVAL;
>  	}
>  
> -	irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
> +	irq = of_irq_to_resource(dn, 0, &irq_res);
> +	if (irq <= 0 && irq != -ENXIO)
> +		return irq ? irq : -ENXIO;

Why are you making an exception for ENXIO ? I suspect this is to cover
the case "there is no IRQ for this node", but then how does this
differentiate from a real error case ?

>  
>  	of_property_read_u32(dn, "reg-shift", &reg_shift);
>  
> @@ -63,7 +67,8 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
>  	pio_mask = 1 << pio_mode;
>  	pio_mask |= (1 << pio_mode) - 1;
>  
> -	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res, irq_res,
> +	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res,
> +				     irq > 0 ? &irq_res : NULL,
>  				     reg_shift, pio_mask, &pata_platform_sht,
>  				     use16bit);
>  }
> 


-- 
Damien Le Moal
Western Digital Research
