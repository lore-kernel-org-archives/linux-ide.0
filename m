From: Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH] ahci: qoriq: add ls1088a platforms support
Date: Fri, 2 Jun 2017 15:23:03 +0800
Message-ID: <1496388183-11534-1-git-send-email-andy.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-cys01nam02on0062.outbound.protection.outlook.com ([104.47.37.62]:27020
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750807AbdFBHil (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 2 Jun 2017 03:38:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Yuantian Tang <andy.tang@nxp.com>

Ls1088a is new introduced arm-based soc with sata support with
following features:

* Complies with the serial ATA 3.0 specification
  and the AHCI 1.3.1 specification
* Contains a high-speed descriptor-based DMA controller
* Supports the following:
* Speeds of 1.5 Gb/s (first-generation SATA),
  3 Gb/s (second-generation SATA), and 6 Gb/s (third-generation SATA)
* FIS-based switching
* Native command queuing (NCQ) commands
* Port multiplier operation
* Asynchronous notification
* SATA Vendor BIST mode

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 drivers/ata/ahci_qoriq.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 4c96f3a..b6b0bf7 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -47,12 +47,14 @@
 
 #define SATA_ECC_DISABLE	0x00020000
 #define ECC_DIS_ARMV8_CH2	0x80000000
+#define ECC_DIS_LS1088A		0x40000000
 
 enum ahci_qoriq_type {
 	AHCI_LS1021A,
 	AHCI_LS1043A,
 	AHCI_LS2080A,
 	AHCI_LS1046A,
+	AHCI_LS1088A,
 	AHCI_LS2088A,
 };
 
@@ -68,6 +70,7 @@ static const struct of_device_id ahci_qoriq_of_match[] = {
 	{ .compatible = "fsl,ls1043a-ahci", .data = (void *)AHCI_LS1043A},
 	{ .compatible = "fsl,ls2080a-ahci", .data = (void *)AHCI_LS2080A},
 	{ .compatible = "fsl,ls1046a-ahci", .data = (void *)AHCI_LS1046A},
+	{ .compatible = "fsl,ls1088a-ahci", .data = (void *)AHCI_LS1088A},
 	{ .compatible = "fsl,ls2088a-ahci", .data = (void *)AHCI_LS2088A},
 	{},
 };
@@ -203,6 +206,17 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
 		break;
 
+	case AHCI_LS1088A:
+		if (!qpriv->ecc_addr)
+			return -EINVAL;
+		writel(readl(qpriv->ecc_addr) | ECC_DIS_LS1088A,
+		       qpriv->ecc_addr);
+		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
+		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
+		if (qpriv->is_dmacoherent)
+			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
+		break;
+
 	case AHCI_LS2088A:
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-- 
2.1.0.27.g96db324

