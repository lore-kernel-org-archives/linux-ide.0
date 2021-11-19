Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F32C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 22:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbhKSWVI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Nov 2021 17:21:08 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:18179 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbhKSWVI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Nov 2021 17:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637360286; x=1668896286;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VA1WIeoMomzEztwI0nhYAGQpBX75zQiLOR1PvtwhWTM=;
  b=cB0MV79zYcT3j+f8lgApi/4H7SDb6LTRFBbtr83hg8drCiB9mOlIY1D+
   JFsr2A9VEdZNKvD3Vc7nwDLjfrxqOCAcIfnc5Ru8yXgeczenrN/7eG1cU
   23dj0maJGtGkOoUIJ2GhhMGnHKrwKPcCMs7nF6GxH2uG4gAcoOB50WuJF
   Bu7A1BSVnaxqKVnZ8WEUtWO4fpUnTOXDOFMxQv14E6vPTURgTPOnPeC2A
   HTgFm1ZpEfMtjMl+braq94IMS4bDxV2Tzh+1FUwiWXdsH3A9isfO2jgPk
   tYAZEFqhXVAlzuI7PCw5p9qdUh28uvZzlpyNa92TbB9A69hiI4Oc1u5Fm
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,248,1631548800"; 
   d="scan'208";a="186144835"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2021 06:18:05 +0800
IronPort-SDR: 0GdsBFEKF9M6iT0aa17NgwdCgAdR+GKTBiNYoWzwx7BLGJBs5YyeoZVshOT6d9/jgS10Kuyx9g
 h4ojYAF50NwBuErdFbfaWEf49DZmZq1SzCaKr4+xx0AdpnplfW1so/kgWLUxumhcU9sHlIUBkg
 xidACkmFK8ozR1pZneZw4hkrQp7ubJP9V3Oqiipp4WD48OJslPUGdKRCnYHDrunoScadW3hBQm
 XBSX/s+yJwqAeWaps4Nlzt4gGzGPZwEJTWQEL9dLWQRvwSWdl0C+VdRttUzmHfz+p0HwLjALN/
 RMl8naYSL14n0PP/r6c0NEp9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 13:53:05 -0800
IronPort-SDR: k5KmXCbgjLjYhaaGlThgXNPxGOQ+ucA1DbiGnOTg2qH9G31731D3DiXOgVVYh+tjLt5GPz8JhD
 vchPtznO07vuXFd1PcFd6IvDcvYuZfYO7EuTUWFmksj8BJs0oxylXHI9hJQj7PYjxR9M7H3uhp
 l8T1LMfjAiAIUFu6t7t+7ikCaWx/HGc4eF7KrQ8Ul9sc/TBYHKJxFSET+mt4Gv3JzYrRbwg1Xm
 pKv9/FMzol7SWpTIElTgxKyHUCdgNg787T3ioWKiYQiV723XzbfbyAMA/bTuTFr69a92rsilci
 U0g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 14:18:07 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hwrdn1Rnnz1RtVw
        for <linux-ide@vger.kernel.org>; Fri, 19 Nov 2021 14:18:05 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637360284; x=1639952285; bh=VA1WIeoMomzEztwI0nhYAGQpBX75zQiLOR1
        PvtwhWTM=; b=b28QL1UR7gaBakwsydvg6wLHNy+svz8UPggyAcidWSiEJx7rf2z
        EXUtR+bh1J51beSzsTwKnE/Ott8Job2gwUFnJ073yrxx6JsMICLmTeaKiC1queTj
        SZsc1sgnaYjXXaFH7pKT3Mo+AjstgXG3iR3Bo2igj9pEPp1cO+BI8x6tMuwPG/cK
        eTS6ThkBJvWYxs60KiMkjKLTVNuIe0Vgi+oIffeVx/NuMNq2fME+5esRyqgNVbof
        +JCnL8dFM+DO2vuBZog0uXqMkInfbu+CvXUtC33J0n4vgIK4E2FMJ43Hc8AGLM/9
        G2beOPoDVt1dBVyOKtRhVHO44H+XTiAKYUw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xvkXEdzBfgwk for <linux-ide@vger.kernel.org>;
        Fri, 19 Nov 2021 14:18:04 -0800 (PST)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hwrdk6z75z1RtVl;
        Fri, 19 Nov 2021 14:18:02 -0800 (PST)
Message-ID: <aae68060-2941-36fd-0abb-e10fdc687111@opensource.wdc.com>
Date:   Sat, 20 Nov 2021 07:18:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH -next 2/2] sata_fsl: fix warning in remove_proc_entry when
 rmmod sata_fsl
Content-Language: en-US
To:     Baokun Li <libaokun1@huawei.com>, axboe@kernel.dk, tj@kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     yebin10@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
References: <20211119041128.2436889-1-libaokun1@huawei.com>
 <20211119041128.2436889-3-libaokun1@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211119041128.2436889-3-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/19/21 13:11, Baokun Li wrote:
> Trying to remove the fsl-sata module in the PPC64 GNU/Linux
> leads to the following warning:
>  ------------[ cut here ]------------
>  remove_proc_entry: removing non-empty directory 'irq/69',
>    leaking at least 'fsl-sata[ff0221000.sata]'
>  WARNING: CPU: 3 PID: 1048 at fs/proc/generic.c:722
>    .remove_proc_entry+0x20c/0x220
>  IRQMASK: 0
>  NIP [c00000000033826c] .remove_proc_entry+0x20c/0x220
>  LR [c000000000338268] .remove_proc_entry+0x208/0x220
>  Call Trace:
>   .remove_proc_entry+0x208/0x220 (unreliable)
>   .unregister_irq_proc+0x104/0x140
>   .free_desc+0x44/0xb0
>   .irq_free_descs+0x9c/0xf0
>   .irq_dispose_mapping+0x64/0xa0
>   .sata_fsl_remove+0x58/0xa0 [sata_fsl]
>   .platform_drv_remove+0x40/0x90
>   .device_release_driver_internal+0x160/0x2c0
>   .driver_detach+0x64/0xd0
>   .bus_remove_driver+0x70/0xf0
>   .driver_unregister+0x38/0x80
>   .platform_driver_unregister+0x14/0x30
>   .fsl_sata_driver_exit+0x18/0xa20 [sata_fsl]
>  ---[ end trace 0ea876d4076908f5 ]---
> 
> The driver creates the mapping by calling irq_of_parse_and_map(),
> so it also has to dispose the mapping. But the easy way out is to
> simply use platform_get_irq() instead of irq_of_parse_map().
> 
> In this case the mapping is not managed by the device but by
> the of core, so the device has not to dispose the mapping.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  drivers/ata/sata_fsl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 30759fd1c3a2..011daac4a14e 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -1493,7 +1493,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
>  	host_priv->ssr_base = ssr_base;
>  	host_priv->csr_base = csr_base;
>  
> -	irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
> +	irq = platform_get_irq(ofdev, 0);
>  	if (!irq) {

Please see the kdoc comment for platform_get_irq() in
drivers/base/platform.c. The error check must be "if (irq < 0)".

Can you send a V2 with that fixed and tested ?

>  		dev_err(&ofdev->dev, "invalid irq from platform\n");
>  		goto error_exit_with_cleanup;
> @@ -1570,8 +1570,6 @@ static int sata_fsl_remove(struct platform_device *ofdev)
>  
>  	ata_host_detach(host);
>  
> -	irq_dispose_mapping(host_priv->irq);
> -
>  	return 0;
>  }
>  
> 


-- 
Damien Le Moal
Western Digital Research
