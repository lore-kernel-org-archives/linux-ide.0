Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00006C433EF
	for <linux-ide@archiver.kernel.org>; Sun, 12 Jun 2022 12:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiFLM5z (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Jun 2022 08:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiFLM5y (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Jun 2022 08:57:54 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C4BF64DE;
        Sun, 12 Jun 2022 05:57:53 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 338C81E80D89;
        Sun, 12 Jun 2022 20:56:49 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HGN2UNlKuFNX; Sun, 12 Jun 2022 20:56:46 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 15CA41E80C8B;
        Sun, 12 Jun 2022 20:56:46 +0800 (CST)
From:   Li Qiong <liqiong@nfschina.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuzhe@nfschina.com, renyu@nfschina.com,
        Li Qiong <liqiong@nfschina.com>
Subject: [PATCH v2] ata: pata_pxa: handle failure of devm_ioremap()
Date:   Sun, 12 Jun 2022 20:57:00 +0800
Message-Id: <20220612125700.11740-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220612073222.18974-1-liqiong@nfschina.com>
References: <20220612073222.18974-1-liqiong@nfschina.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

As the possible failure of the devm_ioremap(), the return value
could be NULL. Therefore it should be better to check it and
print error message, return '-ENOMEM' error code.

Signed-off-by: Li Qiong <liqiong@nfschina.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
v2:
- add driver's name (pata_pxa) to subject.
---
 drivers/ata/pata_pxa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 985f42c4fd70..cd1a8f37f920 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -228,6 +228,11 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	ap->ioaddr.bmdma_addr	= devm_ioremap(&pdev->dev, dma_res->start,
 						resource_size(dma_res));
 
+	if (!ap->ioaddr.cmd_addr || !ap->ioaddr.ctl_addr || !ap->ioaddr.bmdma_addr) {
+		dev_err(&pdev->dev, "failed to map ap->ioaddr\n");
+		return -ENOMEM;
+	}
+
 	/*
 	 * Adjust register offsets
 	 */
-- 
2.11.0

