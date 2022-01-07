Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC5DC433FE
	for <linux-ide@archiver.kernel.org>; Fri,  7 Jan 2022 05:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346261AbiAGFbi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Jan 2022 00:31:38 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44763 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346404AbiAGFav (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jan 2022 00:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641533451; x=1673069451;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SYi02gry4KY913GWD4js08rQ2431DuZd5vGWNXamk/8=;
  b=IBqH+SYaU+plDt+7Zuz2WBnmKLXp2kE1nhU7VTZRrxeyuZ96XbLfL5qQ
   Ez5Q2et+y4bnqV3TVzAESKIHmec6VuPu9vG/pizfcMTbmSLJpiG5gXW5c
   k6rqBnI/dvQ1J/b8qpYMDb+L8S5ltrBYbtSxIWM6ZbEadN3vKp4qMOkuP
   IxB9zg4UuL/cSu5SjMHwVouwONVJi8n0IYQmnRFzcrJ5gIQhrFKuIEDpD
   UEgBDVa3sHbth/oLn7WuIKopZBVk7VYfhzz886QZwHUts7djLpkkZc4nA
   9xHlMh6yRhbtloWTAcggUcDnsitJ5ehHq7P6d5hdAn2nB4fi+DKEbHf3w
   A==;
X-IronPort-AV: E=Sophos;i="5.88,268,1635177600"; 
   d="scan'208";a="293952301"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2022 13:30:38 +0800
IronPort-SDR: GD5kTClbIC2cY8amwFKsQdu/QBZ70RHlWvSolj+Ri25YP+zIicJI1Ky0xCFmiTJinALsyyFbbZ
 sun7WV3JZc6Vn2XeaDv3V+BNLfG527bLLozEMHQAgDYRZ73+Wp8G5ht/KO2tNnJ1K/4pJBANWK
 jFu20+dixddJuCvCl1Z10c0S9oPEw3dDsVAA/tWM7NH5eM2VjHDmjGgYooMchrJ8rLeUI3qIV+
 gkjmtWLXazY/uRrC6nPMn7+RC9hDTSQHU6T8IQa/gJ9QPP7q6bGFVCFb0BGjIVF/q46IxL4DU8
 p0rGYiTHRpPV+t9abuM9d4SH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 21:04:27 -0800
IronPort-SDR: luUEhce3fzkCBGCORvv7GrW/eB2iJlGpn3S31qVFHwQDKtN0APADJ543VOcLAkhU3fwKBo6w3a
 G3XIkgYLNBHdYL9n8eogeQSi/6qWDEtakLBQ1wV9Gb5Ku/I1CL85IvzGtLtdyNnZNt6YuR8Zuw
 D6OzZ/5HKxVCQIL7qVpdvuOf9n7X2tH4BEaTC4gLQSBdPxmKCVE0KZ1rJ6DdvtnvXZb/dG+jor
 6TmE779Cge5ly4EhdTjJnGewata+OGYGL8WPXmBpx+TJC6QPZ+1sBOiKuNNfDZM9LaMKOlKwaU
 Cmg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 21:30:38 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JVWyj584qz1VSkX
        for <linux-ide@vger.kernel.org>; Thu,  6 Jan 2022 21:30:37 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641533437; x=1644125438; bh=SYi02gry4KY913GWD4js08rQ2431DuZd5vG
        WNXamk/8=; b=gnrN4km1uEhgyeNbHHF3p0efRl7iTX+ztV1BPAOVmcHSMkxMIoR
        VFBcR318Pp7Q3KbOLrJUz9GDTPI2PCRRVpMYPTQxxf5Kck5DXn3Q5v94HirIsmz0
        zd6O/tpb6UEZR2HOq0Cw/TOIPJFLMcueYJvIM/4iiue6buhtAnXSPd9aE63fE4VK
        QI6ODluJ6OySphNT+zYUf2V3AgTbUEPpBI4Od/UE7Lq9WxdIW043FvS6fgDuoPz6
        x7wvX1n3oMKdARUKZjaiWww+zDkAorlk8bfIYD2BI0VXqWzKbGm2Ytt18FS7GRjo
        +TiWr3LttUpW+tM1ejc5rUBP830yHx+vI6A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fbZIiM8Piw4Z for <linux-ide@vger.kernel.org>;
        Thu,  6 Jan 2022 21:30:37 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JVWyh5855z1VSkV;
        Thu,  6 Jan 2022 21:30:36 -0800 (PST)
Message-ID: <087ac312-1d73-4721-f17f-af48b6ea65a2@opensource.wdc.com>
Date:   Fri, 7 Jan 2022 14:30:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] ide: Check for null pointer after calling devm_ioremap
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, davem@davemloft.net
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220107031733.3588290-1-jiasheng@iscas.ac.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20220107031733.3588290-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/01/07 12:17, Jiasheng Jiang wrote:
> As the possible failure of the devres_alloc(), the devm_ioremap() and
> devm_ioport_map() may return NULL pointer.
> And then, the 'base' and 'alt_base' is used in plat_ide_setup_ports().
> Therefore, it should be better to add the check in order to avoid the
> dereference of the NULL pointer.
> 
> Fixes: 2bfba3c444fe ("ide: remove useless subdirs from drivers/ide/")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/ide/ide_platform.c | 4 ++++

There is no such file... What kernel is this patch against ?

>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ide/ide_platform.c b/drivers/ide/ide_platform.c
> index 91639fd6c276..8c6e1af7b6eb 100644
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
