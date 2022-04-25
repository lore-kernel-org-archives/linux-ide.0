Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC306C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 25 Apr 2022 00:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbiDYAsx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 24 Apr 2022 20:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240023AbiDYAss (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 24 Apr 2022 20:48:48 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148B318E16
        for <linux-ide@vger.kernel.org>; Sun, 24 Apr 2022 17:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650847546; x=1682383546;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=8rRSUwHJlA2kIstcDcpcJ1bPHlVbpCs28zXsb0a5fI0=;
  b=rqpAWCzrbR/oAn/mIRvcaNgj3hphmwc39dJuRfPU+ltm//Mqp3bGeX/x
   t8o6QiY8m6gRNIWf5mGnjHDCuVZM799KBZbXYdpsIZ0WAxCPlgad6SYJc
   pRAjCDBP952+nRZSJLep6cI97XmHagdryp6LAgOXhunUV70v7HUXZbaVF
   r53woSrgb8VU3YI47Ac3Ltng7Xao4eaH6N53gs+HY/CHQZM+EFfTZCzzQ
   Kwv/Vei2l7vqgStC7iJF3BQ6TsSOeuO2VpJQL2s7bsyAcJG8puUJ17z5h
   mZ8SMHZvpcaq0R3lm74id5MdV2Rs4tm2s7DqvTD1LA7U91+7auETRtENL
   A==;
X-IronPort-AV: E=Sophos;i="5.90,287,1643644800"; 
   d="scan'208";a="197554694"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 08:45:43 +0800
IronPort-SDR: GL78TXhHQSKlhsFYm2YNS9uO/cFKc76KnOLM0OjPHWXMQ7wcj2WMVg+QRh9SGc6Tg8OoWavj3o
 LzU3SDS2t3CaWq6s3UfR3+jBMAFiKiiqlWMKzWuee16Ow+CGaUrkpqINGJim0DGoarx7wI9lk+
 OQJ2Si2WFK780RMnrRaUOxMl9VYd74tAOzo7iSkwVDaiT0a6663GSoPZKUWefZXKt6JUx7jZew
 4H979UE+a6pWv1TKesN/PPaLh1yzCD4/lqBl9oDEh8imXxAHhO1h5/1z75iTSsK+/yz89AExup
 UlZLn+8JupgT0Vw+RlzYMiHc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 17:16:40 -0700
IronPort-SDR: mCySYfTukc3Z1tRRxB+0Eg8URW34OAuHtKTDZI3T5JyC+ExgGU4dZSudPZKBVxdJlehzmJHbKf
 jC8SLE+CXDz3PLq9MH3sVWy/Wh5Su4lIXUgC+El/WsAto57bbNowFE1xLfNgUJ63rtzZCWW1e0
 Sk6XSmIEK3VzC8AGUpSKA9DbvIDBGH7qEB/0jUNnvq56S+EUEgUFdf1iA1kNpaNAdVOYGu3MNA
 e3pm/FCYY8Js/ua8G2YCXPdGoxeBQp14WqqY9FqaSZq7NBnPekGYTCQUMa5APWz0JI+OA8rIEE
 Wl4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 17:45:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KmmX731Lhz1Rwrw
        for <linux-ide@vger.kernel.org>; Sun, 24 Apr 2022 17:45:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650847542; x=1653439543; bh=8rRSUwHJlA2kIstcDcpcJ1bPHlVbpCs28zX
        sb0a5fI0=; b=AyGdqVpz6+RyaJV7VMTXLETh91ct2e79hDFfjp5erPGIBkr6k/m
        ZUpB+b05sF3Ff3PWqV3PoryU7Cp5+jgRBfcuWh66DI6T/J39C+s0cwYbgcRcW0vG
        zq8njdEwl/ETQAXAC/DAdBH0/e1aG8Ljcwe0sPqfjgZdmslUIrXgx2bx7qWiPXs5
        rGLMGcR6xJcgteLIUgvhWsNVLFBSE4MFWr+Gpet71/p27DlSxWTN2sc440/rSes9
        Fq6CtsfLSP/ssryG9baoPVMuu0e7Q2j4cHZpBg9YA72Htw91hlGxTDE6/6x/zdhr
        QNGPNX4Nim1S4zvmOZPczEV9ZgwwqmP146g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mCHv2pWjNE2M for <linux-ide@vger.kernel.org>;
        Sun, 24 Apr 2022 17:45:42 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KmmX60m1Zz1Rvlx;
        Sun, 24 Apr 2022 17:45:41 -0700 (PDT)
Message-ID: <b0d4418c-710a-9fa1-32b8-1b190b512252@opensource.wdc.com>
Date:   Mon, 25 Apr 2022 09:45:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next] ata: palmld: fix return value check in
 palmld_pata_probe()
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc:     arnd@arndb.de, b.zolnierkie@samsung.com, robert.jarzmik@free.fr
References: <20220424093420.2129779-1-yangyingliang@huawei.com>
 <b0469180-f6b5-acf7-735e-5eaaff77b670@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b0469180-f6b5-acf7-735e-5eaaff77b670@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/25/22 09:44, Damien Le Moal wrote:
> On 4/24/22 18:34, Yang Yingliang wrote:
>> If devm_platform_ioremap_resource() fails, it never return
>> NULL pointer, replace the check with IS_ERR().
>>
>> Fixes: 57bf0f5a162d ("ARM: pxa: use pdev resource for palmld mmio")
> 
> This commit ID does not exist in Linus tree. Is this a commit in the ARM
> tree ? If yes, then Arnd, can you take this patch ?

Forgot:

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> 
> 
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>  drivers/ata/pata_palmld.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/pata_palmld.c b/drivers/ata/pata_palmld.c
>> index 400e65190904..51caa2a427dd 100644
>> --- a/drivers/ata/pata_palmld.c
>> +++ b/drivers/ata/pata_palmld.c
>> @@ -63,8 +63,8 @@ static int palmld_pata_probe(struct platform_device *pdev)
>>  
>>  	/* remap drive's physical memory address */
>>  	mem = devm_platform_ioremap_resource(pdev, 0);
>> -	if (!mem)
>> -		return -ENOMEM;
>> +	if (IS_ERR(mem))
>> +		return PTR_ERR(mem);
>>  
>>  	/* request and activate power and reset GPIOs */
>>  	lda->power = devm_gpiod_get(dev, "power", GPIOD_OUT_HIGH);
> 
> 


-- 
Damien Le Moal
Western Digital Research
