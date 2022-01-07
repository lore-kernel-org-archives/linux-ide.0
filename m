Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FBFC433F5
	for <linux-ide@archiver.kernel.org>; Fri,  7 Jan 2022 12:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbiAGMHr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Jan 2022 07:07:47 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62151 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbiAGMHr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jan 2022 07:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641557267; x=1673093267;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DIqbI5MDg3/Xzqi8tsz5+ABmdVszh5nOou+bQe7BFfc=;
  b=W1j6SF1gK4aiSDIQMXyj9oBMwzVSQUhy6jZVbekYee6kjpm2kNAFxhag
   y6eua3J97muAmVau/dqdlXTW+XXr0SMBYvqeNn7IsMVbnK8mUTLKQdB2I
   GTw9kAgaA5rL93T0XVfmytDK2he3VI4obRQquo2Gg9GECb6vwGCMLzkw7
   a7K8tUQTY0c3sT781MpckFGzVxLmETHMDAMebm+xNa6sJzGM7vXUyV9fS
   ylQCzmCrJCMy8b0WVFSvb/3fgo3ngwY7qOqsKVg0uwJFoeavSkeK/Fzqq
   xqA6OSyPCRqjbOii+qmoaf0mLA2UVuoC5vz7X2/3Acz54KdCAKWKtHTTR
   g==;
X-IronPort-AV: E=Sophos;i="5.88,269,1635177600"; 
   d="scan'208";a="190946851"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2022 20:07:47 +0800
IronPort-SDR: RhuY2MIkf9Q/5rUloCNhMREi88pdRbiCc2yMSRS4Oi0WmOACJsrZezFXwiNt6KoyjcJQVFcuHo
 YpWA7JHZiMgVwbAQYyBw9eRxiFzdW8NiwuCSFJaeXi2cJYStJxef0VkVOnRjMHcQByRMbRc3Gy
 bjVClGiYLuiwv3tCAnI1Q6Vl8D4dgRGQwVjpx0IyQSFDvXTq9r553psYTr3RSynGWgZJF4oz6R
 hmd++AAMMSgYLwL1o0s4geXetLanYHWt/CGvhlrvSfRayAJ8e42jMiOX/7+W5PBhPiBeV4x6B7
 NOoBJdwV47ZW/H2BmXKbM66P
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 03:40:14 -0800
IronPort-SDR: v8r3Hs5dXCDPfzBWIt/OQZj4u+3r9XH4Yw3zsnRffj2OEqg/UVleJWvJGt/OtRnmZ7EVgnXQHJ
 cLPNwf/XbbH7Armdt7kjkr058ZF0zixAPThoKHC9Zi338ObCXjXo1wEnbwdYWC5kJzv5DdQEgy
 PBgMqiQWBPFs5rI04HihIa7LZwddtg2mAHbNMf/Fll4NjH1ATa+ewPYW3UMV6T7V859qmtwUrn
 F+ePO39U8XgMItEfNgu8PxyXaH2o8Fx4+JHJG70Qaz5xPnKK0prWieIegDQEIHhrrB+DWviB3R
 V8Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 04:07:46 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JVhmv31LMz1VSkd
        for <linux-ide@vger.kernel.org>; Fri,  7 Jan 2022 04:07:43 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641557262; x=1644149263; bh=DIqbI5MDg3/Xzqi8tsz5+ABmdVszh5nOou+
        bQe7BFfc=; b=mJxFwYAuH1Fz0mrWZqtC7b8NK7J5UlHF2i8vpT09enkoL60LNGA
        BOlb1g9uSY3wyDtHDI+xXSjKYwrw7gFac0BuYpQnWKlpRuMikisQ/tDUiX44DV+C
        ttNsrt+x0uAZrDlsEHHGPbX61utVaFJXFufMGep9NdOnP2MNUbGI8JB4jSOj0Cgv
        gAWP5CtokCckdcji6eJXr+J4mtBwBoYrqxtgGdqmRjGQit09aa9GnT4Tl7/3mzEc
        Vin61ni2KgCaQc5CJXRUCtk90vSz1iUV3PLcrHMri19Xcia4yGGt6c+Kwml1Gknf
        sEIrnkMs1a4ZWRpc4jBm++wXW8Nqptr5t7w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MLUSLMPHgbq7 for <linux-ide@vger.kernel.org>;
        Fri,  7 Jan 2022 04:07:42 -0800 (PST)
Received: from [10.225.163.44] (unknown [10.225.163.44])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JVhmt1HKlz1VSkV;
        Fri,  7 Jan 2022 04:07:42 -0800 (PST)
Message-ID: <604c4187-ba45-1395-1409-103865d82c53@opensource.wdc.com>
Date:   Fri, 7 Jan 2022 21:07:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3] ide: Check for null pointer after calling devm_ioremap
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, David.Laight@ACULAB.COM,
        davem@davemloft.net
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220107115000.4057454-1-jiasheng@iscas.ac.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220107115000.4057454-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/7/22 20:50, Jiasheng Jiang wrote:
> In linux-stable-5.15.13, this file has been removed and combined
> to `drivers/ata/pata_platform.c` without this bug.
> But in the older LTS kernels, like 5.10.90, this bug still exists.
> As the possible failure of the devres_alloc(), the devm_ioremap() and
> devm_ioport_map() may return NULL pointer.
> And then, the 'base' and 'alt_base' are used in plat_ide_setup_ports().
> Therefore, it should be better to add the check in order to avoid the
> dereference of the NULL pointer.
> Actually, it introduced the bug from commit 8cb1f567f4c0
> ("ide: Platform IDE driver") and we can know from the commit message
> that it tended to be similar to the `drivers/ata/pata_platform.c`.
> But actually, even the first time pata_platform was built,
> commit a20c9e820864 ("[PATCH] ata: Generic platform_device libata driver"),
> there was no the bug, as there was a check after the ioremap().
> So possibly the bug was caused by ide itself.
> 
> Fixes: 8cb1f567f4c0 ("ide: Platform IDE driver")
> Cc: stable@vger.kernel.org#5.10.90

This should be:

Cc: stable@vger.kernel.org #5.10

(no release number specified)

> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog
> 
> v2 -> v3
> 
> * Change 1. Correct the fixes tag and commit message.
> * Change 2. Correct the code.

What exactly was corrected should be the change log.
And please keep the history for all versions of the patch (keep v1 -> v2
changes listed here).

> ---
>  drivers/ide/ide_platform.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ide/ide_platform.c b/drivers/ide/ide_platform.c
> index 91639fd6c276..5500c5afb3ca 100644
> --- a/drivers/ide/ide_platform.c
> +++ b/drivers/ide/ide_platform.c
> @@ -85,6 +85,10 @@ static int plat_ide_probe(struct platform_device *pdev)
>  		alt_base = devm_ioport_map(&pdev->dev,
>  			res_alt->start, resource_size(res_alt));
>  	}
> +	if (!base || !alt_base) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
>  
>  	memset(&hw, 0, sizeof(hw));
>  	plat_ide_setup_ports(&hw, base, alt_base, pdata, res_irq->start);


-- 
Damien Le Moal
Western Digital Research
