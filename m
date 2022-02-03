Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B27CC433F5
	for <linux-ide@archiver.kernel.org>; Thu,  3 Feb 2022 08:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbiBCIks (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 3 Feb 2022 03:40:48 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63125 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiBCIks (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2022 03:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643877648; x=1675413648;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0VbHTfibMLmGrYl1RZjX1IeFSIGcr7dYINvCwE6/XxI=;
  b=CMS/noyeTUGGDUg+pC/FeITCtU2uDI29bqkRCNH0bCyHh8WR46CwIv64
   NZCxHyiGe2mznAm2Z722c+pHcTdkjvx+qzlXGm/TnAGHIK8/7vEt28l8x
   1haBVCCmm1n7JzPogU+QujrEFJRKU+FsGRDn7N00v4ntT4yJ6EIpqqZA5
   6Zf8DAMJFPcKN3drL2fmSjmmol7lstW02gMS9ie12dT4NESD7W3a7q5ln
   sf+RqPJZ4EMoQbqa31UfltWSH5J21zF+Frle44y1BvM7qDmFDQK8shsFO
   Nw9AiYgPBuYK8yTIGOY+jmxgsUmUl+wANcvCab3VffxEA2GVF6nqVxoZN
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,339,1635177600"; 
   d="scan'208";a="190996671"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2022 16:40:47 +0800
IronPort-SDR: GgctX2scC5Mx0SsJhgaxhBC7Htu39evtOJhBou5YrMjEAZvxP44GJFsTCBatwdCCoVX+kwf+fK
 sQcGm7X53SNPREMX0H5nH7cUzyl01FzZdRgfA5u/mmSMeSlJdqDz/ZsBQ9gZ0BDU32QIOlS/I8
 GLJhkH3Yr02qvAlYinXlYhr21N9pgo92SIzwHgpakjE1Kb3jPsRdzYPnQSps/ZN6nAmj4Wamt0
 iTcT9PwIJIk2HaormF3gG8LYAuervysWFqBLv6unfje4E4FGcNw3Nh4xaz8Z0mxtHv6q4yZVYy
 LzJlde57hHL5Bh8HWz/aSIPR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 00:13:56 -0800
IronPort-SDR: FXNU4F7Si+z9bEJO7G6XSG3O6xGSc4pRcuZWnrqUdBJ4EZb1Qbvf+z/xugQA22h4HHPIdXwZD5
 e1BpCzZBr4kRXVNJlVzwMhw4Bfq6dzbWHVhaW4SIzU4+G8E0sJbXmRe9mPVCl9YU/udrNsdPT5
 /g2C8gmKyopMuBq3I5yAUEB+TOA73LDjtGrQFrQ+sjlIAtiXutopCaDWDr+xgSNFloupxGo30C
 HeGlpAdEARXgm/Mae5yLIpZV+qE3To1wqnJMqciCcqjWfNZk3db/m4EZIvX5M7vmjsrlAVAttv
 MbI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 00:40:48 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JqBvg4fJWz1SHwl
        for <linux-ide@vger.kernel.org>; Thu,  3 Feb 2022 00:40:47 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643877647; x=1646469648; bh=0VbHTfibMLmGrYl1RZjX1IeFSIGcr7dYINv
        CwE6/XxI=; b=QPhwN762qA3ce1m+dsV/ObVrEy2oMEgi2BW383zcc0V84lVhmGX
        mRsn0L78nTLTbVhTsNLUfaKGYi2fA48up0+eF1yoOv5wbXRZnA6kJZi4JU6vWz3Z
        VjDVqKW+dtLh/RUX7bcwfFATrm6oC2AXOwLcRUIkQmsa+D4Gl94nvh9tBA5Nkd+4
        jA5McEN+GvH0/Bd5qP3Rz4ABdKQ43uzlkwLR1lrE+bItQ6r/qtYhPYDeygNJVS2k
        VX+iNV+DU7sEmJYvt4DPWeOtd6wSFv62cfnGHTj0pxmppxGPClJZI9mO6/FqMILZ
        /dqEP6iJvHwKRqC2rUFU9gNamL7GdynBTXg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sdpacBH8WPWA for <linux-ide@vger.kernel.org>;
        Thu,  3 Feb 2022 00:40:47 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JqBvf5VnTz1Rwrw;
        Thu,  3 Feb 2022 00:40:46 -0800 (PST)
Message-ID: <603e1883-ffbc-a93e-1c42-3f5e6d8d44ed@opensource.wdc.com>
Date:   Thu, 3 Feb 2022 17:40:45 +0900
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220203083233.GI723116@montezuma.acc.umu.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/3/22 17:32, Anton Lundin wrote:
> On 03 February, 2022 - Damien Le Moal wrote:
> 
>> On 2022/02/02 22:54, Anton Lundin wrote:
>>> On 02 February, 2022 - Anton Lundin wrote:
>>>
>>>> On 02 February, 2022 - Damien Le Moal wrote:
>>>>
>>>>> On 2022/02/02 21:25, Anton Lundin wrote:
>>>>>> On 02 February, 2022 - Damien Le Moal wrote:
>>>>>>
>>>>>>> On 2/2/22 19:05, Anton Lundin wrote:
>>>>>>>> Back in 06f6c4c6c3e8 ("ata: libata: add missing ata_identify_page_supported() calls")
>>>>>>>> a read of ATA_LOG_DIRECTORY page was added. This caused the
>>>>>>>> SATADOM-ML 3ME to lock up.
>>>>>>>>
>>>>>>>> In 636f6e2af4fb ("libata: add horkage for missing Identify Device log")
>>>>>>>> a flag was added to cache if a device supports this or not.
>>>>>>>>
>>>>>>>> This adds a blacklist entry which flags that these devices doesn't
>>>>>>>> support that call and shouldn't be issued that call.
>>>>>>>>
>>>>>>>> Cc: stable@vger.kernel.org # v5.10+
>>>>>>>> Signed-off-by: Anton Lundin <glance@acc.umu.se>
>>>>>>>> Depends-on: 636f6e2af4fb ("libata: add horkage for missing Identify Device log")
>>>>>>>
>>>>>>> I do not think so. See below.
>>>>>>>
>>>>>>>> ---
>>>>>>>>  drivers/ata/libata-core.c | 7 +++++++
>>>>>>>>  1 file changed, 7 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>>>>>>> index 87d36b29ca5f..e024af9f33d0 100644
>>>>>>>> --- a/drivers/ata/libata-core.c
>>>>>>>> +++ b/drivers/ata/libata-core.c
>>>>>>>> @@ -4070,6 +4070,13 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>>>>>>>>  	{ "WDC WD3000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
>>>>>>>>  	{ "WDC WD3200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
>>>>>>>>  
>>>>>>>> +	/*
>>>>>>>> +	 * This sata dom goes on a walkabout when it sees the
>>>>>>>> +	 * ATA_LOG_DIRECTORY read request so ensure we don't issue such a
>>>>>>>> +	 * request to these devices.
>>>>>>>> +	 */
>>>>>>>> +	{ "SATADOM-ML 3ME",		NULL,	ATA_HORKAGE_NO_ID_DEV_LOG },
>>>>>>>
>>>>>>> This flag only disables trying to access the identify device log page,
>>>>>>> it does *not* avoid access to the log directory log page in general. The
>>>>>>> log directory will still be consulted for other log pages beside the
>>>>>>> identify device log page, from any function that calls
>>>>>>> ata_log_supported() (e.g. ata_dev_config_ncq_send_recv() and
>>>>>>> ata_dev_config_ncq_non_data())
>>>>>>
>>>>>> Non of those code paths are called for this device, probably due to some
>>>>>> other flag disqualifying them.
>>>>>>  
>>>>>>> So it will be a lot more solid to define a ATA_HORKAGE_NO_LOG_DIR flag
>>>>>>> and test for it in ata_log_supported(), completely preventing any access
>>>>>>> to the log directory page for this drive type.
>>>>>>
>>>>>> That was my first thought but then I found ATA_HORKAGE_NO_ID_DEV_LOG
>>>>>> which was in the calling path that actually triggered this issue.
>>>>>>
>>>>>> But, yes, I totally agree that's a more solid solution preventing this
>>>>>> kind of issue to crop up again.
>>>>>>
>>>>>>>> +
>>>>>>>>  	/* End Marker */
>>>>>>>>  	{ }
>>>>>>>>  };
>>>>>>>
>>>>>>> Note: if you need this fix sent to linux-stable, add "Cc: stable@..."
>>>>>>> and a Fixes tag.
>>>>>>
>>>>>> I'd think it's fitting to send it to linux-stable, because it prevents
>>>>>> those DOM's from working in v5.15.5+.
>>>>>>
>>>>>> Ok. I must have missed that part when I read submitting-patches doc.
>>>>>>
>>>>>> I'll rework and re-submit the patch.
>>>>>
>>>>> I sent you a draft patch. Please try it.
>>>>
>>>> Works like a charm.
>>>>
>>>>> Also, to confirm if the log directory log page is indeed the page that locks up
>>>>> the drive, can you try this command:
>>>>>
>>>>> sg_sat_read_gplog --dma --log=0 --page=0 --readonly
>>>>
>>>> # sg_sat_read_gplog --dma --log=0 --page=0 --readonly /dev/sda
>>>> ATA PASS-THROUGH (16), bad field in cdb
>>>> sg_sat_read_gplog failed: Illegal request
>>>>
>>>>> and
>>>>>
>>>>> sg_sat_read_gplog --log=0 --page=0 --readonly
>>>>
>>>> # sg_sat_read_gplog --log=0 --page=0 --readonly /dev/sda
>>>>  00     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  08     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  10     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  18     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  20     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  28     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  30     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  38     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  40     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  48     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  50     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  58     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  60     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  68     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  70     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  78     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  80     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  88     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  90     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  98     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  a0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  a8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  b0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  b8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  c0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  c8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  d0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  d8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  e0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  e8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  f0     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>  f8     0000 0000 0000 0000 0000 0000 0000 0000     .. .. .. .. .. .. .. .. 
>>>>
>>>> Mind you, this with a patched kernel, if that affects anything.
>>>
>>> Without a patched kernel, (grabbed os with a 4.19.94 kernel) the command
>>> hangs for a while:
>>>
>>> # time sg_sat_read_gplog --log=0 --page=0 --readonly /dev/sda
>>> ATA PASS-THROUGH (16), bad field in cdb
>>> sg_sat_read_gplog failed: Illegal request
>>>
>>> real	0m28.337s
>>> user	0m0.000s
>>> sys	0m0.001s
>>>
>>> and logs the following in the kernel log:
>>>
>>> ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>> ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
>>> ata1.00: revalidation failed (errno=-5)
>>> ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>> ata1.00: configured for UDMA/133
>>>
>>>
>>> But after that 30s walkabout and whatever the kernel does the device
>>> starts functioning again.
>>
>> The 30s "hang" is the default command timeout: your drive is not responding to
>> the DMA version of READ LOG EXT command. There are some drives out there like
>> that. So instead of completely disabling access to the log directory, we should
>> simply force the use of READ LOG EXT. And for that, there is the horkage flag
>> ATA_HORKAGE_NO_DMA_LOG.
>>
>> Can you try using that one without the patch I sent ?
> 
> I think I tested that before submitting the patch, but re-tested it now
> and that doesn't work:

Your original patch used the ATA_HORKAGE_NO_ID_DEV_LOG flag. What
ATA_HORKAGE_NO_DMA_LOG does is prevent the use of the READ LOG DMA EXT
command. READ LOG EXT command (PIO) will be used. And the sg commands I
sent you and that you tried show that it works:

sg_sat_read_gplog --log=0 --page=0 --readonly

worked perfectly, while:

sg_sat_read_gplog --dma --log=0 --page=0 --readonly

failed.

So by simply preventing the use of READ LOG DMA EXT for your drive, the
kernel will be able to safely get the log directory and test for other
page support.

In your original patch, try replacing ATA_HORKAGE_NO_ID_DEV_LOG with
ATA_HORKAGE_NO_DMA_LOG.

> 
> This is on a 5.15 kernel:
> 
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
> 
> On a 5.16+ with the "libata: add horkage for missing Identify Device
> log" patch, the machine will boot because it won't re-try to access the
> ata log directory after the reset to 3.0 Gbps sata.
> 
> 
> //Anton


-- 
Damien Le Moal
Western Digital Research
