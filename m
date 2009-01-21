From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 04/05] sata_mv: msi masking fix (v2)
Date: Wed, 21 Jan 2009 10:31:29 -0500
Message-ID: <49773FD1.3040101@rtr.ca>
References: <49750705.7010709@rtr.ca> <49750746.3010709@rtr.ca> <49750774.1070005@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:56035 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753654AbZAUPbb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jan 2009 10:31:31 -0500
In-Reply-To: <49750774.1070005@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Enable reliable use of Message-Signaled Interrupts (MSI) in sata_mv
by masking further chip interrupts within the main interrupt handler.

Based upon a suggestion by Grant Grundler.
MSI is working reliably in all of my test systems here now.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

This replaces the originally posted [PATCH 05/04] version.

--- old/drivers/ata/sata_mv.c	2009-01-21 10:16:59.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-21 10:22:28.000000000 -0500
@@ -33,8 +33,6 @@
  *
  * --> ATAPI support (Marvell claims the 60xx/70xx chips can do it).
  *
- * --> Investigate problems with PCI Message Signalled Interrupts (MSI).
- *
  * --> Develop a low-power-consumption strategy, and implement it.
  *
  * --> [Experiment, low priority] Investigate interrupt coalescing.
@@ -70,7 +68,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"1.24"
+#define DRV_VERSION	"1.25"
 
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
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
+	/* for MSI: unmask; interrupt cause bits will retrigger now */
+	if (using_msi)
+		writel(hpriv->main_irq_mask, hpriv->main_irq_mask_addr);
+
 	return IRQ_RETVAL(handled);
 }
 
@@ -3414,9 +3423,9 @@
 	if (rc)
 		return rc;
 
-	/* Enable interrupts */
-	if (msi && pci_enable_msi(pdev))
-		pci_intx(pdev, 1);
+	/* Enable message-switched interrupts, if requested */
+	if (msi && 0 == pci_enable_msi(pdev))
+		hpriv->hp_flags |= MV_HP_FLAG_MSI;
 
 	mv_dump_pci_cfg(pdev, 0x68);
 	mv_print_info(host);
