From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 03/03] sata_mv implement IRQ coalescing (v2)
Date: Tue, 10 Mar 2009 22:01:17 -0400
Message-ID: <49B71B6D.40406@rtr.ca>
References: <49B6EE95.1010808@rtr.ca> <49B6EED8.8060205@rtr.ca> <49B6EF18.8050000@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:59084 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753834AbZCKCBV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Mar 2009 22:01:21 -0400
In-Reply-To: <49B6EF18.8050000@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Add IRQ coalescing to sata_mv (off by default).

This feature can reduce total interrupt overhead for RAID setups
in some situations, by deferring the interrupt signal until one or both of:

 a) a specified io_count (completed SATA commands) is achieved, or
 b) a specified time interval elapses after an IO completion.
 
For now, module parameters are used to set the irq_coalescing_io_count
and irq_coalescing_usecs (timeout) globally.  These may eventually
be supplemented with sysfs attributes, so that thresholds can be set
on-the-fly and on a per-chip (or even per-host_controller) basis.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

This (v2) replaces the original 03/03 patch.
This is for #upstream libata-dev #upstream

--- old/drivers/ata/sata_mv.c	2009-03-10 18:28:30.000000000 -0400
+++ new/drivers/ata/sata_mv.c	2009-03-10 21:30:27.000000000 -0400
@@ -34,10 +34,7 @@
  *
  * --> Develop a low-power-consumption strategy, and implement it.
  *
- * --> [Experiment, low priority] Investigate interrupt coalescing.
- *       Quite often, especially with PCI Message Signalled Interrupts (MSI),
- *       the overhead reduced by interrupt mitigation is quite often not
- *       worth the latency cost.
+ * --> Add sysfs attributes for per-chip / per-HC IRQ coalescing thresholds.
  *
  * --> [Experiment, Marvell value added] Is it possible to use target
  *       mode to cross-connect two Linux boxes with Marvell cards?  If so,
@@ -67,7 +64,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"1.26"
+#define DRV_VERSION	"1.27"
 
 /*
  * module options
@@ -79,6 +76,16 @@
 MODULE_PARM_DESC(msi, "Enable use of PCI MSI (0=off, 1=on)");
 #endif
 
+static int irq_coalescing_io_count;
+module_param(irq_coalescing_io_count, int, S_IRUGO);
+MODULE_PARM_DESC(irq_coalescing_io_count,
+		 "IRQ coalescing I/O count threshold (0..255)");
+
+static int irq_coalescing_usecs;
+module_param(irq_coalescing_usecs, int, S_IRUGO);
+MODULE_PARM_DESC(irq_coalescing_usecs,
+		 "IRQ coalescing time threshold in usecs");
+
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
 	MV_PRIMARY_BAR		= 0,	/* offset 0x10: memory space */
@@ -88,8 +95,33 @@
 	MV_MAJOR_REG_AREA_SZ	= 0x10000,	/* 64KB */
 	MV_MINOR_REG_AREA_SZ	= 0x2000,	/* 8KB */
 
+	/* For use with both IRQ coalescing methods ("all ports" or "per-HC" */
+	COAL_CLOCKS_PER_USEC	= 150,		/* for calculating COAL_TIMEs */
+	MAX_COAL_TIME_THRESHOLD	= ((1 << 24) - 1), /* internal clocks count */
+	MAX_COAL_IO_COUNT	= 255,		/* completed I/O count */
+
 	MV_PCI_REG_BASE		= 0,
 
+	/*
+	 * Per-chip ("all ports") interrupt coalescing feature.
+	 * This is only for GEN_II / GEN_IIE hardware.
+	 *
+	 * Coalescing defers the interrupt until either the IO_THRESHOLD
+	 * (count of completed I/Os) is met, or the TIME_THRESHOLD is met.
+	 */
+	MV_COAL_REG_BASE	= 0x18000,
+	MV_IRQ_COAL_CAUSE	= (MV_COAL_REG_BASE + 0x08),
+	ALL_PORTS_COAL_IRQ	= (1 << 4),	/* all ports irq event */
+
+	MV_IRQ_COAL_IO_THRESHOLD   = (MV_COAL_REG_BASE + 0xcc),
+	MV_IRQ_COAL_TIME_THRESHOLD = (MV_COAL_REG_BASE + 0xd0),
+
+	/*
+	 * Registers for the (unused here) transaction coalescing feature:
+	 */
+	MV_TRAN_COAL_CAUSE_LO	= (MV_COAL_REG_BASE + 0x88),
+	MV_TRAN_COAL_CAUSE_HI	= (MV_COAL_REG_BASE + 0x8c),
+
 	MV_SATAHC0_REG_BASE	= 0x20000,
 	MV_FLASH_CTL_OFS	= 0x1046c,
 	MV_GPIO_PORT_CTL_OFS	= 0x104f0,
