Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA75C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 30 Sep 2021 02:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B1961555
	for <linux-ide@archiver.kernel.org>; Thu, 30 Sep 2021 02:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347882AbhI3CqT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Sep 2021 22:46:19 -0400
Received: from smtp181.sjtu.edu.cn ([202.120.2.181]:58150 "EHLO
        smtp181.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347849AbhI3CqS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Sep 2021 22:46:18 -0400
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp181.sjtu.edu.cn (Postfix) with ESMTPS id 351E01008CBC0;
        Thu, 30 Sep 2021 10:44:35 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 234DB200B5753;
        Thu, 30 Sep 2021 10:44:35 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lFKXFlHbaTrP; Thu, 30 Sep 2021 10:44:35 +0800 (CST)
Received: from [192.168.10.98] (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 41C3B200B574E;
        Thu, 30 Sep 2021 10:44:31 +0800 (CST)
Message-ID: <d6aca15f-32f9-191b-9787-179a9ed6dcee@sjtu.edu.cn>
Date:   Thu, 30 Sep 2021 10:44:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] drivers/ata: Fix kernel pointer leak
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20210929121618.1157415-1-qtxuning1999@sjtu.edu.cn>
 <265805eb-162e-4d2d-1e56-39aa16c87934@opensource.wdc.com>
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
In-Reply-To: <265805eb-162e-4d2d-1e56-39aa16c87934@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/9/30 10:35, Damien Le Moal wrote:
> On 2021/09/29 21:16, Guo Zhi wrote:
>> Pointers should be printed with %p or %px rather than cast to
>> 'unsigned long' and pinted with %lx
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
> Looks OK to me. But please fix the commit title to:
>
> "ata: atp867x: Fix pointer value print"
>
> "pointer leak" is too scary for what is only a simple printk problem.
>
I will send a V2 patch.

thanks.

Guo

