Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5484EC433EF
	for <linux-ide@archiver.kernel.org>; Fri,  1 Oct 2021 01:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E6DC611C1
	for <linux-ide@archiver.kernel.org>; Fri,  1 Oct 2021 01:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350757AbhJABUL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Sep 2021 21:20:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53780 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351158AbhJABUL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Sep 2021 21:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633051107; x=1664587107;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d/YAFR2WQBTMOSaK3olQwJN2NfZ4x0xKrgoKumI7sk0=;
  b=a3cWMX6sLgYP8I+DwXIwCz1Kln1y4YRKE/jI4oTpYHThI75thKwIb7Of
   41AyXzUxNDPItDjDnTIbjBHT2maHcHvH0A6u6PbEoP5oqKUgCQ3z0nYdj
   DpgluGXQPD2QygR3AYzeoAP41Gg3cn1fXrmT7a2lmd1JqiV/ld1h5AlxH
   np7YHObVqv7YwlToTdbVVwznGsPrehwRAKqa5E1lYdho5FsnoJhpHVPaS
   cvAF07duhs/TFM54QNlWKNdwmbE0t/rpBzhSDI/aBdM05St7q3ZkgWiUY
   tDQV+Dh0/je0IIpPDlAPsn1ak6L+7RO4jyIg3J0G2SWfspyErhSV3iZ6x
   A==;
X-IronPort-AV: E=Sophos;i="5.85,337,1624291200"; 
   d="scan'208";a="180560896"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2021 09:18:27 +0800
IronPort-SDR: tpwH7dgrjdFgD27XXFA7kakd7jCI5rAzYOYSOKPxgqkZpGciPGoAs4SPKCi0grpxLZOpEZn79W
 2mw+QRjpn3DEtJIuO0VD35RXkKKBZXFfz5nB2ZT3uSMHhFe/r9mRyke5wIesOXxs1WEmn6T2m8
 j1XbJP9sBTRGQSvK0UXm+kaf8NaGHr7fI1JGKOQdmAx3XFPnuOPMKRdjvM2862iRoW3w+ZQEP4
 M9ROce766qyoheP+c+FoRmT+5DstSV1kVsxDsnWXjAooO9vFfsAtwSmuRNPj8/B9CDSk42pPAX
 /ukbl1wsOGb1xoWVDVJAzKC9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 17:52:56 -0700
IronPort-SDR: ixMtonqAyqt6qJT0CjTLpeWvOSwr+5EgApDsmi3OfSUlSQfz6iyBEYos/q1c2XDVSrqSCMgiGJ
 1PVU4mpWdYuS1nSes7/mEEybL2Q2xVjLSdrsQ7VAdZXUOG06yI1r4/p3T4J4oSgWoMqYIXcZ6M
 uFPSqR8fCsrwI0ve6/TMrb4oem3gF8hwYkiErTMyhYzPnixrLHfo1r4yXvwQR6JPo6ZGDPs5Tr
 fVO0yNJLOlvp8TqpKcDgX+k/rL8GYz2pAWTP0KvjRlY56Hzbq0V5/UrlLQSzz4osuaxbikBkwI
 /Ps=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 18:18:27 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HLC0y6yLmz1RvlP
        for <linux-ide@vger.kernel.org>; Thu, 30 Sep 2021 18:18:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1633051106; x=1635643107; bh=d/YAFR2WQBTMOSaK3olQwJN2NfZ4x0xKrgo
        KumI7sk0=; b=Q15PNIp19kw/+qrWH344cWoVr3G5Z3ZiDjU54e5rSZDK8+aIgBp
        bY6bDD9HIldHDpEl8S2phT4s86dM59F3d/DYFaB5U88RpqttnnsO7rp36XDY3rdg
        Q6md22Fc/j8b7SA/5iVTyW9bCKG3SXZQ3LN183S0WpVYQFpySa1ehC6UBZxXMoBy
        YZm153kwXnTCV+TXk36G3uei5/9akuXT9jZLGYarlDIRLVNcsxCS8BvQXwoc9yFS
        CgIMB/DoqKbncb7vK67B4m8UJOGSFoe/CjZHH+PxE2zXq89qNBtlBsBUfoalc1JW
        XEgmEf4lnA/T8WanQ2BdQCdogPDZbguSj8Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1ELOa7m5BmMi for <linux-ide@vger.kernel.org>;
        Thu, 30 Sep 2021 18:18:26 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HLC0y0hBKz1RvTg;
        Thu, 30 Sep 2021 18:18:25 -0700 (PDT)
Message-ID: <445ae4fd-46af-ba09-1921-2ccedcdcf4ce@opensource.wdc.com>
Date:   Fri, 1 Oct 2021 10:18:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH] drivers/ata: Fix kernel pointer leak
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     linux-ide@vger.kernel.org
References: <20210929121618.1157415-1-qtxuning1999@sjtu.edu.cn>
 <265805eb-162e-4d2d-1e56-39aa16c87934@opensource.wdc.com>
 <baee2cee-3401-e8e4-efb3-432d48bb9589@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <baee2cee-3401-e8e4-efb3-432d48bb9589@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/09/30 17:54, Sergey Shtylyov wrote:
> On 30.09.2021 5:35, Damien Le Moal wrote:
>> On 2021/09/29 21:16, Guo Zhi wrote:
>>> Pointers should be printed with %p or %px rather than cast to
>>> 'unsigned long' and pinted with %lx
>>
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
>>
>> Looks OK to me. But please fix the commit title to:
>>
>> "ata: atp867x: Fix pointer value print"
>>
>> "pointer leak" is too scary for what is only a simple printk problem.
> 
>     It's not a simple printk() problem, it's an kernel info leak that he's 
> fixing. But, as I said, this driver doesn't use MMIO, so "leaks" only I/O port 
> addresses.

OK. I interpreted "leak" as memory leak... So the problem is print of pointer
addresses that are unused. But if they are, shouldn't the pointers be NULL ? (I
am absolutely not familiar with this driver, never looked at it).

Guo,

Can you check if the values printed are actually correct and correspond to
resources used by the driver ? If they are not, simply remove the
ata_port_desc() calls.


> 
> MBR, Sergey
> 


-- 
Damien Le Moal
Western Digital Research
