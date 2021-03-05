Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDBBC433DB
	for <linux-ide@archiver.kernel.org>; Fri,  5 Mar 2021 09:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6FBF64F6F
	for <linux-ide@archiver.kernel.org>; Fri,  5 Mar 2021 09:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhCEJQx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhCEJQY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 5 Mar 2021 04:16:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F6FC061760
        for <linux-ide@vger.kernel.org>; Fri,  5 Mar 2021 01:16:22 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lI6ZJ-0004zS-7b; Fri, 05 Mar 2021 10:16:21 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-ide@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] ata: mediatek: fix optional reset handling
Date:   Fri,  5 Mar 2021 10:16:14 +0100
Message-Id: <20210305091614.11390-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

As of commit bb475230b8e5 ("reset: make optional functions really
optional"), the reset framework API calls use NULL pointers to describe
optional, non-present reset controls.

This allows to unconditionally return errors from
devm_reset_control_get_optional_exclusive.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/ata/ahci_mtk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_mtk.c b/drivers/ata/ahci_mtk.c
index d9b08ae7c3b2..7b705302308e 100644
--- a/drivers/ata/ahci_mtk.c
+++ b/drivers/ata/ahci_mtk.c
@@ -49,15 +49,15 @@ static int mtk_ahci_platform_resets(struct ahci_host_priv *hpriv,
 
 	/* reset AXI bus and PHY part */
 	plat->axi_rst = devm_reset_control_get_optional_exclusive(dev, "axi");
-	if (PTR_ERR(plat->axi_rst) == -EPROBE_DEFER)
+	if (IS_ERR(plat->axi_rst))
 		return PTR_ERR(plat->axi_rst);
 
 	plat->sw_rst = devm_reset_control_get_optional_exclusive(dev, "sw");
-	if (PTR_ERR(plat->sw_rst) == -EPROBE_DEFER)
+	if (IS_ERR(plat->sw_rst))
 		return PTR_ERR(plat->sw_rst);
 
 	plat->reg_rst = devm_reset_control_get_optional_exclusive(dev, "reg");
-	if (PTR_ERR(plat->reg_rst) == -EPROBE_DEFER)
+	if (IS_ERR(plat->reg_rst))
 		return PTR_ERR(plat->reg_rst);
 
 	err = reset_control_assert(plat->axi_rst);
-- 
2.29.2

