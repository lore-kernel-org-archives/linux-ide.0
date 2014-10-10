From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH] ata: sata_rcar: Add DIPM mode disabling workaround
Date: Fri, 10 Oct 2014 17:45:03 +0900
Message-ID: <1412930703-24976-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:45848 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbaJJIp0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Oct 2014 04:45:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

This workaround must be applied to R8A7790(H2) ES1

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is against for-next branch of Tejun's libata repo.

 drivers/ata/sata_rcar.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 61eb6d7..0ba5974 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -143,6 +143,11 @@
 #define RCAR_GEN2_PHY_CTL5_DC		BIT(1)	/* DC connection */
 #define RCAR_GEN2_PHY_CTL5_TR		BIT(2)	/* Termination Resistor */
 
+/* Product Register */
+#define PRODUCT_REGISTER		0xFF000044
+#define PRODUCT_CUT_MASK		0x00007FF0
+#define PRODUCT_H2_BIT			(0x45 << 8)
+
 enum sata_rcar_type {
 	RCAR_GEN1_SATA,
 	RCAR_GEN2_SATA,
@@ -751,18 +756,30 @@ done:
 	return IRQ_RETVAL(handled);
 }
 
-static void sata_rcar_setup_port(struct ata_host *host)
+static int sata_rcar_setup_port(struct ata_host *host)
 {
 	struct ata_port *ap = host->ports[0];
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	struct sata_rcar_priv *priv = host->private_data;
 	void __iomem *base = priv->base;
+	void __iomem *product_reg;
 
 	ap->ops		= &sata_rcar_port_ops;
 	ap->pio_mask	= ATA_PIO4;
 	ap->udma_mask	= ATA_UDMA6;
 	ap->flags	|= ATA_FLAG_SATA;
 
+	product_reg = ioremap_nocache(PRODUCT_REGISTER, 0x04);
+	if (!product_reg) {
+		dev_warn(host->dev, "ioremap fail\n");
+		return -ENOMEM;
+	}
+	/* Add the workaround of DIPM mode disabling in R-Car H2 ES1.x.*/
+	if ((readl(product_reg) & PRODUCT_CUT_MASK) == PRODUCT_H2_BIT)
+		ap->flags |= ATA_FLAG_NO_DIPM;
+
+	iounmap(product_reg);
+
 	ioaddr->cmd_addr = base + SDATA_REG;
 	ioaddr->ctl_addr = base + SSDEVCON_REG;
 	ioaddr->scr_addr = base + SCRSSTS_REG;
@@ -778,6 +795,8 @@ static void sata_rcar_setup_port(struct ata_host *host)
 	ioaddr->device_addr	= ioaddr->cmd_addr + (ATA_REG_DEVICE << 2);
 	ioaddr->status_addr	= ioaddr->cmd_addr + (ATA_REG_STATUS << 2);
 	ioaddr->command_addr	= ioaddr->cmd_addr + (ATA_REG_CMD << 2);
+
+	return 0;
 }
 
 static void sata_rcar_init_controller(struct ata_host *host)
@@ -902,7 +921,9 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	}
 
 	/* setup port */
-	sata_rcar_setup_port(host);
+	ret = sata_rcar_setup_port(host);
+	if (ret)
+		goto cleanup;
 
 	/* initialize host controller */
 	sata_rcar_init_controller(host);
-- 
1.9.1

