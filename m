From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] ata: sata_mv: check for errors when parsing nr-ports from dt
Date: Tue, 29 Nov 2016 12:13:38 +0100
Message-ID: <20161129111338.19389-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33743 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754053AbcK2LN7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Nov 2016 06:13:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, kernel@pengutronix.de

If the nr-ports property is missing ata_host_alloc_pinfo is called with
n_ports = 0. This results in host->ports[0] = NULL which later makes
mv_init_host() oops when dereferencing this pointer.

Instead be a bit more cooperative and fail the probing with an error
message.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/ata/sata_mv.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index efc48bf89d51..823e938c9a78 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4090,7 +4090,20 @@ static int mv_platform_probe(struct platform_device *pdev)
 
 	/* allocate host */
 	if (pdev->dev.of_node) {
-		of_property_read_u32(pdev->dev.of_node, "nr-ports", &n_ports);
+		rc = of_property_read_u32(pdev->dev.of_node, "nr-ports",
+					   &n_ports);
+		if (rc) {
+			dev_err(&pdev->dev,
+				"error parsing nr-ports property: %d\n", rc);
+			return rc;
+		}
+
+		if (n_ports <= 0) {
+			dev_err(&pdev->dev, "nr-ports must be positive: %d\n",
+				n_ports);
+			return -EINVAL;
+		}
+
 		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
 	} else {
 		mv_platform_data = dev_get_platdata(&pdev->dev);
-- 
2.10.2

