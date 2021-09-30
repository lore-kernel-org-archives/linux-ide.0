Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23573C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 30 Sep 2021 02:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D50617E6
	for <linux-ide@archiver.kernel.org>; Thu, 30 Sep 2021 02:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347886AbhI3Ctw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Sep 2021 22:49:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:55335 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347849AbhI3Ctv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Sep 2021 22:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632970088; x=1664506088;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WDut9p2cJQN6avvffcALPa3BHeiApv0URU/MdsQ4aGA=;
  b=iT0BSGKKuGiUadLDQl0C6uCFxsIJMwXWdOQV7YS58WM+8C7ytTZHHF7Y
   GdNK8sKJiQJqj8IzcbTTaA3FRzK7CLWAQK4J7xwRhEcH6osSRQjqbQmKW
   zyMrb1gma/XnJ/nfLnrSc9swV5Uj3ENRO9CfIdVRnfru+9GZBKXDGIZz5
   bx7GiMp/uXi8AMuv8sngHRfiXwieHPByT6/pcSpta4QT7r8rh/GYm18v8
   nN7lQKRSh9sX8mf2QVR1m9gm2bmLUTpTrqyVcVJDtc1G2RVHk0MyCDRH2
   4oQCkegSd+zhvW021IhVH0oaMR/4lujhviVyP2HJFRKgjHpI6TmgccoZ1
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,334,1624291200"; 
   d="scan'208";a="186168181"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2021 10:48:08 +0800
IronPort-SDR: XqzE7F5Iq4ZxmjYs4QKj5Zdq8rWQ22cWtMgVZB+PxO7mE0APFJMlMASwhGOtCNbY1loIMQF4lx
 b8ZJIvILbdB2F/4VAe8kzYnqYaFcHKuuuM2H/H8YvuvzSx3nzFQIJ6OlEjxzhJmTjLkO6Fg0/r
 ZGmHSmXq0Ylis7x3h208UzoXPNPrBxMc5abDnX2A5p9kyMSw7GClwtTVYbUBqgRPZhypMbYSvp
 2kTKLedcdDjHcyfX01bJkFw1M0DL+2KgOugRNbdE8bdFzYFVwQTHIQVZefi/mXBa3YVYk+kyUC
 TLtgJbamPQMjejpgsoTrhiIk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 19:24:12 -0700
IronPort-SDR: vPA2Y52+JEkB0Rh09/YiPdsh5wPlscaSME+YQEuOeBx1PoFdM88V7xKoOtR+SJ8XruOGKEICCn
 DMh2APvmSirT971UzHtQcIVcyH0Kr96pcr8CMpSNQ/XA4ky6zmx5Kh42U9EhwSz483Fy6stlhh
 ssh0d19Whkz7ay6jrjR8iDzrje4buolaF8KwSn8v8dEG6QNbo0hSvwyDG6pzsLYWie5fF2X606
 tAu8NoOysVlsMTwPigLSBS578rDEo/4kckeQaB6S/uCgkKl8qpyuwsQXJ4+Noo6K5fd4kwE3ix
 UMc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 19:48:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HKd2x1KXBz1RvlP
        for <linux-ide@vger.kernel.org>; Wed, 29 Sep 2021 19:48:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1632970088; x=1635562089; bh=WDut9p2cJQN6avvffcALPa3BHeiApv0URU/
        MdsQ4aGA=; b=QDWEEr8y3EVoQET/4rDJ7/K1aocdxbXCqcJw1Nvd4Z7osl3mKce
        26zNTZhX/FoSFVoetAyj//B98oSe1tZIQWtpu6G6EnjI7RU7BF9qK3HUMK0mCiFm
        AL0SWlRAO2CyBu1CLNZrbN3H+CEp0mqcqcDSqkEw1OE150wUc2xM0lFcSByHHC0r
        bzmAilF9tWSUL2OKbvz5ERtdGuuyoafMCwIvrA+7Ra1gZVlyeotDWBWmrFqYt0NF
        ADg1aJfoctvqTvD5x/R3aPe9CpuiNkPU9t17xeMv1Npw+7JKJQpQ3MIZBdDtLt2z
        NhMPUSXcGpH8v04wRSZEktWthi7oT8FF4fg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OyoGcPUVpse9 for <linux-ide@vger.kernel.org>;
        Wed, 29 Sep 2021 19:48:08 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HKd2w3SxRz1RvlM;
        Wed, 29 Sep 2021 19:48:08 -0700 (PDT)
Message-ID: <9109b0a4-070d-a980-6731-24194426d12c@opensource.wdc.com>
Date:   Thu, 30 Sep 2021 11:48:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH] drivers/ata: Fix kernel pointer leak
Content-Language: en-US
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     linux-ide@vger.kernel.org
References: <20210929121618.1157415-1-qtxuning1999@sjtu.edu.cn>
 <265805eb-162e-4d2d-1e56-39aa16c87934@opensource.wdc.com>
 <d6aca15f-32f9-191b-9787-179a9ed6dcee@sjtu.edu.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <d6aca15f-32f9-191b-9787-179a9ed6dcee@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/09/30 11:44, Guo Zhi wrote:
> On 2021/9/30 10:35, Damien Le Moal wrote:
>> On 2021/09/29 21:16, Guo Zhi wrote:
>>> Pointers should be printed with %p or %px rather than cast to
>>> 'unsigned long' and pinted with %lx
>> s/pinted/printed
>>
>>> Change %lx to %p to print the secured pointer.
>>>
>>> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
>>> ---
>>>   drivers/ata/pata_atp867x.c | 10 +++++-----
>>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
>>> index 2bc5fc81efe3..c32b95f48e50 100644
>>> --- a/drivers/ata/pata_atp867x.c
>>> +++ b/drivers/ata/pata_atp867x.c
>>> @@ -447,11 +447,11 @@ static int atp867x_ata_pci_sff_init_host(struct ata_host *host)
>>>   #ifdef	ATP867X_DEBUG
>>>   		atp867x_check_ports(ap, i);
>>>   #endif
>>> -		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
>>> -			(unsigned long)ioaddr->cmd_addr,
>>> -			(unsigned long)ioaddr->ctl_addr);
>>> -		ata_port_desc(ap, "bmdma 0x%lx",
>>> -			(unsigned long)ioaddr->bmdma_addr);
>>> +		ata_port_desc(ap, "cmd 0x%p ctl 0x%p",
>>> +			ioaddr->cmd_addr,
>>> +			ioaddr->ctl_addr);
>>> +		ata_port_desc(ap, "bmdma 0x%p",
>>> +			ioaddr->bmdma_addr);
>>>   
>>>   		mask |= 1 << i;
>>>   	}
>>>
>> Looks OK to me. But please fix the commit title to:
>>
>> "ata: atp867x: Fix pointer value print"

Make that "ata: atp867x: Cleanup pointer value print"

Since this is actually not fixing any problem at all. No need to have this patch
being automatically picked-up for backporting to stable.

>>
>> "pointer leak" is too scary for what is only a simple printk problem.
>>
> I will send a V2 patch.
> 
> thanks.
> 
> Guo
> 


-- 
Damien Le Moal
Western Digital Research
