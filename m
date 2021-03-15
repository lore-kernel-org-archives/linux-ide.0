Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65329C433DB
	for <linux-ide@archiver.kernel.org>; Mon, 15 Mar 2021 11:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 316EA64EB3
	for <linux-ide@archiver.kernel.org>; Mon, 15 Mar 2021 11:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhCOLrF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 Mar 2021 07:47:05 -0400
Received: from mxout04.lancloud.ru ([45.84.86.114]:37714 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhCOLq5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 15 Mar 2021 07:46:57 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 08E0B212ED8E
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: [PATCH] pata_rb532_cf: fix deferred probing
To:     Jens Axboe <axboe@kernel.dk>, <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform, LLC
Message-ID: <771ced55-3efb-21f5-f21c-b99920aae611@omprussia.ru>
Date:   Mon, 15 Mar 2021 14:46:53 +0300
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

The driver overrides the error codes returned by platform_get_irq() to
-ENOENT, so if it returns -EPROBE_DEFER, the driver would fail the probe
permanently instead of the deferred probing. Switch to propagating the
error code upstream, still checking/overriding IRQ0 as libata regards it
as "no IRQ" (thus polling) anyway...

Fixes: 9ec36cafe43b ("of/irq: do irq resolution in platform_get_irq")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
This patch is against the 'master' branch of Jens Axboe's 'linux-block.git'
repo.

drivers/ata/pata_rb532_cf.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-block/drivers/ata/pata_rb532_cf.c
===================================================================
--- linux-block.orig/drivers/ata/pata_rb532_cf.c
+++ linux-block/drivers/ata/pata_rb532_cf.c
@@ -115,10 +115,12 @@ static int rb532_pata_driver_probe(struc
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
+	if (irq < 0) {
 		dev_err(&pdev->dev, "no IRQ resource found\n");
-		return -ENOENT;
+		return irq;
 	}
+	if (!irq)
+		return -EINVAL;
 
 	gpiod = devm_gpiod_get(&pdev->dev, NULL, GPIOD_IN);
 	if (IS_ERR(gpiod)) {