@@ -186,6 +218,8 @@
 	DONE_IRQ		= (1 << 1),	/* shift by (2 * port #) */
 	HC0_IRQ_PEND		= 0x1ff,	/* bits 0-8 = HC0's ports */
 	HC_SHIFT		= 9,		/* bits 9-17 = HC1's ports */
+	DONE_IRQ_0_3		= 0x000000aa,	/* DONE_IRQ ports 0,1,2,3 */
+	DONE_IRQ_4_7		= (DONE_IRQ_0_3 << HC_SHIFT),  /* 4,5,6,7 */
 	PCI_ERR			= (1 << 18),
 	TRAN_COAL_LO_DONE	= (1 << 19),	/* transaction coalescing */
 	TRAN_COAL_HI_DONE	= (1 << 20),	/* transaction coalescing */
@@ -207,6 +241,16 @@
 	HC_COAL_IRQ		= (1 << 4),	/* IRQ coalescing */
 	DEV_IRQ			= (1 << 8),	/* shift by port # */
 
+	/*
+	 * Per-HC (Host-Controller) interrupt coalescing feature.
+	 * This is present on all chip generations.
+	 *
+	 * Coalescing defers the interrupt until either the IO_THRESHOLD
+	 * (count of completed I/Os) is met, or the TIME_THRESHOLD is met.
+	 */
+	HC_IRQ_COAL_IO_THRESHOLD_OFS	= 0x000c,
+	HC_IRQ_COAL_TIME_THRESHOLD_OFS	= 0x0010,
+
 	/* Shadow block registers */
 	SHD_BLK_OFS		= 0x100,
 	SHD_CTL_AST_OFS		= 0x20,		/* ofs from SHD_BLK_OFS */
@@ -897,6 +941,23 @@
 		 port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 }
 
+static void mv_write_main_irq_mask(u32 mask, struct mv_host_priv *hpriv)
+{
+	/*
+	 * When writing to the main_irq_mask in hardware,
+	 * we must ensure exclusivity between the interrupt coalescing bits
+	 * and the corresponding individual port DONE_IRQ bits.
+	 *
+	 * Note that this register is really an "IRQ enable" register,
+	 * not an "IRQ mask" register as Marvell's naming might suggest.
+	 */
+	if (mask & (ALL_PORTS_COAL_DONE | PORTS_0_3_COAL_DONE))
+		mask &= ~DONE_IRQ_0_3;
+	if (mask & (ALL_PORTS_COAL_DONE | PORTS_4_7_COAL_DONE))
+		mask &= ~DONE_IRQ_4_7;
+	writelfl(mask, hpriv->main_irq_mask_addr);
+}
+
 static void mv_set_main_irq_mask(struct ata_host *host,
 				 u32 disable_bits, u32 enable_bits)
 {
@@ -907,7 +968,7 @@
 	new_mask = (old_mask & ~disable_bits) | enable_bits;
 	if (new_mask != old_mask) {
 		hpriv->main_irq_mask = new_mask;
-		writelfl(new_mask, hpriv->main_irq_mask_addr);
+		mv_write_main_irq_mask(new_mask, hpriv);
 	}
 }
 
@@ -948,6 +1009,64 @@
 	mv_enable_port_irqs(ap, port_irqs);
 }
 
