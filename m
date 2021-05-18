Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EA3C433ED
	for <linux-ide@archiver.kernel.org>; Tue, 18 May 2021 18:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E60561261
	for <linux-ide@archiver.kernel.org>; Tue, 18 May 2021 18:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbhERSd6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 18 May 2021 14:33:58 -0400
Received: from mxout03.lancloud.ru ([45.84.86.113]:52358 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhERSd5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 18 May 2021 14:33:57 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru F1008206F618
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] pata_rb532_cf: fix deferred probing
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        Jens Axboe <axboe@kernel.dk>, <linux-ide@vger.kernel.org>
References: <771ced55-3efb-21f5-f21c-b99920aae611@omprussia.ru>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <1f82776f-6d61-284c-018c-ef7c00fa284a@omp.ru>
Date:   Tue, 18 May 2021 21:32:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <771ced55-3efb-21f5-f21c-b99920aae611@omprussia.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/15/21 2:46 PM, Sergey Shtylyov wrote:

> The driver overrides the error codes returned by platform_get_irq() to
> -ENOENT, so if it returns -EPROBE_DEFER, the driver would fail the probe
> permanently instead of the deferred probing. Switch to propagating the
> error code upstream, still checking/overriding IRQ0 as libata regards it
> as "no IRQ" (thus polling) anyway...
> 
> Fixes: 9ec36cafe43b ("of/irq: do irq resolution in platform_get_irq")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>
[...]

   Again, 2 months have passed, and it seems the patch has been lost somewhere...

MNR, Sergey
