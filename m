Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA58C43334
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jun 2022 01:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbiFMBHv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Jun 2022 21:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237028AbiFMBHv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Jun 2022 21:07:51 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8967BE92
        for <linux-ide@vger.kernel.org>; Sun, 12 Jun 2022 18:07:48 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 7C3AD1E80D89;
        Mon, 13 Jun 2022 09:06:39 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IZbhMcSmj1ve; Mon, 13 Jun 2022 09:06:36 +0800 (CST)
Received: from [172.30.21.244] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 4B8851E80D05;
        Mon, 13 Jun 2022 09:06:36 +0800 (CST)
Subject: Re: [PATCH v2] ata: pata_pxa: handle failure of devm_ioremap()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, yuzhe@nfschina.com, renyu@nfschina.com
References: <20220612073222.18974-1-liqiong@nfschina.com>
 <20220612125700.11740-1-liqiong@nfschina.com>
 <fbbed055-fa60-cdee-589b-5d8c12672e94@gmail.com>
 <097b7e93-4a85-1b6a-1772-67976f834108@opensource.wdc.com>
From:   liqiong <liqiong@nfschina.com>
Message-ID: <b062bab6-8248-e51a-c1ad-ac3fbc210e53@nfschina.com>
Date:   Mon, 13 Jun 2022 09:07:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <097b7e93-4a85-1b6a-1772-67976f834108@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



在 2022年06月13日 06:47, Damien Le Moal 写道:
> On 6/13/22 03:37, Sergei Shtylyov wrote:
>> On 6/12/22 3:57 PM, Li Qiong wrote:
>>
>>> As the possible failure of the devm_ioremap(), the return value
>>> could be NULL. Therefore it should be better to check it and
>>> print error message, return '-ENOMEM' error code.
> This error is very unlikely. So unless you are seeing actual problems in
> the field, I do not think it is worth fixing.
Agree, It's very unlikely.
This patch follows the guide of  "KernelJanitors",  wants to refine the code a little bit .
I searched and found that most of the other  codes had checked the return value. 
Actually,  no actual bug relation to this patch.

Thanks,
Li Qiong

>
>>> Signed-off-by: Li Qiong <liqiong@nfschina.com>
>>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>> ---
>>> v2:
>>> - add driver's name (pata_pxa) to subject.
>>> ---
>>>  drivers/ata/pata_pxa.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
>>> index 985f42c4fd70..cd1a8f37f920 100644
>>> --- a/drivers/ata/pata_pxa.c
>>> +++ b/drivers/ata/pata_pxa.c
>>> @@ -228,6 +228,11 @@ static int pxa_ata_probe(struct platform_device *pdev)
>>>  	ap->ioaddr.bmdma_addr	= devm_ioremap(&pdev->dev, dma_res->start,
>>>  						resource_size(dma_res));
>>    Looking again into this driver, this statement doesn't make sense: dma_res
>> points to a DMA resource, calling devm_ioremap() on it is just wrong... and
> Yes, having to do an ioremap of an IORESOURCE_DMA resource is rather
> unusual. dmaengine_slave_config() should be doing anything that is
> required for that resource.
>
>> 'ap->ioaddr.bmdma_addr' doesn;t seem to be used anyways...
> It is used in lbata-sff.c.
>
> A much cleaner fix would be to use
> devm_platform_get_and_ioremap_resource() or
> devm_platform_ioremap_resource() which will also remove the call to
> platform_get_resource((). But as mentioned above, unless this is fixing an
> actual bug in production, I do not think this is worth it.
>
>> MBR, Sergey
>
