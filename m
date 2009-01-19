From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 04/04] sata_mv: msi masking
Date: Mon, 19 Jan 2009 18:07:43 -0500
Message-ID: <497507BF.3090608@rtr.ca>
References: <49750705.7010709@rtr.ca> <49750746.3010709@rtr.ca> <49750774.1070005@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:43425 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525AbZASXHo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jan 2009 18:07:44 -0500
In-Reply-To: <49750774.1070005@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Enable reliable use of Message Switched Interrupts (MSI) in sata_mv
by masking further chip interrupts within the main interrupt handler.
Based upon a suggestion by Grant Grundler.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-01-19 17:18:31.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-19 17:12:51.000000000 -0500
@@ -33,8 +33,6 @@
  *
  * --> ATAPI support (Marvell claims the 60xx/70xx chips can do it).
  *
- * --> Investigate problems with PCI Message Signalled Interrupts (MSI).
- *
  * --> Develop a low-power-consumption strategy, and implement it.
  *
  * --> [Experiment, low priority] Investigate interrupt coalescing.
@@ -2199,9 +2197,15 @@
 	struct ata_host *host = dev_instance;
 	struct mv_host_priv *hpriv = host->private_data;
 	unsigned int handled = 0;
+	int using_msi = hpriv->hp_flags & MV_HP_FLAG_MSI;
 	u32 main_irq_cause, pending_irqs;
 
 	spin_lock(&host->lock);
+
+	/* for MSI:  block new interrupts while in here */
+	if (using_msi)
+		writel(0, hpriv->main_irq_mask_addr);
+
 	main_irq_cause = readl(hpriv->main_irq_cause_addr);
 	pending_irqs   = main_irq_cause & hpriv->main_irq_mask;
 	/*
@@ -2215,6 +2219,11 @@
 			handled = mv_host_intr(host, pending_irqs);
 	}
 	spin_unlock(&host->lock);
+
+	/* for MSI: unblock interupts; anything pending will hit us now */
+	if (using_msi)
+		writel(hpriv->main_irq_mask, hpriv->main_irq_mask_addr);
+
 	return IRQ_RETVAL(handled);
 }
 
