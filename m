From: <yuantian.tang@nxp.com>
Subject: [PATCH] ahci: qoriq: Revert "ahci: qoriq: Disable NCQ on ls2080a SoC"
Date: Wed, 28 Sep 2016 09:46:12 +0800
Message-ID: <1475027172-21012-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bl2nam02on0041.outbound.protection.outlook.com ([104.47.38.41]:2020
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756481AbcI1CbO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 27 Sep 2016 22:31:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: Tang Yuantian <Yuantian.Tang@nxp.com>, Tang Yuantian <yuantian.tang@nxp.com>

From: Tang Yuantian <Yuantian.Tang@nxp.com>

This reverts commit 640847298e2b7f19 ("ahci: qoriq: Disable NCQ
on ls2080a SoC")

The erratum has been fixed in ls2080a v2.0 and later soc.
Since ls2080a v1.0 has rarely been released, it can be safely
reverted.

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
 drivers/ata/ahci_qoriq.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 7bdee9b..2342fca 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -137,7 +137,7 @@ static struct ata_port_operations ahci_qoriq_ops = {
 	.hardreset	= ahci_qoriq_hardreset,
 };
 
-static struct ata_port_info ahci_qoriq_port_info = {
+static const struct ata_port_info ahci_qoriq_port_info = {
 	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NCQ,
 	.pio_mask	= ATA_PIO4,
 	.udma_mask	= ATA_UDMA6,
@@ -221,12 +221,6 @@ static int ahci_qoriq_probe(struct platform_device *pdev)
 	if (rc)
 		goto disable_resources;
 
-	/* Workaround for ls2080a */
-	if (qoriq_priv->type == AHCI_LS2080A) {
-		hpriv->flags |= AHCI_HFLAG_NO_NCQ;
-		ahci_qoriq_port_info.flags &= ~ATA_FLAG_NCQ;
-	}
-
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_qoriq_port_info,
 				     &ahci_qoriq_sht);
 	if (rc)
-- 
2.1.0.27.g96db324

