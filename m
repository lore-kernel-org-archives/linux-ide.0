Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AC7C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 18 Feb 2022 09:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiBRJfY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Feb 2022 04:35:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiBRJfY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2022 04:35:24 -0500
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F725E77B
        for <linux-ide@vger.kernel.org>; Fri, 18 Feb 2022 01:35:05 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru B30A1207D578
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: pata_hpt37x: merge mode setting methods
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <4e5e9ea0-f7ac-025a-f94f-a4f0ee009420@omp.ru>
 <0303c512-9193-3d4d-3db7-6ecf391948de@opensource.wdc.com>
 <dbee2241-c540-7f52-1314-9054db292580@omp.ru>
 <101340fd-4215-481b-747b-424f9116111f@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <b93fa847-9343-66bd-9479-3bd9d278da67@omp.ru>
Date:   Fri, 18 Feb 2022 12:35:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <101340fd-4215-481b-747b-424f9116111f@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/17/22 1:57 PM, Damien Le Moal wrote:

>>>> After commit e0afcf140e6e ("ata: pata_hpt37x: disable fast interrupts in
>>>> prereset() method") HPT370's and HPT372+'s PIO/DMA mode setting functions
>>>> have become identical -- merge them.
>>>>
>>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>>
>>>> ---
>>>> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
>>>> repo.
>>>>
>>>>  drivers/ata/pata_hpt37x.c |   71 +++++++---------------------------------------
>>>>  1 file changed, 11 insertions(+), 60 deletions(-)
>>>>
>>>> Index: libata/drivers/ata/pata_hpt37x.c
>>>> ===================================================================
>>>> --- libata.orig/drivers/ata/pata_hpt37x.c
>>>> +++ libata/drivers/ata/pata_hpt37x.c
>> [...]
>>>> @@ -604,8 +556,7 @@ static struct ata_port_operations hpt370
>>>>  };
>>>>  
>>>>  /*
>>>> - *	Configuration for HPT371 and HPT302. Slightly different PIO and DMA
>>>> - *	mode setting functionality.
>>>> + *	Configuration for HPT371 and HPT302.
>>>
>>> Shouldn't this be HPT372 ?
>>
>>    No, HPT372 ops are situated below -- they inherit from these.
> 
> Yep. Got it (checked the code :)). All good.

   Not all good, unfortunately. :-/
   Building with C=1 has shown:

drivers/ata/pata_hpt37x.c:453: warning: expecting prototype for hpt370_set_piomode(). Prototype was for hpt37x_set_piomode() instead
drivers/ata/pata_hpt37x.c:466: warning: expecting prototype for hpt370_set_dmamode(). Prototype was for hpt37x_set_dmamode() instead

i.e. I forgot to update the kernel-doc comments... Let me respin it!

>> [...]

MBR, Sergey
