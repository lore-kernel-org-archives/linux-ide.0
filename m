From: <yuantian.tang@nxp.com>
Subject: [PATCH 3/3 v2] ahci: qoriq: added ls2088a platforms support
Date: Fri, 20 Jan 2017 14:59:36 +0800
Message-ID: <1484895576-40379-3-git-send-email-yuantian.tang@nxp.com>
References: <1484895576-40379-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn3nam01on0088.outbound.protection.outlook.com ([104.47.33.88]:26023
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751403AbdATHNI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 20 Jan 2017 02:13:08 -0500
In-Reply-To: <1484895576-40379-1-git-send-email-yuantian.tang@nxp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: mathieu.poirier@linaro.org, robin.murphy@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tang Yuantian <Yuantian.Tang@nxp.com>, Tang Yuantian <yuantian.tang@nxp.com>

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
v2:
  - no change

 drivers/ata/ahci_qoriq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 137b1c7..85d8332 100644
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
@@ -198,6 +200,13 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
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

