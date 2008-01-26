From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 03/13] sata_mv ncq Rename base to port mmio
Date: Sat, 26 Jan 2008 18:31:00 -0500
Message-ID: <479BC2B4.7030302@rtr.ca>
References: <479BC217.60709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3044 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571AbYAZXbF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 18:31:05 -0500
In-Reply-To: <479BC217.60709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Use naming consistent with elsewhere in this driver.
This will keep things less confusing when we later add "hc_mmio" in this function.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-01-24 11:23:05.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2008-01-24 11:26:33.000000000 -0500
@@ -834,19 +834,19 @@
  *      LOCKING:
  *      Inherited from caller.
  */
-static void mv_start_dma(void __iomem *base, struct mv_host_priv *hpriv,
+static void mv_start_dma(void __iomem *port_mmio, struct mv_host_priv *hpriv,
 			 struct mv_port_priv *pp)
 {
 	if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN)) {
 		/* clear EDMA event indicators, if any */
-		writelfl(0, base + EDMA_ERR_IRQ_CAUSE_OFS);
+		writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
-		mv_set_edma_ptrs(base, hpriv, pp);
+		mv_set_edma_ptrs(port_mmio, hpriv, pp);
 
-		writelfl(EDMA_EN, base + EDMA_CMD_OFS);
+		writelfl(EDMA_EN, port_mmio + EDMA_CMD_OFS);
 		pp->pp_flags |= MV_PP_FLAG_EDMA_EN;
 	}
-	WARN_ON(!(EDMA_EN & readl(base + EDMA_CMD_OFS)));
+	WARN_ON(!(EDMA_EN & readl(port_mmio + EDMA_CMD_OFS)));
 }
 
 /**
