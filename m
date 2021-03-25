Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76A4C433DB
	for <linux-ide@archiver.kernel.org>; Thu, 25 Mar 2021 20:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 824ED61A3C
	for <linux-ide@archiver.kernel.org>; Thu, 25 Mar 2021 20:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCYUvY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 25 Mar 2021 16:51:24 -0400
Received: from mxout01.lancloud.ru ([45.84.86.81]:42342 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhCYUvN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Mar 2021 16:51:13 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 7E4F820CF59B
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: [PATCH 2/2] pata_ipx4xx_cf: fix IRQ check
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
To:     Jens Axboe <axboe@kernel.dk>, Viresh Kumar <vireshk@kernel.org>,
        <linux-ide@vger.kernel.org>
References: <7ba924c1-8c94-b0e7-6361-5e060746e839@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <9ff04a35-dbc8-67fa-4076-05446b4fce48@omprussia.ru>
Date:   Thu, 25 Mar 2021 23:51:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <7ba924c1-8c94-b0e7-6361-5e060746e839@omprussia.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The driver's probe() method is written as if platform_get_irq() returns 0
on error, while actually it returns a negative error code (with all the
other values considered valid IRQs).  Rewrite the driver's IRQ checking
code to pass the positive IRQ #s to ata_host_activate(), propagate errors
upstream, and treat IRQ0 as error, returning -EINVAL, as the libata code
treats 0  as  an indication that polling should be used anyway...

Fixes: 0df0d0a0ea9f ("[libata] ARM: add ixp4xx PATA driver")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

---
 drivers/ata/pata_ixp4xx_cf.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-block/drivers/ata/pata_ixp4xx_cf.c
===================================================================
--- linux-block.orig/drivers/ata/pata_ixp4xx_cf.c
+++ linux-block/drivers/ata/pata_ixp4xx_cf.c
@@ -165,8 +165,12 @@ static int ixp4xx_pata_probe(struct plat
 		return -ENOMEM;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq)
+	if (irq > 0)
 		irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
+	else if (irq < 0)
+		return irq;
+	else
+		return -EINVAL;
 
 	/* Setup expansion bus chip selects */
 	*data->cs0_cfg = data->cs0_bits;
