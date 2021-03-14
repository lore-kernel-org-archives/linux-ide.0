Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08E7C433E0
	for <linux-ide@archiver.kernel.org>; Sun, 14 Mar 2021 20:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D0564EB7
	for <linux-ide@archiver.kernel.org>; Sun, 14 Mar 2021 20:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhCNUlg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 14 Mar 2021 16:41:36 -0400
Received: from mxout04.lancloud.ru ([45.84.86.114]:46860 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbhCNUlS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 14 Mar 2021 16:41:18 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Mar 2021 16:41:18 EDT
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 3FE3C208A3D6
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
To:     Jens Axboe <axboe@kernel.dk>, <linux-ide@vger.kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: [PATCH] sata_highbank: fix deferred probing
Organization: Open Mobile Platform, LLC
Message-ID: <105b456d-1199-f6e9-ceb7-ffc5ba551d1a@omprussia.ru>
Date:   Sun, 14 Mar 2021 23:34:27 +0300
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
-EINVAL, so if it returns -EPROBE_DEFER, the driver would fail the probe
permanently instead of the deferred probing. Switch to propagating the
error code upstream, still checking/overriding IRQ0 as libata regards it
as "no IRQ" (thus polling) anyway...

Fixes: 9ec36cafe43b ("of/irq: do irq resolution in platform_get_irq")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
This patch is againt the 'master' branch of Jens Axboe's linux-block repo.

drivers/ata/sata_highbank.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-block/drivers/ata/sata_highbank.c
===================================================================
--- linux-block.orig/drivers/ata/sata_highbank.c
+++ linux-block/drivers/ata/sata_highbank.c
@@ -469,10 +469,12 @@ static int ahci_highbank_probe(struct pl
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
+	if (irq < 0) {
 		dev_err(dev, "no irq\n");
-		return -EINVAL;
+		return irq;
 	}
+	if (!irq)
+		return -EINVAL;
 
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv) {
