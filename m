Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD70C433C1
	for <linux-ide@archiver.kernel.org>; Sat, 20 Mar 2021 20:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC71661580
	for <linux-ide@archiver.kernel.org>; Sat, 20 Mar 2021 20:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCTUcl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 20 Mar 2021 16:32:41 -0400
Received: from mxout01.lancloud.ru ([45.84.86.81]:33838 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTUcl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 20 Mar 2021 16:32:41 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 62C442096DA9
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: [PATCH v2] pata_ep93xx: fix deferred probing
To:     Jens Axboe <axboe@kernel.dk>, <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform, LLC
Message-ID: <509fda88-2e0d-2cc7-f411-695d7e94b136@omprussia.ru>
Date:   Sat, 20 Mar 2021 23:32:38 +0300
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
permanently instead of the deferred probing.  Propagate the error code
upstream, as it should have been done from the start...

Fixes: 2fff27512600 ("PATA host controller driver for ep93xx")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
This patch is against the 'master' branch of Jens Axboe's 'linux-block.git'
repo.

Changes in version 2:
- split off the part fixing up IRQ0 case, adjusted the description accordingly.

 drivers/ata/pata_ep93xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-block/drivers/ata/pata_ep93xx.c
===================================================================
--- linux-block.orig/drivers/ata/pata_ep93xx.c
+++ linux-block/drivers/ata/pata_ep93xx.c
@@ -928,7 +928,7 @@ static int ep93xx_pata_probe(struct plat
 	/* INT[3] (IRQ_EP93XX_EXT3) line connected as pull down */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		err = -ENXIO;
+		err = irq;
 		goto err_rel_gpio;
 	}
 
