From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 02/03] sata_mv: fix irq mask races
Date: Mon, 06 Apr 2009 12:30:43 -0400
Message-ID: <49DA2E33.4050704@rtr.ca>
References: <49DA2DFD.4010402@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:34646 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246AbZDFQap (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 12:30:45 -0400
In-Reply-To: <49DA2DFD.4010402@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Saeed Bishara <saeed@marvell.com>

Prevent racing on the main interrupt mask during port_start and port_stop.
Otherwise, we end up with IRQs masked on inactive ports,
and hotplug insertions then get missed later on.

Found while debugging (out of tree) target mode operations,
but the bug is present and impacting mainline as well.

This patch should also be considered for -stable.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-04-06 11:59:57.000000000 -0400
+++ new/drivers/ata/sata_mv.c	2009-04-06 12:06:20.000000000 -0400
@@ -1575,6 +1575,7 @@
 	struct device *dev = ap->host->dev;
 	struct mv_host_priv *hpriv = ap->host->private_data;
 	struct mv_port_priv *pp;
+	unsigned long flags;
 	int tag;
 
 	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
@@ -1610,8 +1611,12 @@
 			pp->sg_tbl_dma[tag] = pp->sg_tbl_dma[0];
 		}
 	}
+
+	spin_lock_irqsave(ap->lock, flags);
 	mv_save_cached_regs(ap);
 	mv_edma_cfg(ap, 0, 0);
+	spin_unlock_irqrestore(ap->lock, flags);
+
 	return 0;
 
 out_port_free_dma_mem:
@@ -1630,8 +1635,12 @@
  */
 static void mv_port_stop(struct ata_port *ap)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(ap->lock, flags);
 	mv_stop_edma(ap);
 	mv_enable_port_irqs(ap, 0);
+	spin_unlock_irqrestore(ap->lock, flags);
 	mv_port_free_dma_mem(ap);
 }
 
