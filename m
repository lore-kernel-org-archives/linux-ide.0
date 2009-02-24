From: Frans Pop <elendil@planet.nl>
Subject: [RFC][PATCH] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Tue, 24 Feb 2009 09:33:43 +0100
Message-ID: <200902240933.45874.elendil@planet.nl>
References: <200808261124.39282.elendil@planet.nl> <200808261225.46315.elendil@planet.nl> <497B2C60.60608@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpo-eml04.KPNXCHANGE.COM ([213.75.38.153]:56562 "EHLO
	cpsmtpo-eml04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752803AbZBXIdu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Feb 2009 03:33:50 -0500
In-Reply-To: <497B2C60.60608@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

On Saturday 24 January 2009, Mark Lord wrote:
> Frans Pop wrote:
> > So somehow enabling NCQ is at the root of the issue.
>
> Pardon me digging up this old thread again,
> but I'm back working on sata_mv now.

No problem. I've only recently picked up on this issue again myself.

> There is a reported chipset errata for *exactly* this symptom,
> though the errata is supposedly for the older 6041/6081 variants.
> But it is possible that the same problem still exists in the
> chip you are using there (SOC, right?).

Correct.

> The problem is exactly as you described it:  turning on NCQ
> causes the activity LEDs to remain on constantly.
> No known workaround or fix is available from Marvell,
> so "just live with it" is the only solution.  :)

Well, the attached patch works for me on my QNAP TS-109. It's based on an
earlier patch proposed by Saeed Bishara to unconditionally enable blink
mode for the led for SOC.

The attached patch adds a quirk for SOC that enables the blink mode as
needed when there's at least one port on a host controller for which NCQ
is enabled. 

In the blink mode the led is not as responsive as when NCQ is disabled,
but at least it does show when there is I/O. If I disable NCQ by setting
queue_depth to 1, blink mode is disabled and the led behaves as with
pre-2.6.26 kernels.

I've done my best to make the implementation as cheap as possible.

One question I have is whether _all_ SOCs need this quirk or if we should
test for a model or revision. Is there model/revision info available for SOC?

Cheers,
FJP

---
Subject: sata-mv: enable HDD led blinking when NCQ is active for SOC
    
For some Marvell chips the HDD led does not blink when there is
disk I/O if NCQ is enabled. Add a quirk that enables blink mode for
the led when NCQ is used on any of the ports of a host controller.
    
Currently the quirk is only enabled for SOC, but it can be extended
to other chip models.
    
The code to enable the blink mode is based on an earlier patch
proposed by Saeed Bishara.
    
Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Mark Lord <liml@rtr.ca>
Cc: Saeed Bishara <saeed.bishara@gmail.com>

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 4ae1a41..c5072e6 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -205,6 +205,11 @@ enum {
 	HC_COAL_IRQ		= (1 << 4),	/* IRQ coalescing */
 	DEV_IRQ			= (1 << 8),	/* shift by port # */
 
+	SOC_LED_CTRL_OFS	= 0x2c,
+	SOC_LED_CTRL_BLINK	= (1 << 0),	/* Active LED blink */
+	SOC_LED_CTRL_ACT_PRESENCE = (1 << 2),	/* Multiplex presence with */
+						/* the active LED */
+
 	/* Shadow block registers */
 	SHD_BLK_OFS		= 0x100,
 	SHD_CTL_AST_OFS		= 0x20,		/* ofs from SHD_BLK_OFS */
@@ -359,6 +364,7 @@ enum {
 	MV_HP_PCIE		= (1 << 9),	/* PCIe bus/regs: 7042 */
 	MV_HP_CUT_THROUGH	= (1 << 10),	/* can use EDMA cut-through */
 	MV_HP_FLAG_SOC		= (1 << 11),	/* SystemOnChip, no PCI */
+	MV_HP_QUIRK_LED_BL_EN	= (1 << 12),	/* is led blinking enabled? */
 
 	/* Port private flags (pp_flags) */
 	MV_PP_FLAG_EDMA_EN	= (1 << 0),	/* is EDMA engine enabled? */
@@ -523,6 +529,8 @@ static int mv6_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
 static void mv6_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio);
 static void mv_soc_enable_leds(struct mv_host_priv *hpriv,
 				      void __iomem *mmio);
+static void mv_soc_led_blink_enable(struct mv_host_priv *hpriv,
+				      void __iomem *mmio, int blink_enable);
 static void mv_soc_read_preamp(struct mv_host_priv *hpriv, int idx,
 				      void __iomem *mmio);
 static int mv_soc_reset_hc(struct mv_host_priv *hpriv,
@@ -852,6 +860,52 @@ static void mv_enable_port_irqs(struct ata_port *ap,
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
+	if (enable) {
+		if (!(hpriv->hp_flags & MV_HP_QUIRK_LED_BL_EN)) {
+			mv_soc_led_blink_enable(hpriv, mmio, true);
+			hpriv->hp_flags |= MV_HP_QUIRK_LED_BL_EN;
+		}
+		return;
+	} else {
+		if (!(hpriv->hp_flags & MV_HP_QUIRK_LED_BL_EN))
+			return;
+	}
+
+	/* Does any other port still use NCQ? */
+	if (!mv_has_port_using_ncq(ap->host)) {
+		mv_soc_led_blink_enable(hpriv, mmio, false);
+		hpriv->hp_flags &= ~MV_HP_QUIRK_LED_BL_EN;
+	}
+}
+
 /**
  *      mv_start_dma - Enable eDMA engine
  *      @base: port base address
@@ -961,6 +1015,9 @@ static int mv_stop_edma(struct ata_port *ap)
 		ata_port_printk(ap, KERN_ERR, "Unable to stop eDMA\n");
 		return -EIO;
 	}
+
+	mv_quirk_blink_led_when_ncq(ap, false);
+
 	return 0;
 }
 
@@ -1219,6 +1276,9 @@ static void mv_edma_cfg(struct ata_port *ap, int want_ncq)
 			cfg |= (1 << 18);	/* enab early completion */
 		if (hpriv->hp_flags & MV_HP_CUT_THROUGH)
 			cfg |= (1 << 17); /* enab cut-thru (dis stor&forwrd) */
+
+		if (IS_SOC(hpriv) && want_ncq)
+			mv_quirk_blink_led_when_ncq(ap, true);
 	}
 
 	if (want_ncq) {
@@ -2613,6 +2673,19 @@ static void mv_soc_enable_leds(struct mv_host_priv *hpriv,
 	return;
 }
 
+static void mv_soc_led_blink_enable(struct mv_host_priv *hpriv,
+				      void __iomem *mmio, int blink_enable)
+{
+	void __iomem *hc_mmio = mv_hc_base(mmio, 0);
+	u32 tmp = readl(hc_mmio + SOC_LED_CTRL_OFS);
+
+	/* enable/disable blinking mode */
+	if (blink_enable)
+		writel(tmp | SOC_LED_CTRL_BLINK, hc_mmio + SOC_LED_CTRL_OFS);
+	else
+		writel(tmp & ~SOC_LED_CTRL_BLINK, hc_mmio + SOC_LED_CTRL_OFS);
+}
+
 static void mv_soc_read_preamp(struct mv_host_priv *hpriv, int idx,
 			   void __iomem *mmio)
 {
