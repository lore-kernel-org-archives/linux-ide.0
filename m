Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943D6C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jun 2022 14:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385787AbiFMOqO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Jun 2022 10:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385906AbiFMOoB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jun 2022 10:44:01 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9650B41CC
        for <linux-ide@vger.kernel.org>; Mon, 13 Jun 2022 04:51:02 -0700 (PDT)
Received: from [192.168.1.103] (31.173.86.159) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Mon, 13 Jun
 2022 14:50:40 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH v2] ata: pata_pxa: handle failure of devm_ioremap()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Li Qiong <liqiong@nfschina.com>
CC:     <linux-ide@vger.kernel.org>, <yuzhe@nfschina.com>,
        <renyu@nfschina.com>
References: <20220612073222.18974-1-liqiong@nfschina.com>
 <20220612125700.11740-1-liqiong@nfschina.com>
 <fbbed055-fa60-cdee-589b-5d8c12672e94@gmail.com>
 <097b7e93-4a85-1b6a-1772-67976f834108@opensource.wdc.com>
Organization: Open Mobile Platform
Message-ID: <80cc4026-a6bf-255f-69d9-d1c1d390f83e@omp.ru>
Date:   Mon, 13 Jun 2022 14:50:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <097b7e93-4a85-1b6a-1772-67976f834108@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.86.159]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/13/2022 11:36:46
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 171074 [Jun 13 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 489 489 b67d2e276d358fa514f5991440453e6a402e3a26
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.86.159 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.86.159 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.86.159
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/13/2022 11:39:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/13/2022 9:03:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/13/22 1:47 AM, Damien Le Moal wrote:

>>> As the possible failure of the devm_ioremap(), the return value
>>> could be NULL. Therefore it should be better to check it and
>>> print error message, return '-ENOMEM' error code.
> 
> This error is very unlikely. So unless you are seeing actual problems in
> the field, I do not think it is worth fixing.

   The error paths should absolutely be fixed. It helps avoid an oops later...

>>>
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
>>
>>    Looking again into this driver, this statement doesn't make sense: dma_res
>> points to a DMA resource, calling devm_ioremap() on it is just wrong... and
> 
> Yes, having to do an ioremap of an IORESOURCE_DMA resource is rather
> unusual. dmaengine_slave_config() should be doing anything that is
> required for that resource.
> 
>> 'ap->ioaddr.bmdma_addr' doesn;t seem to be used anyways...
> 
> It is used in lbata-sff.c.

   Where exactly? To me, it looked like all ata_bmdma_port_ops were overridden
by the driver... Even if not so, I don't think such code is correct...

> 
> A much cleaner fix would be to use
> devm_platform_get_and_ioremap_resource() or
> devm_platform_ioremap_resource() which will also remove the call to
> platform_get_resource(().

   This is an -rc1 material.

> But as mentioned above, unless this is fixing an
> actual bug in production, I do not think this is worth it.

   I strongly disagree here.

MBR, Sergey
