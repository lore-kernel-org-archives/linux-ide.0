Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19B2C433EF
	for <linux-ide@archiver.kernel.org>; Thu,  3 Feb 2022 09:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241226AbiBCJVJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 3 Feb 2022 04:21:09 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:64421 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbiBCJVI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2022 04:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643880068; x=1675416068;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9RIGveck0WZ+fdhhAL1dBnrUIte1uL8cMWEWW/ipRtw=;
  b=KuXY6icIX8Wo2+osU0EjqOZWBerBt9ZDJemF7FH+2ky+Np4jfiqi8HYG
   lnCcoEHyhnBVo+cYZSZiYEF0kcpZixYU9BDUGTlOkkh4Yn/cfm+1UhfIj
   ZvsG1Pl3pbQa7w9FHm1izwjBoIutUODLcY1bz/Et4ky1MALhsDnMEZRHT
   KVjAXogt2KpCL62WsAQxx+2eQB353jGlvt4eAgHXLn3UOd/Fo9EjJV8De
   qE0lNp82zhPETevn3Z7GQHVc/rhFlc0pNj1K38fnKV7j3SO6jE+2nyMY8
   7aJZL87R9SsqOI4cfJkyBt3lGhBXkVLWbFz0iwuPP/ooc39cAQZsS8Asu
   g==;
X-IronPort-AV: E=Sophos;i="5.88,339,1635177600"; 
   d="scan'208";a="296149216"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2022 17:21:07 +0800
IronPort-SDR: sesPwMJFZ8Vy3kuH8MhNdt8RbXL8PZJbl99jNS4XRQYUD8fYutyA/f+cYpwAMg1A7AFUapCYCG
 Y6AfxDqTNZtVYz7+YCFfV+dac69qi97AQjU7Xw99MI0pF/hU/xNb5vd+uHUVjWtjijblLVPHQW
 RDIUE1wEM1/n00ENPD8RxWtV7yey33EbO9EVAzhra4LpNqrtA7S7uUoGuXcDEkXQ8EicZwy7EM
 vi76A9K5mvZsaVUJ6Bv+TPL2APTu6UL3HG6IxUjI25d0Srgby4FZsqY+HsNB6QD/jbxQMqmlZG
 d0WXHFHT5TVgqp6kfE/Vk3fs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 00:53:03 -0800
IronPort-SDR: vqryzmaCnifApdK9CupSXw014bRM4XtOmBV9MR8gaL5m0UJfGmVwW8VDibHWfcfMxdSwsNNAFY
 HZK3ANj+tsJzi+Wp9JCUtdh86wT+Tu2RMKY/Ksnt7N0NPwZRUNXBArEHflF028GQakxR5xMQ+V
 EKW3J6+EPfCYxfSBpo2uOgSjqvsLz20HuTTFlLd3Dp82+vx+EImMe+4R6UQfqDxtPERtHKv0dq
 jhmGnpGEREN4xxEPYVpJ5yIvxNonihZItqcOVtk7dNw/k8Ln+wfUOxKOnaNPWc///AmImXVjpC
 Dz0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 01:21:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JqCpC4vzbz1SVnx
        for <linux-ide@vger.kernel.org>; Thu,  3 Feb 2022 01:21:07 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643880067; x=1646472068; bh=9RIGveck0WZ+fdhhAL1dBnrUIte1uL8cMWE
        WW/ipRtw=; b=R5oQQ5OvMhPivhDMQ8GveM3bm5cj13WBisjczskXYMypB4yGfWz
        OwLjABaV8I5mjyYslH6Rpxi6aJwNy1y7ngXBg1AI9zBuw+u582qUGrmvaPecVUhG
        FGUeJXaH2v8iPvaU3aB8s2vPwbNFQRNJprc5amodPo+Gk7jpalq8Do5wYu+h8dLV
        QrmXilJB+QcStvpo+/M3YB5BR4ZocYL4NQMi1Te6p90zRQHvCVX8FTzF17bbvTus
        lEBMt/wLW6hxB3R/u5dunirOR6pz1Uq1NxvxtQfBBOUqrF4Ob48Sp20UTrJOK+1D
        zESrVLPpaZZ1Rpe5FXG4NLrPd7oNIhqrQ/g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cnaU3-YWwEzh for <linux-ide@vger.kernel.org>;
        Thu,  3 Feb 2022 01:21:07 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JqCpB1c37z1Rwrw;
        Thu,  3 Feb 2022 01:21:06 -0800 (PST)
