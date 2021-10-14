Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA70DC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 14 Oct 2021 03:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E8D61181
	for <linux-ide@archiver.kernel.org>; Thu, 14 Oct 2021 03:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhJNDh4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 13 Oct 2021 23:37:56 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:44902 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhJNDhz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 13 Oct 2021 23:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634182551; x=1665718551;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BTQ/FBytJkYeAe/W11YgyjFoLQZK3TyIHOuIxod+jto=;
  b=ls3+hvaCQNeZ2AMJ+gxhGKCtQIREdUx0U/2ylaIAB+8JuNGzId9ZYc+a
   V6PtUOMjvHLpVA4F+DLTgVpl2ZHpyv3XRlCHMxwrWjtD1hVOfNJDS5Kmi
   YG4cd6w6RREcQymfdHycGaujZbY0zUIJrRaktwcpyA6xpTE7kXMOyy8t6
   w8TWebiAfoE/C/Y23maFJCHQKIVqo1I2ZxdCzdgAooVQvMcej5WS1vSJX
   aQiRO2ncUiv82pWE2ZeTpLiKuGqffww2YWGRmnAenQFGq8KLXTKM3Elok
   C1ehL3DOup6g6vU/cMO+RHnQvK62XGzV0UvE8cmQhLr3LONGSrOVFhzGB
   A==;
X-IronPort-AV: E=Sophos;i="5.85,371,1624291200"; 
   d="scan'208";a="294521776"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2021 11:35:50 +0800
IronPort-SDR: uc/9yyPuEwA9jkkisEpjZMrl9yTu1/KIWHPE/Td46qOIZXZ+h+2wO2vf6ep/v/9G6y25aCd2TI
 hXrv9EdmsD84Ocedb0UGLjKrXYZszlgTskVDR5BtyL0pxwjHaX6CwNLgFlehAoavSqVwCgPFTY
 nAUtkHKWsubBd0oJmXuPkeYvZMFqCkoKp3SdCaPdayXx3NhGugnMpQvGNIggUuiJ21YjFUuTHm
 7lG0US5W0BL4/U90no9kyCZZPfpOn/dMTuvThoLJpdfJy04r6PVcG6vvwnrwJjIp8jz6HYcO/l
 tQcn9soMV3QL8ZTDEW0w9FQ6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 20:11:36 -0700
IronPort-SDR: fhurdYyL0ckR0soxbTrowwaYvAC2G9YZIjAWEXXsBkodu2RwwH0mkwmeH7SwQTQkolOoQON52I
 EbKFt1BrkJcML1jSL/aHD7ee36Nsjp9XxGZhg475AUdTaCXk7gGHWvH4ISanVYvDRmTQunoZOi
 QKNwGSnbgihMmiSd5iRrTM9cFTiEP3j8+Gg55Pz0QAPjYtobgQtNgPM7kh/YoXFzSo7B0JCR/q
 HQnyOWjpNPUoCBiFePkk9wursrh/m9HR3s1aRU2auZnFLVRuEzZoQGFWCvKAevqg4ycSujXrU2
 RFs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 20:35:51 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HVFRV5JrVz1Rvlv
        for <linux-ide@vger.kernel.org>; Wed, 13 Oct 2021 20:35:50 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1634182550; x=1636774551; bh=BTQ/FBytJkYeAe/W11YgyjFoLQZK3TyIHOu
        Ixod+jto=; b=a/BJuufDY74w5DB576fPRVgDJIPEN8OQRlJOWziAll5ZuQRM79/
        eEzSfEvP/tAsISf30RA8GTrZXxawQXWKpKvwHchHd7OCFPjGjbn3vX10DGjh1SPF
        wi3Hyym+ridca8EBir6v5jqxzpAQ/tp71fzky/etEDM8S/WTM7ssUZTtOiLg+aQy
        SWxOn5kRSycbFN6OhYDrX/7Ce78qDfr0G1zLlMmC+tDPaJH6KlDehBAE5EtY1M9P
        lzitx9sZkQLJWhdLt+68S9bIUOgHBO60fUFOn5oDk3hZBCgcc/KxXtJaQj76ORyg
        NaOvS5mbIUX0gsSZw+lVV2Lel1mdqC+ZV2A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EdoQkWYf_zFf for <linux-ide@vger.kernel.org>;
        Wed, 13 Oct 2021 20:35:50 -0700 (PDT)
Received: from [10.225.163.59] (unknown [10.225.163.59])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HVFRT0Z7tz1RvTg;
        Wed, 13 Oct 2021 20:35:48 -0700 (PDT)
Message-ID: <0a7afa9a-db24-910c-314d-2a6f7c43c5ea@opensource.wdc.com>
Date:   Thu, 14 Oct 2021 12:35:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] ata: ahci_platform: fix null-ptr-deref in
 ahci_platform_enable_regulators()
Content-Language: en-US
To:     Wang Hai <wanghai38@huawei.com>, hdegoede@redhat.com,
        axboe@kernel.dk, lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211013061631.2958938-1-wanghai38@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211013061631.2958938-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/13/21 15:16, Wang Hai wrote:
> I got a null-ptr-deref report:
> 
> KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
> ...
> RIP: 0010:regulator_enable+0x84/0x260
> ...
> Call Trace:
>  ahci_platform_enable_regulators+0xae/0x320
>  ahci_platform_enable_resources+0x1a/0x120
>  ahci_probe+0x4f/0x1b9
>  platform_probe+0x10b/0x280
> ...
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> If devm_regulator_get() in ahci_platform_get_resources() fails,
> hpriv->phy_regulator will point to NULL, when enabling or disabling it,
> null-ptr-deref will occur.
> 
> ahci_probe()
> 	ahci_platform_get_resources()
> 		devm_regulator_get(, "phy") // failed, let phy_regulator = NULL
> 	ahci_platform_enable_resources()
> 		ahci_platform_enable_regulators()
> 			regulator_enable(hpriv->phy_regulator) // null-ptr-deref
> 
> commit 962399bb7fbf ("ata: libahci_platform: Fix regulator_get_optional()
> misuse") replaces devm_regulator_get_optional() with devm_regulator_get(),
> but PHY regulator omits to delete "hpriv->phy_regulator = NULL;" like AHCI.
> Delete it like AHCI regulator to fix this bug.
> 
> Fixes: commit 962399bb7fbf ("ata: libahci_platform: Fix regulator_get_optional() misuse")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  drivers/ata/libahci_platform.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index b2f552088291..0910441321f7 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -440,10 +440,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  	hpriv->phy_regulator = devm_regulator_get(dev, "phy");
>  	if (IS_ERR(hpriv->phy_regulator)) {
>  		rc = PTR_ERR(hpriv->phy_regulator);
> -		if (rc == -EPROBE_DEFER)
> -			goto err_out;
> -		rc = 0;
> -		hpriv->phy_regulator = NULL;
> +		goto err_out;
>  	}
>  
>  	if (flags & AHCI_PLATFORM_GET_RESETS) {
> 

I applied this to for-5.15-fixes.

Note that the code right before the hunk you fixed looks like this:

        hpriv->ahci_regulator = devm_regulator_get(dev, "ahci");
        if (IS_ERR(hpriv->ahci_regulator)) {
                rc = PTR_ERR(hpriv->ahci_regulator);
                if (rc != 0)
                        goto err_out;
        }

This looks very strange to me. The "if (rc != 0)" seems bogus since if
IS_ERR() is true, then hpriv->ahci_regulator is not NULL, it is an error
pointer. Some cleanup seems necessary to me.


-- 
Damien Le Moal
Western Digital Research
