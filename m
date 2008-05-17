From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 05/09] sata_mv don't blindly enable IRQs
Date: Sat, 17 May 2008 13:34:42 -0400
Message-ID: <482F1732.6010109@rtr.ca>
References: <482AE694.5080604@rtr.ca> <482AE6E2.4080900@rtr.ca> <482AE767.8090103@rtr.ca> <482AE817.2020809@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4029 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753013AbYEQRen (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 May 2008 13:34:43 -0400
In-Reply-To: <482AE817.2020809@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

These five small patches are on top of the four previously posted,
so I'm extending the numbering to be xx/09 now:

-----snip-----

Part one of simplifying/fixing handling of the main_irq_mask register
to resolve unexpected interrupt issues observed in 2.6.26-rc*.

Don't blindly enable port IRQs at host init time.
Instead, enable only the bits that we want,
which in this case is simply the PCI_ERR bit.

The per-port bits can wait until the ports are reset/probed for devices.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-14 09:24:49.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-16 15:25:16.000000000 -0400
@@ -202,13 +202,6 @@
 	HC_MAIN_RSVD		= (0x7f << 25),	/* bits 31-25 */
 	HC_MAIN_RSVD_5		= (0x1fff << 19), /* bits 31-19 */
 	HC_MAIN_RSVD_SOC	= (0x3fffffb << 6),     /* bits 31-9, 7-6 */
-	HC_MAIN_MASKED_IRQS	= (TRAN_LO_DONE | TRAN_HI_DONE |
-				   PORTS_0_3_COAL_DONE | PORTS_4_7_COAL_DONE |
-				   PORTS_0_7_COAL_DONE | GPIO_INT | TWSI_INT |
-				   HC_MAIN_RSVD),
-	HC_MAIN_MASKED_IRQS_5	= (PORTS_0_3_COAL_DONE | PORTS_4_7_COAL_DONE |
-				   HC_MAIN_RSVD_5),
-	HC_MAIN_MASKED_IRQS_SOC = (PORTS_0_3_COAL_DONE | HC_MAIN_RSVD_SOC),
 
 	/* SATAHC registers */
 	HC_CFG_OFS		= 0,
@@ -3101,25 +3094,12 @@
 
 		/* and unmask interrupt generation for host regs */
 		writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
-		if (IS_GEN_I(hpriv))
-			writelfl(~HC_MAIN_MASKED_IRQS_5,
-				 hpriv->main_irq_mask_addr);
-		else
-			writelfl(~HC_MAIN_MASKED_IRQS,
-				 hpriv->main_irq_mask_addr);
 
-		VPRINTK("HC MAIN IRQ cause/mask=0x%08x/0x%08x "
-			"PCI int cause/mask=0x%08x/0x%08x\n",
-			readl(hpriv->main_irq_cause_addr),
-			readl(hpriv->main_irq_mask_addr),
-			readl(mmio + hpriv->irq_cause_ofs),
-			readl(mmio + hpriv->irq_mask_ofs));
-	} else {
-		writelfl(~HC_MAIN_MASKED_IRQS_SOC,
-			 hpriv->main_irq_mask_addr);
-		VPRINTK("HC MAIN IRQ cause/mask=0x%08x/0x%08x\n",
-			readl(hpriv->main_irq_cause_addr),
-			readl(hpriv->main_irq_mask_addr));
+		/*
+		 * enable only global host interrupts for now.
+		 * The per-port interrupts get done later as ports are set up.
+		 */
+		writelfl(PCI_ERR, hpriv->main_irq_mask_addr);
 	}
 done:
 	return rc;
