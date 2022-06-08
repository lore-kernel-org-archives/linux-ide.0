Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE43C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Jun 2022 05:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiFHFrJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Jun 2022 01:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiFHFmu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2022 01:42:50 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FCB12ABC
        for <linux-ide@vger.kernel.org>; Tue,  7 Jun 2022 20:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654658099; x=1686194099;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ZjTfJDnZQbNAtd3oOq629J8yWkreDaMfGWrCxgVxtpE=;
  b=Y+nTt8xwuSUQe8Q/zdin30LUwNZu4oy4//XgnTNg7D73jfwIL/qG6iny
   I8g1tWzo0u8ZX1NN3SD/zWKlrPO9/srv9Lxgg7JWjp0jhWtSu2kzxHUAB
   aq8fuZ1qcyf+v/e3ik1ctNB6JdQ/i+zudC98ZnwBgQqVg6NR7Of0VvF6d
   bqyfO+DXrWyUBmaGN6fKK0oIaMA2ooOYk9Q0v63MVCdRWoGyNM/Z/mxsG
   OUaNinZnjwyhRYqlS3t7Q8e59unkmrLVbOhi+xpuikUkXIAAcNfpEPxpt
   FSU/U9E8duGcSlQuS50CHOlDOHITsCocYgXcT2Y3JirdaRDNcdPM593f2
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647273600"; 
   d="scan'208";a="207406797"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2022 11:14:57 +0800
IronPort-SDR: WSU+RJmVzbhJeaH3DIvyz6H2c4ORsIaL7GCh6c0+qXJ8OKnlh6Go1H9rTkWfiqN3ZL40JejVYS
 8lctq4Qb8TfWX4cL8IT4YhnI7lSAjNZAFcPJUYeKtFjoqBiVeBjDRTLpuZUN+RiXnJ6OX44LAZ
 cdwBKlWdDpO9SKolYV0ZogcVW57NGDGyt9Yrm6gO9KcuFDl3dA7+cWN9uQbHUAgj2MPMC5uT6r
 nhTiME06ywDDnUwzo/ByJ2sI4dr0Ty83Bhneb2U1ufksLRcJS0h8lz//eXWTR25AV3YpTvh2Yi
 xfX5kP90tB1f5z3poydr1Grq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 19:38:13 -0700
IronPort-SDR: +pEbgMOgY4BuEI9Gr5omTs8NqeYAF+2U51N02o/sJCnXbRF3Z4LQ0sBu2NlljgB6wP/T9hZ5Fy
 VXWB5oq8Y8KzbTkbkPhNLgb/F5hxHEIxC+NZ2Gw7s2dv0Zdbg6x2R7tZWjIIWVCfeRLRmVonLF
 ZMn9S6fZcAZfpkgsD6iHGZIjNUc4wfuwG3UI8Ow1xkNek7zKv4aK3XRwdRKmmvfCv4bBPileVA
 3eHXx5KCg2B/W8BtcGW0iyiuc+W6dBp8vIRoCjk7X1XkGKHAd8/uTA3tx+a77xHiSrYq1FOavb
 Kbg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 20:15:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LHsm21lXkz1Rvlx
        for <linux-ide@vger.kernel.org>; Tue,  7 Jun 2022 20:14:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654658097; x=1657250098; bh=ZjTfJDnZQbNAtd3oOq629J8yWkreDaMfGWr
        CxgVxtpE=; b=bDoh3vL579rAa0sqTjx7F2fNqcwmWaDYHjQ5k9ZRXdj6IVIVCQI
        5Y+LVUk8MUYD/wkpCs0KEN1z5R15h052m1k7QsqJjK1J34/kenVwqSEhocj/JQoR
        qASfnrxbE3Wc+q4fmq4+1QBXeVcd7XLBWRS3R0g86px8NKoOfVS1feRlNWjEvkG0
        2jVjOrRte+T4DOZmKHSYrHHTfRvwDFkk/VyCNIt/cHfSVUXGCaCQ8ejTgBd/HQt4
        5+CgujBtZpBAbyzeSgtHRHiwBTAgbCTQTjiiWT7dA7fjzXEmqNssSOtO3uI7VFo3
        la1sT3b8nDdpojCUBgbZLtV1czdIYmTYaEw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ozf9f4gzxWyB for <linux-ide@vger.kernel.org>;
        Tue,  7 Jun 2022 20:14:57 -0700 (PDT)
