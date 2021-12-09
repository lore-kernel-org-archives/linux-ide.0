Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43908C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 01:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhLIBR7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:17:59 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3452 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhLIBR7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 20:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639012466; x=1670548466;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0lwqys45I6gODNvKdIdsZJWCKk6YGjYRoiWUpI5j1hE=;
  b=fscG6XaYT6ssTGnzCulNjbsB1+qcTWb8Act7HCBiNPYhQpMsqBiyRurI
   bwFSjQ8g+1LzZeW4kYpVF/qYhSHOrWGMaSA317JQI3Oj/BUlvptJhSD4S
   6YMoHWaCY71Ok7PM+V7xViCzDd0CZKyjhKAc5Nw2SUTLTwKaYkG326zi2
   urpkEkKdDRt0TBvUXxrdqUIUuTo/J3gVTa65ppm1ZqPfnhJexcaIh46Ac
   1aWMECHgAMtPLAcfX1tWqTULaO9Xm7Sl8sTm3tDLjneJiAWHrRchxjn3h
   94vyTyoMYgm9+TjPru+hkTUOPz4envY2JngCl9RU4Y9ujqJD0X+IHJXDB
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,190,1635177600"; 
   d="scan'208";a="192576477"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 09:14:25 +0800
IronPort-SDR: EyP9wSgcGAXQHVDvOAiWPMzGW5T7JL9NMPmSd1yGAfyP5N/36wTNHiaRNNd8ba/aZebuNnXNsT
 FKNyMtUYTcnu5Y7lrKbcNnkXI/UPh2uAyi+ym44TidZYPfS1FT8cI29Fg00LV0PYgIVAg7oOnN
 Rq9Ms+WnZ+sGWadXs30YLhFV6LM6SGfTp+R29tXyvOj2CjswTjdh8mgpFgCrG87zZa8mjvfkHi
 CkjGuMnDzNbWBKBCz8XMaVeSFoB/HgiovjRdOjp2M4OM9BkYq0K4TrUI7OhbbHBH/+pb5TEvQv
 SPy0Sw6/ZUbxQZsla2I8j5ZT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:49:00 -0800
IronPort-SDR: 31QRzH5kyOtVF60p+/cufgCrvvDCUbcVLwhwSuJ9t3taJHJdkAVeisVPhw6RvuactJLDWhvfLY
 iIBhKgnBQs/Qoi2JqQvvA7DUFU1CJWB1gR6yfwhY09/1prWUHd227/uxJKHFi86S+lJAtYFa3G
 p+QCXyj4uMjx9Nd7tgTfY09Pnp1tYWlyqJqWvyV0K1BHa1wIYLNqzk2c5S6FpBGzDmidFGPlLe
 9jmWIuUa20gRbndwPn6XmV+5SqRau23onVOhl49OGkC6YJxNS83ZiTStg2wf4KHRUhzzhXJ3bc
 fdg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 17:14:26 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8bfT5tggz1Rvlf
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 17:14:25 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639012465; x=1641604466; bh=0lwqys45I6gODNvKdIdsZJWCKk6YGjYRoiW
        UpI5j1hE=; b=k2TzVbi6Wb42wm8Y8HSuBLbBGddZU0v5ZTlFId5HOf1vW6pPTNc
        RBo6TPihNZvUIJYG+JzmAwxRHHG4kfVXeQtcTqlVderj6aU+vzIECaxlMkOszFu3
        fXWLTMYQ7MpkKAoeliKLJGrkWXEC/QVRnL8bU02acowdWBCgd0V7jLcBRH4eefcw
        ZFkSlIpl3l4ZLAFBphWbwK+LCnFgIIL1g9b54Pyfg8pWG7uIMukWc3GFGJpe1FW9
        TQ9zO9wWPvHLw3lbfa6Ds8zFzwRlmmDx+axybZudtmeK2FimR7QrGw33khk+WLW3
        knEPRt7ot3tytTNnx8ZaP1FRVbvrs9VZZUg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id l30Hhx6iPrTG for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 17:14:25 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8bfT1Dwmz1RtVG;
        Wed,  8 Dec 2021 17:14:25 -0800 (PST)
Message-ID: <55f961fa-fab2-0ba3-2c19-72f4068491a4@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 10:14:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 71/73] pata_hpt3x2n: convert pr_err() calls
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-72-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208163255.114660-72-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 1:32, Hannes Reinecke wrote:
> Convert pr_err() calls to dev_err()
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/sata_gemini.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
> index f793564f3d78..440a63de20d0 100644
> --- a/drivers/ata/sata_gemini.c
> +++ b/drivers/ata/sata_gemini.c
> @@ -253,12 +253,12 @@ static int gemini_sata_bridge_init(struct sata_gemini *sg)
>  
>  	ret = clk_prepare_enable(sg->sata0_pclk);
>  	if (ret) {
> -		pr_err("failed to enable SATA0 PCLK\n");
> +		dev_err(dev, "failed to enable SATA0 PCLK\n");
>  		return ret;
>  	}
>  	ret = clk_prepare_enable(sg->sata1_pclk);
>  	if (ret) {
> -		pr_err("failed to enable SATA1 PCLK\n");
> +		dev_err(dev, "failed to enable SATA1 PCLK\n");
>  		clk_disable_unprepare(sg->sata0_pclk);
>  		return ret;
>  	}
> 

Why is this not part of the previous patch ?

-- 
Damien Le Moal
Western Digital Research
