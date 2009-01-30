From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 01/07] sata_mv: cleanup chipset GENeration FLAGS
Date: Fri, 30 Jan 2009 18:46:39 -0500
Message-ID: <4983915F.7090705@rtr.ca>
References: <49839107.2040603@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:48388 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753575AbZA3Xqk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jan 2009 18:46:40 -0500
In-Reply-To: <49839107.2040603@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Clean up the chipset GENeration FLAGS, and rename them
for consistency with other uses of GEN_XX within sata_mv.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-01-30 16:09:07.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-30 16:27:13.000000000 -0500
@@ -120,14 +120,15 @@
 	MV_FLAG_IRQ_COALESCE	= (1 << 29),  /* IRQ coalescing capability */
 
 	MV_COMMON_FLAGS		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI |
-				  ATA_FLAG_PIO_POLLING,
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_POLLING,
 
-	MV_6XXX_FLAGS		= MV_FLAG_IRQ_COALESCE,
+	MV_GEN_I_FLAGS		= MV_COMMON_FLAGS | ATA_FLAG_NO_ATAPI,
 
-	MV_GENIIE_FLAGS		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
+	MV_GEN_II_FLAGS		= MV_COMMON_FLAGS | MV_FLAG_IRQ_COALESCE |
 				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
-				  ATA_FLAG_NCQ | ATA_FLAG_AN,
+				  ATA_FLAG_NCQ | ATA_FLAG_NO_ATAPI,
+
+	MV_GEN_IIE_FLAGS	= MV_GEN_II_FLAGS | ATA_FLAG_AN,
 
 	CRQB_FLAG_READ		= (1 << 0),
 	CRQB_TAG_SHIFT		= 1,
@@ -603,53 +604,49 @@
 
 static const struct ata_port_info mv_port_info[] = {
 	{  /* chip_504x */
-		.flags		= MV_COMMON_FLAGS,
+		.flags		= MV_GEN_I_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv5_ops,
 	},
 	{  /* chip_508x */
-		.flags		= MV_COMMON_FLAGS | MV_FLAG_DUAL_HC,
+		.flags		= MV_GEN_I_FLAGS | MV_FLAG_DUAL_HC,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv5_ops,
 	},
 	{  /* chip_5080 */
-		.flags		= MV_COMMON_FLAGS | MV_FLAG_DUAL_HC,
+		.flags		= MV_GEN_I_FLAGS | MV_FLAG_DUAL_HC,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv5_ops,
 	},
 	{  /* chip_604x */
-		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
-				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
-				  ATA_FLAG_NCQ,
+		.flags		= MV_GEN_II_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv6_ops,
 	},
 	{  /* chip_608x */
-		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
-				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
-				  ATA_FLAG_NCQ | MV_FLAG_DUAL_HC,
+		.flags		= MV_GEN_II_FLAGS | MV_FLAG_DUAL_HC,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv6_ops,
 	},
 	{  /* chip_6042 */
-		.flags		= MV_GENIIE_FLAGS,
+		.flags		= MV_GEN_IIE_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv_iie_ops,
 	},
 	{  /* chip_7042 */
-		.flags		= MV_GENIIE_FLAGS,
+		.flags		= MV_GEN_IIE_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv_iie_ops,
 	},
 	{  /* chip_soc */
-		.flags		= MV_GENIIE_FLAGS,
+		.flags		= MV_GEN_IIE_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv_iie_ops,
