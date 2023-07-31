Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7EAC001E0
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jul 2023 09:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjGaJQy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjGaJQu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jul 2023 05:16:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377BE129
        for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2023 02:16:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1B-0000AS-7W; Mon, 31 Jul 2023 11:16:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP1A-0005kl-HN; Mon, 31 Jul 2023 11:16:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qQP19-009GVa-Md; Mon, 31 Jul 2023 11:16:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 06/12] ata/pata_pxa: Convert to platform remove callback returning void
Date:   Mon, 31 Jul 2023 11:16:30 +0200
Message-Id: <20230731091636.693193-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
References: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+BfHotY0QcmdlarIBDAD6LVhaI+L2gRy5c/bvmVr0rU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkx3uE1KaJvjapuLekUX6ZKXLSj/JYZamlM23fI mLsvuObONaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMd7hAAKCRCPgPtYfRL+ Tn+GCACXaUue1QUa02wOaki806X7PNMN8z1xXdtHzDmEYIU0/lipYyi6TTGivfZBkvdtxYCq1DM atiLhdAJ3rVL2lGM7NAeUpjBS6L8xebBEFRyBAj/Se/EqEv2wko3g4tKcD0ZkjDzYIn+3M/SzzG 4ImEm5QMlpR5ntSsvRupedjirQ1g48EQA5tO664Mx1F0cpZfWYg2j0RqRSpWvbvPO9YVoGOx6gK T73fuqMzUe1vixORwGQlRfoZjH/oif5ifQzLOA76PY7CwjCivap7w0X78LJOi1B7JOMxgqNRqNH 4IXEgxclRpKlKCPjseUdnS7BfvZlRS0BGzFJpqzNaVDSZSZ9
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() is renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/ata/pata_pxa.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index ea402e02c46e..5275c6464f57 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -295,7 +295,7 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pxa_ata_remove(struct platform_device *pdev)
+static void pxa_ata_remove(struct platform_device *pdev)
 {
 	struct ata_host *host = platform_get_drvdata(pdev);
 	struct pata_pxa_data *data = host->ports[0]->private_data;
@@ -303,13 +303,11 @@ static int pxa_ata_remove(struct platform_device *pdev)
 	dma_release_channel(data->dma_chan);
 
 	ata_host_detach(host);
-
-	return 0;
 }
 
 static struct platform_driver pxa_ata_driver = {
 	.probe		= pxa_ata_probe,
-	.remove		= pxa_ata_remove,
+	.remove_new	= pxa_ata_remove,
 	.driver		= {
 		.name		= DRV_NAME,
 	},
-- 
2.39.2

