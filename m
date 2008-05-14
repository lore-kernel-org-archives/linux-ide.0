From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 03/04] sata_mv group genIIe flags
Date: Wed, 14 May 2008 09:21:43 -0400
Message-ID: <482AE767.8090103@rtr.ca>
References: <482AE694.5080604@rtr.ca> <482AE6E2.4080900@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1698 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754185AbYENNVo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 May 2008 09:21:44 -0400
In-Reply-To: <482AE6E2.4080900@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Group all of the flags for GenIIe devices into a common definition,
to ensure that any updates to them are shared by all GenIIe devices.

This will help make future maintenance somewhat simpler.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

For 2.6.26.

--- old/drivers/ata/sata_mv.c	2008-05-14 08:51:49.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-14 09:00:36.000000000 -0400
@@ -128,8 +128,13 @@
 	MV_COMMON_FLAGS		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI |
 				  ATA_FLAG_PIO_POLLING,
+
 	MV_6XXX_FLAGS		= MV_FLAG_IRQ_COALESCE,
 
+	MV_GENIIE_FLAGS		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
+				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
+				  ATA_FLAG_NCQ,
+
 	CRQB_FLAG_READ		= (1 << 0),
 	CRQB_TAG_SHIFT		= 1,
 	CRQB_IOID_SHIFT		= 6,	/* CRQB Gen-II/IIE IO Id shift */
@@ -640,25 +645,19 @@
 		.port_ops	= &mv6_ops,
 	},
 	{  /* chip_6042 */
-		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
-				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
-				  ATA_FLAG_NCQ,
+		.flags		= MV_GENIIE_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv_iie_ops,
 	},
 	{  /* chip_7042 */
-		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
-				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
-				  ATA_FLAG_NCQ,
+		.flags		= MV_GENIIE_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv_iie_ops,
 	},
 	{  /* chip_soc */
-		.flags		= MV_COMMON_FLAGS | MV_6XXX_FLAGS |
-				  ATA_FLAG_PMP | ATA_FLAG_ACPI_SATA |
-				  ATA_FLAG_NCQ | MV_FLAG_SOC,
+		.flags		= MV_GENIIE_FLAGS | MV_FLAG_SOC,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv_iie_ops,
