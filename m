Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8C2C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 25 Apr 2022 00:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbiDYArj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 24 Apr 2022 20:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbiDYArj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 24 Apr 2022 20:47:39 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A805665D1E
        for <linux-ide@vger.kernel.org>; Sun, 24 Apr 2022 17:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650847475; x=1682383475;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w5zLXzL4wFyNDf1UHVnJxkjWiPLqYrBtKIh58L/3R7A=;
  b=rE2RBVc5148VG6+ECbH3CSpENiA/pYXjr6OPPyeI1EI29N5vtf3jOw14
   LZBILefVeARpaZCLw72eMm1QMw8ClTjXA/yX3O/oIzNUNRAaQi27npg2q
   Ktw0JGYaHrLzUWJpikRtzMJpBfjK6BBrMNumN9I6CyCIwt5q72RXUf2le
   P8JVFGjsevP6jvzJmG0eC7QUz83VdW3x81M9RFf563on2mWOBro2I6nXy
   Kpxeydu4kHOMqTG8DKJEPAlzoO/ItsNEEo83xVymyHU1ytK4rLM9ess+f
   xNduBgksNZGpOF9PBOHBNfyYWvLi/EwBIufQ2rQ47X00RmYF4bEjiy53n
   w==;
X-IronPort-AV: E=Sophos;i="5.90,287,1643644800"; 
   d="scan'208";a="199600608"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 08:44:32 +0800
IronPort-SDR: UliJgfyijDg+DE7BMFOkKEtJTDqBC70Xdc64SDQOTBpwSd98yFkw7v7FeB6hoIKXRw7S+Zt6eQ
 iPpD+sthGh94q6ukaZAnBNcM1eSml8vPAtwd9WtiS+SxDrTFzKb7e0dMEhygBqxp7Rjy+/W1yc
 LzPVwGaXWxIFMZNcon6e4fHUKQfS17wS1VkQ9Qa4fm3OueLespXTa3lUqikbJJt6TBEOjBQ17w
 SnHdLdqYVXhkTIcVeVDCq2Z94mORZczcHyDkIhnAg2YYEsE9QXWos+Qv2lXkTDglSI8gZExsKf
 9BbrFFujVUzfFxKIODnzdGM8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 17:15:28 -0700
IronPort-SDR: fnQM90Jw9294WqdXDWJXw2uMPtPV/gKXC2D96wkbCBiNtTqz00xZP4YNMLwJJyfSiyOMiLawo0
 tLHjSKUVEPRScoR8UMXUzoMq88k7AFLat+lFg3fs41AcHV7VAltbYC6M+lNx7IALlbfuDXC1wu
 fZbba/8CP2juGHWJ1CE6oq2r2R19c9Ww0r/LXEnYoqfBQUwxIRwlhGwzoXpPhqY2R5XJuJu8iJ
 SDEKhAapPgKchP6uuRR5vM7HYC9jtIcaGWRFY9GNIV3QMGWFDcfGmkbEH1AKfoJdYnvvs8xEFS
 nck=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 17:44:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KmmVl6548z1SVnx
        for <linux-ide@vger.kernel.org>; Sun, 24 Apr 2022 17:44:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650847471; x=1653439472; bh=w5zLXzL4wFyNDf1UHVnJxkjWiPLqYrBtKIh
        58L/3R7A=; b=h6NKfpsvFOX7OsJ591fXvH17ksMhSekrPFDHlAgdGwuzsb/3xy/
        AshBiBjmxgrWFF8xP35jwEwBRXLn1NMSoAeTTFYe9t7kQnmOpppQBrqaMbU+W1Dd
        vYXl6ZjOM0DrV+2pt45VLw7+giFYysBfFHvgmRaa902uUmHFYMbCkW+O/vXidmqL
        MLw2B6ia4rEBpvfnRP9efsFVWBBGW4PxY6T+iAa8PspLHCz+VnVLPdiVOeh5cG1T
        1EYVBpEJ4u7cKf3iaJt8J53vqnoKPv3jrJaKR0C5My4BpDSFaYA+ordHR3eOwVR7
        I1Gon4xEtKphGrAiqKkdPAiQiJ6kX6WM54A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hLftJys0KmBE for <linux-ide@vger.kernel.org>;
        Sun, 24 Apr 2022 17:44:31 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KmmVk2vGlz1Rvlx;
        Sun, 24 Apr 2022 17:44:30 -0700 (PDT)
Message-ID: <b0469180-f6b5-acf7-735e-5eaaff77b670@opensource.wdc.com>
Date:   Mon, 25 Apr 2022 09:44:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next] ata: palmld: fix return value check in
 palmld_pata_probe()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc:     arnd@arndb.de, b.zolnierkie@samsung.com, robert.jarzmik@free.fr
References: <20220424093420.2129779-1-yangyingliang@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220424093420.2129779-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/24/22 18:34, Yang Yingliang wrote:
> If devm_platform_ioremap_resource() fails, it never return
> NULL pointer, replace the check with IS_ERR().
> 
> Fixes: 57bf0f5a162d ("ARM: pxa: use pdev resource for palmld mmio")

This commit ID does not exist in Linus tree. Is this a commit in the ARM
tree ? If yes, then Arnd, can you take this patch ?


> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
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


-- 
Damien Le Moal
Western Digital Research
