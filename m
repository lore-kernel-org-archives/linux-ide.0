From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH] sata: rcar_sata: Reset SATA PHY when Salvator-X board resumes
Date: Thu,  7 Dec 2017 03:45:25 +0900
Message-ID: <1512585925-4251-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>

Because power of Salvator-X board is cut off in suspend,
it needs to reset SATA PHY state in resume.
Otherwise, SATA partition could not be accessed anymore.

Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Signed-off-by: Hien Dang <hien.dang.eb@rvc.renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the for-next branch of libata tree.

 drivers/ata/sata_rcar.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 80ee2f2..aba6121 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -977,11 +977,43 @@ static int sata_rcar_resume(struct device *dev)
 	struct sata_rcar_priv *priv = host->private_data;
 	void __iomem *base = priv->base;
 	int ret;
+	u32 val;
 
 	ret = clk_prepare_enable(priv->clk);
 	if (ret)
 		return ret;
 
+	/* Re-use from sata_rcar_init_controller() */
+	/* reset and setup phy */
+	switch (priv->type) {
+	case RCAR_GEN1_SATA:
+		sata_rcar_gen1_phy_init(priv);
+		break;
+	case RCAR_GEN2_SATA:
+		sata_rcar_gen2_phy_init(priv);
+		break;
+	default:
+		dev_warn(host->dev, "SATA phy is not initialized\n");
+		break;
+	}
+
+	/* SATA-IP reset state */
+	val = ioread32(base + ATAPI_CONTROL1_REG);
+	val |= ATAPI_CONTROL1_RESET;
+	iowrite32(val, base + ATAPI_CONTROL1_REG);
+
+	/* ISM mode, PRD mode, DTEND flag at bit 0 */
+	val = ioread32(base + ATAPI_CONTROL1_REG);
+	val |= ATAPI_CONTROL1_ISM;
+	val |= ATAPI_CONTROL1_DESE;
+	val |= ATAPI_CONTROL1_DTA32M;
+	iowrite32(val, base + ATAPI_CONTROL1_REG);
+
+	/* Release the SATA-IP from the reset state */
+	val = ioread32(base + ATAPI_CONTROL1_REG);
+	val &= ~ATAPI_CONTROL1_RESET;
+	iowrite32(val, base + ATAPI_CONTROL1_REG);
+
 	/* ack and mask */
 	iowrite32(0, base + SATAINTSTAT_REG);
 	iowrite32(0x7ff, base + SATAINTMASK_REG);
-- 
1.9.1
