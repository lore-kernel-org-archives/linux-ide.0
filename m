Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE042C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 17 Feb 2022 09:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiBQJt5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 17 Feb 2022 04:49:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238854AbiBQJtz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 17 Feb 2022 04:49:55 -0500
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B46017AA7
        for <linux-ide@vger.kernel.org>; Thu, 17 Feb 2022 01:49:40 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 1888C20CD421
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: pata_hpt37x: merge mode setting methods
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <4e5e9ea0-f7ac-025a-f94f-a4f0ee009420@omp.ru>
 <0303c512-9193-3d4d-3db7-6ecf391948de@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <dbee2241-c540-7f52-1314-9054db292580@omp.ru>
Date:   Thu, 17 Feb 2022 12:49:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0303c512-9193-3d4d-3db7-6ecf391948de@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/16/22 2:29 PM, Damien Le Moal wrote:

>> After commit e0afcf140e6e ("ata: pata_hpt37x: disable fast interrupts in
>> prereset() method") HPT370's and HPT372+'s PIO/DMA mode setting functions
>> have become identical -- merge them.
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> ---
>> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
>> repo.
>>
>>  drivers/ata/pata_hpt37x.c |   71 +++++++---------------------------------------
>>  1 file changed, 11 insertions(+), 60 deletions(-)
>>
>> Index: libata/drivers/ata/pata_hpt37x.c
>> ===================================================================
>> --- libata.orig/drivers/ata/pata_hpt37x.c
>> +++ libata/drivers/ata/pata_hpt37x.c
[...]
>> @@ -604,8 +556,7 @@ static struct ata_port_operations hpt370
>>  };
>>  
>>  /*
>> - *	Configuration for HPT371 and HPT302. Slightly different PIO and DMA
>> - *	mode setting functionality.
>> + *	Configuration for HPT371 and HPT302.
> 
> Shouldn't this be HPT372 ?

   No, HPT372 ops are situated below -- they inherit from these.

[...]

MBR, Sergey
