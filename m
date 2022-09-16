Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A406AECAAD8
	for <linux-ide@archiver.kernel.org>; Fri, 16 Sep 2022 14:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiIPOVx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 16 Sep 2022 10:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiIPOVp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 16 Sep 2022 10:21:45 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC27B277C
        for <linux-ide@vger.kernel.org>; Fri, 16 Sep 2022 07:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663338096; x=1694874096;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=84pn1zP6OIV/5QpJPF4VioDf7XMSIZsIpSSdc8bqVLo=;
  b=Af6FHZZ7CW6Y4qr3sXG5SF+iKQdHg/GcohxSz6pqpmGd38x7UUtKmtav
   yxzbYEWM2LTCuasl2WtoHF3AYxyL+PATALB7cDB8NH/JPtSoXn+lfOYvK
   33JA5axqv9gAFKcslRkP2StOutwCteAr3iBS2YsD5xrBKQbNqbErtUb/B
   NFftTUamA7aIs79YOFAvwihB9h3rLyeuB/iC8O2DuJSdyxnnrQ3J7kLGm
   IInnBTqBeFTqOfGeOlY6ndTGadNWVwDWbc5EA2hFFZdBkTIZv/HkEax4+
   +39mWy8sUxfdx7sx69SOQPGSdMzrYYQ4KKkZa90n/ogCz4AB/ZfQQFQWv
   g==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654531200"; 
   d="scan'208";a="209930965"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2022 22:21:35 +0800
IronPort-SDR: 1JAFbdPqfZlpLJQDb1eq+xR8S3oG/rfiY8ueqr3KsyRWTYtokbzEhQbmU+Rv7LXqSCdbc8FaMB
 cUZdyGGp1epJcpj+NTyCvYNQuMwumXpyqK3+ifBLR5r/ZRjCDFQiuGnwUMdfdahXyDKtDY9ioe
 trbfWlHy2EfdDGiOnzL6P8mRI2N/o3C/kaE+M/ShoDC799IvJuLqV2A5oolkkYUo+Xjk+Fvbw5
 Nx3dLvSV7yUP4wNrZhncOY1zeqzle1GtdvhyUAAbrQw0dkzUFiICQ2PkVYN/xzT5ogZNhzckdB
 odRZCe1piwdzXOFg6iBktQoy
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 06:41:44 -0700
IronPort-SDR: L/xOuWgVLWRg/Hx5JOPmfRjUi+8yl8eu4dv8s57KJbxorS5Vcu4D8nDEA/yMShQVfSeSXHn3qG
 i1S1V0mJHv6cyc0YppmMKzlvLJOsl44bljLTzMO37TVqXZeyPPkJIT8CCWPFXoZxZ+bh48+xrM
 LX0YYPz0iOkp2q2m9azsffyr1UmieHW7g0bxSDF6AH/V7eBD8aTiLBhPHhzYl5PsWJ+H4WFWuf
 WQFIbbK1bqoEwG+jAu+tRfQguN5srx9ZZPvqXGlCYpHgnaee3VzrrCby5Lt0Hb4R2DrJgKEIFD
 6tA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 07:21:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MTbq25Kd8z1RvTp
        for <linux-ide@vger.kernel.org>; Fri, 16 Sep 2022 07:21:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663338094; x=1665930095; bh=84pn1zP6OIV/5QpJPF4VioDf7XMSIZsIpSS
        dc8bqVLo=; b=SBl2kAtab+wRZelgXy74wEUdwx+SPFe9Ko2ETaiGfQ9+Bg4hJK9
        11cxhEpPON0+DY+iQmSLZLgkrPNU6YQN5UIVh33CWfzF5X/xgzjfWfkslhiPgy1T
        qHI7G+ZggRSWyJxM4eEKUYuTSgIsHmaHauTLW7JAV5HjZT4h+ELeaTojGZoV3Mbw
        QUWR9KK5n/GkWiSAq8ZtpXnEE0Ez++LzpRVoO3MNcqNvViZOTIYkIkm9rY4luoNI
        xbF0y6to3XwPlV+mzVOBM+rQD1Wk/ZOk8x+kV8DqV0ujCupbN6bvcs8gXb7pGyxB
        boXqPtFe9Xq7HgcqNl/AJ2TfGGEaDPjU6AQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JwliyqHGY33L for <linux-ide@vger.kernel.org>;
        Fri, 16 Sep 2022 07:21:34 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MTbq03J7tz1RvLy;
        Fri, 16 Sep 2022 07:21:32 -0700 (PDT)
Message-ID: <7b7f36d4-9aa5-fff5-bd82-3658be6496f4@opensource.wdc.com>
Date:   Fri, 16 Sep 2022 15:21:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v2] ata: libata-core: Check errors in
 sata_print_link_status()
Content-Language: en-US
To:     Li Zhong <floridsleeves@gmail.com>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <20220903231039.2278817-1-floridsleeves@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220903231039.2278817-1-floridsleeves@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/09/04 0:10, Li Zhong wrote:
> sata_scr_read() could return negative error code on failure. Check the
> return value when reading the control register.
> 
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  drivers/ata/libata-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 826d41f341e4..ae08c7d35cb0 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3021,7 +3021,8 @@ static void sata_print_link_status(struct ata_link *link)
>  
>  	if (sata_scr_read(link, SCR_STATUS, &sstatus))
>  		return;
> -	sata_scr_read(link, SCR_CONTROL, &scontrol);
> +	if (sata_scr_read(link, SCR_CONTROL, &scontrol))
> +		return;
>  
>  	if (ata_phys_link_online(link)) {
>  		tmp = (sstatus >> 4) & 0xf;

Applied to for-6.1. Thanks.

-- 
Damien Le Moal
Western Digital Research

