From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 07/07] sata_mv: workaround errata SATA#13
Date: Mon, 06 Apr 2009 15:26:24 -0400
Message-ID: <49DA5760.1040104@rtr.ca>
References: <49DA2DFD.4010402@rtr.ca> <49DA2E33.4050704@rtr.ca> <49DA2E76.7000800@rtr.ca> <49DA566D.9040501@rtr.ca> <49DA56DE.3000200@rtr.ca> <49DA5709.7060005@rtr.ca> <49DA5733.3050206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:33226 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753099AbZDFT00 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 15:26:26 -0400
In-Reply-To: <49DA5733.3050206@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Saeed Bishara <saeed@marvell.com>

Add remainder of workaround for errata SATA#13.

This prevents writes of certain adjacent 32-bit registers
from being combined into single 64-bit writes, which might
fail for the affected registers.

Most of sata_mv is already safe from this issue,
but adding this code to mv_write_cached_reg() will
catch the remaining cases and hopefully prevent future ones.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-04-06 15:00:16.000000000 -0400
+++ new/drivers/ata/sata_mv.c	2009-04-06 15:04:05.000000000 -0400
@@ -919,8 +919,26 @@
 static inline void mv_write_cached_reg(void __iomem *addr, u32 *old, u32 new)
 {
 	if (new != *old) {
+		unsigned long laddr;
 		*old = new;
-		writel(new, addr);
+		/*
+		 * Workaround for 88SX60x1-B2 FEr SATA#13:
+		 * Read-after-write is needed to prevent generating 64-bit
+		 * write cycles on the PCI bus for SATA interface registers
+		 * at offsets ending in 0x4 or 0xc.
+		 *
+		 * Looks like a lot of fuss, but it avoids an unnecessary
+		 * +1 usec read-after-write delay for unaffected registers.
+		 */
+		laddr = (long)addr & 0xffff;
+		if (laddr >= 0x300 && laddr <= 0x33c) {
+			laddr &= 0x000f;
+			if (laddr == 0x4 || laddr == 0xc) {
+				writelfl(new, addr); /* read after write */
+				return;
+			}
+		}
+		writel(new, addr); /* unaffected by the errata */
 	}
 }
 
