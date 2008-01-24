From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 03/14] sata_mv Clear queue indexes on chip restart
Date: Thu, 24 Jan 2008 15:58:28 -0500
Message-ID: <4798FBF4.7060705@rtr.ca>
References: <4798FB68.70400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2686 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755619AbYAXU63 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Jan 2008 15:58:29 -0500
In-Reply-To: <4798FB68.70400@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

sata_mv Clear queue indexes on chip restart.

Force in/out queue pointer indexes back to zero on any (re)init.
This ensures things are in a consistent state after any chip/dev errors.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-01-24 11:17:42.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2008-01-24 11:23:05.000000000 -0500
@@ -792,7 +792,7 @@
 	/*
 	 * initialize request queue
 	 */
-	index = (pp->req_idx & MV_MAX_Q_DEPTH_MASK) << EDMA_REQ_Q_PTR_SHIFT;
+	index = pp->req_idx = 0;
 
 	WARN_ON(pp->crqb_dma & 0x3ff);
 	writel((pp->crqb_dma >> 16) >> 16, port_mmio + EDMA_REQ_Q_BASE_HI_OFS);
@@ -808,7 +808,7 @@
 	/*
 	 * initialize response queue
 	 */
-	index = (pp->resp_idx & MV_MAX_Q_DEPTH_MASK) << EDMA_RSP_Q_PTR_SHIFT;
+	index = pp->resp_idx = 0;
 
 	WARN_ON(pp->crpb_dma & 0xff);
 	writel((pp->crpb_dma >> 16) >> 16, port_mmio + EDMA_RSP_Q_BASE_HI_OFS);
