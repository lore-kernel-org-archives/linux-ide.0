Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D7CC433DB
	for <linux-ide@archiver.kernel.org>; Sat, 27 Mar 2021 21:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84AAB6196C
	for <linux-ide@archiver.kernel.org>; Sat, 27 Mar 2021 21:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhC0VOW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 27 Mar 2021 17:14:22 -0400
Received: from mxout01.lancloud.ru ([45.84.86.81]:50820 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhC0VNw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 27 Mar 2021 17:13:52 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 57C6A20D8777
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
To:     Jens Axboe <axboe@kernel.dk>, <linux-ide@vger.kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: [PATCH] sata_mv: add IRQ checks
Organization: Open Mobile Platform, LLC
CC:     <linux-kernel@vger.kernel.org>
Message-ID: <51436f00-27a1-e20b-c21b-0e817e0a7c86@omprussia.ru>
Date:   Sun, 28 Mar 2021 00:13:49 +0300
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

The function mv_platform_probe() neglects to check the results of the
calls to platform_get_irq() and irq_of_parse_and_map() and blithely
passes them to ata_host_activate() -- while the latter only checks
for IRQ0 (treating it as a polling mode indicattion) and passes the
negative values to devm_request_irq() causing it to fail as it takes
unsigned values for the IRQ #...

Add to mv_platform_probe() the proper IRQ checks to pass the positive IRQ
#s to ata_host_activate(), propagate upstream the negative error codes,
and override the IRQ0 with -EINVAL (as we don't want the polling mode).

Fixes: f351b2d638c3 ("sata_mv: Support SoC controllers")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
 drivers/ata/sata_mv.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-block/drivers/ata/sata_mv.c
===================================================================
--- linux-block.orig/drivers/ata/sata_mv.c
+++ linux-block/drivers/ata/sata_mv.c
@@ -4097,6 +4097,10 @@ static int mv_platform_probe(struct plat
 		n_ports = mv_platform_data->n_ports;
 		irq = platform_get_irq(pdev, 0);
 	}
+	if (irq < 0)
+		return irq;
+	if (!irq)
+		return -EINVAL;
 
 	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
 	hpriv = devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);
