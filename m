From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH/RFT v3] sata_rcar: Reset SATA PHY when Salvator-X board resumes
Date: Mon,  5 Feb 2018 04:18:51 +0900
Message-ID: <1517771931-17157-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41898 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeBDTT2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 4 Feb 2018 14:19:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>

Because power of Salvator-X board is cut off in suspend,
it needs to reset SATA PHY state in resume.
Otherwise, SATA partition could not be accessed anymore.

Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Signed-off-by: Hien Dang <hien.dang.eb@rvc.renesas.com>
[reinit phy in sata_rcar_resume() function on R-Car Gen3 only]
[factor out SATA module init sequence]
[fixed the prefix for the subject]
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---
 drivers/ata/sata_rcar.c | 63 +++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 23 deletions(-)

This patch is based on the for-next branch of libata tree.

v2 [Yoshihiro Kaneko]
* reinit phy on R-Car Gen3 only as suggested by Geert Uytterhoeven
* use "sata_rcar" prefix for the subject as suggested by Sergei Shtylyov

v3 [Yoshihiro Kaneko]
* As suggested by Sergei Shtylyov
  - factored out the common part of the initialising SATA module
  - remove the redundant "sata:" prefix from the subject

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 80ee2f2..6f47ca3 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -146,6 +146,7 @@
 enum sata_rcar_type {
 	RCAR_GEN1_SATA,
 	RCAR_GEN2_SATA,
+	RCAR_GEN3_SATA,
 	RCAR_R8A7790_ES1_SATA,
 };
 
@@ -784,26 +785,11 @@ static void sata_rcar_setup_port(struct ata_host *host)
 	ioaddr->command_addr	= ioaddr->cmd_addr + (ATA_REG_CMD << 2);
 }
 
-static void sata_rcar_init_controller(struct ata_host *host)
+static void sata_rcar_init_module(struct sata_rcar_priv *priv)
 {
-	struct sata_rcar_priv *priv = host->private_data;
 	void __iomem *base = priv->base;
 	u32 val;
 
-	/* reset and setup phy */
-	switch (priv->type) {
-	case RCAR_GEN1_SATA:
-		sata_rcar_gen1_phy_init(priv);
-		break;
-	case RCAR_GEN2_SATA:
-	case RCAR_R8A7790_ES1_SATA:
-		sata_rcar_gen2_phy_init(priv);
-		break;
-	default:
-		dev_warn(host->dev, "SATA phy is not initialized\n");
-		break;
-	}
-
 	/* SATA-IP reset state */
 	val = ioread32(base + ATAPI_CONTROL1_REG);
 	val |= ATAPI_CONTROL1_RESET;
@@ -824,10 +810,34 @@ static void sata_rcar_init_controller(struct ata_host *host)
 	/* ack and mask */
 	iowrite32(0, base + SATAINTSTAT_REG);
 	iowrite32(0x7ff, base + SATAINTMASK_REG);
+
 	/* enable interrupts */
 	iowrite32(ATAPI_INT_ENABLE_SATAINT, base + ATAPI_INT_ENABLE_REG);
 }
 
+static void sata_rcar_init_controller(struct ata_host *host)
+{
+	struct sata_rcar_priv *priv = host->private_data;
+	void __iomem *base = priv->base;
+
+	/* reset and setup phy */
+	switch (priv->type) {
+	case RCAR_GEN1_SATA:
+		sata_rcar_gen1_phy_init(priv);
+		break;
+	case RCAR_GEN2_SATA:
+	case RCAR_GEN3_SATA:
+	case RCAR_R8A7790_ES1_SATA:
+		sata_rcar_gen2_phy_init(priv);
+		break;
+	default:
+		dev_warn(host->dev, "SATA phy is not initialized\n");
+		break;
+	}
+
+	sata_rcar_init_module(priv);
+}
+
 static const struct of_device_id sata_rcar_match[] = {
 	{
 		/* Deprecated by "renesas,sata-r8a7779" */
@@ -856,7 +866,7 @@ static void sata_rcar_init_controller(struct ata_host *host)
 	},
 	{
 		.compatible = "renesas,sata-r8a7795",
-		.data = (void *)RCAR_GEN2_SATA
+		.data = (void *)RCAR_GEN3_SATA
 	},
 	{
 		.compatible = "renesas,rcar-gen2-sata",
@@ -864,7 +874,7 @@ static void sata_rcar_init_controller(struct ata_host *host)
 	},
 	{
 		.compatible = "renesas,rcar-gen3-sata",
-		.data = (void *)RCAR_GEN2_SATA
+		.data = (void *)RCAR_GEN3_SATA
 	},
 	{ },
 };
@@ -982,11 +992,18 @@ static int sata_rcar_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	/* ack and mask */
-	iowrite32(0, base + SATAINTSTAT_REG);
-	iowrite32(0x7ff, base + SATAINTMASK_REG);
-	/* enable interrupts */
-	iowrite32(ATAPI_INT_ENABLE_SATAINT, base + ATAPI_INT_ENABLE_REG);
+	if (priv->type == RCAR_GEN3_SATA) {
+		sata_rcar_gen2_phy_init(priv);
+		sata_rcar_init_module(priv);
+	} else {
+		/* ack and mask */
+		iowrite32(0, base + SATAINTSTAT_REG);
+		iowrite32(0x7ff, base + SATAINTMASK_REG);
+
+		/* enable interrupts */
+		iowrite32(ATAPI_INT_ENABLE_SATAINT,
+			  base + ATAPI_INT_ENABLE_REG);
+	}
 
 	ata_host_resume(host);
 
-- 
1.9.1

