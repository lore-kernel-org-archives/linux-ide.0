From: Frans Pop <elendil@planet.nl>
Subject: [PATCH,v2][1/2] sata-mv: enable HDD led blinking when NCQ is active for GenIIe
Date: Wed, 11 Mar 2009 08:15:51 +0100
Message-ID: <200903110815.52650.elendil@planet.nl>
References: <200903110813.25650.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Cpsmtpm-eml109.kpnxchange.com ([195.121.3.13]:49709 "EHLO
	CPSMTPM-EML109.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751884AbZCKHPz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 03:15:55 -0400
In-Reply-To: <200903110813.25650.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm@vger.kernel.org
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

For some Marvell chips the HDD led does not blink when there is
disk I/O if NCQ is enabled. Add a quirk that enables blink mode for
the led when NCQ is used on any of the ports of a host controller.

The code to enable the blink mode is based on an earlier patch
proposed by Saeed Bishara.

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Mark Lord <liml@rtr.ca>
Cc: Saeed Bishara <saeed.bishara@gmail.com>

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 7007edd..4057647 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -205,6 +205,11 @@ enum {
 	HC_COAL_IRQ		= (1 << 4),	/* IRQ coalescing */
 	DEV_IRQ			= (1 << 8),	/* shift by port # */
 
+	IIE_LED_CTRL_OFS	= 0x2c,
+	IIE_LED_CTRL_BLINK	= (1 << 0),	/* Active LED blink */
+	IIE_LED_CTRL_ACT_PRESENCE = (1 << 2),	/* Multiplex presence with */
+						/* the active LED */
+
 	/* Shadow block registers */
 	SHD_BLK_OFS		= 0x100,
 	SHD_CTL_AST_OFS		= 0x20,		/* ofs from SHD_BLK_OFS */
@@ -359,6 +364,8 @@ enum {
 	MV_HP_PCIE		= (1 << 9),	/* PCIe bus/regs: 7042 */
 	MV_HP_CUT_THROUGH	= (1 << 10),	/* can use EDMA cut-through */
 	MV_HP_FLAG_SOC		= (1 << 11),	/* SystemOnChip, no PCI */
+	MV_HP_NCQ_LED_QUIRK	= (1 << 12),
+	MV_HP_LED_BL_EN		= (1 << 13),	/* is led blinking enabled? */
 
 	/* Port private flags (pp_flags) */
 	MV_PP_FLAG_EDMA_EN	= (1 << 0),	/* is EDMA engine enabled? */
@@ -480,11 +487,19 @@ struct mv_hw_ops {
 			   unsigned int port);
 	void (*enable_leds)(struct mv_host_priv *hpriv, void __iomem *mmio);
 	void (*read_preamp)(struct mv_host_priv *hpriv, int idx,
-			   void __iomem *mmio);
+			    void __iomem *mmio);
 	int (*reset_hc)(struct mv_host_priv *hpriv, void __iomem *mmio,
 			unsigned int n_hc);
 	void (*reset_flash)(struct mv_host_priv *hpriv, void __iomem *mmio);
 	void (*reset_bus)(struct ata_host *host, void __iomem *mmio);
+	void (*enable_led_blink)(struct mv_host_priv *hpriv,
+				 void __iomem *mmio, int enable_blink);
+
+	/*
+	 * ->inherits must be the last field and all the preceding
+	 * fields must be pointers.
+	 */
+	const struct mv_hw_ops	*inherits;
 };
 
 static int mv_scr_read(struct ata_link *link, unsigned int sc_reg_in, u32 *val);
@@ -530,6 +545,8 @@ static int mv_soc_reset_hc(struct mv_host_priv *hpriv,
 static void mv_soc_reset_flash(struct mv_host_priv *hpriv,
 				      void __iomem *mmio);
 static void mv_soc_reset_bus(struct ata_host *host, void __iomem *mmio);
+static void mv_iie_enable_led_blink(struct mv_host_priv *hpriv,
+					void __iomem *mmio, int enable_blink);
 static void mv_reset_pci_bus(struct ata_host *host, void __iomem *mmio);
 static void mv_reset_channel(struct mv_host_priv *hpriv, void __iomem *mmio,
 			     unsigned int port_no);
@@ -705,6 +722,11 @@ static const struct mv_hw_ops mv6xxx_ops = {
 	.reset_bus		= mv_reset_pci_bus,
 };
 
+static const struct mv_hw_ops mv6xxx_iie_ops = {
+	.inherits		= &mv6xxx_ops,
+	.enable_led_blink	= mv_iie_enable_led_blink,
+};
+
 static const struct mv_hw_ops mv_soc_ops = {
 	.phy_errata		= mv6_phy_errata,
 	.enable_leds		= mv_soc_enable_leds,
@@ -712,6 +734,7 @@ static const struct mv_hw_ops mv_soc_ops = {
 	.reset_hc		= mv_soc_reset_hc,
 	.reset_flash		= mv_soc_reset_flash,
 	.reset_bus		= mv_soc_reset_bus,
+	.enable_led_blink	= mv_iie_enable_led_blink,
 };
 
 /*
@@ -852,6 +875,55 @@ static void mv_enable_port_irqs(struct ata_port *ap,
 	mv_set_main_irq_mask(ap->host, disable_bits, enable_bits);
 }
 
+static int mv_has_port_using_ncq(struct ata_host *host)
+{
+	int port;
+	struct mv_host_priv *hpriv = host->private_data;
+
+	for (port = 0; port < hpriv->n_ports; port++) {
+		struct ata_port *ap = host->ports[port];
+		struct mv_port_priv *pp = ap->private_data;
+
+		if ((pp->pp_flags & MV_PP_FLAG_EDMA_EN) &&
+		    (pp->pp_flags & MV_PP_FLAG_NCQ_EN))
+			return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * Some chips have an erratum which causes the HDD led not to blink
+ * during I/O when NCQ is enabled. Enabling the blink mode of the
+ * led makes activity visible in that case.
+ */
+static void mv_quirk_blink_led_when_ncq(struct ata_port *ap,
+					int enable)
+{
+	struct mv_host_priv *hpriv = ap->host->private_data;
+	void __iomem *mmio = hpriv->base;
+
+	if (!hpriv->ops->enable_led_blink)
+		return;
+
+	if (enable) {
+		if (!(hpriv->hp_flags & MV_HP_LED_BL_EN)) {
+			hpriv->ops->enable_led_blink(hpriv, mmio, true);
+			hpriv->hp_flags |= MV_HP_LED_BL_EN;
+		}
+		return;
+	} else {
+		if (!(hpriv->hp_flags & MV_HP_LED_BL_EN))
+			return;
+	}
+
+	/* Does any other port still use NCQ? */
+	if (!mv_has_port_using_ncq(ap->host)) {
+		hpriv->ops->enable_led_blink(hpriv, mmio, false);
+		hpriv->hp_flags &= ~MV_HP_LED_BL_EN;
+	}
+}
+
 /**
  *      mv_start_dma - Enable eDMA engine
  *      @base: port base address
@@ -952,6 +1024,7 @@ static int mv_stop_edma(struct ata_port *ap)
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct mv_port_priv *pp = ap->private_data;
+	struct mv_host_priv *hpriv = ap->host->private_data;
 
 	if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN))
 		return 0;
@@ -961,6 +1034,10 @@ static int mv_stop_edma(struct ata_port *ap)
 		ata_port_printk(ap, KERN_ERR, "Unable to stop eDMA\n");
 		return -EIO;
 	}
+
+	if (hpriv->hp_flags & MV_HP_NCQ_LED_QUIRK)
+		mv_quirk_blink_led_when_ncq(ap, false);
+
 	return 0;
 }
 
@@ -1222,6 +1299,9 @@ static void mv_edma_cfg(struct ata_port *ap, int want_ncq)
 	}
 
 	if (want_ncq) {
+		if (hpriv->hp_flags & MV_HP_NCQ_LED_QUIRK)
+			mv_quirk_blink_led_when_ncq(ap, true);
+
 		cfg |= EDMA_CFG_NCQ;
 		pp->pp_flags |=  MV_PP_FLAG_NCQ_EN;
 	} else
@@ -2690,6 +2770,19 @@ static void mv_soc_reset_bus(struct ata_host *host, void __iomem *mmio)
 	return;
 }
 
+static void mv_iie_enable_led_blink(struct mv_host_priv *hpriv,
+				      void __iomem *mmio, int enable_blink)
+{
+	void __iomem *hc_mmio = mv_hc_base(mmio, 0);
+	u32 tmp = readl(hc_mmio + IIE_LED_CTRL_OFS);
+
+	/* enable/disable blinking mode */
+	if (enable_blink)
+		writel(tmp | IIE_LED_CTRL_BLINK, hc_mmio + IIE_LED_CTRL_OFS);
+	else
+		writel(tmp & ~IIE_LED_CTRL_BLINK, hc_mmio + IIE_LED_CTRL_OFS);
+}
+
 static void mv_setup_ifcfg(void __iomem *port_mmio, int want_gen2i)
 {
 	u32 ifcfg = readl(port_mmio + SATA_INTERFACE_CFG_OFS);
@@ -2997,8 +3090,8 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
 		}
 		/* drop through */
 	case chip_6042:
-		hpriv->ops = &mv6xxx_ops;
-		hp_flags |= MV_HP_GEN_IIE;
+		hpriv->ops = &mv6xxx_iie_ops;
+		hp_flags |= MV_HP_GEN_IIE | MV_HP_NCQ_LED_QUIRK;
 		if (board_idx == chip_6042 && mv_pci_cut_through_okay(host))
 			hp_flags |= MV_HP_CUT_THROUGH;
 
@@ -3016,7 +3109,7 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
 	case chip_soc:
 		hpriv->ops = &mv_soc_ops;
 		hp_flags |= MV_HP_FLAG_SOC | MV_HP_GEN_IIE |
-			MV_HP_ERRATA_60X1C0;
+			MV_HP_ERRATA_60X1C0 | MV_HP_NCQ_LED_QUIRK;
 		break;
 
 	default:
