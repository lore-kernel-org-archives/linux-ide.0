From: <yuantian.tang@nxp.com>
Subject: [PATCH 1/3 v2] ahci: qoriq: added a condition to enable dma coherence
Date: Fri, 20 Jan 2017 14:59:34 +0800
Message-ID: <1484895576-40379-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: mathieu.poirier@linaro.org, robin.murphy@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tang Yuantian <Yuantian.Tang@nxp.com>, Tang Yuantian <yuantian.tang@nxp.com>
List-Id: linux-ide@vger.kernel.org

From: Tang Yuantian <Yuantian.Tang@nxp.com>

Enable DMA coherence in SATA controller on condition that
dma-coherent property exists in sata node in DTS.

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
v2:
  - use of_dma_is_coherent() instead of open-coding.

 drivers/ata/ahci_qoriq.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 9884c8c..01ef662 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -59,6 +59,7 @@ struct ahci_qoriq_priv {
 	struct ccsr_ahci *reg_base;
 	enum ahci_qoriq_type type;
 	void __iomem *ecc_addr;
+	bool is_dmacoherent;
 };
 
 static const struct of_device_id ahci_qoriq_of_match[] = {
@@ -164,26 +165,31 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		writel(LS1021A_PORT_PHY4, reg_base + PORT_PHY4);
 		writel(LS1021A_PORT_PHY5, reg_base + PORT_PHY5);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-		writel(AHCI_PORT_AXICC_CFG, reg_base + LS1021A_AXICC_ADDR);
+		if (qpriv->is_dmacoherent)
+			writel(AHCI_PORT_AXICC_CFG,
+					reg_base + LS1021A_AXICC_ADDR);
 		break;
 
 	case AHCI_LS1043A:
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-		writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
+		if (qpriv->is_dmacoherent)
+			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
 		break;
 
 	case AHCI_LS2080A:
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-		writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
+		if (qpriv->is_dmacoherent)
+			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
 		break;
 
 	case AHCI_LS1046A:
 		writel(LS1046A_SATA_ECC_DIS, qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-		writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
+		if (qpriv->is_dmacoherent)
+			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
 		break;
 	}
 
@@ -221,6 +227,7 @@ static int ahci_qoriq_probe(struct platform_device *pdev)
 		if (IS_ERR(qoriq_priv->ecc_addr))
 			return PTR_ERR(qoriq_priv->ecc_addr);
 	}
+	qoriq_priv->is_dmacoherent = of_dma_is_coherent(np);
 
 	rc = ahci_platform_enable_resources(hpriv);
 	if (rc)
-- 
2.1.0.27.g96db324
