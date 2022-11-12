Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C4DC433FE
	for <linux-ide@archiver.kernel.org>; Sat, 12 Nov 2022 02:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiKLCMD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Nov 2022 21:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiKLCMC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2022 21:12:02 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE021F61E
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 18:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668219122; x=1699755122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WQd0tuGhFCozkOHjDWW+kUqRokl8phBHfghcLIyAaHA=;
  b=qL9wx0X+gDNSgpK7Yr4b4U80ZoMDpMiTDxVRnba1+I5cG1hY5P+2b2Je
   LbgjbYPk8Saav6rPdklZfBA88JitOWfit0mZZU0zS22E8aAdMZv9cJYQb
   gl6+Kwdj6eDwuOeYNyOt1eo7iRNM5/2clRpZnpFLw56T3nrokdO+R5a9u
   +zZlAufepkPd1cBM8dZEtnSXLz88ypTJXyh7IJZB+mYnNvegGCe7uHbFT
   XlkeUsLImHjcpbrqblFXoRo2XwC/s+RemzOdukjN98VU1SIVR2kI9c1DG
   DV9U4yCtozz2Fa4XxFMo6LroydDhakRPSwNItTtQNd5iamiPkgST6Pkoa
   w==;
X-IronPort-AV: E=Sophos;i="5.96,158,1665417600"; 
   d="scan'208";a="216095406"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2022 10:12:02 +0800
IronPort-SDR: PJdSGG77I/hLcT0B7Qe+hWzXMcmvHn9ntlAI14bnD8e9mNCG6WIDG4GLdFSC0Zj1/oFlKGwZRq
 y67XO5CqdBMOhDgnEZIDXLZ/s5lAvuv24QVkvYTh8eGiKrqEtm81AjCnQbGCd1u06KpaGmH7/H
 CUvcC7GZCP3B4K6niDzfVcHV40chbDhax0WWpeMd68BIVRD7juHB5pj3JLwLmg++EV04rSy4y1
 OUqtRTtUi66l249zmERe/0RfV2tRsBQeZC202kNuudLg3eyWQb+94wX/ahLt6GTuK0//qs2hPg
 ZYw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 17:25:19 -0800
IronPort-SDR: ugj728pe57kBbB3Q4fBM3CiZYp23HfdMtlKJ8o2Kf6emB5Pf07IT04hsvUGhn+3LN8K+NU4vJQ
 V3oskDKoD2xQsbRfjHbEF0ehY7xjvAES98rS9W5+N3W4pdjcqn2gn4xlwhLEm7w/ch4mw+4cuq
 8R+DNdPRKdA2KkG+V7booAtV4j9/UDqWAM5Qm9LtzmgI3fUDnbRFFd9ZS7TQDOjYE6O8VwAdKm
 BdPDlEtdcyMydC6qLqHjgIUucVT8DtNgRM1H8U8bHyQIx91tqNeTnkWRiIHZiwswtvXDQLZXcG
 p2w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 18:12:02 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N8Jwx6Tbkz1RvTr
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 18:12:01 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668219121; x=1670811122; bh=WQd0tuGhFCozkOHjDWW+kUqRokl8phBHfgh
        cLIyAaHA=; b=KCsByQYCQKCcsAVQJbpvrQW/C28QXibvRw9idxiZLQgNE4Uxy+U
        SyuDTCc0Hd7UfRO3juvm1MDS0Pa2pQ7ntDffDI7cUdVEWxTBrcwEEggwZD7OrriU
        UUlDq/1k5J7Y+pUHwZSngowNDisYFG7KvGYx+OFEE5DBtAIu3y5HtKupzTCUXDKN
        ARGx3Ef0GizqejsLvwhj/FvZtgFWPX3jrXuMmgBfsRffiC4S6sGBtkyDLq2TL61D
        MbolNQmCZPGYxO6i5uPXhdLjrlM6Vn7btP1FfrpteUsvJAs+YVNuM/zDsVpjYmpS
        /5hXuO5BciF1Ai67XxWU0DTHqz4kMrBBo/Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3sDJpu_iRJK2 for <linux-ide@vger.kernel.org>;
        Fri, 11 Nov 2022 18:12:01 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N8Jww5Cthz1RvLy;
        Fri, 11 Nov 2022 18:12:00 -0800 (PST)
Message-ID: <413631cb-b9fa-b148-9dc7-ccca6047ace4@opensource.wdc.com>
Date:   Sat, 12 Nov 2022 11:11:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] ata: ep93xx: use devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        chi.minghao@zte.com.cn
References: <202211111647123266703@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202211111647123266703@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/11/22 17:47, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/ata/pata_ep93xx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index 6c75a22db12b..47845d920075 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
> @@ -931,8 +931,7 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
>  		goto err_rel_gpio;
>  	}
> 
> -	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	ide_base = devm_ioremap_resource(&pdev->dev, mem_res);
> +	ide_base = devm_platform_get_and_ioremap_resource(pdev, 0, &mem_res);
>  	if (IS_ERR(ide_base)) {
>  		err = PTR_ERR(ide_base);
>  		goto err_rel_gpio;

Applied to for-6.2 with the title chaged to "ata: pata_ep93xx: use...".
Thanks !

-- 
Damien Le Moal
Western Digital Research

