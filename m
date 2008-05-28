From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 05/05] sata_mv: implement SoC guideline SATA_S11
Date: Wed, 28 May 2008 13:41:52 -0400
Message-ID: <483D9960.8070607@rtr.ca>
References: <483C8328.1030807@rtr.ca> <483C838F.9060208@rtr.ca> <483C8420.5090706@rtr.ca> <483D81C8.90208@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2171 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794AbYE1Rly (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 May 2008 13:41:54 -0400
In-Reply-To: <483D81C8.90208@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

The 5182 System-On-Chip (SOC) variant wants certain lower
bits to be cleared on any write to the PHY_MODE3 register.

If/when support is added for other SOC variants, we'll need
some way to uniquely identify the 5182, and not perform this
workaround for the others.

But for now, it is the only SOC variant we support here.

Signed-off-by: Mark Lord <mlord@pobox.com>
---
Another extension to the patch series.
This concludes the errata fixes I know of
for the various PHY_MODE registers.

--- old/drivers/ata/sata_mv.c	2008-05-28 11:50:56.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-28 12:20:05.000000000 -0400
@@ -72,7 +72,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"1.23"
+#define DRV_VERSION	"1.24"
 
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
@@ -2558,6 +2558,10 @@
 	m3 = readl(port_mmio + PHY_MODE3);
 	m3 = (m3 & 0x1f) | (0x5555601 << 5);
 
+	/* Guideline 88F5182 (GL# SATA-S11) */
+	if (IS_SOC(hpriv))
+		m3 &= ~0x1c;
+
 	if (fix_phy_mode4) {
 		u32 m4;
 
