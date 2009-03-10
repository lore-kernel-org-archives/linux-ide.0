From: Mark Lord <liml@rtr.ca>
Subject: [PATCH #upstream-fixes] sata_mv fix MSI irq race condition
Date: Tue, 10 Mar 2009 16:28:51 -0400
Message-ID: <49B6CD83.1020904@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:34051 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860AbZCJU2z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Mar 2009 16:28:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Fix a (rare) race condition in mv_interrupt() when using MSI.

The value of hpriv->main_irq_mask_addr can change on on the fly,
and without this patch we could end up writing back a stale copy
to the hardware.

Signed-off-by: Mark Lord <mlord@pobox.com>
--

** This is required for 2.6.29 and beyond ***

--- old/drivers/ata/sata_mv.c	2009-03-10 16:19:39.000000000 -0400
+++ new/drivers/ata/sata_mv.c	2009-03-10 16:21:29.000000000 -0400
@@ -2218,12 +2218,13 @@
 		else
 			handled = mv_host_intr(host, pending_irqs);
 	}
-	spin_unlock(&host->lock);
 
 	/* for MSI: unmask; interrupt cause bits will retrigger now */
 	if (using_msi)
 		writel(hpriv->main_irq_mask, hpriv->main_irq_mask_addr);
 
+	spin_unlock(&host->lock);
+
 	return IRQ_RETVAL(handled);
 }
 
