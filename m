Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC28C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  2 Feb 2022 22:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347744AbiBBWEm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Feb 2022 17:04:42 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31335 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbiBBWEm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2022 17:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643839481; x=1675375481;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dPCU0F2JtekjI2zDy3U3N/DZ+PnnMzlO/SGj9vXdMHs=;
  b=AGAuGHJurT/k+V0C5K2JcryOh1uVxKeK3D88b7a8oYj2bCciPWjaemqa
   sWBAp5RqH9DQI/Lf5QumZzb4F5CTXWivuMYFyGbEHWWkuEW7DZo9eBQWX
   txLhiIEnDPJgghJnBGKvY/guFL3KgkmzUlqRXGAlu+4ap9rm2y5jLZBAp
   1jCvPpqeSshdzadvwM+G/dI3zh82H5b1YrZz5UZ/z7ZGrv4m3GAvbjVaP
   AxOIFz3LbBgeYkUkrduhW4TLLNKBNBf8W2vrA+6WfQhUS22ySzqUKmt5H
   7ureGzv56oW+A+5vogQ6MX+yH4wtDPNCX9vDFHTucVAXer/2c9LFurZRR
   A==;
X-IronPort-AV: E=Sophos;i="5.88,337,1635177600"; 
   d="scan'208";a="192012571"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2022 06:04:40 +0800
IronPort-SDR: hU5LnNiLbupd1wzY87wMs1RVWMIFeS46Wyql+zIkds8ti0MIe2OsMSOzPEqNXBbkYtI5C1WirS
 1icjzG6tVJDQwhyoRud4ToOxOy+TykyQY77EAvBXdFHEDzU+1abxIen55HMp33jMtDE2QlQXYA
 PXqUmBUVguTHNnj3ZaKqdK+djgLwyfHdMjQZLCQD2xKaVUtuG1pBdJBQGahMV7Eh+srNC0xL3U
 34f4sDfuoyjLhgLf9rPBgXa9ZELlYG7wLoS4GEw37hPBndEX/HqlZc6vfpxVa+uPjMrmKldvDs
 jFAH5+6ykAamTHfncNckppPj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 13:37:49 -0800
IronPort-SDR: vcDghwNZPmcDt6rPLan8446W29MAN2iArIBYN9ijOXhwjG3QD5PJ5kqiYU9IF+jnnFtP4n54h5
 kS9wJCODelIaUHzyTfxZ4HMlwicVvrA6RFkSfDtpZc13okxtX8nZl1Mqvn5lmKJfEDjx6kFegW
 Jsoabx91yUZQJkic+1UV8AuM4ByBrbfF+4GaxY2XsmZFHpCuvG/LPZFmzCE4du66i8kcw59/bT
 IN3tUxZcylfqjuZ0WBwX7ZE/i0R6Sl7pt3sZAQMJY3LmHU4rWCLQEggjn9YdamZk0uuqDNSDoT
 hNo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 14:04:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jpwnj2w7kz1SHwl
        for <linux-ide@vger.kernel.org>; Wed,  2 Feb 2022 14:04:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643839480; x=1646431481; bh=dPCU0F2JtekjI2zDy3U3N/DZ+PnnMzlO/SG
        j9vXdMHs=; b=AYZV87o7ACKiutecqxgcYeQLxC12CEsS7rPEvd6/5zet6tWxE/j
        UU5OCRe5zij6nH1Aa3uh489WC+NikdZ/OOuGXmqq/cOgwJZ5+wUYbhSypmGznPI8
        lzMfRXTOKdm0/wu6VsArpieBBIxUIGPq62TdFVSL3ev2opCK2YSvMhEfV1AhDs6a
        pDuNmXvBcUgHshoNZ6rtZudHmisXyo5QOyjavThznp6IauG7vpC/eLbvZzP2d4gy
        GbgU/sL8xivYyWtyu9OpQEba60dprfHQX5KE0SHuBxtTyb5iv1g+MbSbYAxYAz9W
        wvUpRAY9VPTMsIjxVO2/uIfev1QFLh75meg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8tOKQda2pjih for <linux-ide@vger.kernel.org>;
        Wed,  2 Feb 2022 14:04:40 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jpwnh4Knlz1Rwrw;
        Wed,  2 Feb 2022 14:04:40 -0800 (PST)
