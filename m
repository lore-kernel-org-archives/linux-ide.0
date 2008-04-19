From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 5/8] sata_mv tidy host controller interrupt handling
Date: Sat, 19 Apr 2008 14:52:15 -0400
Message-ID: <480A3F5F.9030008@rtr.ca>
References: <480A3D2E.4040503@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3908 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129AbYDSSwL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Apr 2008 14:52:11 -0400
In-Reply-To: <480A3D2E.4040503@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tidy up host controller interrupt handling, by moving the weirdo
bit shifting from mv_interrupt() to mv_host_intr().

This lets us take advantage of the MV_PORT_TO_SHIFT_AND_HARDPORT() macro
from an earlier patch to greatly simplify the port numbering logic.

Also, defer reading the hc_irq_cause (one per hc) until it is
actually proven to be needed.  This may save a microsecond or
so per interrupt, on average (a later patchset will further reduce
unnecessary register reads throughout the driver).

Apart from that, we still leave the actual IRQ handling logic alone.
Subsequent patches in this series will address that.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-04-19 13:21:28.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-04-19 13:36:17.000000000 -0400
@@ -1689,50 +1689,48 @@
  *      LOCKING:
  *      Inherited from caller.
  */
-static void mv_host_intr(struct ata_host *host, u32 relevant, unsigned int hc)
+static int mv_host_intr(struct ata_host *host, u32 main_cause)
 {
 	struct mv_host_priv *hpriv = host->private_data;
-	void __iomem *mmio = hpriv->base;
-	void __iomem *hc_mmio = mv_hc_base(mmio, hc);
-	u32 hc_irq_cause;
-	int port, port0, last_port;
-
-	if (hc == 0)
-		port0 = 0;
-	else
-		port0 = MV_PORTS_PER_HC;
-
-	if (HAS_PCI(host))
-		last_port = port0 + MV_PORTS_PER_HC;
-	else
-		last_port = port0 + hpriv->n_ports;
-	/* we'll need the HC success int register in most cases */
-	hc_irq_cause = readl(hc_mmio + HC_IRQ_CAUSE_OFS);
-	if (!hc_irq_cause)
-		return;
-
-	writelfl(~hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
+	void __iomem *mmio = hpriv->base, *hc_mmio = NULL;
+	u32 hc_irq_cause = 0;
+	unsigned int handled = 0, port;
 
-	VPRINTK("ENTER, hc%u relevant=0x%08x HC IRQ cause=0x%08x\n",
-		hc, relevant, hc_irq_cause);
-
-	for (port = port0; port < last_port; port++) {
+	for (port = 0; port < hpriv->n_ports; port++) {
 		struct ata_port *ap = host->ports[port];
 		struct mv_port_priv *pp;
-		int have_err_bits, hardport, shift;
-
-		if ((!ap) || (ap->flags & ATA_FLAG_DISABLED))
+		unsigned int shift, hardport, port_cause;
+		/*
+		 * When we move to the second hc, flag our cached
+		 * copies of hc_mmio (and hc_irq_cause) as invalid again.
+		 */
+		if (port == MV_PORTS_PER_HC)
+			hc_mmio = NULL;
+		/*
+		 * Do nothing if port is not interrupting or is disabled:
+		 */
+		MV_PORT_TO_SHIFT_AND_HARDPORT(port,shift,hardport);
+		port_cause = (main_cause >> shift) & (DONE_IRQ | ERR_IRQ);
+		if (!port_cause || !ap || (ap->flags & ATA_FLAG_DISABLED))
 			continue;
+		/*
+		 * Each hc within the host has its own hc_irq_cause register.
+		 * We defer reading it until we know we need it, right now:
+		 *
+		 * FIXME later: we don't really need to read this register
+		 * (some logic changes required below if we go that way),
+		 * because it doesn't tell us anything new.  But we do need
+		 * to write to it, outside the top of this loop,
+		 * to reset the interrupt triggers for next time.
+		 */
+		if (!hc_mmio) {
+			hc_mmio = mv_hc_base_from_port(mmio, port);
+			hc_irq_cause = readl(hc_mmio + HC_IRQ_CAUSE_OFS);
+			writelfl(~hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
+			handled = 1;
+		}
 
-		pp = ap->private_data;
-
-		shift = port << 1;		/* (port * 2) */
-		if (port >= MV_PORTS_PER_HC)
-			shift++;	/* skip bit 8 in the HC Main IRQ reg */
-
-		have_err_bits = ((ERR_IRQ << shift) & relevant);
-
-		if (unlikely(have_err_bits)) {
+		if (unlikely(port_cause & ERR_IRQ)) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->link.active_tag);
@@ -1743,8 +1741,7 @@
 			continue;
 		}
 
-		hardport = mv_hardport_from_port(port); /* range 0..3 */
-
+		pp = ap->private_data;
 		if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
 			if ((DMA_IRQ << hardport) & hc_irq_cause)
 				mv_process_crpb_entries(ap, pp);
@@ -1753,10 +1750,10 @@
 				mv_intr_pio(ap);
 		}
 	}
-	VPRINTK("EXIT\n");
+	return handled;
 }
 
-static void mv_pci_error(struct ata_host *host, void __iomem *mmio)
+static int mv_pci_error(struct ata_host *host, void __iomem *mmio)
 {
 	struct mv_host_priv *hpriv = host->private_data;
 	struct ata_port *ap;
@@ -1794,6 +1791,7 @@
 			ata_port_freeze(ap);
 		}
 	}
+	return 1;	/* handled */
 }
 
 /**
@@ -1814,8 +1812,7 @@
 {
 	struct ata_host *host = dev_instance;
 	struct mv_host_priv *hpriv = host->private_data;
-	unsigned int hc, handled = 0, n_hcs;
-	void __iomem *mmio = hpriv->base;
+	unsigned int handled = 0;
 	u32 main_cause, main_mask;
 
 	spin_lock(&host->lock);
@@ -1825,26 +1822,12 @@
 	 * Deal with cases where we either have nothing pending, or have read
 	 * a bogus register value which can indicate HW removal or PCI fault.
 	 */
-	if (!(main_cause & main_mask) || (main_cause == 0xffffffffU))
-		goto out_unlock;
-
-	n_hcs = mv_get_hc_count(host->ports[0]->flags);
-
-	if (unlikely((main_cause & PCI_ERR) && HAS_PCI(host))) {
-		mv_pci_error(host, mmio);
-		handled = 1;
-		goto out_unlock;	/* skip all other HC irq handling */
-	}
-
-	for (hc = 0; hc < n_hcs; hc++) {
-		u32 relevant = main_cause & (HC0_IRQ_PEND << (hc * HC_SHIFT));
-		if (relevant) {
-			mv_host_intr(host, relevant, hc);
-			handled = 1;
-		}
+	if ((main_cause & main_mask) && (main_cause != 0xffffffffU)) {
+		if (unlikely((main_cause & PCI_ERR) && HAS_PCI(host)))
+			handled = mv_pci_error(host, hpriv->base);
+		else
+			handled = mv_host_intr(host, main_cause);
 	}
-
-out_unlock:
 	spin_unlock(&host->lock);
 	return IRQ_RETVAL(handled);
 }
