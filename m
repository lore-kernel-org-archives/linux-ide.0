Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F346C433F5
	for <linux-ide@archiver.kernel.org>; Sun, 22 May 2022 22:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiEVW0s (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 22 May 2022 18:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiEVW0r (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 22 May 2022 18:26:47 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACA3286F3
        for <linux-ide@vger.kernel.org>; Sun, 22 May 2022 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653258406; x=1684794406;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=tdeEmImgHRb+LuwK33yqgGEhRETIV3w6BSJbFjZMXD0=;
  b=rEhJg6KT4AMX71ZZPaK2biTApw0R+0q3h3UsEZir+nYrnLwxY/AImpJk
   zVi3eoRVetnBZfzvQE6Bb4ORfEV3mkZN824C9IjeuYRXPhIaPk2WNaePI
   Izlo0jsz0/8bD4TPRseXcvHKao5CojOPrr6OaqnDFw+mlMec06fpaCmbA
   WsRb7UwEvaiBINA6mLxH1nMplkU6JAXZFf1bXAOFZYPWZap8/qMNKJOMW
   Hsf3Hgihb0I7+rneGbX5JNNILaqidYlElX57u2cvZ1K55qPQ1zB8XBwen
   +wme0NkJs1EQgDCyqvcl6e1h+Xgg2Ce+xLN/X9Z7gAh9E5u/+7qkwbiZQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,244,1647273600"; 
   d="scan'208";a="305310372"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2022 06:26:45 +0800
IronPort-SDR: VqsLasCi473uRjD9plZ4A/yGmZbmJkNZ/6q3qWUjggaIYopuC7kq9wm2ROESK1bEYBIKkq6EkI
 HMTiGqg1w2MStgC/DDTe6kaRfqQ62RKI+jfKm+OEDPBomJdpX1h+9JPZsxG85T3BsHwYF04KTw
 1Ae/VY4pEYYbf7yMMrgDYy4yI41Qv2cQUvsPcpIpmd4ov+87G9DL41nwP1ffz3Nijjv0bYyssg
 P4bRCYUCi2bgsW/UoGkNBIUuo7aIGoiC9lXh3ygAEC3y+u2yITIZDuLYppCjqyW4/VJa0gXmMs
 SD9/i3AYF+VsQA75tDnvJnKw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2022 14:46:19 -0700
IronPort-SDR: 5AMg0iS3wQLEjUyGb27+h4O3LOV1xwrEcEQivI/ze6mAMxiZFKtjMi9I9SJttxG3DVoa32YTPU
 P53qHOx3U96UCrp8blV2sywbwtkfKQ+Y2czMKLBf3r4KA+RQwOFqyKHA5eLeO3ORN6W0cQ35pj
 7TBpvUQoODwqoofWpxPALFWgSltBDCXkMMU8wTO6MlIfHcP3MQkpu5yTXS0C16GHu8SU/QQ2+C
 N7B33wNGRSyDIUPIe8qXwQFrlBoQmWdoSwx6Oykqk2b6iMbMLdQKP5IS8TDTQ9hQ7k3cLuuTzw
 iU8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2022 15:26:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L5w6s2T9vz1Rvlx
        for <linux-ide@vger.kernel.org>; Sun, 22 May 2022 15:26:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653258405; x=1655850406; bh=tdeEmImgHRb+LuwK33yqgGEhRETIV3w6BSJ
        bFjZMXD0=; b=Vkowck7cQjyS4/cDtCyQygIue3NlhUS8d+WL/aExchJXgNa/teV
        hLy+GiBaD2NEf/Vn8izpkcdwiT5mxKuCvYEumCMYUh5IyI/uyuU/L8hvtIcn8Tw2
        fdQnXrrcwVsZbapmlgSNOcQHlyNldKrxTcM/QZBEb/FMA46ti3xGCipTHNTS9/wC
        ieoel21ky6GqU3He/YEVx+CKaoZkagzAzXbmLA+tHxZ08Yo+/eci53/Zr8ckx37c
        h6x6TBcaW3Vjok3k1+ExfHTCvyn2l9FtHJ16wy4lmmgPss9jDoIKRdEeUEgxzlST
        Fp0rO9sd3aQsxQ8I+JqAd+qKba1K6W5LLSA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mnzbLEDawQay for <linux-ide@vger.kernel.org>;
        Sun, 22 May 2022 15:26:45 -0700 (PDT)
Received: from [10.89.85.73] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L5w6r4QNTz1Rvlc;
        Sun, 22 May 2022 15:26:44 -0700 (PDT)
Message-ID: <7645cbbb-a37d-9beb-b70d-66888f0e3d62@opensource.wdc.com>
Date:   Mon, 23 May 2022 07:26:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] ata: libata-core: fix sloppy typing in ata_id_n_sectors()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <a15e1894-8be2-70f8-26b4-be62de8055d9@omp.ru>
 <f8e5288f-e0e9-da11-6a82-6bcbe5365eea@opensource.wdc.com>
 <0fbb1f50-503c-f258-2a34-10cf069a633e@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <0fbb1f50-503c-f258-2a34-10cf069a633e@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/05/18 4:43, Sergey Shtylyov wrote:
> Hello!
> 
> On 5/16/22 2:29 PM, Damien Le Moal wrote:
> 
>>> The code multiplying the # of cylinders/heads/sectors in ata_id_n_sectors()
>>> to get a disk capacity implicitly uses the *int* type for that calculation
>>> and casting the result to 'u64' before returning ensues a sign extension.
>>> Explicitly casting the 'u16' typed multipliers to 'u32' results in avoiding
>>> a sign extension instruction and so in a more compact code...
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>>> analysis tool.
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>
>>> ---
>>> This patch is against the 'for-next' branch of Damien's 'libata.git' repo.
>>>
>>>  drivers/ata/libata-core.c |   10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> Index: libata/drivers/ata/libata-core.c
>>> ===================================================================
>>> --- libata.orig/drivers/ata/libata-core.c
>>> +++ libata/drivers/ata/libata-core.c
>>> @@ -1107,11 +1107,13 @@ static u64 ata_id_n_sectors(const u16 *i
>>>  			return ata_id_u32(id, ATA_ID_LBA_CAPACITY);
>>>  	} else {
>>>  		if (ata_id_current_chs_valid(id))
>>> -			return id[ATA_ID_CUR_CYLS] * id[ATA_ID_CUR_HEADS] *
>>> -			       id[ATA_ID_CUR_SECTORS];
>>> +			return (u32)id[ATA_ID_CUR_CYLS] *
>>> +			       (u32)id[ATA_ID_CUR_HEADS] *
>>> +			       (u32)id[ATA_ID_CUR_SECTORS];
>>>  		else
>>
>> While at it, you can drop this useless "else". The 2 else above this one are
>> actually also useless...
> 
>    OK. But I think it's all a matter of a separate patch. I don't want to touch
> the LBA branches in this same patch...

OK.


> 
>>> -			return id[ATA_ID_CYLS] * id[ATA_ID_HEADS] *
>>> -			       id[ATA_ID_SECTORS];
>>> +			return (u32)id[ATA_ID_CYLS] *
>>> +			       (u32)id[ATA_ID_HEADS] *
>>> +			       (u32)id[ATA_ID_SECTORS];
>>
>> Given that the function returns an u64, I would cast everything to u64. That
> 
>    I don't think this is a good idea. Looking at the produced x86 32-bit code,
> gcc produces an extra (3rd) multiplication instruction for no value.
> 
>> will avoid overflows too, which was possible before,
> 
>    No, it wasn't possible. Any possible CHS capacity always fits into 32 bits --
> max # of sectors per track is 255, max # of heads is only 16.
>    What actually seems to make sense is changing the order of multiplications
> to first multiply # of sectors by # of heads and than multiply that by # of
> cylinders...

OK.


> 
>> eventhough no problems seem
>> to have been reported...
> 
>    Because there's not problem. :-)
>    The current CHS capacity is stored in the words 57-58 (so 32-bit) and we
> could read it from there instead of the multiplications... BUT I do remember
> the disks (IIRC Fujitsu... but I'm not sure now -- that was back in 90s!)
> that had totally wrong value in these words... so the code we have now is
> a good thing! :-)
> 
>> Who uses CHS these days :)
> 
>    Indeed, the CHS days are long gone... :-)
> 
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
