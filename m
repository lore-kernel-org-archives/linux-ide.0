Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557B7C433EF
	for <linux-ide@archiver.kernel.org>; Sat, 18 Sep 2021 20:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264E360EE4
	for <linux-ide@archiver.kernel.org>; Sat, 18 Sep 2021 20:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhIRVAl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 18 Sep 2021 17:00:41 -0400
Received: from mxout03.lancloud.ru ([45.84.86.113]:47042 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbhIRVAl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 18 Sep 2021 17:00:41 -0400
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Sep 2021 17:00:40 EDT
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 5F83D20A7684
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 4/4] pata_imx: deny IRQ0
To:     Fabio Estevam <festevam@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omprussia.ru>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-ide@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <2e552c36-84a5-a642-a8f0-1395f77a1a6a@omprussia.ru>
 <d9aa4052-f3d1-6595-65d5-0b0bfc489047@omprussia.ru>
 <CAOMZO5DM5dpqtO2_kg+n0xi2eBoURH+OSDdUfHwocE_jKpw47w@mail.gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <f6e3bb64-4715-01b1-5149-745507ffa7d4@omp.ru>
Date:   Sat, 18 Sep 2021 23:49:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAOMZO5DM5dpqtO2_kg+n0xi2eBoURH+OSDdUfHwocE_jKpw47w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 3/21/21 10:06 PM, Fabio Estevam wrote:

[...]

   Sorry for replying this late. If I don't reply to mails right away, I tend to forget about
the unreplied mails. I might have been busy with other stuff ATM too... :-)

>> If platform_get_irq() returns IRQ0 (considered invalid according to Linus)
> 
> How can platform_get_irq() return 0 on i.MX?
> This driver only runs on imx31 and imx51 and in both platforms the
> PATA IRQ is non-zero.

   Maybe this is impossible indeed -- iff someone doesn't change the kernel (or DT) on purpose
(the driver wouldn't work correctly in this case as libata would ignore the driver's IRQ
handler).

> IMHO the current code is correct as-is.

   Not quite... I don't want to leave a bad example for the future driver authors. What should
I change in the patch description for the patch to become acceptable for you?

MBR, Sergey