Message-ID: <113f45e4-3605-e668-d073-f3ec217425a5@opensource.wdc.com>
Date:   Thu, 3 Feb 2022 18:21:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] libata: Don't issue ATA_LOG_DIRECTORY to SATADOM-ML 3ME
Content-Language: en-US
To:     Anton Lundin <glance@acc.umu.se>
Cc:     linux-ide@vger.kernel.org
References: <20220202100536.1909665-1-glance@acc.umu.se>
 <bf9f47f1-08c4-370b-446a-1ae9efdc772a@opensource.wdc.com>
 <20220202122520.GE723116@montezuma.acc.umu.se>
 <b7486a01-2f3f-fc12-82c6-8a6c874793e4@opensource.wdc.com>
 <20220202130921.GF723116@montezuma.acc.umu.se>
 <20220202135458.GH723116@montezuma.acc.umu.se>
 <77e0c3b6-5a06-87f4-3718-bacdd8f01728@opensource.wdc.com>
 <20220203083233.GI723116@montezuma.acc.umu.se>
 <603e1883-ffbc-a93e-1c42-3f5e6d8d44ed@opensource.wdc.com>
 <20220203091125.GJ723116@montezuma.acc.umu.se>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220203091125.GJ723116@montezuma.acc.umu.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/3/22 18:11, Anton Lundin wrote:
