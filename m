Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E74C433DB
	for <linux-ide@archiver.kernel.org>; Thu, 25 Mar 2021 20:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D521619E4
	for <linux-ide@archiver.kernel.org>; Thu, 25 Mar 2021 20:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCYUux (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 25 Mar 2021 16:50:53 -0400
Received: from mxout04.lancloud.ru ([45.84.86.114]:45406 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhCYUu1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Mar 2021 16:50:27 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 30BA5208A3FB
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: [PATCH 1/2] pata_arasan_cf: fix IRQ check
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
To:     Jens Axboe <axboe@kernel.dk>, Viresh Kumar <vireshk@kernel.org>,
        <linux-ide@vger.kernel.org>
References: <7ba924c1-8c94-b0e7-6361-5e060746e839@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <be289a3d-b230-be2c-c367-d9a42b1cde82@omprussia.ru>
Date:   Thu, 25 Mar 2021 23:50:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <7ba924c1-8c94-b0e7-6361-5e060746e839@omprussia.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The driver's probe() method is written as if platform_get_irq() returns 0
on error, while actually it returns a negative error code (with all the
other values considered valid IRQs). Rewrite the driver's IRQ checking code
to pass the positive IRQ #s to ata_host_activate(), propagate upstream
-EPROBE_DEFER, and set up the driver to polling mode on (negative) errors
and IRQ0 (libata treats IRQ #0 as a polling mode anyway)...

Fixes: a480167b23ef ("pata_arasan_cf: Adding support for arasan compact flash host controller")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
This patch is against the 'master' branch of Jens Axboe's 'linux-block.git'
repo.

 drivers/ata/pata_arasan_cf.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

Index: linux-block/drivers/ata/pata_arasan_cf.c
===================================================================
--- linux-block.orig/drivers/ata/pata_arasan_cf.c
+++ linux-block/drivers/ata/pata_arasan_cf.c
@@ -818,12 +818,19 @@ static int arasan_cf_probe(struct platfo
 	else
 		quirk = CF_BROKEN_UDMA; /* as it is on spear1340 */
 
-	/* if irq is 0, support only PIO */
-	acdev->irq = platform_get_irq(pdev, 0);
-	if (acdev->irq)
+	/*
+	 * If there's an error getting IRQ (or we do get IRQ0),
+	 * support only PIO
+	 */
+	ret = platform_get_irq(pdev, 0);
+	if (ret > 0) {
+		acdev->irq = ret;
 		irq_handler = arasan_cf_interrupt;
-	else
+	} else	if (ret == -EPROBE_DEFER) {
+		return ret;
+	} else	{
 		quirk |= CF_BROKEN_MWDMA | CF_BROKEN_UDMA;
+	}
 
 	acdev->pbase = res->start;
 	acdev->vbase = devm_ioremap(&pdev->dev, res->start,
