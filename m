From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH,v2][1/2] sata-mv: enable HDD led blinking when NCQ is
 active for GenIIe
Date: Wed, 11 Mar 2009 10:15:30 -0400
Message-ID: <49B7C782.9070004@rtr.ca>
References: <200903110813.25650.elendil@planet.nl> <200903110815.52650.elendil@planet.nl> <49B7B2C9.10203@rtr.ca> <200903111408.37298.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:37631 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752780AbZCKOPe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Mar 2009 10:15:34 -0400
In-Reply-To: <200903111408.37298.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

Frans Pop wrote:
> On Wednesday 11 March 2009, Mark Lord wrote:
>>> +static const struct mv_hw_ops mv6xxx_iie_ops = {
>>> +	.inherits		= &mv6xxx_ops,
>>> +	.enable_led_blink	= mv_iie_enable_led_blink,
>>> +};
>>> +
>> I'm afraid I just don't understand the purpose of "inherits" above.
>> This field appears to never be referenced anywhere.
> 
> Fun, as it's also used in mv6_ops and mv_iie_ops. That's where I copied it 
> from. I really don't have anywhere near the C fu to think up such 
> constructs all by myself :-D
> 
> What it does (I've been assuming) is include any ops defined in the struct 
> that is being referred to. So mv6xxx_iie_ops gets all the ops defined for 
> mv6xxx_ops plus mv_iie_enable_led_blink.
..

Heh.. that's the idea.

Except it is not a C-language feature, but rather a simple/clever
implementation for those specific data structures, as can be seen
in libata-core.c :: ata_finalize_port_ops().

So, skip that.

I've looked through the patches, and through the various Marvell datasheets
that I have access to here.  And it seems that the "LED blink" controls are
in different bits of different registers for the non-SOC chips.

So enough: we'll just do this the original way, for SOC only.
All of the SOC chips that I know about appear to have the correct bits
in the same places, so perhaps that's what Saeed's cryptic commment was about.

Here's my hacked version of your original patch,
against the latest libata-dev#upstream tree + IRQ coalescing patches.

Can you test this there and confirm that it still works for you?
Please try switching NCQ on/off etc.. just to make sure.

After I hear back, I'll submit this for #upstream.

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
@@ -1404,6 +1410,61 @@
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
+		if (pp->pp_flags & MV_PP_FLAG_NCQ_EN)
+			return;
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
@@ -1451,6 +1512,13 @@
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
