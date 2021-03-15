Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A310BC433DB
	for <linux-ide@archiver.kernel.org>; Mon, 15 Mar 2021 20:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B96564E83
	for <linux-ide@archiver.kernel.org>; Mon, 15 Mar 2021 20:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhCOUKB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 Mar 2021 16:10:01 -0400
Received: from mxout04.lancloud.ru ([45.84.86.114]:54600 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhCOUJo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 15 Mar 2021 16:09:44 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 8EEDD209458A
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: libahci_platform: fix IRQ check
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
To:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-ide@vger.kernel.org>
References: <f3aaa894-97f4-2a0b-dd1d-df345cd56e76@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <49173d96-6d0d-720a-c29d-7e22ffe8bd20@omprussia.ru>
Date:   Mon, 15 Mar 2021 23:09:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <f3aaa894-97f4-2a0b-dd1d-df345cd56e76@omprussia.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/15/21 10:47 PM, Sergey Shtylyov wrote:

> Iff platform_get_irq() returns 0, ahci_platform_init_host() would return 0
> early (as if the call was successful). Override IRQ0 with -EINVAL instead
> as the 'libata' regards 0 as "no IRQ" (thus polling) anyway...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

   Oops, forgot the "Fixes: tag, will repost! :-)

MBR, Sergey
