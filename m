Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F176C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 20 Sep 2021 16:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BBCE610A8
	for <linux-ide@archiver.kernel.org>; Mon, 20 Sep 2021 16:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbhITQnB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 20 Sep 2021 12:43:01 -0400
Received: from mxout03.lancloud.ru ([45.84.86.113]:34432 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239268AbhITQm7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 20 Sep 2021 12:42:59 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 0686D20FAF20
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 4/4] pata_imx: deny IRQ0
To:     Fabio Estevam <festevam@gmail.com>
CC:     Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        Jens Axboe <axboe@kernel.dk>, <linux-ide@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <2e552c36-84a5-a642-a8f0-1395f77a1a6a@omprussia.ru>
 <d9aa4052-f3d1-6595-65d5-0b0bfc489047@omprussia.ru>
 <CAOMZO5DM5dpqtO2_kg+n0xi2eBoURH+OSDdUfHwocE_jKpw47w@mail.gmail.com>
 <f6e3bb64-4715-01b1-5149-745507ffa7d4@omp.ru>
 <CAOMZO5A3NiOOg8Zv1+mXh_VixuQ3=KLFPG-7CphQt-S997XV5A@mail.gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <06b8794c-102e-6c85-5f73-ebdc2d30b246@omp.ru>
Date:   Mon, 20 Sep 2021 19:41:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAOMZO5A3NiOOg8Zv1+mXh_VixuQ3=KLFPG-7CphQt-S997XV5A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/20/21 3:45 PM, Fabio Estevam wrote:

>>> IMHO the current code is correct as-is.
>>
>>    Not quite... I don't want to leave a bad example for the future driver authors. What should
>> I change in the patch description for the patch to become acceptable for you?
> 
> Please see how the PCI subsystem has converted the handling of
> platform_get_irq():
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.15-rc2&id=0584bff09629666eea97c7ac428e55b00df211f5

   Thanks for the link -- that's what I've been doing for the drivers outside PCI in the
past few months. :-)

>  Why does drivers/ata/ need to handle platform_get_irq() differently?

   Because ata_host_activate() treats irq0 as polling indicater and complains about
the 'handler' being non-NULL.
 
> I still don't see the need for changing drivers/ata/pata_imx.c in this aspect.

   And now?

MBR, Sergei