Received: from [10.225.163.72] (unknown [10.225.163.72])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LHsm06fDnz1Rvlc;
        Tue,  7 Jun 2022 20:14:56 -0700 (PDT)
Message-ID: <1c81b5a8-b1b3-7bac-b7e4-9de7127c48b0@opensource.wdc.com>
Date:   Wed, 8 Jun 2022 12:14:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: libata-transport: fix {dma|pio|xfer}_mode sysfs
 files
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <b0f8a1d3-2550-31b2-702c-3294d0569187@omp.ru>
 <c9695894-3bc6-e825-8239-ea6aa3e4831e@opensource.wdc.com>
 <78ae75a3-7f11-b177-c430-ad746f7d106a@omp.ru>
 <a9a01deb-c314-3196-bd3e-947fcd8819b8@opensource.wdc.com>
 <ac79bf20-5db0-90fa-380d-3e16f81bd79f@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ac79bf20-5db0-90fa-380d-3e16f81bd79f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/7/22 18:49, Sergei Shtylyov wrote:
> On 6/7/22 3:37 AM, Damien Le Moal wrote:
> 
> [...]
>>>>> The {dma|pio|xfer}_mode sysfs files are incorrectly handled by the
>>>>> ata_bitfield_name_match() macro which leads to reading such kind of
>>>>> nonsense from them:
>>>>>
>>>>> $ cat /sys/class/ata_device/dev3.0/pio_mode
>>>>> XFER_UDMA_7, XFER_UDMA_6, XFER_UDMA_5, XFER_UDMA_4, XFER_MW_DMA_4,
>>>>> XFER_PIO_6, XFER_PIO_5, XFER_PIO_4, XFER_PIO_3, XFER_PIO_2, XFER_PIO_1,
>>>>> XFER_PIO_0
>>>>>
>>>>> Using the correct ata_bitfield_name_search() macro fixes that:
>>>>>
>>>>> $ cat /sys/class/ata_device/dev3.0/pio_mode
>>>>> XFER_PIO_4
>>>>
>>>> Looks good, but Documentation/ABI/testing/sysfs-ata says:
>>>
>>>    Completely forgot that the sysfs files are documented as ABIs... :-(
>>>    Hm, shouldn't that file be added to the libata's entry in MAINTAINERS?
> 
>    So what's your opinion on that idea?
>>>> pio_mode:       (RO) Transfer modes supported by the device when
>>>>                 in PIO mode. Mostly used by PATA device.
>>>>
>>>> xfer_mode:      (RO) Current transfer mode
>>>>
>>>> dma_mode:       (RO) Transfer modes supported by the device when
>>>>                 in DMA mode. Mostly used by PATA device.
>>>>
>>>> which seems incorrect/badly worded for pio_mode and dma_mode. Since these
>>>> 2 sysfs attributes do not actually device the pio mask (list of supported
>>>
>>>    Device?
>>
>> advertise :)
> 
>    Makes sense now. :-)
> 
>>>> pio modes) but the pio mode that will be used for that device, we should
>>>> reword, no ?
>>>
>>>    Yes, of course. :-)
>>>
>>>> What about:
>>>>
>>>> pio_mode:       (RO) Transfer mode used by the device when
>>>>                 in PIO mode. Mostly used by PATA device.
>>>>
>>>> xfer_mode:      (RO) Current transfer mode
>>>>
>>>> dma_mode:       (RO) Transfer mode used by the device when
>>>>                 in DMA mode. Mostly used by PATA device.
>>>
>>>    Sounds quite tautological... :-)
>>>    What about:
>>>
>>> {dma|pio}_mode: (RO) {DMA|PIO} transfer mode used by the device.
>>>                 Mostly used by PATA devices.
>>>
>>>    I think this should be done in the same patch. Or would you prefer 2 patches?
>>
>> Let's do 2 patches. Not sure if you can find a fixes tag for the doc update
> 
>    It'll be the same tag.

OK. Then let's do code and doc fixes in one patch, not 2.

> 
>> though. But we should not aggregate the 2 attributes as you did. These doc files
>> have a defined format and may not be happy with that merged syntax.
> 
>    Sorry about that -- I did that just for the mail... :-)
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
