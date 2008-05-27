From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 03/03] sata_mv: nuke unreleased GenIIe revisions
Date: Tue, 27 May 2008 17:58:56 -0400
Message-ID: <483C8420.5090706@rtr.ca>
References: <483C8328.1030807@rtr.ca> <483C838F.9060208@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4744 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757475AbYE0V66 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 May 2008 17:58:58 -0400
In-Reply-To: <483C838F.9060208@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

The only public release of the 6042/7042 chips was/is revision "B0".
Remove code that attempted to deal with earlier, non-released revs.
This matches the logic of the current Marvell "proprietary" driver.

Also, bump up the sata_mv version number, to reflect this batch of erratas.

Signed-off-by: Mark Lord <mlord@pobox.com>
---
This update was specifically requested by Marvell.

--- old/drivers/ata/sata_mv.c	2008-05-27 12:01:25.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-27 12:07:06.000000000 -0400
@@ -72,7 +72,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"1.21"
+#define DRV_VERSION	"1.22"
 
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
@@ -354,7 +354,6 @@
 	MV_HP_ERRATA_50XXB2	= (1 << 2),
 	MV_HP_ERRATA_60X1B2	= (1 << 3),
 	MV_HP_ERRATA_60X1C0	= (1 << 4),
-	MV_HP_ERRATA_XX42A0	= (1 << 5),
 	MV_HP_GEN_I		= (1 << 6),	/* Generation I: 50xx */
 	MV_HP_GEN_II		= (1 << 7),	/* Generation II: 60xx */
 	MV_HP_GEN_IIE		= (1 << 8),	/* Generation IIE: 6042/7042 */
@@ -811,12 +810,7 @@
 	writel((pp->crqb_dma >> 16) >> 16, port_mmio + EDMA_REQ_Q_BASE_HI_OFS);
 	writelfl((pp->crqb_dma & EDMA_REQ_Q_BASE_LO_MASK) | index,
 		 port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
-
-	if (hpriv->hp_flags & MV_HP_ERRATA_XX42A0)
-		writelfl((pp->crqb_dma & 0xffffffff) | index,
-			 port_mmio + EDMA_REQ_Q_OUT_PTR_OFS);
-	else
-		writelfl(index, port_mmio + EDMA_REQ_Q_OUT_PTR_OFS);
+	writelfl(index, port_mmio + EDMA_REQ_Q_OUT_PTR_OFS);
 
 	/*
 	 * initialize response queue
@@ -826,13 +820,7 @@
 
 	WARN_ON(pp->crpb_dma & 0xff);
 	writel((pp->crpb_dma >> 16) >> 16, port_mmio + EDMA_RSP_Q_BASE_HI_OFS);
-
-	if (hpriv->hp_flags & MV_HP_ERRATA_XX42A0)
-		writelfl((pp->crpb_dma & 0xffffffff) | index,
-			 port_mmio + EDMA_RSP_Q_IN_PTR_OFS);
-	else
-		writelfl(index, port_mmio + EDMA_RSP_Q_IN_PTR_OFS);
-
+	writelfl(index, port_mmio + EDMA_RSP_Q_IN_PTR_OFS);
 	writelfl((pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK) | index,
 		 port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 }
@@ -3002,10 +2990,7 @@
 			hp_flags |= MV_HP_CUT_THROUGH;
 
 		switch (pdev->revision) {
-		case 0x0:
-			hp_flags |= MV_HP_ERRATA_XX42A0;
-			break;
-		case 0x1:
+		case 0x2: /* Rev.B0: the first/only public release */
 			hp_flags |= MV_HP_ERRATA_60X1C0;
 			break;
 		default:
