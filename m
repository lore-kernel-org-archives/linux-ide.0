From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 08/09] sata_mv disregard masked irqs
Date: Sat, 17 May 2008 13:37:07 -0400
Message-ID: <482F17C3.8020106@rtr.ca>
References: <482AE694.5080604@rtr.ca> <482AE6E2.4080900@rtr.ca> <482AE767.8090103@rtr.ca> <482AE817.2020809@rtr.ca> <482F1732.6010109@rtr.ca> <482F1759.20905@rtr.ca> <482F179E.8020602@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4044 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013AbYEQRhI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 May 2008 13:37:08 -0400
In-Reply-To: <482F179E.8020602@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Part four of simplifying/fixing handling of the main_irq_mask register
to resolve unexpected interrupt issues observed in 2.6.26-rc*.

Ignore masked IRQs in mv_interrupt().
This prevents "unexpected device interrupt while idle" messages.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-16 16:05:48.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-16 16:06:23.000000000 -0400
@@ -2200,20 +2200,21 @@
 	struct ata_host *host = dev_instance;
 	struct mv_host_priv *hpriv = host->private_data;
 	unsigned int handled = 0;
-	u32 main_irq_cause, main_irq_mask;
+	u32 main_irq_cause, main_irq_mask, pending_irqs;
 
 	spin_lock(&host->lock);
 	main_irq_cause = readl(hpriv->main_irq_cause_addr);
 	main_irq_mask  = readl(hpriv->main_irq_mask_addr);
+	pending_irqs   = main_irq_cause & main_irq_mask;
 	/*
 	 * Deal with cases where we either have nothing pending, or have read
 	 * a bogus register value which can indicate HW removal or PCI fault.
 	 */
-	if ((main_irq_cause & main_irq_mask) && (main_irq_cause != 0xffffffffU)) {
-		if (unlikely((main_irq_cause & PCI_ERR) && HAS_PCI(host)))
+	if (pending_irqs && main_irq_cause != 0xffffffffU) {
+		if (unlikely((pending_irqs & PCI_ERR) && HAS_PCI(host)))
 			handled = mv_pci_error(host, hpriv->base);
 		else
-			handled = mv_host_intr(host, main_irq_cause);
+			handled = mv_host_intr(host, pending_irqs);
 	}
 	spin_unlock(&host->lock);
 	return IRQ_RETVAL(handled);
