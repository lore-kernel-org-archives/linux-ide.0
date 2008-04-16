From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 04/07] sata_mv fix SOC flags, enable NCQ on SOC
Date: Wed, 16 Apr 2008 14:58:13 -0400
Message-ID: <48064C45.4070208@rtr.ca>
References: <48064BCC.5070505@rtr.ca> <48064BF3.8010301@rtr.ca> <48064C15.9090109@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2659 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089AbYDPS6O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Apr 2008 14:58:14 -0400
In-Reply-To: <48064C15.9090109@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

The System-On-Chip (SOC) core supports all of the same
features as the other recent Marvell chips,
including NCQ and IRQ coalescing.

Fix the chip_soc flags to enable these capabilities
(note that the driver currently does nothing special
for IRQ coalescing, though).

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-04-15 18:20:02.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-04-15 18:23:09.000000000 -0400
@@ -626,7 +626,8 @@
 		.port_ops	= &mv_iie_ops,
 	},
 	{  /* chip_soc */
-		.flags		= MV_COMMON_FLAGS | MV_FLAG_SOC,
+		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
+				  ATA_FLAG_NCQ | MV_FLAG_SOC,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv_iie_ops,
