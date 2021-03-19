Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9E6C433C1
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 20:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A34661949
	for <linux-ide@archiver.kernel.org>; Fri, 19 Mar 2021 20:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCSUYS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Mar 2021 16:24:18 -0400
Received: from mxout03.lancloud.ru ([45.84.86.113]:49154 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhCSUYG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Mar 2021 16:24:06 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 069A2207520A
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: [PATCH] pata_ep93xx: fix deferred probing
To:     Jens Axboe <axboe@kernel.dk>, <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform, LLC
Message-ID: <215f70ac-64fd-bf56-a5d2-79b2ffe24d5e@omprussia.ru>
Date:   Fri, 19 Mar 2021 23:24:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The driver overrides the error codes returned by platform_get_irq() to
-ENXIO, so if it returns -EPROBE_DEFER, the driver would fail the probe
permanently instead of the deferred probing. Switch to propagating the
error code upstream, still checking/overriding IRQ0 as libata regards it
as "no IRQ" (thus polling) anyway...

Fixes: 2fff27512600 ("PATA host controller driver for ep93xx")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
This patch is against the 'master' branch of Jens Axboe's 'linux-block.git'
repo.

 drivers/ata/pata_ep93xx.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-block/drivers/ata/pata_ep93xx.c
===================================================================
--- linux-block.orig/drivers/ata/pata_ep93xx.c
+++ linux-block/drivers/ata/pata_ep93xx.c
@@ -928,7 +928,11 @@ static int ep93xx_pata_probe(struct plat
 	/* INT[3] (IRQ_EP93XX_EXT3) line connected as pull down */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		err = -ENXIO;
+		err = irq;
+		goto err_rel_gpio;
+	}
+	if (!irq) {
+		err = -EINVAL;
 		goto err_rel_gpio;
 	}
 
