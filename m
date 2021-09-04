Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAC5C433EF
	for <linux-ide@archiver.kernel.org>; Sat,  4 Sep 2021 18:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CD260EE3
	for <linux-ide@archiver.kernel.org>; Sat,  4 Sep 2021 18:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhIDS7D (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 4 Sep 2021 14:59:03 -0400
Received: from mxout01.lancloud.ru ([45.84.86.81]:57184 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhIDS7C (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 4 Sep 2021 14:59:02 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 9B24A2093224
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 0/4] Explicitly deny IRQ0 in the libata drivers
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        Jens Axboe <axboe@kernel.dk>, <linux-ide@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <2e552c36-84a5-a642-a8f0-1395f77a1a6a@omprussia.ru>
 <e167d421-1456-9211-86ff-979792245b48@omp.ru>
Organization: Open Mobile Platform
Message-ID: <86087864-2023-890b-5e9e-f229aa4b9db6@omp.ru>
Date:   Sat, 4 Sep 2021 21:57:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e167d421-1456-9211-86ff-979792245b48@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/10/21 11:48 PM, Sergey Shtylyov wrote:

> Hello!
> 
>    What about this series?
>    I got no feedback whatsoever -- it seems to have been lost.

   Almost 4 months have paseed from this reminder. Still no commnets whatsoever...

> On 3/21/21 9:50 PM, Sergey Shtylyov wrote:
> 
>> Here are 4 patches against the 'master' branch of the Jens Axboe's 'linux-blobk.git'
>> repo plus the 'pataep_93xx' driver patch re-posted yesterday.  The affected drivers
>> use platform_get_irq() which may return IRQ0 (considered invalid, according to Linus)
>> that means polling when passed to ata_host_activate() called at the end of the probe
>> methods.
> 
>    I might not have been clear enough: 'irq == 0' means that the libata core would WARN about
> the non-NULL 'handler' paramter which seems a to be a problem...
> 
>> I think that the solution to this issue is to explicitly deny IRQ0 returned
>> by platform_get_irq()...
[...]

MBR, Sergey
