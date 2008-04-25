From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] sata_mv Improve naming of main_irq cause/mask identifiers
Date: Fri, 25 Apr 2008 11:24:24 -0400
Message-ID: <4811F7A8.6080004@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1084 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312AbYDYPYW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Apr 2008 11:24:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
..
> applied patches 1-8...
..
>> -    irq_stat = readl(hpriv->main_cause_reg_addr);
>> -    irq_mask = readl(hpriv->main_mask_reg_addr);
..
>> +    main_cause = readl(hpriv->main_cause_reg_addr);
>> +    main_mask  = readl(hpriv->main_mask_reg_addr);
..
>  ...but I am sad to see this.  irq_stat and irq_mask naming make the 
> driver more accessible to outsiders, because the purpose of the 
> registers is immediately apparent even without having the docs at hand 
> -- which is the case for everybody in the world except me and you :)
> 
> I applied the patch anyway because you are defacto maintainer of sata_mv.
> 
> However, I _request_ a reconsideration of some of these renames when 
> viewed in that light.  It's your prerogative as maintainer to ignore or 
> honor that request as you see fit...  We all have to balance making our 
> own job easier with making the driver accessible to outsiders, 
> particularly those without NDA'd docs.
..

Here ya go:

-------------------- SNIP ----------------------------------

Tidy up naming of things associated with the PCI / SOC chip
"main irq cause/mask" registers, as inspired by Jeff.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-04-25 09:30:04.000000000 -0400
+++ new/drivers/ata/sata_mv.c	2008-04-25 10:29:05.000000000 -0400
@@ -172,10 +172,11 @@
 	PCIE_IRQ_MASK_OFS	= 0x1910,
 	PCIE_UNMASK_ALL_IRQS	= 0x40a,	/* assorted bits */
 
-	HC_MAIN_IRQ_CAUSE_OFS	= 0x1d60,
-	HC_MAIN_IRQ_MASK_OFS	= 0x1d64,
-	HC_SOC_MAIN_IRQ_CAUSE_OFS = 0x20020,
-	HC_SOC_MAIN_IRQ_MASK_OFS = 0x20024,
+	/* Host Controller Main Interrupt Cause/Mask registers (1 per-chip) */
+	PCI_HC_MAIN_IRQ_CAUSE_OFS = 0x1d60,
+	PCI_HC_MAIN_IRQ_MASK_OFS  = 0x1d64,
+	SOC_HC_MAIN_IRQ_CAUSE_OFS = 0x20020,
+	SOC_HC_MAIN_IRQ_MASK_OFS  = 0x20024,
 	ERR_IRQ			= (1 << 0),	/* shift by port # */
 	DONE_IRQ		= (1 << 1),	/* shift by port # */
 	HC0_IRQ_PEND		= 0x1ff,	/* bits 0-8 = HC0's ports */
@@ -445,8 +446,8 @@
 	const struct mv_hw_ops	*ops;
 	int			n_ports;
 	void __iomem		*base;
-	void __iomem		*main_cause_reg_addr;
-	void __iomem		*main_mask_reg_addr;
+	void __iomem		*main_irq_cause_addr;
+	void __iomem		*main_irq_mask_addr;
 	u32			irq_cause_ofs;
 	u32			irq_mask_ofs;
 	u32			unmask_all_irqs;
@@ -727,8 +728,8 @@
  * Simple code, with two return values, so macro rather than inline.
  *
  * port is the sole input, in range 0..7.
- * shift is one output, for use with the main_cause and main_mask registers.
- * hardport is the other output, in range 0..3
+ * shift is one output, for use with main_irq_cause / main_irq_mask registers.
+ * hardport is the other output, in range 0..3.
  *
  * Note that port and hardport may be the same variable in some cases.
  */
@@ -1679,12 +1680,12 @@
 /**
  *      mv_host_intr - Handle all interrupts on the given host controller
  *      @host: host specific structure
- *      @main_cause: Main interrupt cause register for the chip.
+ *      @main_irq_cause: Main interrupt cause register for the chip.
  *
  *      LOCKING:
  *      Inherited from caller.
  */
