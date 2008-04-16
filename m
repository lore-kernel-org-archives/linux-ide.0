From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 06/07] sata_mv remove redundant edma init code
Date: Wed, 16 Apr 2008 15:00:17 -0400
Message-ID: <48064CC1.40203@rtr.ca>
References: <48064BCC.5070505@rtr.ca> <48064BF3.8010301@rtr.ca> <48064C15.9090109@rtr.ca> <48064C45.4070208@rtr.ca> <48064C7B.500@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2668 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144AbYDPTAS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Apr 2008 15:00:18 -0400
In-Reply-To: <48064C7B.500@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Remove unnecessary edma init code from port_start.
This sequence gets done later on the first I/O to the port.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-04-15 18:32:31.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-04-15 21:40:31.000000000 -0400
@@ -1144,8 +1144,6 @@
 	struct device *dev = ap->host->dev;
 	struct mv_host_priv *hpriv = ap->host->private_data;
 	struct mv_port_priv *pp;
-	void __iomem *port_mmio = mv_ap_base(ap);
-	unsigned long flags;
 	int tag;
 
 	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
@@ -1178,18 +1176,6 @@
 			pp->sg_tbl_dma[tag] = pp->sg_tbl_dma[0];
 		}
 	}
-
-	spin_lock_irqsave(&ap->host->lock, flags);
-
-	mv_edma_cfg(ap, 0);
-	mv_set_edma_ptrs(port_mmio, hpriv, pp);
-
-	spin_unlock_irqrestore(&ap->host->lock, flags);
-
-	/* Don't turn on EDMA here...do it before DMA commands only.  Else
-	 * we'll be unable to send non-data, PIO, etc due to restricted access
-	 * to shadow regs.
-	 */
 	return 0;
 
 out_port_free_dma_mem:
