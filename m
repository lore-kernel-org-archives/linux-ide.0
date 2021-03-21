Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C270C433C1
	for <linux-ide@archiver.kernel.org>; Sun, 21 Mar 2021 18:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501606194C
	for <linux-ide@archiver.kernel.org>; Sun, 21 Mar 2021 18:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhCUSyt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 21 Mar 2021 14:54:49 -0400
Received: from mxout01.lancloud.ru ([45.84.86.81]:41026 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhCUSyV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 21 Mar 2021 14:54:21 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 1B336205D672
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: [PATCH 1/4] pata_bk3710: deny IRQ0
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
To:     Jens Axboe <axboe@kernel.dk>, <linux-ide@vger.kernel.org>
References: <2e552c36-84a5-a642-a8f0-1395f77a1a6a@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <0e1e3f42-aaca-d5d2-0038-9945633ba0f8@omprussia.ru>
Date:   Sun, 21 Mar 2021 21:54:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <2e552c36-84a5-a642-a8f0-1395f77a1a6a@omprussia.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

If platform_get_irq() returns IRQ0 (considered invalid according to Linus)
the driver blithely passes it to ata_host_activate() that treats IRQ0 as
a sign that libata should use polling and thus complains about non-NULL 
IRQ handler passed to it. Deny IRQ0 right away, returning -EINVAL from
the probe() method...

Fixes: 76a40ca82f34 ("Add Palmchip BK3710 PATA controller driver.")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
 drivers/ata/pata_bk3710.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-block/drivers/ata/pata_bk3710.c
===================================================================
--- linux-block.orig/drivers/ata/pata_bk3710.c
+++ linux-block/drivers/ata/pata_bk3710.c
@@ -317,6 +317,8 @@ static int __init pata_bk3710_probe(stru
 		pr_err(DRV_NAME ": failed to get IRQ resource\n");
 		return irq;
 	}
+	if (!irq)
+		return -EINVAL;
 
 	base = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(base))
