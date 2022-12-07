Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBBAC63705
	for <linux-ide@archiver.kernel.org>; Wed,  7 Dec 2022 13:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiLGNWv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Dec 2022 08:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiLGNWn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Dec 2022 08:22:43 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C84ADF23
        for <linux-ide@vger.kernel.org>; Wed,  7 Dec 2022 05:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670419362; x=1701955362;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MBA3RUU8atxV2pIWYj0d+jaKkWZZU9b5BLBBvfS8F40=;
  b=lfpt1jo2796SYBHJwNo9z0ofSKXEeegs7smhqgjMkcmle2DEEYBsghf6
   ygb8gjjXnag2Mor8DiGPQdbRG/ZJCcyb5pAasLVbFIt5BA09d/bnlT7jO
   q2ahtMrsd3Z+NNBw0sJBfyT2umzTwd9zFjSY7QeOtUBJYGz0x1egdGaWY
   KiMeIZh+qSZjezPwoXJ6BRqqCD2Qeq4i44TMlqX5wHheUUfxR+fAsd1Pn
   LWjgkIYA0WDiUJgn7qJkjq3igfC7i0Fzbne8RHVTzoAj93Vx3SdPkeQAM
   Ncj0iwSA0NhDEplokYCRWZTpn+CEYhsP5wjwqroSeZjB5TKbthsrMWPqw
   g==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665417600"; 
   d="scan'208";a="218095705"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2022 21:22:35 +0800
IronPort-SDR: uVAtBl9Qn7uv2bg4azYf0hgO21lHaNqL6xjIsAnxHoezrKdOHa91FYw/Ah5MlAmu0UbZJuQNBp
 9G9wX4GH/Z4XSRvbYS0LnzfMUVHl2UooKiPQoXaVSehLCjCPTdzLWYDmb2N5C4oY/mOap2LReg
 eBnC19mg0DOhBgbGLrnGonL4VZ6iOsp8IDbOXZvVaTLfs6b439MhpMOivlqHzNHvDk63/jFFqZ
 9EQ1Rc/vjvP9zlXkWK9UgUHQszQ2kFytFcuDsLKcN5i5EhtFSbIb8W7DyqZJ6AbH35ZNktcFsm
 m9c=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 04:35:21 -0800
IronPort-SDR: L/obKho0gC+lokC63YYV7ASOBw0NubYc/+of/nQB8M4d0uDjS67ELgaBfUZ2hwvlWBh+18kP7X
 1EMp70yJcJ81ATQPn1I0apj2nhQMFvUjaxXlO1bBRWclI8IUgXrBHpWmk8BDhtzr17ukWjS8cL
 0n6DRkfeL9Q9+SSL3t6kSuCbtOuZI/OTyCUy1eVhUpo38eNC4OL+7WAGfSnaPdeAs85RNT4nbq
 WvlPJaSJGlI4r86z3Qg1NMSsMGeeSXiZjXQBuqguE79LPpXRpkO2OmBS9azcYXmp0nf3WcnjBN
 dAs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 05:22:35 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NRyd7073tz1RwqL
        for <linux-ide@vger.kernel.org>; Wed,  7 Dec 2022 05:22:34 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670419354; x=1673011355; bh=MBA3RUU8atxV2pIWYj0d+jaKkWZZU9b5BLB
        BvfS8F40=; b=kucfA1Q+jycUqtYawXrLAgc95qX0hndDZ/YSlFIFBJkM0riSJXe
        9owzJ/kjZX1maNEyjXTMQxTFR3vkm6rwz0yOBLPLH/3rCThrcHmDi9Gu1fOePlbm
        aYPEKEIJty4lSjEwiujFikEqvYY0mvlMCLnXu5Kx7jeBdn2UUcxjlfytYdhRqcFK
        IcqkveHcXMc/FdV4dcpOdqGBM5OFLLKnuXFcUVa1jSweJcDVVnffZrpRtqaxGCs2
        4X0nGqI3DkN4NiBoDYk7z1mXsJPAoYzrl11Tmorj4ZlDN7i3zzDnTWNITLB+jL//
        xVlzf/9tqsPoHnyueNV78Ap6EOYSSopH5SA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c24L5c1WEsUB for <linux-ide@vger.kernel.org>;
        Wed,  7 Dec 2022 05:22:34 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NRyd56nZJz1RvLy;
        Wed,  7 Dec 2022 05:22:33 -0800 (PST)
Message-ID: <4d105e81-7f99-a17a-2a84-5eb70c74cc91@opensource.wdc.com>
Date:   Wed, 7 Dec 2022 22:22:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] libata: Sort Pioneer model in blacklist names
 lexicographically
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221207102656.12486-1-pmenzel@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221207102656.12486-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/7/22 19:26, Paul Menzel wrote:
> Fixes: commit ea08aec7e77b ("libata: add ATA_HORKAGE_NOLPM for Pioneer BDR-207M and BDR-205")
> Cc: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/ata/libata-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d3ce5c383f3a..c08c534b7fc7 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3990,8 +3990,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
>  
>  	/* These specific Pioneer models have LPM issues */
> -	{ "PIONEER BD-RW   BDR-207M",	NULL,	ATA_HORKAGE_NOLPM },
>  	{ "PIONEER BD-RW   BDR-205",	NULL,	ATA_HORKAGE_NOLPM },
> +	{ "PIONEER BD-RW   BDR-207M",	NULL,	ATA_HORKAGE_NOLPM },

Nah... Not worse the trouble. If anything, I would rather have the entire
ata_device_blacklist array entries sorted alphabetically by vendor and models.

>  
>  	/* Crucial BX100 SSD 500GB has broken LPM support */
>  	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },

-- 
Damien Le Moal
Western Digital Research

