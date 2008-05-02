From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 05/12] sata_mv errata workaround for sata25 part 1
Date: Fri, 02 May 2008 02:10:56 -0400
Message-ID: <481AB070.9050707@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca> <481AAFE0.9090101@rtr.ca> <481AB00A.3000206@rtr.ca> <481AB03A.60808@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1127 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756970AbYEBGK6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 02:10:58 -0400
In-Reply-To: <481AB03A.60808@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Part 1 of workaround for errata "sata#25" for the 60x1 series
(the second half of this errata workaround is still in development.

Bit22 of the GPIO port has to be set "on" when in NCQ mode.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-01 18:01:04.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-01 18:04:24.000000000 -0400
@@ -1151,6 +1151,21 @@
 		writelfl(new_ltmode, port_mmio + LTMODE_OFS);
 }
 
+static void mv_60x1_errata_sata25(struct ata_port *ap, int want_ncq)
+{
+	struct mv_host_priv *hpriv = ap->host->private_data;
+	u32 old, new;
+
+	/* workaround for 88SX60x1 FEr SATA#25 (part 1) */
+	old = readl(hpriv->base + MV_GPIO_PORT_CTL_OFS);
+	if (want_ncq)
+		new = old | (1 << 22);
+	else
+		new = old & ~(1 << 22);
+	if (new != old)
+		writel(new, hpriv->base + MV_GPIO_PORT_CTL_OFS);
+}
+
 static void mv_edma_cfg(struct ata_port *ap, int want_ncq)
 {
 	u32 cfg;
@@ -1164,10 +1179,11 @@
 	if (IS_GEN_I(hpriv))
 		cfg |= (1 << 8);	/* enab config burst size mask */
 
-	else if (IS_GEN_II(hpriv))
+	else if (IS_GEN_II(hpriv)) {
 		cfg |= EDMA_CFG_RD_BRST_EXT | EDMA_CFG_WR_BUFF_LEN;
+		mv_60x1_errata_sata25(ap, want_ncq);
 
-	else if (IS_GEN_IIE(hpriv)) {
+	} else if (IS_GEN_IIE(hpriv)) {
 		cfg |= (1 << 23);	/* do not mask PM field in rx'd FIS */
 		cfg |= (1 << 22);	/* enab 4-entry host queue cache */
 		if (HAS_PCI(ap->host))
