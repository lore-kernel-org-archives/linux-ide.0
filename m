Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296AEC43460
	for <linux-ide@archiver.kernel.org>; Wed, 19 May 2021 15:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02DFD610A8
	for <linux-ide@archiver.kernel.org>; Wed, 19 May 2021 15:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354473AbhESPVL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 19 May 2021 11:21:11 -0400
Received: from mxout03.lancloud.ru ([45.84.86.113]:53118 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354419AbhESPVK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 19 May 2021 11:21:10 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru DEF3320FD455
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] sata_highbank: fix deferred probing
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sergey Shtylyov <s.shtylyov@omprussia.ru>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-ide@vger.kernel.org>
References: <105b456d-1199-f6e9-ceb7-ffc5ba551d1a@omprussia.ru>
 <alpine.DEB.2.22.394.2105190930300.1685435@ramsan.of.borg>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <13485ccc-83d6-d4a7-f423-feeb9094505f@omp.ru>
Date:   Wed, 19 May 2021 18:19:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2105190930300.1685435@ramsan.of.borg>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/19/21 10:33 AM, Geert Uytterhoeven wrote:

>> The driver overrides the error codes returned by platform_get_irq() to
>> -EINVAL, so if it returns -EPROBE_DEFER, the driver would fail the probe
>> permanently instead of the deferred probing. Switch to propagating the
>> error code upstream, still checking/overriding IRQ0 as libata regards it
>> as "no IRQ" (thus polling) anyway...
>>
>> Fixes: 9ec36cafe43b ("of/irq: do irq resolution in platform_get_irq")
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>
> 
> Thanks for your patch, which is now commit 4a24efa16e7db023
> ("sata_highbank: fix deferred probing") in block/for-next.
> 
>> --- linux-block.orig/drivers/ata/sata_highbank.c
>> +++ linux-block/drivers/ata/sata_highbank.c
>> @@ -469,10 +469,12 @@ static int ahci_highbank_probe(struct pl
>>     }
>>
>>     irq = platform_get_irq(pdev, 0);
>> -    if (irq <= 0) {
>> +    if (irq < 0) {
>>         dev_err(dev, "no irq\n");
> 
> This message should not be printed in case of -EPROBE_DEFER...

    I fact, platform_get_irq() now prints erors, even checking for EPROBE_DEFER,
so the message may be removed completely... :-)

> 
>> -        return -EINVAL;
>> +        return irq;
[...]

MBR, Sergey
