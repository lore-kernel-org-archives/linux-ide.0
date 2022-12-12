Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53FCC4332F
	for <linux-ide@archiver.kernel.org>; Mon, 12 Dec 2022 21:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiLLVlV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiLLVlV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Dec 2022 16:41:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934A0FAED
        for <linux-ide@vger.kernel.org>; Mon, 12 Dec 2022 13:41:20 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4qY2-0008BP-UE; Mon, 12 Dec 2022 22:41:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4qY1-0046bv-7G; Mon, 12 Dec 2022 22:41:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4qY1-004bIk-Bt; Mon, 12 Dec 2022 22:41:17 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] ata: octeon: Drop empty platform remove function
Date:   Mon, 12 Dec 2022 22:41:12 +0100
Message-Id: <20221212214112.3775327-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Z1RqCbjDjRIoZdYTj0677xw8Feb0CeNXjw2zg0nHjrs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjl5/0Kime4HS5mV13/ugeXl6I6KDBzglgqbDQCDlb 3STFdGuJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY5ef9AAKCRDB/BR4rcrsCZBcB/ 90pYqpDhc0Baqjq1nAKhgEtTvA16ZJVqF6h45txj8dI/TyGBx33KO7RHCEc/wheWzbxk+vNIndtQfV 2KnByA50QMidsCPJ0Bpqq/X0i0ODvj6PjR1vZJPiCcUqLpSuPmHUyiV9epv1jKWGGmWtnoSmFRtJl+ rSsjFcAL9l04jEdG4+FSrlgfitFgVtJT4xrboPdBl11DaSjJscqKaMFKz/ic6oOr8gnUV5k4rPCKvA 4LdwbEZYq9ek7ehaf2d6JUIpwLPjTkl5uhlmV4hFtAkl5R3r8edwksHMqSYpv4BeEuGmlSF9XOswqS yx3sx2N0L8CA5QLy7kzWMMGQNWm0by
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

A remove callback just returning 0 is equivalent to no remove callback
at all. So drop the useless function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/ata/ahci_octeon.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/ata/ahci_octeon.c b/drivers/ata/ahci_octeon.c
index b9460b91288f..5021ab3ede49 100644
--- a/drivers/ata/ahci_octeon.c
+++ b/drivers/ata/ahci_octeon.c
@@ -73,11 +73,6 @@ static int ahci_octeon_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ahci_octeon_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static const struct of_device_id octeon_ahci_match[] = {
 	{ .compatible = "cavium,octeon-7130-sata-uctl", },
 	{ /* sentinel */ }
@@ -86,7 +81,6 @@ MODULE_DEVICE_TABLE(of, octeon_ahci_match);
 
 static struct platform_driver ahci_octeon_driver = {
 	.probe          = ahci_octeon_probe,
-	.remove         = ahci_octeon_remove,
 	.driver         = {
 		.name   = "octeon-ahci",
 		.of_match_table = octeon_ahci_match,

base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
-- 
2.38.1

