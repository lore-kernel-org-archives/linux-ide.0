From: <yuantian.tang@nxp.com>
Subject: [PATCH 2/3 v2] ahci: qoriq: report error when ecc register address is missing in dts
Date: Fri, 20 Jan 2017 14:59:35 +0800
Message-ID: <1484895576-40379-2-git-send-email-yuantian.tang@nxp.com>
References: <1484895576-40379-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484895576-40379-1-git-send-email-yuantian.tang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: mathieu.poirier@linaro.org, robin.murphy@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tang Yuantian <Yuantian.Tang@nxp.com>, Tang Yuantian <yuantian.tang@nxp.com>
List-Id: linux-ide@vger.kernel.org

From: Tang Yuantian <Yuantian.Tang@nxp.com>

For ls1021a, and armv8 chasis 2 socs, sata ecc must be disabled.
If ecc register is not found in sata node in dts, report error.

This is a chip erratum described as bellow:
The Read DMA operations get early termination indication from the
controller. This issue is observed as CRC error in the status registers.
The issue is due to address collision at address 0 in the dual port
memory. The read is a dummy read to flush out the header, but due to
collision the controller logs the mbit error reported by the ECC check
logic. This results in the early termination of the Read DMA operation
by the controller. The issue happens to all the interface
speeds(GEN1/2/3) for all the products.

Workaround:
Disable ECC feature on those platforms.

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
v2:
  - refine the title and description
  - change reporting warning to reporting error

 drivers/ata/ahci_qoriq.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 01ef662..137b1c7 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -46,7 +46,7 @@
 #define LS1021A_AXICC_ADDR	0xC0
 
 #define SATA_ECC_DISABLE	0x00020000
-#define LS1046A_SATA_ECC_DIS	0x80000000
+#define ECC_DIS_ARMV8_CH2	0x80000000
 
 enum ahci_qoriq_type {
 	AHCI_LS1021A,
@@ -158,6 +158,8 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 
 	switch (qpriv->type) {
 	case AHCI_LS1021A:
+		if (!qpriv->ecc_addr)
+			return -EINVAL;
 		writel(SATA_ECC_DISABLE, qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(LS1021A_PORT_PHY2, reg_base + PORT_PHY2);
@@ -171,6 +173,9 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		break;
 
 	case AHCI_LS1043A:
+		if (!qpriv->ecc_addr)
+			return -EINVAL;
+		writel(ECC_DIS_ARMV8_CH2, qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
 		if (qpriv->is_dmacoherent)
@@ -185,7 +190,9 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		break;
 
 	case AHCI_LS1046A:
-		writel(LS1046A_SATA_ECC_DIS, qpriv->ecc_addr);
+		if (!qpriv->ecc_addr)
+			return -EINVAL;
+		writel(ECC_DIS_ARMV8_CH2, qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
 		if (qpriv->is_dmacoherent)
-- 
2.1.0.27.g96db324
