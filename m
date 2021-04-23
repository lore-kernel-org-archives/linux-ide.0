Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6558C433ED
	for <linux-ide@archiver.kernel.org>; Fri, 23 Apr 2021 20:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A4B613B1
	for <linux-ide@archiver.kernel.org>; Fri, 23 Apr 2021 20:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhDWUnO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 23 Apr 2021 16:43:14 -0400
Received: from mxout01.lancloud.ru ([45.84.86.81]:59228 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhDWUnN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 23 Apr 2021 16:43:13 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 16A5B205EE82
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: [PATCH 2/2] tx4939ide: fix deferred probing
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
To:     "David S. Miller" <davem@davemloft.net>,
        <linux-ide@vger.kernel.org>
References: <35757c7b-d25f-5ef6-0088-5b0fb568a0de@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <153446a9-a5a9-1ce5-b224-6e0d5dd14eff@omprussia.ru>
Date:   Fri, 23 Apr 2021 23:42:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <35757c7b-d25f-5ef6-0088-5b0fb568a0de@omprussia.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The driver overrides the error codes returned by platform_get_irq() to
-ENODEV, so if it returns -EPROBE_DEFER,  the driver will fail the probe
permanently instead of the deferred probing.  Switch to propagating the
error code upstream.

Fixes: 37897989232e ("ide: Add tx4939ide driver (v6)")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
 drivers/ide/tx4939ide.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: ide/drivers/ide/tx4939ide.c
===================================================================
--- ide.orig/drivers/ide/tx4939ide.c
+++ ide/drivers/ide/tx4939ide.c
@@ -543,7 +543,7 @@ static int __init tx4939ide_probe(struct
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -ENODEV;
+		return irq;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
