Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AF3C433F5
	for <linux-ide@archiver.kernel.org>; Fri,  1 Oct 2021 20:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E5161247
	for <linux-ide@archiver.kernel.org>; Fri,  1 Oct 2021 20:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhJAUTt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 1 Oct 2021 16:19:49 -0400
Received: from mxout04.lancloud.ru ([45.84.86.114]:58576 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhJAUTs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 1 Oct 2021 16:19:48 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 7185420A58A3
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] drivers/ata: Fix kernel pointer leak
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>
CC:     <linux-ide@vger.kernel.org>
References: <20210929121618.1157415-1-qtxuning1999@sjtu.edu.cn>
 <265805eb-162e-4d2d-1e56-39aa16c87934@opensource.wdc.com>
 <baee2cee-3401-e8e4-efb3-432d48bb9589@omp.ru>
 <445ae4fd-46af-ba09-1921-2ccedcdcf4ce@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <b0176181-ae0d-f2d7-d9de-776c161b2ff9@omp.ru>
Date:   Fri, 1 Oct 2021 23:18:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <445ae4fd-46af-ba09-1921-2ccedcdcf4ce@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/1/21 4:18 AM, Damien Le Moal wrote:

[...]
>>>> Pointers should be printed with %p or %px rather than cast to
>>>> 'unsigned long' and pinted with %lx
>>>
>>> s/pinted/printed
>>>
>>>> Change %lx to %p to print the secured pointer.
>>>>
>>>> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
>>>> ---
>>>>   drivers/ata/pata_atp867x.c | 10 +++++-----
>>>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
>>>> index 2bc5fc81efe3..c32b95f48e50 100644
>>>> --- a/drivers/ata/pata_atp867x.c
>>>> +++ b/drivers/ata/pata_atp867x.c
>>>> @@ -447,11 +447,11 @@ static int atp867x_ata_pci_sff_init_host(struct ata_host *host)
>>>>   #ifdef	ATP867X_DEBUG
>>>>   		atp867x_check_ports(ap, i);
>>>>   #endif
>>>> -		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
>>>> -			(unsigned long)ioaddr->cmd_addr,
>>>> -			(unsigned long)ioaddr->ctl_addr);
>>>> -		ata_port_desc(ap, "bmdma 0x%lx",
>>>> -			(unsigned long)ioaddr->bmdma_addr);
>>>> +		ata_port_desc(ap, "cmd 0x%p ctl 0x%p",
>>>> +			ioaddr->cmd_addr,
>>>> +			ioaddr->ctl_addr);
>>>> +		ata_port_desc(ap, "bmdma 0x%p",
>>>> +			ioaddr->bmdma_addr);
>>>>   
>>>>   		mask |= 1 << i;
>>>>   	}
>>>>
>>>
>>> Looks OK to me. But please fix the commit title to:
>>>
>>> "ata: atp867x: Fix pointer value print"
>>>
>>> "pointer leak" is too scary for what is only a simple printk problem.
>>
>>     It's not a simple printk() problem, it's an kernel info leak that he's 
>> fixing. But, as I said, this driver doesn't use MMIO, so "leaks" only I/O port 
>> addresses.
> 
> OK. I interpreted "leak" as memory leak... So the problem is print of pointer
> addresses that are unused. But if they are, shouldn't the pointers be NULL ? (I
> am absolutely not familiar with this driver, never looked at it).

  They are used to map the I/O parts, so the driver can use ioread*()/iowrite()*.

[...]


MBR, Sergey

