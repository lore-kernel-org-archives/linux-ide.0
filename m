From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: [PATCH] sata_mv: use new sata phy register settings for new
	devices
Date: Wed, 22 Apr 2009 13:44:10 +0300
Message-ID: <c70ff3ad0904220344x2e2d9ffat2285c76e0ab437c5@mail.gmail.com>
References: <20090411160809.GA10922@deprecation.cyrius.com>
	 <da824cf30904111502u50d8f55dj2d0414bb45a49a22@mail.gmail.com>
	 <c70ff3ad0904130026r4aac1ef4le36175ecdfed581c@mail.gmail.com>
	 <49E2EAEC.5030606@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:46485 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbZDVKoM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Apr 2009 06:44:12 -0400
Received: by fxm2 with SMTP id 2so3023316fxm.37
        for <linux-ide@vger.kernel.org>; Wed, 22 Apr 2009 03:44:10 -0700 (PDT)
In-Reply-To: <49E2EAEC.5030606@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Grant Grundler <grundler@google.com>, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Martin Michlmayr <tbm@cyrius.com>

Here the patch with names constants:
To: Mark Lord <liml@rtr.ca>
Cc: Martin Michlmayr <tbm@cyrius.com>, linux-ide@vger.kernel.org
Subject: [PATCH] sata_mv: use new sata phy register settings for new devices

Marvell's new SoC (65 nano) needs different settings for its SATA
PHY registers.

Tested-by: Martin Michlmayr <tbm@cyrius.com>
Signed-off-by: Saeed Bishara <saeed@marvell.com>


--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -293,6 +293,10 @@ enum {
 	FISCFG_WAIT_DEV_ERR	= (1 << 8),	/* wait for host on DevErr */
 	FISCFG_SINGLE_SYNC	= (1 << 16),	/* SYNC on DMA activation */

+	PHY_MODE9_GEN2		= 0x398,
+	PHY_MODE9_GEN1		= 0x39c,
+	PHYCFG_OFS		= 0x3a0,	/* only in 65n devices */
+
 	MV5_PHY_MODE		= 0x74,
 	MV5_LTMODE		= 0x30,
 	MV5_PHY_CTL		= 0x0C,
@@ -609,6 +613,8 @@ static int mv_soc_reset_hc(struct mv_host_priv *hpriv,
 static void mv_soc_reset_flash(struct mv_host_priv *hpriv,
 				      void __iomem *mmio);
 static void mv_soc_reset_bus(struct ata_host *host, void __iomem *mmio);
+static void mv_soc_65n_phy_errata(struct mv_host_priv *hpriv,
+				  void __iomem *mmio, unsigned int port);
 static void mv_reset_pci_bus(struct ata_host *host, void __iomem *mmio);
 static void mv_reset_channel(struct mv_host_priv *hpriv, void __iomem *mmio,
 			     unsigned int port_no);
@@ -807,6 +813,14 @@ static const struct mv_hw_ops mv_soc_ops = {
 	.reset_bus		= mv_soc_reset_bus,
 };

+static const struct mv_hw_ops mv_soc_65n_ops = {
+	.phy_errata		= mv_soc_65n_phy_errata,
+	.enable_leds		= mv_soc_enable_leds,
+	.reset_hc		= mv_soc_reset_hc,
+	.reset_flash		= mv_soc_reset_flash,
+	.reset_bus		= mv_soc_reset_bus,
+};
+
 /*
  * Functions
  */
@@ -3359,6 +3373,53 @@ static void mv_soc_reset_bus(struct ata_host
*host, void __iomem *mmio)
 	return;
 }

+static void mv_soc_65n_phy_errata(struct mv_host_priv *hpriv,
+				  void __iomem *mmio, unsigned int port)
+{
+	void __iomem *port_mmio = mv_port_base(mmio, port);
+	u32	reg;
+
+	reg = readl(port_mmio + PHY_MODE3);
+	reg &= ~(0x3 << 27);	/* SELMUPF (bits 28:27) to 1 */
+	reg |= (0x1 << 27);
+	reg &= ~(0x3 << 29);	/* SELMUPI (bits 30:29) to 1 */
+	reg |= (0x1 << 29);
+	writel(reg, port_mmio + PHY_MODE3);
+
+	reg = readl(port_mmio + PHY_MODE4);
+	reg &= ~0x1;	/* SATU_OD8 (bit 0) to 0, reserved bit 16 must be set */
+	reg |= (0x1 << 16);
+	writel(reg, port_mmio + PHY_MODE4);
+
+	reg = readl(port_mmio + PHY_MODE9_GEN2);
+	reg &= ~0xf;	/* TXAMP[3:0] (bits 3:0) to 8 */
+	reg |= 0x8;
+	reg &= ~(0x1 << 14);	/* TXAMP[4] (bit 14) to 0 */
+	writel(reg, port_mmio + PHY_MODE9_GEN2);
+
+	reg = readl(port_mmio + PHY_MODE9_GEN1);
+	reg &= ~0xf;	/* TXAMP[3:0] (bits 3:0) to 8 */
+	reg |= 0x8;
+	reg &= ~(0x1 << 14);	/* TXAMP[4] (bit 14) to 0 */
+	writel(reg, port_mmio + PHY_MODE9_GEN1);
+}
+
+/**
+ *	soc_is_65 - check if the soc is 65 nano device
+ *
+ *	Detect the type of the SoC, this is done by reading the PHYCFG_OFS
+ *	register, this register should contain non-zero value and it exists only
+ *	in the 65 nano devices, when reading it from older devices we get 0.
+ */
+static bool soc_is_65n(struct mv_host_priv *hpriv)
+{
+	void __iomem *port0_mmio = mv_port_base(hpriv->base, 0);
+
+	if (readl(port0_mmio + PHYCFG_OFS))
+		return true;
+	return false;
+}
+
 static void mv_setup_ifcfg(void __iomem *port_mmio, int want_gen2i)
 {
 	u32 ifcfg = readl(port_mmio + SATA_IFCFG);
@@ -3699,7 +3760,10 @@ static int mv_chip_id(struct ata_host *host,
unsigned int board_idx)
 		}
 		break;
 	case chip_soc:
-		hpriv->ops = &mv_soc_ops;
+		if (soc_is_65n(hpriv))
+			hpriv->ops = &mv_soc_65n_ops;
+		else
+			hpriv->ops = &mv_soc_ops;
 		hp_flags |= MV_HP_FLAG_SOC | MV_HP_GEN_IIE |
 			MV_HP_ERRATA_60X1C0;
 		break;
@@ -3762,7 +3826,8 @@ static int mv_init_host(struct ata_host *host,
unsigned int board_idx)
 	n_hc = mv_get_hc_count(host->ports[0]->flags);

 	for (port = 0; port < host->n_ports; port++)
-		hpriv->ops->read_preamp(hpriv, port, mmio);
+		if (hpriv->ops->read_preamp)
+			hpriv->ops->read_preamp(hpriv, port, mmio);

 	rc = hpriv->ops->reset_hc(hpriv, mmio, n_hc);
 	if (rc)
