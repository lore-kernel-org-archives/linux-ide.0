From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 3/5] sata_mv fix ifctl handling
Date: Mon, 31 Mar 2008 19:35:13 -0400
Message-ID: <47F17531.9080607@rtr.ca>
References: <47F1736F.8020104@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3043 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbYCaXfO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Mar 2008 19:35:14 -0400
In-Reply-To: <47F1736F.8020104@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Fix handling of the SATA_INTERFACE_CFG register to match datasheet requirements.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

--- old/drivers/ata/sata_mv.c	2008-03-31 18:12:56.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-03-31 18:14:40.000000000 -0400
@@ -2242,6 +2242,16 @@
 	return;
 }
 
+static void mv_setup_ifctl(void __iomem *port_mmio, int want_gen2i)
+{
+	u32 ifctl = readl(port_mmio + SATA_INTERFACE_CFG);
+
+	ifctl = (ifctl & 0xf7f) | 0x9b1000;	/* from chip spec */
+	if (want_gen2i)
+		ifctl |= (1 << 7);		/* enable gen2i speed */
+	writelfl(ifctl, port_mmio + SATA_INTERFACE_CFG);
+}
+
 /*
  * Caller must ensure that EDMA is not active,
  * by first doing mv_stop_edma() where needed.
@@ -2253,18 +2263,17 @@
 
 	writelfl(ATA_RST, port_mmio + EDMA_CMD_OFS);
 
-	if (IS_GEN_II(hpriv)) {
-		u32 ifctl = readl(port_mmio + SATA_INTERFACE_CFG);
-		ifctl |= (1 << 7);		/* enable gen2i speed */
-		ifctl = (ifctl & 0xfff) | 0x9b1000; /* from chip spec */
-		writelfl(ifctl, port_mmio + SATA_INTERFACE_CFG);
+	if (!IS_GEN_I(hpriv)) {
+		/* Enable 3.0gb/s link speed */
+		mv_setup_ifctl(port_mmio, 1);
 	}
-
-	udelay(25);		/* allow reset propagation */
-
-	/* Spec never mentions clearing the bit.  Marvell's driver does
-	 * clear the bit, however.
+	/*
+	 * Strobing ATA_RST here causes a hard reset of the SATA transport,
+	 * link, and physical layers.  It resets all SATA interface registers
+	 * (except for SATA_INTERFACE_CFG), and issues a COMRESET to the dev.
 	 */
+	writelfl(ATA_RST, port_mmio + EDMA_CMD_OFS);
+	udelay(25);	/* allow reset propagation */
 	writelfl(0, port_mmio + EDMA_CMD_OFS);
 
 	hpriv->ops->phy_errata(hpriv, mmio, port_no);
@@ -2711,19 +2720,6 @@
 	hpriv->ops->enable_leds(hpriv, mmio);
 
 	for (port = 0; port < host->n_ports; port++) {
-		if (IS_GEN_II(hpriv)) {
-			void __iomem *port_mmio = mv_port_base(mmio, port);
-
-			u32 ifctl = readl(port_mmio + SATA_INTERFACE_CFG);
-			ifctl |= (1 << 7);		/* enable gen2i speed */
-			ifctl = (ifctl & 0xfff) | 0x9b1000; /* from chip spec */
-			writelfl(ifctl, port_mmio + SATA_INTERFACE_CFG);
-		}
-
-		hpriv->ops->phy_errata(hpriv, mmio, port);
-	}
-
-	for (port = 0; port < host->n_ports; port++) {
 		struct ata_port *ap = host->ports[port];
 		void __iomem *port_mmio = mv_port_base(mmio, port);
 
