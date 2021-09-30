Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B889CC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 30 Sep 2021 08:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98577615A4
	for <linux-ide@archiver.kernel.org>; Thu, 30 Sep 2021 08:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349015AbhI3I4c (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Sep 2021 04:56:32 -0400
Received: from mxout03.lancloud.ru ([45.84.86.113]:36612 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348271AbhI3I4b (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Sep 2021 04:56:31 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru D5F2C20F10BD
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] drivers/ata: Fix kernel pointer leak
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>
CC:     <linux-ide@vger.kernel.org>
References: <20210929121618.1157415-1-qtxuning1999@sjtu.edu.cn>
 <265805eb-162e-4d2d-1e56-39aa16c87934@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <baee2cee-3401-e8e4-efb3-432d48bb9589@omp.ru>
Date:   Thu, 30 Sep 2021 11:54:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <265805eb-162e-4d2d-1e56-39aa16c87934@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 30.09.2021 5:35, Damien Le Moal wrote:
> On 2021/09/29 21:16, Guo Zhi wrote:
>> Pointers should be printed with %p or %px rather than cast to
>> 'unsigned long' and pinted with %lx
> 
> s/pinted/printed
> 
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
> Looks OK to me. But please fix the commit title to:
> 
> "ata: atp867x: Fix pointer value print"
> 
> "pointer leak" is too scary for what is only a simple printk problem.

    It's not a simple printk() problem, it's an kernel info leak that he's 
fixing. But, as I said, this driver doesn't use MMIO, so "leaks" only I/O port 
addresses.

MBR, Sergey
