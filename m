Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0329C4332F
	for <linux-ide@archiver.kernel.org>; Thu, 17 Feb 2022 10:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbiBQKzx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 17 Feb 2022 05:55:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239409AbiBQKzq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 17 Feb 2022 05:55:46 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3AC2944C1
        for <linux-ide@vger.kernel.org>; Thu, 17 Feb 2022 02:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645095331; x=1676631331;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=JeHUzimhsaVc4RC1yQLd9Fwip79n4POX2phsWDfHGnE=;
  b=J8bszbMgfaHgm1QJy6WiMtIpSza215L7KXsFPhmeP+TBGw9tu5zuKDWe
   efZPDtgMBePY4SeDRUT+YtiEP/By7Ir+9m+skxpoK/qvdCDpjsZX2eefN
   6l/7mV5t9GKsc3ePv8T9/9UaX3o6boL6iHmYUvNfP8/w9I3oTKDohOXym
   uJc3nSaKLpjZz3tK9MXReUSznIkn3g2mjudZfIo6MgS1O65EAbRVX7Hwv
   ctfj0WjBdXIeaswSki2RlQtlOxCEJ+bnUBcNxM/8xyXeF5rebQQBDcIU+
   RkZ5Xo/c3Q2srhCQTaYJJnKhAHFMalHYJ2SiPi1eUnsnGtwP8nniHg37K
   A==;
X-IronPort-AV: E=Sophos;i="5.88,375,1635177600"; 
   d="scan'208";a="305083088"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2022 18:55:31 +0800
IronPort-SDR: OW8vsn3RF3uc1Mqhu4fgYSXmn2lnB6tfEKIHNWg5C0XpS77NYPb1bM0vFzOmT/1OZn5W00Nh3o
 MmLNG8mKi42TgX5JCq4I3xYQlrM0EXktk+biWf+Vc/UfMKqlfR2u/KrMueWVDQaPGMTCrEELZ+
 dajpvQI5dl0VgzbEdEfJW/NsYl9WE8TNbcDOoh7mB4+8ccfgNBCDHqXcHQAnmdkAVm9t6ATs5E
 Z1yr9uccJAmYthrVPUAWvJROKfuNOsXhBn+sKUczU/Y1stvauu5J1AaRc57VHkfviOMSdv8aWd
 aW3/EyTJwslHdW48RUjF03Ss
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 02:27:09 -0800
IronPort-SDR: Rw1YIT8Lqf66sScJ/mTxWjr5BzUVm3E21gKbbhqFSzu8lwkWssnA7/0uxdPWB25LCEHQJ6w3mJ
 qpCGJb4O1LDzibCeApiZZsHhZk1g4qzu8Z5a4Vpx7Ea5jRAW1M82shNpFV3NL8Dcof6KC+7SGv
 zTkueL0eRfsb7juh8vTan8LttngzIOwiRwTvfEdU6dwZy+m0igrqRWq53FBiWZbeF3rk5eVDCL
 Zp5oWUA6eKXkQzdNGw3dRlX1S7Zkoxx8ozJM89UQddVJMn/sLDa1r54V8ry/SlMy+pevSiYIVE
 P9U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 02:55:32 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JzsDg0b2lz1SHwl
        for <linux-ide@vger.kernel.org>; Thu, 17 Feb 2022 02:55:31 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645095330; x=1647687331; bh=JeHUzimhsaVc4RC1yQLd9Fwip79n4POX2ph
        sWDfHGnE=; b=nfMMCd9NdGAlaYSF6V+dU7hJiPn/1Iclf/JIOFjyJo1t2BLCTre
        G8jY15FPeykgKtkqUAeNCeDwjR4rJNYmkDVpfRKwmlsD+fHHSf433eu6WbSb+Chx
        P3zLksG4Y26oVtBBEpwXckJvk3+78FcXRR114ZzzGwkDgN4qo1a25Aae+fzcxDei
        5y3KjzP5MM9NLWJhxs558U/OpiQ4Od2aokXm8Avbi2nZTIFfKD7R6lyWgoPhme8g
        rpMNykUZnMuQxwEcbsg8L47OP0WptUOcvrlceRVovCiF7tbdW7QZZtjBWaKJFrzf
        6Xbhi8gA4crjlnGqL+766MQhigzZBqK5xag==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M9dHHcHxlP-3 for <linux-ide@vger.kernel.org>;
        Thu, 17 Feb 2022 02:55:30 -0800 (PST)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JzsDf2CqPz1Rwrw;
        Thu, 17 Feb 2022 02:55:30 -0800 (PST)
Message-ID: <15a39279-c348-cd7a-879e-64a86bb454ce@opensource.wdc.com>
Date:   Thu, 17 Feb 2022 19:55:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: libata-sff: use *switch* statement in
 ata_sff_dev_classify()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <b4b1d7c1-b786-358f-154a-ba755a0814fb@omp.ru>
 <16173ee5-00a8-4bd2-484a-d4c5953b98a9@opensource.wdc.com>
 <d607d22d-fcd3-15e9-d58a-459e0393f805@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d607d22d-fcd3-15e9-d58a-459e0393f805@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/17/22 18:29, Sergey Shtylyov wrote:
> Hello!
> 
> On 2/17/22 3:22 AM, Damien Le Moal wrote:
> [...]
>>> In ata_sff_dev_classify(), replace a string of the *if* statements checking
>>> the device's class with the *switch* statement that fits better here...
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>
>>> ---
>>> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
>>> repo.
>>>
>>>  drivers/ata/libata-sff.c |   14 ++++++++------
>>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> Index: libata/drivers/ata/libata-sff.c
>>> ===================================================================
>>> --- libata.orig/drivers/ata/libata-sff.c
>>> +++ libata/drivers/ata/libata-sff.c
>>> @@ -1841,8 +1841,8 @@ unsigned int ata_sff_dev_classify(struct
>>>  
>>
>> The err check before the hunk below could use a switch too.
> 
>    I have initially converted that one too but finally decided to keep
> the order of the comparisons intact -- it makes more sense to 1st check
> dev->devno in the last *if*...

Yeah. Not critical. Just tried to use a switch and that does not make
the code very clear anyway :)

> 
>>
>>>  	/* determine if device is ATA or ATAPI */
>>
>> This comment is a bit weird since ATA_DEV_ATAPI is not used. Maybe
> 
>    Why? A call ata_port_classify() should detect the ATAPI devices,
> we just don't "post-process" that result...
> 
>> change that to something like:
>>
>> 	/* Check the device class */
> 
>    No, I don't agree here. :-)

Matter of taste I guess. I do find that comment useless anyway as the
code is fairly obvious. Leave it as-is. No problem.

> 
>>
>> Or just drop it... The code is clear enough I think.
>>
>>>  	class = ata_port_classify(ap, &tf);
>>> -
>>> -	if (class == ATA_DEV_UNKNOWN) {
>>> +	switch (class) {
>>> +	case ATA_DEV_UNKNOWN:
>>>  		/* If the device failed diagnostic, it's likely to
>>
>> While at it, please correct the comment style here (start with a "/*"
>> line). There are a ton of these style problems all over, so when
>> touching code around them, let's fix them :)
> 
>    OK. :-)
> 
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
