Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFF1C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 10 Jan 2022 22:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345077AbiAJWxM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Jan 2022 17:53:12 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38996 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241114AbiAJWxM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jan 2022 17:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641855192; x=1673391192;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vCt7YeJ6ihHy34FQA1brq9w4AvGaHog9ruTyBQgPR64=;
  b=g1/JfnXP5YgJFEsTXzoFfu5NgE32yEqSjGM9GcwBeW5qgWYOL3nJVxRV
   ZjZxykxCshZlHBzWCrhfS7RbfI8p0Gn64vjyoYGYFV4kl82JPyobBE/9O
   EWqT7bLnW9/fIRs/1dK/CFC/RuUkFb8bAbMCBZ35W2Cy9Znzv83zsDoX4
   4Q9w17LkfZ9Re/bLU3fdYcR42SV1kCALQSuONcnS4EpelpMS/E8PCC6Sz
   eszF9rnNbwreK70/d7idMQHf2L6QFa3qh2SWC28xaFEap3r1XWXp40JCg
   DJvvevpWbKkjdvif018ArxahDaPLL9vw5/Y5YD2+Jz0IPlVm8tg3jIsgN
   g==;
X-IronPort-AV: E=Sophos;i="5.88,278,1635177600"; 
   d="scan'208";a="191147638"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2022 06:53:11 +0800
IronPort-SDR: efBjh3z78zGmMjxxU0xH/he7uwhlps0Bcqu3iJO9I0e8M8+UeAk19dipyiKmboaO6ljvR5Rsvb
 wtTKjvTtzvwi8EEE2VxCkJVLj/qAE7BFdBw78o2alxCB394+Aa6D/8qc7cGsGXgzXrsR1RAE3R
 TRY+C0Pdi3cBM1xomszOOJZRuhWQ/oX4n1JZD+0MDZOIWl+rFAEtboSN+z96mBNuJdKF32fiHP
 jKJ0VKoQY0hQtHIdR4O7a8/sGcLaNJuI5/b+/yL9+AjtC6JGVFt5soi84viM8PI1dHi18QVF/q
 Fq/YXD6ePKMe1PZcVYhtC25t
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 14:25:34 -0800
IronPort-SDR: 0LQHLgyKZt53P5clP8HbFDLakP2YJqqmUOabETFZF/65Kpyw4fF2PzazvAbfcBxoBCV4DBXFbX
 5a5kQcp4lffsjzPiJSEDAxKTXayxDVmEymBz21gam+kupmOTmQJMyxyjXsRGRiPrqbizn7zbEh
 I0GUaGisJ8kcpgC4784QCLyiWnCFGgV5set9t2YoVfZpQCQgzQkqsIggKsj8AOHUb28c+tp4WA
 HUnGVSLdGhWERC0sRw2hkqD5MzlDMAY2lvE630ir6Q6BONmv1m0J9R6FMMojuk5jmbCzYgY5dD
 b5I=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 14:53:11 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JXpyG2shYz1VSkX
        for <linux-ide@vger.kernel.org>; Mon, 10 Jan 2022 14:53:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641855189; x=1644447190; bh=vCt7YeJ6ihHy34FQA1brq9w4AvGaHog9ruT
        yBQgPR64=; b=d5V/kww1vens9ElvcIjIOEDSaYJUlgc3bShj9AYaoTIyJ20TF96
        WOJqgP0+bzPDGv/k/5aEmLrZISU7eqPeam03JTJPWIbo5yiqRZB9Yw3/opAO9jxW
        6nsOaIBArX2XOTZ3aa9uqYhlae9zSpVA4Mt6OzMMxMA9rRKXyULl9aKYKftFMeOS
        T/L+Q228ELUwEY0Lzrj9LJd/UctAy4L/cDXSMmxe8E4Kjspy4E4KFlnygyTURTgP
        aucM/nBJvSunncZ2n4YH8TgONtqDOFZGLpWHcMn9Q1HCh81Kbo2VTT8aZuFbgYs6
        zyA+MgrcwCXQAPG9ELlL3mh46Qj6EHtI41g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WOAkprQAPfxa for <linux-ide@vger.kernel.org>;
        Mon, 10 Jan 2022 14:53:09 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JXpyD4dSdz1VSkV;
        Mon, 10 Jan 2022 14:53:08 -0800 (PST)
Message-ID: <c9c63445-3ecc-4a0e-3e70-3b5942e0d5d5@opensource.wdc.com>
Date:   Tue, 11 Jan 2022 07:53:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v5] ata: pata_of_platform: Use platform_get_irq_optional()
 to get the interrupt
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220105181721.13087-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20220105181721.13087-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/01/06 3:17, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_optional().
> 
> Note the code does not set the IRQ flags as this is handled automatically
> for DT.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
> 
> This patch is part of series [1]. I'll re-visit merging of pata_of_platform
> into pata_platform at later point. As my primary focus is removal of static
> setup of IRQ resource from DT core code.
> 
> [1] https://patchwork.ozlabs.org/project/linux-ide/list/?series=278349
> 
> v4->v5
> * Set end member of IRQ resource
> * Clear irq_res un-conditionally.
> 
> Cheers,
> Prabhakar
> ---
>  drivers/ata/pata_of_platform.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
> index 35aa158fc976..c3a40b717dcd 100644
> --- a/drivers/ata/pata_of_platform.c
> +++ b/drivers/ata/pata_of_platform.c
> @@ -25,11 +25,12 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
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
> @@ -45,7 +46,15 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
>  		return -EINVAL;
>  	}
>  
> -	irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
> +	memset(&irq_res, 0, sizeof(irq_res));
> +
> +	irq = platform_get_irq_optional(ofdev, 0);
> +	if (irq < 0 && irq != -ENXIO)
> +		return irq;
> +	if (irq > 0) {
> +		irq_res.start = irq;
> +		irq_res.end = irq;
> +	}
>  
>  	of_property_read_u32(dn, "reg-shift", &reg_shift);
>  
> @@ -63,7 +72,7 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
>  	pio_mask = 1 << pio_mode;
>  	pio_mask |= (1 << pio_mode) - 1;
>  
> -	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res, irq_res,
> +	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res, irq > 0 ? &irq_res : NULL,
>  				     reg_shift, pio_mask, &pata_platform_sht,
>  				     use16bit);
>  }

Andy,

Are you OK with this version ?

-- 
Damien Le Moal
Western Digital Research
