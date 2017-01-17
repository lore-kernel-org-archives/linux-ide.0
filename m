From: <yuantian.tang@nxp.com>
Subject: [PATCH] ahci: qoriq: added ls2088a platforms support
Date: Tue, 17 Jan 2017 14:12:01 +0800
Message-ID: <1484633521-10938-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-by2nam03on0082.outbound.protection.outlook.com ([104.47.42.82]:4096
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750770AbdAQGZT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 17 Jan 2017 01:25:19 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tang Yuantian <Yuantian.Tang@nxp.com>, Tang Yuantian <yuantian.tang@nxp.com>

From: Tang Yuantian <Yuantian.Tang@nxp.com>

Ls2088a is new introduced arm-based soc with sata support with
following features:
1. Complies with the serial ATA 3.0 specification and the AHCI 1.3.1
   specification
2. Contains a high-speed descriptor-based DMA controller
3. Supports the following:
   a. Speeds of 1.5 Gb/s (first-generation SATA), 3 Gb/s
      (second-generation SATA), and 6 Gb/s (third-generation SATA)
   b. FIS-based switching
   c. Native command queuing (NCQ) commands
   d. Port multiplier operation
   e. Asynchronous notification
   f. SATA BIST mode

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
 Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt | 2 +-
 drivers/ata/ahci_qoriq.c                                 | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
index fc33ca0..ed87c6f 100644
--- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
@@ -3,7 +3,7 @@ Binding for Freescale QorIQ AHCI SATA Controller
 Required properties:
   - reg: Physical base address and size of the controller's register area.
   - compatible: Compatibility string. Must be 'fsl,<chip>-ahci', where
-    chip could be ls1021a, ls1043a, ls1046a, ls2080a etc.
+    chip could be ls1021a, ls1043a, ls1046a, ls2080a, ls2088a etc.
   - clocks: Input clock specifier. Refer to common clock bindings.
   - interrupts: Interrupt specifier. Refer to interrupt binding.
 
diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 66eb4b5..912fe32 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -53,6 +53,7 @@ enum ahci_qoriq_type {
 	AHCI_LS1043A,
 	AHCI_LS2080A,
 	AHCI_LS1046A,
+	AHCI_LS2088A,
 };
 
 struct ahci_qoriq_priv {
@@ -67,6 +68,7 @@ static const struct of_device_id ahci_qoriq_of_match[] = {
 	{ .compatible = "fsl,ls1043a-ahci", .data = (void *)AHCI_LS1043A},
 	{ .compatible = "fsl,ls2080a-ahci", .data = (void *)AHCI_LS2080A},
 	{ .compatible = "fsl,ls1046a-ahci", .data = (void *)AHCI_LS1046A},
+	{ .compatible = "fsl,ls2088a-ahci", .data = (void *)AHCI_LS2088A},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_qoriq_of_match);
@@ -193,6 +195,13 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		if (qpriv->is_dmacoherent)
 			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
 		break;
+
+	case AHCI_LS2088A:
+		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
+		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
+		if (qpriv->is_dmacoherent)
+			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
+		break;
 	}
 
 	return 0;
-- 
2.1.0.27.g96db324

