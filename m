Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B046C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  9 Mar 2022 09:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiCIJBL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Mar 2022 04:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiCIJBK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Mar 2022 04:01:10 -0500
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06F8483A0;
        Wed,  9 Mar 2022 01:00:07 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 111E120DCBD4
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <45fa6cff-948f-93e0-388c-42da30e70efb@omp.ru>
Date:   Wed, 9 Mar 2022 12:00:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V3] ata: pata_pxa: Use platform_get_irq() to get the
 interrupt
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <cgel.zte@gmail.com>
CC:     <chi.minghao@zte.com.cn>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zealci@zte.com.cn>
References: <d1dfb244-eda3-b5c6-c6bd-c0294a9a4a94@opensource.wdc.com>
 <20220309072834.2081944-1-chi.minghao@zte.com.cn>
 <4ce9ad67-7102-1ad8-2726-5e96aecfde80@opensource.wdc.com>
 <d4f60079-9a99-c8e6-4a3c-4c77597cc151@gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <d4f60079-9a99-c8e6-4a3c-4c77597cc151@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 09.03.2022 11:55, Sergei Shtylyov wrote:

>>> From: Minghao Chi <chi.minghao@zte.com.cn>
>>>
>>> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
>>> allocation of IRQ resources in DT core code, this causes an issue
>>> when using hierarchical interrupt domains using "interrupts" property
>>> in the node as this bypasses the hierarchical setup and messes up the
>>> irq chaining.
>>>
>>> In preparation for removal of static setup of IRQ resource from DT core
>>> code use platform_get_irq().
>>>
>>> v1->v2:
>>>      - Use more specific in the subject: ata: pata_pxa:
>>>      - Switch to returning 'irq'
>>> v2->v3:
>>>      - drop the unlikely()
>>
>> Looks good. FYI, the changelog above should be placed under the "---"
>> after your Signed-off-by so that it does not stay as part of the commit
>> message. No need to resend, I will remove this when applying.
>>
>> Sergey,
>>
>> Review OK ?
> 
>     Yes.

    Ugh, replied from the wrong account. I had provided my Reviewed-by: tag 
already...

>     Although, strictly speaking, we still need to check for IRQ0 as well...

    The platform_get_irq() patch preventing IRQ0 hasn't landed still...

MBR, Sergey
