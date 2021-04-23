Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5C7C433B4
	for <linux-ide@archiver.kernel.org>; Fri, 23 Apr 2021 20:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4CD56117A
	for <linux-ide@archiver.kernel.org>; Fri, 23 Apr 2021 20:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243797AbhDWUl1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 23 Apr 2021 16:41:27 -0400
Received: from mxout01.lancloud.ru ([45.84.86.81]:59180 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243985AbhDWUlY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 23 Apr 2021 16:41:24 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 1711F2040EBA
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
To:     "David S. Miller" <davem@davemloft.net>,
        <linux-ide@vger.kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: [PATCH 0/2] Fix deferred probing for the Toshiba TX493x IDE drivers
Organization: Open Mobile Platform, LLC
Message-ID: <35757c7b-d25f-5ef6-0088-5b0fb568a0de@omprussia.ru>
Date:   Fri, 23 Apr 2021 23:40:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Here are 2 patches against the of DaveM's 'ide.git' repo. The Toshiba TX493x IDE
drivers call platform_get_irq() but override its result in case of error which
prevents the deferred probing from working...

[1/2] tx4938ide: fix deferred probing
[2/2] tx4939ide: fix deferred probing
