From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH,v2][1/2] sata-mv: enable HDD led blinking when NCQ is
 active for GenIIe
Date: Thu, 12 Mar 2009 10:26:14 -0400
Message-ID: <49B91B86.7070309@rtr.ca>
References: <200903110813.25650.elendil@planet.nl> <200903111408.37298.elendil@planet.nl> <49B7C782.9070004@rtr.ca> <200903121240.55194.elendil@planet.nl> <49B918D1.7020407@rtr.ca> <49B918F7.2060401@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:58377 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753815AbZCLO0S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Mar 2009 10:26:18 -0400
In-Reply-To: <49B918F7.2060401@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

Mark Lord wrote:
..
> Or rather, exactly *how* did you "disable NCQ" ?
..

And after you answer that, then does this revised patch work?
If not, then perhaps you could try and figure out why,
since I just don't have your hardware available to me here.

Thanks

--- old/drivers/ata/sata_mv.c	2009-03-11 00:50:48.000000000 -0400
+++ new/drivers/ata/sata_mv.c	2009-03-11 10:13:29.000000000 -0400
@@ -251,6 +251,11 @@
 	HC_IRQ_COAL_IO_THRESHOLD_OFS	= 0x000c,
 	HC_IRQ_COAL_TIME_THRESHOLD_OFS	= 0x0010,
 
+	SOC_LED_CTRL_OFS	= 0x2c,
+	SOC_LED_CTRL_BLINK	= (1 << 0),	/* Active LED blink */
+	SOC_LED_CTRL_ACT_PRESENCE = (1 << 2),	/* Multiplex dev presence */
+						/*  with dev activity LED */
+
 	/* Shadow block registers */
 	SHD_BLK_OFS		= 0x100,
 	SHD_CTL_AST_OFS		= 0x20,		/* ofs from SHD_BLK_OFS */
@@ -411,6 +416,7 @@
 	MV_HP_PCIE		= (1 << 9),	/* PCIe bus/regs: 7042 */
 	MV_HP_CUT_THROUGH	= (1 << 10),	/* can use EDMA cut-through */
 	MV_HP_FLAG_SOC		= (1 << 11),	/* SystemOnChip, no PCI */
+	MV_HP_QUIRK_LED_BLINK_EN = (1 << 12),	/* is led blinking enabled? */
 
 	/* Port private flags (pp_flags) */
 	MV_PP_FLAG_EDMA_EN	= (1 << 0),	/* is EDMA engine enabled? */
@@ -1404,6 +1410,62 @@
 	mv_write_cached_reg(mv_ap_base(ap) + EDMA_UNKNOWN_RSVD_OFS, old, new);
 }
 
+/*
+ * SOC chips have an issue whereby the HDD LEDs don't always blink
+ * during I/O when NCQ is enabled. Enabling a special "LED blink" mode
+ * of the SOC takes care of it, generating a steady blink rate when
+ * any drive on the chip is active.
+ *
+ * Unfortunately, the blink mode is a global hardware setting for the SOC,
+ * so we must use it whenever at least one port on the SOC has NCQ enabled.
+ *
+ * We turn "LED blink" off when NCQ is not in use anywhere, because the normal
+ * LED operation works then, and provides better (more accurate) feedback.
+ *
+ * Note that this code assumes that an SOC never has more than one HC onboard.
+ */
+static void mv_soc_led_blink_enable(struct ata_port *ap)
+{
+	struct ata_host *host = ap->host;
+	struct mv_host_priv *hpriv = host->private_data;
+	void __iomem *hc_mmio;
+	u32 led_ctrl;
+
+	if (hpriv->hp_flags & MV_HP_QUIRK_LED_BLINK_EN)
+		return;
+	hpriv->hp_flags |= MV_HP_QUIRK_LED_BLINK_EN;
+	hc_mmio = mv_hc_base_from_port(mv_host_base(host), ap->port_no);
+	led_ctrl = readl(hc_mmio + SOC_LED_CTRL_OFS);
+	writel(led_ctrl | SOC_LED_CTRL_BLINK, hc_mmio + SOC_LED_CTRL_OFS);
+}
+
+static void mv_soc_led_blink_disable(struct ata_port *ap)
+{
+	struct ata_host *host = ap->host;
+	struct mv_host_priv *hpriv = host->private_data;
+	void __iomem *hc_mmio;
+	u32 led_ctrl;
+	unsigned int port;
+
+	if (!(hpriv->hp_flags & MV_HP_QUIRK_LED_BLINK_EN))
+		return;
+
+	/* disable led-blink only if no ports are using NCQ */
+	for (port = 0; port < hpriv->n_ports; port++) {
+		struct ata_port *this_ap = host->ports[port];
+		struct mv_port_priv *pp = this_ap->private_data;
+
+		if (pp->pp_flags & MV_PP_FLAG_EDMA_EN)
+			if (pp->pp_flags & MV_PP_FLAG_NCQ_EN)
+				return;
+	}
+
+	hpriv->hp_flags &= ~MV_HP_QUIRK_LED_BLINK_EN;
+	hc_mmio = mv_hc_base_from_port(mv_host_base(host), ap->port_no);
+	led_ctrl = readl(hc_mmio + SOC_LED_CTRL_OFS);
+	writel(led_ctrl & ~SOC_LED_CTRL_BLINK, hc_mmio + SOC_LED_CTRL_OFS);
+}
+
 static void mv_edma_cfg(struct ata_port *ap, int want_ncq, int want_edma)
 {
 	u32 cfg;
@@ -1451,6 +1513,13 @@
 		if (hpriv->hp_flags & MV_HP_CUT_THROUGH)
 			cfg |= (1 << 17); /* enab cut-thru (dis stor&forwrd) */
 		mv_bmdma_enable_iie(ap, !want_edma);
+
+		if (IS_SOC(hpriv)) {
+			if (want_ncq)
+				mv_soc_led_blink_enable(ap);
+			else
+				mv_soc_led_blink_disable(ap);
+		}
 	}
 
 	if (want_ncq) {
