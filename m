Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49917C433FE
	for <linux-ide@archiver.kernel.org>; Sat, 12 Dec 2020 13:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1677322D04
	for <linux-ide@archiver.kernel.org>; Sat, 12 Dec 2020 13:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438898AbgLLNBC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 12 Dec 2020 08:01:02 -0500
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:17003 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438988AbgLLNAu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 12 Dec 2020 08:00:50 -0500
Received: from localhost.localdomain ([93.22.36.60])
        by mwinf5d19 with ME
        id 3KxH2400D1HrHD103KxJ4V; Sat, 12 Dec 2020 08:57:19 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 12 Dec 2020 08:57:19 +0100
X-ME-IP: 93.22.36.60
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     axboe@kernel.dk, qiang.liu@freescale.com, jgarzik@redhat.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] sata_fsl: Fix a resource leak in an error handling path in the probe function
Date:   Sat, 12 Dec 2020 08:57:16 +0100
Message-Id: <20201212075716.78986-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

'irq_dispose_mapping()' should be called in the error handling path of the
probe function, as already done in the remove function.

Fixes: 6b4b8fc87dc5 ("sata_fsl: add support for interrupt coalsecing feature")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/ata/sata_fsl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index d55ee244d693..49ecbc55a804 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1540,6 +1540,9 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	if (host)
 		ata_host_detach(host);
 
+	if (host_priv && host_priv->irq)
+		irq_dispose_mapping(host_priv->irq);
+
 	if (hcr_base)
 		iounmap(hcr_base);
 	kfree(host_priv);
-- 
2.27.0

