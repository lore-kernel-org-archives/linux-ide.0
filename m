Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226F3C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 08:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4DE60E05
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 08:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhJLILG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Oct 2021 04:11:06 -0400
Received: from mxout02.lancloud.ru ([45.84.86.82]:49698 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhJLILG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2021 04:11:06 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 4BE40205FD26
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v2] ata: atp867x: Cleanup pointer value print
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210930030533.1216577-1-qtxuning1999@sjtu.edu.cn>
 <974dfba6-915e-c3d6-53f6-473be18faf80@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <e9c13b1d-a4dd-9aea-e8b5-2165e727d660@omp.ru>
Date:   Tue, 12 Oct 2021 11:08:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <974dfba6-915e-c3d6-53f6-473be18faf80@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12.10.2021 4:06, Damien Le Moal wrote:

>> Pointers should be printed with %p or %px rather than cast to
>> 'unsigned long' and printed with %lx
>> Change %lx to %p to print the secured pointer.
>>
>> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
>> ---
>>   drivers/ata/pata_atp867x.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
>> index 2bc5fc81efe3..c32b95f48e50 100644
>> --- a/drivers/ata/pata_atp867x.c
>> +++ b/drivers/ata/pata_atp867x.c
>> @@ -447,11 +447,11 @@ static int atp867x_ata_pci_sff_init_host(struct ata_host *host)
>>   #ifdef	ATP867X_DEBUG
>>   		atp867x_check_ports(ap, i);
>>   #endif
>> -		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
>> -			(unsigned long)ioaddr->cmd_addr,
>> -			(unsigned long)ioaddr->ctl_addr);
>> -		ata_port_desc(ap, "bmdma 0x%lx",
>> -			(unsigned long)ioaddr->bmdma_addr);
>> +		ata_port_desc(ap, "cmd 0x%p ctl 0x%p",
>> +			ioaddr->cmd_addr,
>> +			ioaddr->ctl_addr);
>> +		ata_port_desc(ap, "bmdma 0x%p",
>> +			ioaddr->bmdma_addr);
>>   
>>   		mask |= 1 << i;
>>   	}
>>
> 
> I lost track of this one. Any v3 to be expected to address Sergey comment ?

    No, this patch isn't needed at all.

MBR, Sergey
