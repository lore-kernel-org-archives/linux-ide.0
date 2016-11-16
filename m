From: <yuantian.tang@nxp.com>
Subject: [PATCH 2/2] ahci: qoriq: report warning when ecc register is missing
Date: Wed, 16 Nov 2016 11:11:19 +0800
Message-ID: <1479265879-48840-2-git-send-email-yuantian.tang@nxp.com>
References: <1479265879-48840-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1479265879-48840-1-git-send-email-yuantian.tang@nxp.com>
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
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tang Yuantian <yuantian.tang@nxp.com>
List-Id: linux-ide@vger.kernel.org

From: Tang Yuantian <Yuantian.Tang@nxp.com>

For ls1021a and ls1046a socs, sata ecc must be disabled.
If ecc register is not found in sata node in dts, report
a warning.

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
 drivers/ata/ahci_qoriq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 45c88de..66eb4b5 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -158,6 +158,7 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 
 	switch (qpriv->type) {
 	case AHCI_LS1021A:
+		WARN_ON(!qpriv->ecc_addr);
 		writel(SATA_ECC_DISABLE, qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(LS1021A_PORT_PHY2, reg_base + PORT_PHY2);
@@ -185,6 +186,7 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		break;
 
 	case AHCI_LS1046A:
+		WARN_ON(!qpriv->ecc_addr);
 		writel(LS1046A_SATA_ECC_DIS, qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-- 
2.1.0.27.g96db324
