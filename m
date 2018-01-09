From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/3] phy: brcm-sata: Implementation calibrate callback
Date: Tue,  9 Jan 2018 15:04:56 -0800
Message-ID: <1515539097-26742-3-git-send-email-f.fainelli@gmail.com>
References: <1515539097-26742-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515539097-26742-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcm-kernel-feedback-list@broadcom.com
Cc: Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Heiko Stuebner <heiko@sntech.de>, Srinath Mannam <srinath.mannam@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Dan Carpenter <dan.carpenter@oracle.com>, "open list:LIBATA SUBSYSTEM Serial and
        Parallel ATA drivers" <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Implement the calibration callback to allow turning on the Clock-Data Recovery
module clamping when necessary.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-sata.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
index 3f953db70288..8000ce312d95 100644
--- a/drivers/phy/broadcom/phy-brcm-sata.c
+++ b/drivers/phy/broadcom/phy-brcm-sata.c
@@ -150,6 +150,9 @@ enum sata_phy_regs {
 	TXPMD_TX_FREQ_CTRL_CONTROL2_FMIN_MASK	= 0x3ff,
 	TXPMD_TX_FREQ_CTRL_CONTROL3		= 0x84,
 	TXPMD_TX_FREQ_CTRL_CONTROL3_FMAX_MASK	= 0x3ff,
+
+	RXPMD_REG_BANK				= 0x1c0,
+	RXPMD_RX_FREQ_MON_CONTROL1		= 0x87,
 };
 
 enum sata_phy_ctrl_regs {
@@ -505,8 +508,37 @@ static int brcm_sata_phy_init(struct phy *phy)
 	return rc;
 }
 
+static void brcm_stb_sata_calibrate(struct brcm_sata_port *port)
+{
+	void __iomem *base = brcm_sata_pcb_base(port);
+	struct brcm_sata_phy *priv = port->phy_priv;
+	u32 tmp = BIT(8);
+
+	brcm_sata_phy_wr(base, RXPMD_REG_BANK, RXPMD_RX_FREQ_MON_CONTROL1,
+			 ~tmp, tmp);
+}
+
+static int brcm_sata_phy_calibrate(struct phy *phy)
+{
+	struct brcm_sata_port *port = phy_get_drvdata(phy);
+	int rc = -EOPNOTSUPP;
+
+	switch (port->phy_priv->version) {
+	case BRCM_SATA_PHY_STB_28NM:
+	case BRCM_SATA_PHY_STB_40NM:
+		brcm_stb_sata_calibrate(port);
+		rc = 0;
+		break;
+	default:
+		break;
+	};
+
+	return rc;
+}
+
 static const struct phy_ops phy_ops = {
 	.init		= brcm_sata_phy_init,
+	.calibrate	= brcm_sata_phy_calibrate,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.7.4