Message-ID: <f93c8b2a-6032-df74-d4a2-fdc933dc505e@opensource.wdc.com>
Date:   Thu, 3 Feb 2022 07:04:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH] libata: Don't issue ATA_LOG_DIRECTORY to SATADOM-ML 3ME
Content-Language: en-US
To:     Anton Lundin <glance@acc.umu.se>
Cc:     linux-ide@vger.kernel.org
References: <20220202100536.1909665-1-glance@acc.umu.se>
 <bf9f47f1-08c4-370b-446a-1ae9efdc772a@opensource.wdc.com>
 <20220202122520.GE723116@montezuma.acc.umu.se>
 <b7486a01-2f3f-fc12-82c6-8a6c874793e4@opensource.wdc.com>
 <20220202130921.GF723116@montezuma.acc.umu.se>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220202130921.GF723116@montezuma.acc.umu.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/02/02 22:09, Anton Lundin wrote:
> On 02 February, 2022 - Damien Le Moal wrote:
> 
>> On 2022/02/02 21:25, Anton Lundin wrote:
>>> On 02 February, 2022 - Damien Le Moal wrote:
>>>
>>>> On 2/2/22 19:05, Anton Lundin wrote:
>>>>> Back in 06f6c4c6c3e8 ("ata: libata: add missing ata_identify_page_supported() calls")
>>>>> a read of ATA_LOG_DIRECTORY page was added. This caused the
>>>>> SATADOM-ML 3ME to lock up.
>>>>>
>>>>> In 636f6e2af4fb ("libata: add horkage for missing Identify Device log")
>>>>> a flag was added to cache if a device supports this or not.
>>>>>
>>>>> This adds a blacklist entry which flags that these devices doesn't
>>>>> support that call and shouldn't be issued that call.
>>>>>
>>>>> Cc: stable@vger.kernel.org # v5.10+
>>>>> Signed-off-by: Anton Lundin <glance@acc.umu.se>
>>>>> Depends-on: 636f6e2af4fb ("libata: add horkage for missing Identify Device log")
>>>>
>>>> I do not think so. See below.
>>>>
>>>>> ---
>>>>>  drivers/ata/libata-core.c | 7 +++++++
>>>>>  1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>>>> index 87d36b29ca5f..e024af9f33d0 100644
>>>>> --- a/drivers/ata/libata-core.c
>>>>> +++ b/drivers/ata/libata-core.c
>>>>> @@ -4070,6 +4070,13 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>>>>>  	{ "WDC WD3000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
>>>>>  	{ "WDC WD3200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
>>>>>  
>>>>> +	/*
>>>>> +	 * This sata dom goes on a walkabout when it sees the
>>>>> +	 * ATA_LOG_DIRECTORY read request so ensure we don't issue such a
>>>>> +	 * request to these devices.
>>>>> +	 */
>>>>> +	{ "SATADOM-ML 3ME",		NULL,	ATA_HORKAGE_NO_ID_DEV_LOG },
>>>>
>>>> This flag only disables trying to access the identify device log page,
>>>> it does *not* avoid access to the log directory log page in general. The
>>>> log directory will still be consulted for other log pages beside the
>>>> identify device log page, from any function that calls
>>>> ata_log_supported() (e.g. ata_dev_config_ncq_send_recv() and
>>>> ata_dev_config_ncq_non_data())
>>>
>>> Non of those code paths are called for this device, probably due to some
>>> other flag disqualifying them.
>>>  
>>>> So it will be a lot more solid to define a ATA_HORKAGE_NO_LOG_DIR flag
>>>> and test for it in ata_log_supported(), completely preventing any access
>>>> to the log directory page for this drive type.
>>>
>>> That was my first thought but then I found ATA_HORKAGE_NO_ID_DEV_LOG
>>> which was in the calling path that actually triggered this issue.
>>>
>>> But, yes, I totally agree that's a more solid solution preventing this
>>> kind of issue to crop up again.
>>>
>>>>> +
>>>>>  	/* End Marker */
>>>>>  	{ }
>>>>>  };
>>>>
>>>> Note: if you need this fix sent to linux-stable, add "Cc: stable@..."
>>>> and a Fixes tag.
>>>
>>> I'd think it's fitting to send it to linux-stable, because it prevents
>>> those DOM's from working in v5.15.5+.
>>>
>>> Ok. I must have missed that part when I read submitting-patches doc.
>>>
>>> I'll rework and re-submit the patch.
>>
>> I sent you a draft patch. Please try it.
> 
> Works like a charm.
> 
>> Also, to confirm if the log directory log page is indeed the page that locks up
>> the drive, can you try this command:
>>
>> sg_sat_read_gplog --dma --log=0 --page=0 --readonly
> 
> # sg_sat_read_gplog --dma --log=0 --page=0 --readonly /dev/sda
> ATA PASS-THROUGH (16), bad field in cdb
> sg_sat_read_gplog failed: Illegal request
> 
>> and
>>
>> sg_sat_read_gplog --log=0 --page=0 --readonly
> 
> # sg_sat_read_gplog --log=0 --page=0 --readonly /dev/sda
>  00     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  08     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  10     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  18     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  20     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  28     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  30     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  38     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  40     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  48     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  50     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  58     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  60     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  68     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  70     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  78     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  80     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  88     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  90     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  98     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  a0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  a8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  b0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  b8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  c0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  c8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  d0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  d8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  e0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  e8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  f0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>  f8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
> 
> Mind you, this with a patched kernel, if that affects anything.

So your drive does support the log diretory, but it definitely does not like the
DMA version of READ LOG EXT command. And from the result above, it looks like
the only log page that the drive support is the log directory :)

