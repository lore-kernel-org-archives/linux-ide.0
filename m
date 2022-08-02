Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48711C00140
	for <linux-ide@archiver.kernel.org>; Tue,  2 Aug 2022 06:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbiHBGlM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 2 Aug 2022 02:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbiHBGlK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 2 Aug 2022 02:41:10 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A9E15719
        for <linux-ide@vger.kernel.org>; Mon,  1 Aug 2022 23:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659422466; x=1690958466;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4J0HMWpDXBHsDxH+LbeWJCs4EZBbBv4SbOlce1/etLE=;
  b=CroDdh2yXiGWCf6AQbIyQjKaBPoWGyh/z0SSse/9dhXVJh0Fs4Q8GEBD
   tyDhz5ggHzbt8iMZ92IGSbtb3psYPwh8kOxB7iEWKOQPSuxLWG+0MDR4B
   hJIb5VvIT49RzH2Q7jf1XK6lfVsDCqC2TtgLK8C25zpEsrIX16gToZdNq
   lSuPDrdQt0FzR0alqu2WgCPJtDvQiLFz/xkK+Jzj9TeZs1H+iinY5S79d
   Ojq19GNbSYUUj0vYqpu64+hpKkWwLvboFBxO4HSSAdcG+pYJnoZtEqsMY
   7UK7XVzo/k5rjUYoCIexBfjE5/MWzClJBa8JyGBklA6QqHIG7J0oSD1AN
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,210,1654531200"; 
   d="scan'208";a="311849456"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2022 14:41:05 +0800
IronPort-SDR: N/TRKLKmimRxSknx56LCcfnaBWX3SF4AxGmMUUOEYu5PMWFEczlGIQRFGvqKOpR4pyMkoovXRD
 JMs8xvdBkTI2yZ31vCg5rL7dKmC4bpV2Ug22h/vMR1BkSL34oz6g/dpzICSHyVTAtVGlJ798np
 KrtIuaEk8FyZAdjS8cDYBP+sNH2ypOCnhDUE71qZyLaESREDuPC6+3+04KNhgCxdO/A7boICc5
 ACrhgNpyG1/S9uEOWTAaPNqW6l7RBqLTN1IP8CjYZN/piz+Im8Kp5mwvu5vH0JR0EKxBSTvnH1
 VcFAnfdzsniLklBVcaMuSEhb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Aug 2022 22:57:03 -0700
IronPort-SDR: lGTggD9TpTdiKdbtKvoyeMxfKlxXovVfkYrgFiKs/Lu/UufznAhCawPN8Z+eYTrKO2j04XHqMx
 k+wtRjyYVkWjiURUTS4CTqfOH/ycpHf+HPlmSOAHk26E6A6DKf5+Be6YeTJU4YqnyawFavIaok
 O7VvCcYODTxfINC2FhiRg8v0vt4nqXgGzsA1qxSF7b4i8SIiTgdW8gxLUvJAdbezBZrHv/AxhX
 e52x9dU3GeyALY5KXvFacsy3LM3u+rbgi0txMJ5pKvH12WGFrTAT39kKZw2n0xJ6nM4V8pVuXX
 wOg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Aug 2022 23:41:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LxlkT3VSXz1Rwnm
        for <linux-ide@vger.kernel.org>; Mon,  1 Aug 2022 23:41:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1659422465; x=1662014466; bh=4J0HMWpDXBHsDxH+LbeWJCs4EZBbBv4SbOl
        ce1/etLE=; b=DkG0hjyR+9SZeVAeamEhZipdqzREkHhLCLSSjBKLWqK9kr9bF8Q
        OFwDAm4w4qVYf7le6XdiYE9iGlAIrcLLAxsdYBx7PVj/47G0BM0orsWlfFpzs2Lg
        sgjjSDpo8pRWkYG+HUWpg87xSBQgcW0WFACx56guEdFvQIYFfNv3bGtFESB1CUSG
        g56fjUqiE+FEk43wcLY6rk31/1vJYED4x2JLno7EAyQB3rjtVGH0GPySKFxrtoky
        12yHaVdztIQQURms2KjWyzbeFvpxVZmPEbWTKeYUpy/2l3KOQZmG2XZwZCBTZTaw
        +JFJ1l7BP60eccfrYsnRt3rthwfHRVsrm4A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id t2Ri8L3_uXoT for <linux-ide@vger.kernel.org>;
        Mon,  1 Aug 2022 23:41:05 -0700 (PDT)
Received: from [10.225.163.22] (unknown [10.225.163.22])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LxlkS19rxz1RtVk;
        Mon,  1 Aug 2022 23:41:03 -0700 (PDT)
Message-ID: <92a360ad-4ae8-9d36-51ca-a44b13ea3d9c@opensource.wdc.com>
Date:   Tue, 2 Aug 2022 15:41:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ata: sata_mv: Fixes expected number of resources now IRQs
 are gone
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-ide@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220731204906.2885445-1-andrew@lunn.ch>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220731204906.2885445-1-andrew@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/1/22 05:49, Andrew Lunn wrote:
> The commit a1a2b7125e10 ("of/platform: Drop static setup of IRQ
> resource from DT core") stopped IRQ resources being available as
> platform resources. This broke the sanity check for the expected
> number of resources in the Marvell SATA driver which expected two
> resources, the IO memory and the interrupt.
> 
> Change the sanity check to only expect the IO memory.
> 
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Fixes: a1a2b7125e10 ("of/platform: Drop static setup of IRQ resource from DT core")
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> v5.19-rc8 is broken. I guess there will not be a -rc9, so please could you
> queue this up for 5.19.1.

I will queue this for 5.10-rc1 and this will be picked up automatically
for stable 5.19.x thanks to the Fixes tag.

> 
> drivers/ata/sata_mv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index de5bd02cad44..e3cff01201b8 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -4057,7 +4057,7 @@ static int mv_platform_probe(struct platform_device *pdev)
>  	/*
>  	 * Simple resource validation ..
>  	 */
> -	if (unlikely(pdev->num_resources != 2)) {
> +	if (unlikely(pdev->num_resources != 1)) {
>  		dev_err(&pdev->dev, "invalid number of resources\n");
>  		return -EINVAL;
>  	}


-- 
Damien Le Moal
Western Digital Research
