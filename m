Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B423CC433F5
	for <linux-ide@archiver.kernel.org>; Wed,  2 Feb 2022 12:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbiBBMsz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Feb 2022 07:48:55 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:55195 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344215AbiBBMsy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2022 07:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643806134; x=1675342134;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WzkZbCa7hvkZqOzvp85EfKZ6oR9mQ5GROER5eAEWJi8=;
  b=EqF5XXTA+nFaxI4jtI9ElTEZ9ybVqKFybN+7p/H3jjOku58uj5LFyEue
   f3HsrQZeMiyIPkVW4FlfAyMka4Y6EUNA250PCfnoAk/KtVQrZcyEHDxeR
   qkuAGx+GlS+YNeWqAOcR5nTtdN+uDycz3f3Ed+7m0vaTCoa7LGefvEKI4
   YASBs31YvXUmF/UnWLgS0XPzSm8yw7/QD44OFYOdY1uBCi39eRbzu+pdF
   81OBvrbQ2Y8Qb2J/kJ2sKu8orO2qEw1JZ0Sx2Iueux9iworZUNfqkoK2Z
   hlE1ba/lBOJ2cBaZtADntpHWbpVume+HIeLdvSqbPkcQrJdPBizCU6uf1
   w==;
X-IronPort-AV: E=Sophos;i="5.88,336,1635177600"; 
   d="scan'208";a="303874546"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2022 20:48:54 +0800
IronPort-SDR: sM8LGCn4EYeP1ObPiQlrnuE8yoeeZ8tUs8ROA2NU3LR8+E9OxRIhUYnvtQInaiNpDbjiA/cn9v
 FkBx/ZAYdGeR20lwT8BZftpcm+KWlq1goqkxEZgrDEOr60aYmiYZ80EVwnkBVzmKS/+fIZr/AX
 TD4TfGgoC0axVoCG2MJ5oJdXrCyzYH1FmrVyKZKxbdANwu0N670eMTHEtTkSiKCC402I0e2t+N
 mDbsXK2GXNRKCyVJn84wCbjSYtsTCnZihDTPZW+vKrBrnc8PRr32HBnGefv7wPrYIfR+8JwrFX
 8o3SN8nsFpLWVWRBwOKJRZg6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 04:22:03 -0800
IronPort-SDR: LIhzUaqSzOCLmY50psdpszT3FWUG8a2EqiVp0HdC5J6R0pLa0VPVM2Ets0ymy9Ikf82PxVuY3h
 IAa7FIH47i45QNAoHqftzrBdHVn+A1jDb5+mO/4eYJrQyFje6VzDX0AklI6lwIwPbn9Aa6SyiI
 QI5PxW5UhpgwXdLo7QwtEzaJnvp7G6Au+81w8L5P1+Zv1CqCzOeH3FjOiCcP6jJus4FD0tw2vh
 mvbVRbvgOKPcLYUawZh7UYwRzMiAXMFrwG8WdHiQLh5el6s5UuOafyeX4txXwqYL8R0Bc2EfyM
 YrA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 04:48:55 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JphSP6sglz1SVnx
        for <linux-ide@vger.kernel.org>; Wed,  2 Feb 2022 04:48:53 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643806133; x=1646398134; bh=WzkZbCa7hvkZqOzvp85EfKZ6oR9mQ5GROER
        5eAEWJi8=; b=ezBngxP90h1hde9f2ZUjgIcpYqJV9D/oAJBy8vFKy+ZMFAM4vHS
        W/XPApRp6ViLx7/MK8X7447Jwy8QdU5gkz8PEcBt1wdnaNV1Byh20MMNOrFVGk3V
        j3fNNbQMt5lqAtMyRay+/sbDlXiiWcjm2zj+wOFQSew1F+J2HB8Zvdpx6/WHxAKd
        KueNHMWYHmwYGS3WbW0VmSl3y2mieVDSn7Zr9TZwJDy4XcZjqbDk6c1u9C9nBLK9
        yAhsWcc5gPyVqnxImRMIau46UF1BK+xDgVMHSbhIXW05F0sanw91BHIPgnJ4uOUZ
        HraY7UjaqbziE3z/SON810rIgRicBhyHCjg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id G3YmRTaLKbB7 for <linux-ide@vger.kernel.org>;
        Wed,  2 Feb 2022 04:48:53 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JphSP1Qpgz1Rwrw;
        Wed,  2 Feb 2022 04:48:52 -0800 (PST)