As mentioned in my other reply, please try the ATA_HORKAGE_NO_DMA_LOG flag.

>  
>> Beware that if the log drectory is the problem, this will lockup your drive !
>> If that is OK and works, then please try:
>>
>> sg_sat_read_gplog --dma --log=48 --page=0 --readonly
> 
> # sg_sat_read_gplog --dma --log=48 --page=0 --readonly /dev/sda
> ATA PASS-THROUGH (16), bad field in cdb
> sg_sat_read_gplog failed: Illegal request
> 
>> and
>>
>> sg_sat_read_gplog --log=48 --page=0 --readonly
> 
> sg_sat_read_gplog --log=48 --page=0 --readonly /dev/sda
> ATA PASS-THROUGH (16), bad field in cdb
> sg_sat_read_gplog failed: Illegal request
>  
>> log=48 (0x30) is the identify device log page. log=0 is the log directory log page.
>  
> So, does this means that it might be where in the init of the device the
> directory log page is accessed that causes the device to fault?
> 
> A snippet from a failed boot before the patch looks like:
> ata1.00: qc timeout (cmd 0x2f)
> ata1.00: Read log 0x00 page 0x00 failed, Emask 0x4
> ata1.00: ATA Identify Device Log not supported
> ata1.00: failed to set xfermode (err_mask=0x40)
> ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
> ata1.00: revalidation failed (errno=-5)
> ata1: limiting SATA link speed to 3.0 Gbps
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
> ata1.00: qc timeout (cmd 0x2f)
> ata1.00: Read log 0x00 page 0x00 failed, Emask 0x4
> ata1.00: ATA Identify Device Log not supported
> ata1.00: failed to set xfermode (err_mask=0x40)
> ata1.00: disabled
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
> 
> 
> When I messed around trying to figure out what the fault was I saw a
> couple of different Emask, 0x4, 0x40 and 0x80.
> 
> I also blindly played around with adding a ata_msleep(ap, 500); after
> the failed attempt to access the log directory log page, but that didn't
> help.
> 
> //Anton


-- 
Damien Le Moal
Western Digital Research