-static int mv_host_intr(struct ata_host *host, u32 main_cause)
+static int mv_host_intr(struct ata_host *host, u32 main_irq_cause)
 {
 	struct mv_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->base, *hc_mmio = NULL;
@@ -1705,7 +1706,7 @@
 		 * Do nothing if port is not interrupting or is disabled:
 		 */
 		MV_PORT_TO_SHIFT_AND_HARDPORT(port, shift, hardport);
-		port_cause = (main_cause >> shift) & (DONE_IRQ | ERR_IRQ);
+		port_cause = (main_irq_cause >> shift) & (DONE_IRQ | ERR_IRQ);
 		if (!port_cause || !ap || (ap->flags & ATA_FLAG_DISABLED))
 			continue;
 		/*
@@ -1811,20 +1812,20 @@
 	struct ata_host *host = dev_instance;
 	struct mv_host_priv *hpriv = host->private_data;
 	unsigned int handled = 0;
-	u32 main_cause, main_mask;
+	u32 main_irq_cause, main_irq_mask;
 
 	spin_lock(&host->lock);
-	main_cause = readl(hpriv->main_cause_reg_addr);
-	main_mask  = readl(hpriv->main_mask_reg_addr);
+	main_irq_cause = readl(hpriv->main_irq_cause_addr);
+	main_irq_mask  = readl(hpriv->main_irq_mask_addr);
 	/*
 	 * Deal with cases where we either have nothing pending, or have read
 	 * a bogus register value which can indicate HW removal or PCI fault.
 	 */
-	if ((main_cause & main_mask) && (main_cause != 0xffffffffU)) {
-		if (unlikely((main_cause & PCI_ERR) && HAS_PCI(host)))
+	if ((main_irq_cause & main_irq_mask) && (main_irq_cause != 0xffffffffU)) {
+		if (unlikely((main_irq_cause & PCI_ERR) && HAS_PCI(host)))
 			handled = mv_pci_error(host, hpriv->base);
 		else
-			handled = mv_host_intr(host, main_cause);
+			handled = mv_host_intr(host, main_irq_cause);
 	}
 	spin_unlock(&host->lock);
 	return IRQ_RETVAL(handled);
@@ -2027,7 +2028,7 @@
 	ZERO(MV_PCI_DISC_TIMER);
 	ZERO(MV_PCI_MSI_TRIGGER);
 	writel(0x000100ff, mmio + MV_PCI_XBAR_TMOUT);
-	ZERO(HC_MAIN_IRQ_MASK_OFS);
+	ZERO(PCI_HC_MAIN_IRQ_MASK_OFS);
 	ZERO(MV_PCI_SERR_MASK);
 	ZERO(hpriv->irq_cause_ofs);
 	ZERO(hpriv->irq_mask_ofs);
@@ -2404,7 +2405,7 @@
 {
 	struct mv_host_priv *hpriv = ap->host->private_data;
 	unsigned int shift, hardport, port = ap->port_no;
-	u32 main_mask;
+	u32 main_irq_mask;
 
 	/* FIXME: handle coalescing completion events properly */
 
@@ -2412,9 +2413,9 @@
 	MV_PORT_TO_SHIFT_AND_HARDPORT(port, shift, hardport);
 
 	/* disable assertion of portN err, done events */
-	main_mask = readl(hpriv->main_mask_reg_addr);
-	main_mask &= ~((DONE_IRQ | ERR_IRQ) << shift);
-	writelfl(main_mask, hpriv->main_mask_reg_addr);
+	main_irq_mask = readl(hpriv->main_irq_mask_addr);
+	main_irq_mask &= ~((DONE_IRQ | ERR_IRQ) << shift);
+	writelfl(main_irq_mask, hpriv->main_irq_mask_addr);
 }
 
 static void mv_eh_thaw(struct ata_port *ap)
@@ -2423,7 +2424,7 @@
 	unsigned int shift, hardport, port = ap->port_no;
 	void __iomem *hc_mmio = mv_hc_base_from_port(hpriv->base, port);
 	void __iomem *port_mmio = mv_ap_base(ap);
-	u32 main_mask, hc_irq_cause;
+	u32 main_irq_mask, hc_irq_cause;
 
 	/* FIXME: handle coalescing completion events properly */
 
@@ -2438,9 +2439,9 @@
 	writelfl(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
 
 	/* enable assertion of portN err, done events */
-	main_mask = readl(hpriv->main_mask_reg_addr);
-	main_mask |= ((DONE_IRQ | ERR_IRQ) << shift);
-	writelfl(main_mask, hpriv->main_mask_reg_addr);
+	main_irq_mask = readl(hpriv->main_irq_mask_addr);
+	main_irq_mask |= ((DONE_IRQ | ERR_IRQ) << shift);
+	writelfl(main_irq_mask, hpriv->main_irq_mask_addr);
 }
 
 /**
@@ -2654,15 +2655,15 @@
 		goto done;
 
 	if (HAS_PCI(host)) {
-		hpriv->main_cause_reg_addr = mmio + HC_MAIN_IRQ_CAUSE_OFS;
-		hpriv->main_mask_reg_addr  = mmio + HC_MAIN_IRQ_MASK_OFS;
+		hpriv->main_irq_cause_addr = mmio + PCI_HC_MAIN_IRQ_CAUSE_OFS;
+		hpriv->main_irq_mask_addr  = mmio + PCI_HC_MAIN_IRQ_MASK_OFS;
 	} else {
-		hpriv->main_cause_reg_addr = mmio + HC_SOC_MAIN_IRQ_CAUSE_OFS;
-		hpriv->main_mask_reg_addr  = mmio + HC_SOC_MAIN_IRQ_MASK_OFS;
+		hpriv->main_irq_cause_addr = mmio + SOC_HC_MAIN_IRQ_CAUSE_OFS;
+		hpriv->main_irq_mask_addr  = mmio + SOC_HC_MAIN_IRQ_MASK_OFS;
 	}
 
 	/* global interrupt mask: 0 == mask everything */
-	writel(0, hpriv->main_mask_reg_addr);
+	writel(0, hpriv->main_irq_mask_addr);
 
 	n_hc = mv_get_hc_count(host->ports[0]->flags);
 
@@ -2712,23 +2713,23 @@
 		writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
 		if (IS_GEN_I(hpriv))
 			writelfl(~HC_MAIN_MASKED_IRQS_5,
-				 hpriv->main_mask_reg_addr);
+				 hpriv->main_irq_mask_addr);
 		else
 			writelfl(~HC_MAIN_MASKED_IRQS,
-				 hpriv->main_mask_reg_addr);
+				 hpriv->main_irq_mask_addr);
 
 		VPRINTK("HC MAIN IRQ cause/mask=0x%08x/0x%08x "
 			"PCI int cause/mask=0x%08x/0x%08x\n",
-			readl(hpriv->main_cause_reg_addr),
-			readl(hpriv->main_mask_reg_addr),
+			readl(hpriv->main_irq_cause_addr),
+			readl(hpriv->main_irq_mask_addr),
 			readl(mmio + hpriv->irq_cause_ofs),
 			readl(mmio + hpriv->irq_mask_ofs));
 	} else {
 		writelfl(~HC_MAIN_MASKED_IRQS_SOC,
-			 hpriv->main_mask_reg_addr);
+			 hpriv->main_irq_mask_addr);
 		VPRINTK("HC MAIN IRQ cause/mask=0x%08x/0x%08x\n",
-			readl(hpriv->main_cause_reg_addr),
-			readl(hpriv->main_mask_reg_addr));
+			readl(hpriv->main_irq_cause_addr),
+			readl(hpriv->main_irq_mask_addr));
 	}
 done:
 	return rc;
