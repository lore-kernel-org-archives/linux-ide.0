From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] sata_mv: fix SoC interrupt breakage
Date: Thu, 19 Feb 2009 10:38:04 -0500
Message-ID: <499D7CDC.9000202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:36699 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbZBSPiD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2009 10:38:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Lennert Buytenhek <buytenh@marvell.com>, Martin Michlmayr <tbm@cyrius.com>

For some reason, sata_mv doesn't clear interrupt status during init
when it's running on an SoC host adapter.  If the bootloader has
touched the SATA controller before starting Linux, Linux can end up
enabling the SATA interrupt with events pending, which will cause the
interrupt to be marked as spurious and then be disabled, which then
breaks all further accesses to the controller.

This patch makes the SoC path clear interrupt status on init like in
the non-SoC case.

Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>
Signed-off-by: Mark Lord <mlord@pobox.com>
---

This is for 2.6.29 (upstream-fixes).
Despite appearances, this patch simply removes a single unnecessary
if-stmt from the code.  It looks larger due to the resulting change
in indentation level.

--- old/drivers/ata/sata_mv.c.orig	2009-02-17 09:31:30.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2009-02-19 10:31:28.000000000 -0500
@@ -3114,19 +3114,17 @@
  		writelfl(0, hc_mmio + HC_IRQ_CAUSE_OFS);
  	}

-	if (!IS_SOC(hpriv)) {
-		/* Clear any currently outstanding host interrupt conditions */
-		writelfl(0, mmio + hpriv->irq_cause_ofs);
-
-		/* and unmask interrupt generation for host regs */
-		writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
-
-		/*
-		 * enable only global host interrupts for now.
-		 * The per-port interrupts get done later as ports are set up.
-		 */
-		mv_set_main_irq_mask(host, 0, PCI_ERR);
-	}
+	/* Clear any currently outstanding host interrupt conditions */
+	writelfl(0, mmio + hpriv->irq_cause_ofs);
+
+	/* and unmask interrupt generation for host regs */
+	writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
+
+	/*
+	 * enable only global host interrupts for now.
+	 * The per-port interrupts get done later as ports are set up.
+	 */
+	mv_set_main_irq_mask(host, 0, PCI_ERR);
  done:
  	return rc;
  }
