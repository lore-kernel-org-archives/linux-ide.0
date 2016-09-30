From: <yuantian.tang@nxp.com>
Subject: [PATCH] ahci: qoriq: Revert "ahci: qoriq: Disable NCQ on ls2080a SoC"
Date: Fri, 30 Sep 2016 14:12:34 +0800
Message-ID: <1475215954-48395-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-cys01nam02on0079.outbound.protection.outlook.com ([104.47.37.79]:44929
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932761AbcI3I6S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 30 Sep 2016 04:58:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: Tang Yuantian <Yuantian.Tang@nxp.com>, Tang Yuantian <yuantian.tang@nxp.com>

From: Tang Yuantian <Yuantian.Tang@nxp.com>

This reverts commit 640847298e2b7f19 ("ahci: qoriq: Disable NCQ
on ls2080a SoC")

The erratum has been fixed in ls2080a v2.0 and later soc.
In reality, customer will not get any ls2080a v1.0 soc. Neither apply
to any products. So reverting this commit won't create any side effect.

Blacklisting v2.0 could also be a option, but that needs to check the
soc version which is not suitable in the driver.

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
 drivers/ata/ahci_qoriq.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 925c4b6..1eba8df 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -136,7 +136,7 @@ static struct ata_port_operations ahci_qoriq_ops = {
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