+static void mv_set_irq_coalescing(struct ata_host *host,
+				  unsigned int count, unsigned int usecs)
+{
+	struct mv_host_priv *hpriv = host->private_data;
+	void __iomem *mmio = hpriv->base, *hc_mmio;
+	u32 coal_enable = 0;
+	unsigned long flags;
+	unsigned int clks;
+	const u32 coal_disable = PORTS_0_3_COAL_DONE | PORTS_4_7_COAL_DONE |
+							ALL_PORTS_COAL_DONE;
+
+	/* Disable IRQ coalescing if either threshold is zero */
+	if (!usecs || !count) {
+		clks = count = 0;
+	} else {
+		/* Respect maximum limits of the hardware */
+		clks = usecs * COAL_CLOCKS_PER_USEC;
+		if (clks > MAX_COAL_TIME_THRESHOLD)
+			clks = MAX_COAL_TIME_THRESHOLD;
+		if (count > MAX_COAL_IO_COUNT)
+			count = MAX_COAL_IO_COUNT;
+	}
+
+	spin_lock_irqsave(&host->lock, flags);
+
+#if 0 /* disabled pending functional clarification from Marvell */
+	if (!IS_GEN_I(hpriv)) {
+		/*
+		 * GEN_II/GEN_IIE: global thresholds for the entire chip.
+		 */
+		writel(clks,  mmio + MV_IRQ_COAL_TIME_THRESHOLD);
+		writel(count, mmio + MV_IRQ_COAL_IO_THRESHOLD);
+		/* clear leftover coal IRQ bit */
+		writelfl(~ALL_PORTS_COAL_IRQ, mmio + MV_IRQ_COAL_CAUSE);
+		clks = count = 0; /* so as to clear the alternate regs below */
+		coal_enable = ALL_PORTS_COAL_DONE;
+	}
+#endif
+	/*
+	 * All chips: independent thresholds for each HC on the chip.
+	 */
+	hc_mmio = mv_hc_base_from_port(mmio, 0);
+	writel(clks,  hc_mmio + HC_IRQ_COAL_TIME_THRESHOLD_OFS);
+	writel(count, hc_mmio + HC_IRQ_COAL_IO_THRESHOLD_OFS);
+	coal_enable |= PORTS_0_3_COAL_DONE;
+	if (hpriv->n_ports > 4) {
+		hc_mmio = mv_hc_base_from_port(mmio, MV_PORTS_PER_HC);
+		writel(clks,  hc_mmio + HC_IRQ_COAL_TIME_THRESHOLD_OFS);
+		writel(count, hc_mmio + HC_IRQ_COAL_IO_THRESHOLD_OFS);
+		coal_enable |= PORTS_4_7_COAL_DONE;
+	}
+	if (!count)
+		coal_enable = 0;
+	mv_set_main_irq_mask(host, coal_disable, coal_enable);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
 /**
  *      mv_start_edma - Enable eDMA engine
  *      @base: port base address
@@ -2500,6 +2619,10 @@
 	void __iomem *mmio = hpriv->base, *hc_mmio;
 	unsigned int handled = 0, port;
 
+	/* If asserted, clear the "all ports" IRQ coalescing bit */
+	if (main_irq_cause & ALL_PORTS_COAL_DONE)
+		writel(~ALL_PORTS_COAL_IRQ, mmio + MV_IRQ_COAL_CAUSE);
+
 	for (port = 0; port < hpriv->n_ports; port++) {
 		struct ata_port *ap = host->ports[port];
 		unsigned int p, shift, hardport, port_cause;
@@ -2532,6 +2655,8 @@
 			 * to ack (only) those ports via hc_irq_cause.
 			 */
 			ack_irqs = 0;
+			if (hc_cause & PORTS_0_3_COAL_DONE)
+				ack_irqs = HC_COAL_IRQ;
 			for (p = 0; p < MV_PORTS_PER_HC; ++p) {
 				if ((port + p) >= hpriv->n_ports)
 					break;
@@ -2620,7 +2745,7 @@
 
 	/* for MSI:  block new interrupts while in here */
 	if (using_msi)
-		writel(0, hpriv->main_irq_mask_addr);
+		mv_write_main_irq_mask(0, hpriv);
 
 	main_irq_cause = readl(hpriv->main_irq_cause_addr);
 	pending_irqs   = main_irq_cause & hpriv->main_irq_mask;
@@ -2637,7 +2762,7 @@
 
 	/* for MSI: unmask; interrupt cause bits will retrigger now */
 	if (using_msi)
-		writel(hpriv->main_irq_mask, hpriv->main_irq_mask_addr);
+		mv_write_main_irq_mask(hpriv->main_irq_mask, hpriv);
 
 	spin_unlock(&host->lock);
 
@@ -3546,6 +3671,8 @@
 	 * The per-port interrupts get done later as ports are set up.
 	 */
 	mv_set_main_irq_mask(host, 0, PCI_ERR);
+	mv_set_irq_coalescing(host, irq_coalescing_io_count,
+				    irq_coalescing_usecs);
 done:
 	return rc;
 }