Message-ID: <b7486a01-2f3f-fc12-82c6-8a6c874793e4@opensource.wdc.com>
Date:   Wed, 2 Feb 2022 21:48:51 +0900
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220202122520.GE723116@montezuma.acc.umu.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/02/02 21:25, Anton Lundin wrote:
> On 02 February, 2022 - Damien Le Moal wrote:
> 
>> On 2/2/22 19:05, Anton Lundin wrote:
>>> Back in 06f6c4c6c3e8 ("ata: libata: add missing ata_identify_page_supported() calls")
>>> a read of ATA_LOG_DIRECTORY page was added. This caused the
>>> SATADOM-ML 3ME to lock up.
>>>
>>> In 636f6e2af4fb ("libata: add horkage for missing Identify Device log")
>>> a flag was added to cache if a device supports this or not.
>>>
>>> This adds a blacklist entry which flags that these devices doesn't
>>> support that call and shouldn't be issued that call.
>>>
>>> Cc: stable@vger.kernel.org # v5.10+
>>> Signed-off-by: Anton Lundin <glance@acc.umu.se>
>>> Depends-on: 636f6e2af4fb ("libata: add horkage for missing Identify Device log")
>>
>> I do not think so. See below.
>>
>>> ---
>>>  drivers/ata/libata-core.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index 87d36b29ca5f..e024af9f33d0 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -4070,6 +4070,13 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>>>  	{ "WDC WD3000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
>>>  	{ "WDC WD3200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
>>>  
>>> +	/*
>>> +	 * This sata dom goes on a walkabout when it sees the
>>> +	 * ATA_LOG_DIRECTORY read request so ensure we don't issue such a
>>> +	 * request to these devices.
>>> +	 */
>>> +	{ "SATADOM-ML 3ME",		NULL,	ATA_HORKAGE_NO_ID_DEV_LOG },
>>
>> This flag only disables trying to access the identify device log page,
>> it does *not* avoid access to the log directory log page in general. The
>> log directory will still be consulted for other log pages beside the
>> identify device log page, from any function that calls
>> ata_log_supported() (e.g. ata_dev_config_ncq_send_recv() and
>> ata_dev_config_ncq_non_data())
> 
> Non of those code paths are called for this device, probably due to some
> other flag disqualifying them.
>  
>> So it will be a lot more solid to define a ATA_HORKAGE_NO_LOG_DIR flag
>> and test for it in ata_log_supported(), completely preventing any access
>> to the log directory page for this drive type.
> 
> That was my first thought but then I found ATA_HORKAGE_NO_ID_DEV_LOG
> which was in the calling path that actually triggered this issue.
> 
> But, yes, I totally agree that's a more solid solution preventing this
> kind of issue to crop up again.
> 
>>> +
>>>  	/* End Marker */
>>>  	{ }
>>>  };
>>
>> Note: if you need this fix sent to linux-stable, add "Cc: stable@..."
>> and a Fixes tag.
> 
> I'd think it's fitting to send it to linux-stable, because it prevents
> those DOM's from working in v5.15.5+.
> 
> Ok. I must have missed that part when I read submitting-patches doc.
> 
> I'll rework and re-submit the patch.

I sent you a draft patch. Please try it.

Also, to confirm if the log directory log page is indeed the page that locks up
the drive, can you try this command:

sg_sat_read_gplog --dma --log=0 --page=0 --readonly

and

sg_sat_read_gplog --log=0 --page=0 --readonly

Beware that if the log drectory is the problem, this will lockup your drive !
If that is OK and works, then please try:

sg_sat_read_gplog --dma --log=48 --page=0 --readonly

and

sg_sat_read_gplog --log=48 --page=0 --readonly

log=48 (0x30) is the identify device log page. log=0 is the log directory log page.

> 
> 
> //Anton


-- 
Damien Le Moal
Western Digital Research
