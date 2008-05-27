From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 02/03] sata_mv: PHY_MODEx errata fixes
Date: Tue, 27 May 2008 17:56:31 -0400
Message-ID: <483C838F.9060208@rtr.ca>
References: <483C8328.1030807@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2258 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760104AbYE0V4c (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 May 2008 17:56:32 -0400
In-Reply-To: <483C8328.1030807@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Fix and update the errata handling for the PHY_MODEx registers.
This improves receiver noise tolerance, among other things.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-27 11:53:01.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-27 12:01:25.000000000 -0400
@@ -2546,7 +2546,7 @@
 		hp_flags & (MV_HP_ERRATA_60X1B2 | MV_HP_ERRATA_60X1C0);
 	int fix_phy_mode4 =
 		hp_flags & (MV_HP_ERRATA_60X1B2 | MV_HP_ERRATA_60X1C0);
-	u32 m2, tmp;
+	u32 m2, m3;
 
 	if (fix_phy_mode2) {
 		m2 = readl(port_mmio + PHY_MODE2);
@@ -2563,27 +2563,27 @@
 		udelay(200);
 	}
 
-	/* who knows what this magic does */
-	tmp = readl(port_mmio + PHY_MODE3);
-	tmp &= ~0x7F800000;
-	tmp |= 0x2A800000;
-	writel(tmp, port_mmio + PHY_MODE3);
+	/*
+	 * Gen-II/IIe PHY_MODE3 errata RM#2:
+	 * Achieves better receiver noise performance than the h/w default:
+	 */
+	m3 = readl(port_mmio + PHY_MODE3);
+	m3 = (m3 & 0x1f) | (0x5555601 << 5);
+	writel(m3, port_mmio + PHY_MODE3);
 
 	if (fix_phy_mode4) {
 		u32 m4;
 
 		m4 = readl(port_mmio + PHY_MODE4);
 
-		if (hp_flags & MV_HP_ERRATA_60X1B2)
-			tmp = readl(port_mmio + PHY_MODE3);
-
 		/* workaround for errata FEr SATA#10 (part 1) */
 		m4 = (m4 & ~(1 << 1)) | (1 << 0);
 
-		writel(m4, port_mmio + PHY_MODE4);
+		/* enforce bit restrictions on GenIIe devices */
+		if (IS_GEN_IIE(hpriv))
+			m4 = (m4 & ~0x5DE3FFFC) | (1 << 2);
 
-		if (hp_flags & MV_HP_ERRATA_60X1B2)
-			writel(tmp, port_mmio + PHY_MODE3);
+		writel(m4, port_mmio + PHY_MODE4);
 	}
 
 	/* Revert values of pre-emphasis and signal amps to the saved ones */
