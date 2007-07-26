From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_cmd64x: Correct the speed ranges
Date: Thu, 26 Jul 2007 18:43:01 +0100
Message-ID: <20070726184301.4677ee46@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:48777 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762069AbXGZRgU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jul 2007 13:36:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

I must have been half asleep when doing the original code

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/drivers/ata/pata_cmd64x.c linux-2.6.23rc1-mm1/drivers/ata/pata_cmd64x.c
--- linux.vanilla-2.6.23rc1-mm1/drivers/ata/pata_cmd64x.c	2007-07-26 15:01:52.915752536 +0100
+++ linux-2.6.23rc1-mm1/drivers/ata/pata_cmd64x.c	2007-07-26 15:18:38.486882488 +0100
@@ -31,7 +31,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_cmd64x"
-#define DRV_VERSION "0.2.3"
+#define DRV_VERSION "0.2.4"
 
 /*
  * CMD64x specific registers definition.
@@ -397,7 +397,7 @@
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
-			.udma_mask = ATA_UDMA1,
+			.udma_mask = ATA_UDMA2,
 			.port_ops = &cmd64x_port_ops
 		},
 		{	/* CMD 646 rev 1  */
@@ -412,7 +412,7 @@
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
-			.udma_mask = ATA_UDMA2,
+			.udma_mask = ATA_UDMA4,
 			.port_ops = &cmd648_port_ops
 		},
 		{	/* CMD 649 */
@@ -420,7 +420,7 @@
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = 0x1f,
 			.mwdma_mask = 0x07,
-			.udma_mask = ATA_UDMA3,
+			.udma_mask = ATA_UDMA5,
 			.port_ops = &cmd648_port_ops
 		}
 	};