> On 03 February, 2022 - Damien Le Moal wrote:
> 
>> On 2/3/22 17:32, Anton Lundin wrote:
>>> On 03 February, 2022 - Damien Le Moal wrote:
>>>
>>>> On 2022/02/02 22:54, Anton Lundin wrote:
>>>>> On 02 February, 2022 - Anton Lundin wrote:
>>>>>
>>>>>> On 02 February, 2022 - Damien Le Moal wrote:
>>>>>>
>>>>>>> On 2022/02/02 21:25, Anton Lundin wrote:
>>>>>>>> On 02 February, 2022 - Damien Le Moal wrote:
>>>>>>>>
>>>>>>>>> On 2/2/22 19:05, Anton Lundin wrote:
>>>>>>>>>> Back in 06f6c4c6c3e8 ("ata: libata: add missing ata_identify_page_supported() calls")
>>>>>>>>>> a read of ATA_LOG_DIRECTORY page was added. This caused the
>>>>>>>>>> SATADOM-ML 3ME to lock up.
>>>>>>>>>>
>>>>>>>>>> In 636f6e2af4fb ("libata: add horkage for missing Identify Device log")
>>>>>>>>>> a flag was added to cache if a device supports this or not.
>>>>>>>>>>
>>>>>>>>>> This adds a blacklist entry which flags that these devices doesn't
>>>>>>>>>> support that call and shouldn't be issued that call.
>>>>>>>>>>
>>>>>>>>>> Cc: stable@vger.kernel.org # v5.10+
>>>>>>>>>> Signed-off-by: Anton Lundin <glance@acc.umu.se>
>>>>>>>>>> Depends-on: 636f6e2af4fb ("libata: add horkage for missing Identify Device log")
>>>>>>>>>
>>>>>>>>> I do not think so. See below.
>>>>>>>>>
>>>>>>>>>> ---
>>>>>>>>>>  drivers/ata/libata-core.c | 7 +++++++
>>>>>>>>>>  1 file changed, 7 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>>>>>>>>> index 87d36b29ca5f..e024af9f33d0 100644
>>>>>>>>>> --- a/drivers/ata/libata-core.c
>>>>>>>>>> +++ b/drivers/ata/libata-core.c
>>>>>>>>>> @@ -4070,6 +4070,13 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>>>>>>>>>>  	{ "WDC WD3000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
>>>>>>>>>>  	{ "WDC WD3200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
>>>>>>>>>>  
>>>>>>>>>> +	/*
>>>>>>>>>> +	 * This sata dom goes on a walkabout when it sees the
>>>>>>>>>> +	 * ATA_LOG_DIRECTORY read request so ensure we don't issue such a
>>>>>>>>>> +	 * request to these devices.
>>>>>>>>>> +	 */
>>>>>>>>>> +	{ "SATADOM-ML 3ME",		NULL,	ATA_HORKAGE_NO_ID_DEV_LOG },
>>>>>>>>>
>>>>>>>>> This flag only disables trying to access the identify device log page,
>>>>>>>>> it does *not* avoid access to the log directory log page in general. The
>>>>>>>>> log directory will still be consulted for other log pages beside the
>>>>>>>>> identify device log page, from any function that calls
>>>>>>>>> ata_log_supported() (e.g. ata_dev_config_ncq_send_recv() and
>>>>>>>>> ata_dev_config_ncq_non_data())
>>>>>>>>
>>>>>>>> Non of those code paths are called for this device, probably due to some
>>>>>>>> other flag disqualifying them.
>>>>>>>>  
>>>>>>>>> So it will be a lot more solid to define a ATA_HORKAGE_NO_LOG_DIR flag
>>>>>>>>> and test for it in ata_log_supported(), completely preventing any access
>>>>>>>>> to the log directory page for this drive type.
>>>>>>>>
>>>>>>>> That was my first thought but then I found ATA_HORKAGE_NO_ID_DEV_LOG
>>>>>>>> which was in the calling path that actually triggered this issue.
>>>>>>>>
>>>>>>>> But, yes, I totally agree that's a more solid solution preventing this
>>>>>>>> kind of issue to crop up again.
>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>>  	/* End Marker */
>>>>>>>>>>  	{ }
>>>>>>>>>>  };
>>>>>>>>>
>>>>>>>>> Note: if you need this fix sent to linux-stable, add "Cc: stable@..."
>>>>>>>>> and a Fixes tag.
>>>>>>>>
>>>>>>>> I'd think it's fitting to send it to linux-stable, because it prevents
>>>>>>>> those DOM's from working in v5.15.5+.
>>>>>>>>
>>>>>>>> Ok. I must have missed that part when I read submitting-patches doc.
>>>>>>>>
>>>>>>>> I'll rework and re-submit the patch.
>>>>>>>
>>>>>>> I sent you a draft patch. Please try it.
>>>>>>
>>>>>> Works like a charm.
>>>>>>
>>>>>>> Also, to confirm if the log directory log page is indeed the page that locks up
>>>>>>> the drive, can you try this command:
>>>>>>>
>>>>>>> sg_sat_read_gplog --dma --log=0 --page=0 --readonly
>>>>>>
>>>>>> # sg_sat_read_gplog --dma --log=0 --page=0 --readonly /dev/sda
>>>>>> ATA PASS-THROUGH (16), bad field in cdb
>>>>>> sg_sat_read_gplog failed: Illegal request
>>>>>>
>>>>>>> and
>>>>>>>
>>>>>>> sg_sat_read_gplog --log=0 --page=0 --readonly
>>>>>>
>>>>>> # sg_sat_read_gplog --log=0 --page=0 --readonly /dev/sda
>>>>>>  00     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  08     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  10     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  18     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  20     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  28     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  30     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  38     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  40     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  48     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  50     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  58     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  60     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  68     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  70     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  78     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  80     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  88     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  90     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  98     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  a0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  a8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  b0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  b8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  c0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  c8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  d0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  d8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  e0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  e8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  f0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>  f8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>>>
>>>>>> Mind you, this with a patched kernel, if that affects anything.
>>>>>
>>>>> Without a patched kernel, (grabbed os with a 4.19.94 kernel) the command
>>>>> hangs for a while:
>>>>>
>>>>> # time sg_sat_read_gplog --log=0 --page=0 --readonly /dev/sda
>>>>> ATA PASS-THROUGH (16), bad field in cdb
>>>>> sg_sat_read_gplog failed: Illegal request
>>>>>
>>>>> real	0m28.337s
>>>>> user	0m0.000s
>>>>> sys	0m0.001s
>>>>>
>>>>> and logs the following in the kernel log:
>>>>>
>>>>> ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>>>> ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
>>>>> ata1.00: revalidation failed (errno=-5)
>>>>> ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>>>> ata1.00: configured for UDMA/133
>>>>>
>>>>>
>>>>> But after that 30s walkabout and whatever the kernel does the device
>>>>> starts functioning again.
>>>>
>>>> The 30s "hang" is the default command timeout: your drive is not responding to
>>>> the DMA version of READ LOG EXT command. There are some drives out there like
>>>> that. So instead of completely disabling access to the log directory, we should
>>>> simply force the use of READ LOG EXT. And for that, there is the horkage flag
>>>> ATA_HORKAGE_NO_DMA_LOG.
>>>>
>>>> Can you try using that one without the patch I sent ?
>>>
>>> I think I tested that before submitting the patch, but re-tested it now
>>> and that doesn't work:
>>
>> Your original patch used the ATA_HORKAGE_NO_ID_DEV_LOG flag. What
>> ATA_HORKAGE_NO_DMA_LOG does is prevent the use of the READ LOG DMA EXT
>> command. READ LOG EXT command (PIO) will be used. And the sg commands I
>> sent you and that you tried show that it works:
>>
>> sg_sat_read_gplog --log=0 --page=0 --readonly
>>
>> worked perfectly, while:
>>
>> sg_sat_read_gplog --dma --log=0 --page=0 --readonly
>>
>> failed.
>>
>> So by simply preventing the use of READ LOG DMA EXT for your drive, the
>> kernel will be able to safely get the log directory and test for other
>> page support.
>>
>> In your original patch, try replacing ATA_HORKAGE_NO_ID_DEV_LOG with
>> ATA_HORKAGE_NO_DMA_LOG.
> 
> I could have bin clearer. This log snippet below is a 5.15.10 with
> ATA_HORKAGE_NO_DMA_LOG set for this device.
> 
> Shure, sg_sat_read_gplog --log=0 --page=0 --readonly worked when booted,
> but as it looks to me, it doesn't work during boot.

Very weird... So I guess the big-hammer patch introducing
ATA_HORKAGE_NO_LOG_DIR seems like the best solution for your drive.
Please review and test again the patch I sent and post it to linux-ide
for review.


-- 
Damien Le Moal
Western Digital Research
