Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DD0C433C1
	for <linux-ide@archiver.kernel.org>; Thu, 25 Mar 2021 20:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E250461A28
	for <linux-ide@archiver.kernel.org>; Thu, 25 Mar 2021 20:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhCYUrD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 25 Mar 2021 16:47:03 -0400
Received: from mxout04.lancloud.ru ([45.84.86.114]:45332 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhCYUqc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Mar 2021 16:46:32 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru A4202208A3F6
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
To:     Jens Axboe <axboe@kernel.dk>, Viresh Kumar <vireshk@kernel.org>,
        <linux-ide@vger.kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: [PATCH 0/2] Correctly handle plaform_get_irq()'s result in the libata
 drivers
Organization: Open Mobile Platform, LLC
Message-ID: <7ba924c1-8c94-b0e7-6361-5e060746e839@omprussia.ru>
Date:   Thu, 25 Mar 2021 23:46:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
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

Here are 2 patches against the 'master' branch of the Jens Axboe's 'linux-block.git' repo.
The affected drivers call platform_get_irq() but mis-interprete its result -- they consider
IRQ0 as error and the real error codes as valid IRQs... :-/

[1/2] pata_arasan_cf: fix IRQ check
[2/2] pata_ipx4xx_cf: fix IRQ check
