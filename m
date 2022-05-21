Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8D4C433EF
	for <linux-ide@archiver.kernel.org>; Sat, 21 May 2022 20:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiEUUAe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 21 May 2022 16:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiEUUAe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 21 May 2022 16:00:34 -0400
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9BA5A59F
        for <linux-ide@vger.kernel.org>; Sat, 21 May 2022 13:00:30 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 39A4C20D931E
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: libata-core: fix NULL pointer deref in
 ata_host_alloc_pinfo()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <3727e0b4-3958-283f-c0cf-6b8b898ab018@omp.ru>
 <d2d4a222-b3d3-b3a6-41a4-db2fc4c11038@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <ad4ace86-1c79-371a-077b-250461837542@omp.ru>
Date:   Sat, 21 May 2022 23:00:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d2d4a222-b3d3-b3a6-41a4-db2fc4c11038@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 5/21/22 2:45 AM, Damien Le Moal wrote:

>> In an unlikely (and probably wrong?) case that the 'ppi' parameter of
>> ata_host_alloc_pinfo() points to an array starting with a NULL pointer,
>> there's going to be a kernel oops as the 'pi' local variable won't get
>> reassigned from the initial value of NULL.  Assign &ata_dummy_port_info
>> to 'pi' at the start of the *for* loop instead to fix this kernel oops
>> for good...
>>
>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>> analysis tool.
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> ---
>> This patch is against the 'for-next' branch of Damien's 'libata.git' repo.
>>
>>  drivers/ata/libata-core.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Index: libata/drivers/ata/libata-core.c
>> ===================================================================
>> --- libata.orig/drivers/ata/libata-core.c
>> +++ libata/drivers/ata/libata-core.c
>> @@ -5470,7 +5470,7 @@ struct ata_host *ata_host_alloc_pinfo(st
>>  	if (!host)
>>  		return NULL;
>>  
>> -	for (i = 0, j = 0, pi = NULL; i < host->n_ports; i++) {
>> +	for (i = 0, j = 0, pi = &ata_dummy_port_info; i < host->n_ports; i++) {
>>  		struct ata_port *ap = host->ports[i];
>>  
>>  		if (ppi[j])
> 
> I had a fight with this one a while back as the build bot was complaining
> about this a while back.

   Hm, what exact tool was complaining?

> pi cannot be null in this case, but silencing
> warnings is good. So OK.

   At least it shouldn't be NULL with a tested driver... I found one driver (pata_cs5520)
that sets the port info array entries to &ata_dummy_port_info on disabled ports, hence
was my idea to also use it...

> Just one nit: please move the initialization of pi to its declaration to
> avoid the overly long for line.

   It's not _overly_ long but OK. :-)

MBR, Sergey
