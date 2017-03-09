From: Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH] ahci: qoriq: correct the sata ecc setting error
Date: Thu, 9 Mar 2017 17:13:29 +0800
Message-ID: <1489050809-15265-1-git-send-email-andy.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Sata ecc is controlled by only 1 bit which is 24bit in big-endian
in ecc register. So only setting 24bit to disable sata ecc prevents
other bits from being overwritten in ecc register.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 drivers/ata/ahci_qoriq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 85d8332..4c96f3a 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -177,7 +177,8 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 	case AHCI_LS1043A:
 		if (!qpriv->ecc_addr)
 			return -EINVAL;
-		writel(ECC_DIS_ARMV8_CH2, qpriv->ecc_addr);
+		writel(readl(qpriv->ecc_addr) | ECC_DIS_ARMV8_CH2,
+				qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
 		if (qpriv->is_dmacoherent)
@@ -194,7 +195,8 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 	case AHCI_LS1046A:
 		if (!qpriv->ecc_addr)
 			return -EINVAL;
-		writel(ECC_DIS_ARMV8_CH2, qpriv->ecc_addr);
+		writel(readl(qpriv->ecc_addr) | ECC_DIS_ARMV8_CH2,
+				qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
 		if (qpriv->is_dmacoherent)
-- 
2.1.0.27.g96db324
