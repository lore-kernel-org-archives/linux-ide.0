From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 01/03] sata_mv: revert SoC irq breakage
Date: Mon, 06 Apr 2009 12:29:49 -0400
Message-ID: <49DA2DFD.4010402@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:34627 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809AbZDFQ3w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 12:29:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Maxime Bizon <mbizon@freebox.fr>, Lennert Buytenhek <buytenh@marvell.com>, Saeed Bishara <saeed@marvell.com>

Revert most of commit 6be96ac1d5e4d913e1f48299db083ada5321803b2,
originally from Lennert Buijtenheck (Marvell) and Saeed Bishara (Marvell),
since that commit causes sata_mv to oops at startup on SOC "Kirkwood".

The SOC variants do not have the hpriv->irq_{cause,mask}_ofs registers,
so don't try to write to them!

This patch should also be considered for -stable.

Reported-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Mark Lord <mlord@pobox.com>
---
Note: I am mostly in the dark about the sata_mv SOC stuff,
since I have incomplete documentation and no hardware to test with.

--- old/drivers/ata/sata_mv.c	2009-04-06 11:18:01.000000000 -0400
+++ new/drivers/ata/sata_mv.c	2009-04-06 11:59:57.000000000 -0400
@@ -3734,11 +3734,13 @@
 		writelfl(0, hc_mmio + HC_IRQ_CAUSE_OFS);
 	}
 
-	/* Clear any currently outstanding host interrupt conditions */
-	writelfl(0, mmio + hpriv->irq_cause_ofs);
+	if (!IS_SOC(hpriv)) {
+		/* Clear any currently outstanding host interrupt conditions */
+		writelfl(0, mmio + hpriv->irq_cause_ofs);
 
-	/* and unmask interrupt generation for host regs */
-	writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
+		/* and unmask interrupt generation for host regs */
+		writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
+	}
 
 	/*
 	 * enable only global host interrupts for now.
