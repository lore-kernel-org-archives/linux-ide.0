From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 04/04] sata_mv: workaround for 60x1 errata sata13
Date: Wed, 28 May 2008 12:01:12 -0400
Message-ID: <483D81C8.90208@rtr.ca>
References: <483C8328.1030807@rtr.ca> <483C838F.9060208@rtr.ca> <483C8420.5090706@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1591 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584AbYE1QBQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 May 2008 12:01:16 -0400
In-Reply-To: <483C8420.5090706@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

The "B2" variant of the 6041/6081 (genII) chips requires
that the PHY_MODE3 register be rewritten after any write
to PHY_MODE4.

This fixes a regression introduced by an earlier patch.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-28 11:47:44.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-28 11:50:56.000000000 -0400
@@ -72,7 +72,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"1.22"
+#define DRV_VERSION	"1.23"
 
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
@@ -2557,7 +2557,6 @@
 	 */
 	m3 = readl(port_mmio + PHY_MODE3);
 	m3 = (m3 & 0x1f) | (0x5555601 << 5);
-	writel(m3, port_mmio + PHY_MODE3);
 
 	if (fix_phy_mode4) {
 		u32 m4;
@@ -2573,6 +2572,12 @@
 
 		writel(m4, port_mmio + PHY_MODE4);
 	}
+	/*
+	 * Workaround for 60x1-B2 errata SATA#13:
+	 * Any write to PHY_MODE4 (above) may corrupt PHY_MODE3,
+	 * so we must always rewrite PHY_MODE3 after PHY_MODE4.
+	 */
+	writel(m3, port_mmio + PHY_MODE3);
 
 	/* Revert values of pre-emphasis and signal amps to the saved ones */
 	m2 = readl(port_mmio + PHY_MODE2);
