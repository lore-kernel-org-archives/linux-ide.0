Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3A3C433B4
	for <linux-ide@archiver.kernel.org>; Wed, 28 Apr 2021 16:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 739E5613FF
	for <linux-ide@archiver.kernel.org>; Wed, 28 Apr 2021 16:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbhD1Qe0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 28 Apr 2021 12:34:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:33858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230470AbhD1QeZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 28 Apr 2021 12:34:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BAB8FB1BB;
        Wed, 28 Apr 2021 16:33:39 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] ata: pata_rb532: Add device tree support
Date:   Wed, 28 Apr 2021 18:33:35 +0200
Message-Id: <20210428163336.73125-2-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210428163336.73125-1-tsbogend@alpha.franken.de>
References: <20210428163336.73125-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Make driver also available via device tree binding.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 drivers/ata/pata_rb532_cf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 529ba28f471f..93d839ab9654 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -162,11 +162,20 @@ static int rb532_pata_driver_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id pata_rb532_match[] = {
+	{ .compatible = "mikrotik,rb532-pata", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pata_rb532_match);
+#endif
+
 static struct platform_driver rb532_pata_platform_driver = {
 	.probe		= rb532_pata_driver_probe,
 	.remove		= rb532_pata_driver_remove,
 	.driver	 = {
 		.name   = DRV_NAME,
+		.of_match_table = of_match_ptr(pata_rb532_match),
 	},
 };
 
-- 
2.29.2

