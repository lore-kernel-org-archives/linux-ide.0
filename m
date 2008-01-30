From: saeed.bishara@gmail.com
Subject: [PATCH 2/2 v3] sata_mv: Support SoC controllers
Date: Wed, 30 Jan 2008 11:50:46 -1100
Message-ID: <12017334492566-git-send-email-saeed.bishara@gmail.com>
References: <1201733446499-git-send-email-saeed.bishara@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host2.marvell.com ([65.219.4.2]:23089 "EHLO maili.marvell.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932380AbYA3UK5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jan 2008 15:10:57 -0500
In-Reply-To: <1201733446499-git-send-email-saeed.bishara@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: saeed@marvell.com, saeed.bishara@gmail.com, htejun@gmail.com, liml@rtr.ca, Saeed Bishara <saeed@il.marvell.com>

From: Saeed Bishara <saeed@ubuntu-saeed.il.marvell.com>

Marvell's Orion SoC includes SATA controllers based on Marvell's
PCI-to-SATA 88SX controllers. This patch extends the libATA sata_mv
driver to support those controllers.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c   |  365 +++++++++++++++++++++++++++++++++++++++++------
 include/linux/sata_mv.h |   21 +++
 2 files changed, 341 insertions(+), 45 deletions(-)
 create mode 100644 include/linux/sata_mv.h

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 3c1b5c9..a957ed7 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -71,6 +71,8 @@
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/sata_mv.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
@@ -179,6 +181,8 @@ enum {
 
 	HC_MAIN_IRQ_CAUSE_OFS	= 0x1d60,
 	HC_MAIN_IRQ_MASK_OFS	= 0x1d64,
+	HC_SOC_MAIN_IRQ_CAUSE_OFS = 0x20020,
+	HC_SOC_MAIN_IRQ_MASK_OFS = 0x20024,
 	PORT0_ERR		= (1 << 0),	/* shift by port # */
 	PORT0_DONE		= (1 << 1),	/* shift by port # */
 	HC0_IRQ_PEND		= 0x1ff,	/* bits 0-8 = HC0's ports */
@@ -194,11 +198,13 @@ enum {
 	TWSI_INT		= (1 << 24),
 	HC_MAIN_RSVD		= (0x7f << 25),	/* bits 31-25 */
 	HC_MAIN_RSVD_5		= (0x1fff << 19), /* bits 31-19 */
+	HC_MAIN_RSVD_SOC 	= (0x3fffffb << 6),     /* bits 31-9, 7-6 */
 	HC_MAIN_MASKED_IRQS	= (TRAN_LO_DONE | TRAN_HI_DONE |
 				   PORTS_0_7_COAL_DONE | GPIO_INT | TWSI_INT |
 				   HC_MAIN_RSVD),
 	HC_MAIN_MASKED_IRQS_5	= (PORTS_0_3_COAL_DONE | PORTS_4_7_COAL_DONE |
 				   HC_MAIN_RSVD_5),
+	HC_MAIN_MASKED_IRQS_SOC = (PORTS_0_3_COAL_DONE | HC_MAIN_RSVD_SOC),
 
 	/* SATAHC registers */
 	HC_CFG_OFS		= 0,
@@ -368,6 +374,7 @@ enum chip_type {
 	chip_608x,
 	chip_6042,
 	chip_7042,
+	chip_soc,
 };
 
 /* Command ReQuest Block: 32B */
@@ -424,6 +431,10 @@ struct mv_host_priv {
 	u32			hp_flags;
 	struct mv_port_signal	signal[8];
 	const struct mv_hw_ops	*ops;
+	int			n_ports;
+	void __iomem		*base;
+	void __iomem		*main_cause_reg_addr;
+	void __iomem		*main_mask_reg_addr;
 	u32			irq_cause_ofs;
 	u32			irq_mask_ofs;
 	u32			unmask_all_irqs;
@@ -482,6 +493,15 @@ static void mv6_read_preamp(struct mv_host_priv *hpriv, int idx,
 static int mv6_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
 			unsigned int n_hc);
 static void mv6_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio);
+static void mv_soc_enable_leds(struct mv_host_priv *hpriv,
+				      void __iomem *mmio);
+static void mv_soc_read_preamp(struct mv_host_priv *hpriv, int idx,
+				      void __iomem *mmio);
+static int mv_soc_reset_hc(struct mv_host_priv *hpriv,
+				  void __iomem *mmio, unsigned int n_hc);
+static void mv_soc_reset_flash(struct mv_host_priv *hpriv,
+				      void __iomem *mmio);
+static void mv_soc_reset_bus(struct ata_host *host, void __iomem *mmio);
 static void mv_reset_pci_bus(struct ata_host *host, void __iomem *mmio);
 static void mv_channel_reset(struct mv_host_priv *hpriv, void __iomem *mmio,
 			     unsigned int port_no);
@@ -661,6 +681,12 @@ static const struct ata_port_info mv_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv_iie_ops,
 	},
+	{  /* chip_soc */
+		.flags = MV_COMMON_FLAGS | MV_FLAG_SOC,
+		.pio_mask = 0x1f,      /* pio0-4 */
+		.udma_mask = ATA_UDMA6,
+		.port_ops = &mv_iie_ops,
+	},
 };
 
 static const struct pci_device_id mv_pci_tbl[] = {
@@ -711,6 +737,15 @@ static const struct mv_hw_ops mv6xxx_ops = {
 	.reset_bus		= mv_reset_pci_bus,
 };
 
+static const struct mv_hw_ops mv_soc_ops = {
+	.phy_errata		= mv6_phy_errata,
+	.enable_leds		= mv_soc_enable_leds,
+	.read_preamp		= mv_soc_read_preamp,
+	.reset_hc		= mv_soc_reset_hc,
+	.reset_flash		= mv_soc_reset_flash,
+	.reset_bus		= mv_soc_reset_bus,
+};
+
 /*
  * Functions
  */
@@ -749,9 +784,15 @@ static inline void __iomem *mv_port_base(void __iomem *base, unsigned int port)
 		(mv_hardport_from_port(port) * MV_PORT_REG_SZ);
 }
 
+static inline void __iomem *mv_host_base(struct ata_host *host)
+{
+	struct mv_host_priv *hpriv = host->private_data;
+	return hpriv->base;
+}
+
 static inline void __iomem *mv_ap_base(struct ata_port *ap)
 {
-	return mv_port_base(ap->host->iomap[MV_PRIMARY_BAR], ap->port_no);
+	return mv_port_base(mv_host_base(ap->host), ap->port_no);
 }
 
 static inline int mv_get_hc_count(unsigned long port_flags)
@@ -1649,16 +1690,21 @@ static void mv_intr_edma(struct ata_port *ap)
  */
 static void mv_host_intr(struct ata_host *host, u32 relevant, unsigned int hc)
 {
-	void __iomem *mmio = host->iomap[MV_PRIMARY_BAR];
+	struct mv_host_priv *hpriv = host->private_data;
+	void __iomem *mmio = hpriv->base;
 	void __iomem *hc_mmio = mv_hc_base(mmio, hc);
 	u32 hc_irq_cause;
-	int port, port0;
+	int port, port0, last_port;
 
 	if (hc == 0)
 		port0 = 0;
 	else
 		port0 = MV_PORTS_PER_HC;
 
+	if (HAS_PCI(host))
+		last_port = port0 + MV_PORTS_PER_HC;
+	else
+		last_port = port0 + hpriv->n_ports;
 	/* we'll need the HC success int register in most cases */
 	hc_irq_cause = readl(hc_mmio + HC_IRQ_CAUSE_OFS);
 	if (!hc_irq_cause)
@@ -1669,7 +1715,7 @@ static void mv_host_intr(struct ata_host *host, u32 relevant, unsigned int hc)
 	VPRINTK("ENTER, hc%u relevant=0x%08x HC IRQ cause=0x%08x\n",
 		hc, relevant, hc_irq_cause);
 
-	for (port = port0; port < port0 + MV_PORTS_PER_HC; port++) {
+	for (port = port0; port < port0 + last_port; port++) {
 		struct ata_port *ap = host->ports[port];
 		struct mv_port_priv *pp = ap->private_data;
 		int have_err_bits, hard_port, shift;
@@ -1764,13 +1810,15 @@ static void mv_pci_error(struct ata_host *host, void __iomem *mmio)
 static irqreturn_t mv_interrupt(int irq, void *dev_instance)
 {
 	struct ata_host *host = dev_instance;
+	struct mv_host_priv *hpriv = host->private_data;
 	unsigned int hc, handled = 0, n_hcs;
-	void __iomem *mmio = host->iomap[MV_PRIMARY_BAR];
+	void __iomem *mmio = hpriv->base;
 	u32 irq_stat, irq_mask;
 
 	spin_lock(&host->lock);
-	irq_stat = readl(mmio + HC_MAIN_IRQ_CAUSE_OFS);
-	irq_mask = readl(mmio + HC_MAIN_IRQ_MASK_OFS);
+
+	irq_stat = readl(hpriv->main_cause_reg_addr);
+	irq_mask = readl(hpriv->main_mask_reg_addr);
 
 	/* check the cases where we either have nothing pending or have read
 	 * a bogus register value which can indicate HW removal or PCI fault
@@ -1827,7 +1875,8 @@ static unsigned int mv5_scr_offset(unsigned int sc_reg_in)
 
 static int mv5_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u32 *val)
 {
-	void __iomem *mmio = ap->host->iomap[MV_PRIMARY_BAR];
+	struct mv_host_priv *hpriv = ap->host->private_data;
+	void __iomem *mmio = hpriv->base;
 	void __iomem *addr = mv5_phy_base(mmio, ap->port_no);
 	unsigned int ofs = mv5_scr_offset(sc_reg_in);
 
@@ -1840,7 +1889,8 @@ static int mv5_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u32 *val)
 
 static int mv5_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val)
 {
-	void __iomem *mmio = ap->host->iomap[MV_PRIMARY_BAR];
+	struct mv_host_priv *hpriv = ap->host->private_data;
+	void __iomem *mmio = hpriv->base;
 	void __iomem *addr = mv5_phy_base(mmio, ap->port_no);
 	unsigned int ofs = mv5_scr_offset(sc_reg_in);
 
@@ -2178,6 +2228,93 @@ static void mv6_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
 	writel(m2, port_mmio + PHY_MODE2);
 }
 
+/* TODO: use the generic LED interface to configure the SATA Presence */
+/* & Acitivy LEDs on the board */
+static void mv_soc_enable_leds(struct mv_host_priv *hpriv,
+				      void __iomem *mmio)
+{
+	return;
+}
+
+static void mv_soc_read_preamp(struct mv_host_priv *hpriv, int idx,
+			   void __iomem *mmio)
+{
+	void __iomem *port_mmio;
+	u32 tmp;
+
+	port_mmio = mv_port_base(mmio, idx);
+	tmp = readl(port_mmio + PHY_MODE2);
+
+	hpriv->signal[idx].amps = tmp & 0x700;	/* bits 10:8 */
+	hpriv->signal[idx].pre = tmp & 0xe0;	/* bits 7:5 */
+}
+
+#undef ZERO
+#define ZERO(reg) writel(0, port_mmio + (reg))
+static void mv_soc_reset_hc_port(struct mv_host_priv *hpriv,
+					void __iomem *mmio, unsigned int port)
+{
+	void __iomem *port_mmio = mv_port_base(mmio, port);
+
+	writelfl(EDMA_DS, port_mmio + EDMA_CMD_OFS);
+
+	mv_channel_reset(hpriv, mmio, port);
+
+	ZERO(0x028);		/* command */
+	writel(0x101f, port_mmio + EDMA_CFG_OFS);
+	ZERO(0x004);		/* timer */
+	ZERO(0x008);		/* irq err cause */
+	ZERO(0x00c);		/* irq err mask */
+	ZERO(0x010);		/* rq bah */
+	ZERO(0x014);		/* rq inp */
+	ZERO(0x018);		/* rq outp */
+	ZERO(0x01c);		/* respq bah */
+	ZERO(0x024);		/* respq outp */
+	ZERO(0x020);		/* respq inp */
+	ZERO(0x02c);		/* test control */
+	writel(0xbc, port_mmio + EDMA_IORDY_TMOUT);
+}
+
+#undef ZERO
+
+#define ZERO(reg) writel(0, hc_mmio + (reg))
+static void mv_soc_reset_one_hc(struct mv_host_priv *hpriv,
+				       void __iomem *mmio)
+{
+	void __iomem *hc_mmio = mv_hc_base(mmio, 0);
+
+	ZERO(0x00c);
+	ZERO(0x010);
+	ZERO(0x014);
+
+}
+
+#undef ZERO
+
+static int mv_soc_reset_hc(struct mv_host_priv *hpriv,
+				  void __iomem *mmio, unsigned int n_hc)
+{
+	unsigned int port;
+
+	for (port = 0; port < hpriv->n_ports; port++)
+		mv_soc_reset_hc_port(hpriv, mmio, port);
+
+	mv_soc_reset_one_hc(hpriv, mmio);
+
+	return 0;
+}
+
+static void mv_soc_reset_flash(struct mv_host_priv *hpriv,
+				      void __iomem *mmio)
+{
+	return;
+}
+
+static void mv_soc_reset_bus(struct ata_host *host, void __iomem *mmio)
+{
+	return;
+}
+
 static void mv_channel_reset(struct mv_host_priv *hpriv, void __iomem *mmio,
 			     unsigned int port_no)
 {
@@ -2342,7 +2479,7 @@ static int mv_hardreset(struct ata_link *link, unsigned int *class,
 {
 	struct ata_port *ap = link->ap;
 	struct mv_host_priv *hpriv = ap->host->private_data;
-	void __iomem *mmio = ap->host->iomap[MV_PRIMARY_BAR];
+	void __iomem *mmio = hpriv->base;
 
 	mv_stop_dma(ap);
 
@@ -2383,7 +2520,7 @@ static void mv_error_handler(struct ata_port *ap)
 
 static void mv_eh_freeze(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->host->iomap[MV_PRIMARY_BAR];
+	struct mv_host_priv *hpriv = ap->host->private_data;
 	unsigned int hc = (ap->port_no > 3) ? 1 : 0;
 	u32 tmp, mask;
 	unsigned int shift;
@@ -2397,13 +2534,14 @@ static void mv_eh_freeze(struct ata_port *ap)
 	mask = 0x3 << shift;
 
 	/* disable assertion of portN err, done events */
-	tmp = readl(mmio + HC_MAIN_IRQ_MASK_OFS);
-	writelfl(tmp & ~mask, mmio + HC_MAIN_IRQ_MASK_OFS);
+	tmp = readl(hpriv->main_mask_reg_addr);
+	writelfl(tmp & ~mask, hpriv->main_mask_reg_addr);
 }
 
 static void mv_eh_thaw(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->host->iomap[MV_PRIMARY_BAR];
+	struct mv_host_priv *hpriv = ap->host->private_data;
+	void __iomem *mmio = hpriv->base;
 	unsigned int hc = (ap->port_no > 3) ? 1 : 0;
 	void __iomem *hc_mmio = mv_hc_base(mmio, hc);
 	void __iomem *port_mmio = mv_ap_base(ap);
@@ -2430,8 +2568,8 @@ static void mv_eh_thaw(struct ata_port *ap)
 	writel(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
 
 	/* enable assertion of portN err, done events */
-	tmp = readl(mmio + HC_MAIN_IRQ_MASK_OFS);
-	writelfl(tmp | mask, mmio + HC_MAIN_IRQ_MASK_OFS);
+	tmp = readl(hpriv->main_mask_reg_addr);
+	writelfl(tmp | mask, hpriv->main_mask_reg_addr);
 }
 
 /**
@@ -2598,9 +2736,13 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
 			break;
 		}
 		break;
+	case chip_soc:
+		hpriv->ops = &mv_soc_ops;
+		hp_flags |= MV_HP_ERRATA_60X1C0;
+		break;
 
 	default:
-		dev_printk(KERN_ERR, &pdev->dev,
+		dev_printk(KERN_ERR, host->dev,
 			   "BUG: invalid board index %u\n", board_idx);
 		return 1;
 	}
@@ -2633,15 +2775,25 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
 static int mv_init_host(struct ata_host *host, unsigned int board_idx)
 {
 	int rc = 0, n_hc, port, hc;
-	void __iomem *mmio = host->iomap[MV_PRIMARY_BAR];
 	struct mv_host_priv *hpriv = host->private_data;
-
-	/* global interrupt mask */
-	writel(0, mmio + HC_MAIN_IRQ_MASK_OFS);
+	void __iomem *mmio = hpriv->base;
 
 	rc = mv_chip_id(host, board_idx);
 	if (rc)
-		goto done;
+	goto done;
+
+	if (HAS_PCI(host)) {
+		hpriv->main_cause_reg_addr = hpriv->base +
+		  HC_MAIN_IRQ_CAUSE_OFS;
+		hpriv->main_mask_reg_addr = hpriv->base + HC_MAIN_IRQ_MASK_OFS;
+	} else {
+		hpriv->main_cause_reg_addr = hpriv->base +
+		  HC_SOC_MAIN_IRQ_CAUSE_OFS;
+		hpriv->main_mask_reg_addr = hpriv->base +
+		  HC_SOC_MAIN_IRQ_MASK_OFS;
+	}
+	/* global interrupt mask */
+	writel(0, hpriv->main_mask_reg_addr);
 
 	n_hc = mv_get_hc_count(host->ports[0]->flags);
 
@@ -2672,13 +2824,15 @@ static int mv_init_host(struct ata_host *host, unsigned int board_idx)
 	for (port = 0; port < host->n_ports; port++) {
 		struct ata_port *ap = host->ports[port];
 		void __iomem *port_mmio = mv_port_base(mmio, port);
-		unsigned int offset = port_mmio - mmio;
 
 		mv_port_init(&ap->ioaddr, port_mmio);
 
 #ifdef CONFIG_PCI
-		ata_port_pbar_desc(ap, MV_PRIMARY_BAR, -1, "mmio");
-		ata_port_pbar_desc(ap, MV_PRIMARY_BAR, offset, "port");
+		if (HAS_PCI(host)) {
+			unsigned int offset = port_mmio - mmio;
+			ata_port_pbar_desc(ap, MV_PRIMARY_BAR, -1, "mmio");
+			ata_port_pbar_desc(ap, MV_PRIMARY_BAR, offset, "port");
+		}
 #endif
 	}
 
@@ -2694,35 +2848,141 @@ static int mv_init_host(struct ata_host *host, unsigned int board_idx)
 		writelfl(0, hc_mmio + HC_IRQ_CAUSE_OFS);
 	}
 
-	/* Clear any currently outstanding host interrupt conditions */
-	writelfl(0, mmio + hpriv->irq_cause_ofs);
+	if (HAS_PCI(host)) {
+		/* Clear any currently outstanding host interrupt conditions */
+		writelfl(0, mmio + hpriv->irq_cause_ofs);
 
-	/* and unmask interrupt generation for host regs */
-	writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
+		/* and unmask interrupt generation for host regs */
+		writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
+		if (IS_GEN_I(hpriv))
+			writelfl(~HC_MAIN_MASKED_IRQS_5,
+				 hpriv->main_mask_reg_addr);
+		else
+			writelfl(~HC_MAIN_MASKED_IRQS,
+				 hpriv->main_mask_reg_addr);
+
+		VPRINTK("HC MAIN IRQ cause/mask=0x%08x/0x%08x "
+			"PCI int cause/mask=0x%08x/0x%08x\n",
+			readl(hpriv->main_cause_reg_addr),
+			readl(hpriv->main_mask_reg_addr),
+			readl(mmio + hpriv->irq_cause_ofs),
+			readl(mmio + hpriv->irq_mask_ofs));
+	} else {
+		writelfl(~HC_MAIN_MASKED_IRQS_SOC,
+			 hpriv->main_mask_reg_addr);
+		VPRINTK("HC MAIN IRQ cause/mask=0x%08x/0x%08x\n",
+			readl(hpriv->main_cause_reg_addr),
+			readl(hpriv->main_mask_reg_addr));
+	}
+done:
+	return rc;
+}
 
-	if (IS_GEN_I(hpriv))
-		writelfl(~HC_MAIN_MASKED_IRQS_5, mmio + HC_MAIN_IRQ_MASK_OFS);
-	else
-		writelfl(~HC_MAIN_MASKED_IRQS, mmio + HC_MAIN_IRQ_MASK_OFS);
+/**
+ *      mv_platform_probe - handle a positive probe of an soc Marvell
+ *      host
+ *      @pdev: platform device found
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
+static int mv_platform_probe(struct platform_device *pdev)
+{
+	static int printed_version;
+	const struct mv_sata_platform_data *mv_platform_data;
+	const struct ata_port_info *ppi[] =
+	    { &mv_port_info[chip_soc], NULL };
+	struct ata_host *host;
+	struct mv_host_priv *hpriv;
+	struct resource *res;
+	int n_ports, rc;
 
-	VPRINTK("HC MAIN IRQ cause/mask=0x%08x/0x%08x "
-		"PCI int cause/mask=0x%08x/0x%08x\n",
-		readl(mmio + HC_MAIN_IRQ_CAUSE_OFS),
-		readl(mmio + HC_MAIN_IRQ_MASK_OFS),
-		readl(mmio + hpriv->irq_cause_ofs),
-		readl(mmio + hpriv->irq_mask_ofs));
+	if (!printed_version++)
+		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
 
-done:
-	return rc;
+	/*
+	 * Simple resource validation ..
+	 */
+	if (unlikely(pdev->num_resources != 2)) {
+		dev_err(&pdev->dev, "invalid number of resources\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Get the register base first
+	 */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL)
+		return -EINVAL;
+
+	/* allocate host */
+	mv_platform_data = pdev->dev.platform_data;
+	n_ports = mv_platform_data->n_ports;
+
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
+	hpriv = devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);
+
+	if (!host || !hpriv)
+		return -ENOMEM;
+	host->private_data = hpriv;
+	hpriv->n_ports = n_ports;
+
+	host->iomap = NULL;
+	hpriv->base = ioremap(res->start, res->end - res->start + 1);
+	hpriv->base -= MV_SATAHC0_REG_BASE;
+
+	/* initialize adapter */
+	rc = mv_init_host(host, chip_soc);
+	if (rc)
+		return rc;
+
+	dev_printk(KERN_INFO, &pdev->dev,
+		   "slots %u ports %d\n", (unsigned)MV_MAX_Q_DEPTH,
+		   host->n_ports);
+
+	return ata_host_activate(host, platform_get_irq(pdev, 0), mv_interrupt,
+				 IRQF_SHARED, &mv6_sht);
+}
+
+/*
+ *
+ *      mv_platform_remove    -       unplug a platform interface
+ *      @pdev: platform device
+ *
+ *      A platform bus SATA device has been unplugged. Perform the needed
+ *      cleanup. Also called on module unload for any active devices.
+ */
+static int __devexit mv_platform_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct mv_host_priv *hpriv = host->private_data;
+	void __iomem *base = hpriv->base;
+
+	ata_host_detach(host);
+	iounmap(base);
+	return 0;
 }
 
+static struct platform_driver mv_platform_driver = {
+	.probe			= mv_platform_probe,
+	.remove			= __devexit_p(mv_platform_remove),
+	.driver			= {
+				   .name = DRV_NAME,
+				   .owner = THIS_MODULE,
+				  },
+};
+
+
 #ifdef CONFIG_PCI
-static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
+static int mv_pci_init_one(struct pci_dev *pdev,
+			   const struct pci_device_id *ent);
+
 
 static struct pci_driver mv_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= mv_pci_tbl,
-	.probe			= mv_init_one,
+	.probe			= mv_pci_init_one,
 	.remove			= ata_pci_remove_one,
 };
 
@@ -2828,14 +3088,15 @@ static int mv_create_dma_pools(struct mv_host_priv *hpriv, struct device *dev)
 }
 
 /**
- *      mv_init_one - handle a positive probe of a Marvell host
+ *      mv_pci_init_one - handle a positive probe of a PCI Marvell host
  *      @pdev: PCI device found
  *      @ent: PCI device ID entry for the matched host
  *
  *      LOCKING:
  *      Inherited from caller.
  */
-static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int mv_pci_init_one(struct pci_dev *pdev,
+			   const struct pci_device_id *ent)
 {
 	static int printed_version;
 	unsigned int board_idx = (unsigned int)ent->driver_data;
@@ -2855,6 +3116,7 @@ static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!host || !hpriv)
 		return -ENOMEM;
 	host->private_data = hpriv;
+	hpriv->n_ports = n_ports;
 
 	/* acquire resources */
 	rc = pcim_enable_device(pdev);
@@ -2867,6 +3129,7 @@ static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 	host->iomap = pcim_iomap_table(pdev);
+	hpriv->base = host->iomap[MV_PRIMARY_BAR];
 
 	rc = pci_go_64(pdev);
 	if (rc)
@@ -2895,11 +3158,22 @@ static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 }
 #endif
 
+static int mv_platform_probe(struct platform_device *pdev);
+static int __devexit mv_platform_remove(struct platform_device *pdev);
+
 static int __init mv_init(void)
 {
 	int rc = -ENODEV;
 #ifdef CONFIG_PCI
 	rc = pci_register_driver(&mv_pci_driver);
+	if (rc < 0)
+		return rc;
+#endif
+	rc = platform_driver_register(&mv_platform_driver);
+
+#ifdef CONFIG_PCI
+	if (rc < 0)
+		pci_unregister_driver(&mv_pci_driver);
 #endif
 	return rc;
 }
@@ -2909,6 +3183,7 @@ static void __exit mv_exit(void)
 #ifdef CONFIG_PCI
 	pci_unregister_driver(&mv_pci_driver);
 #endif
+	platform_driver_unregister(&mv_platform_driver);
 }
 
 MODULE_AUTHOR("Brett Russ");
diff --git a/include/linux/sata_mv.h b/include/linux/sata_mv.h
new file mode 100644
index 0000000..b0fa7cd
--- /dev/null
+++ b/include/linux/sata_mv.h
@@ -0,0 +1,21 @@
+/*
+ * Marvell integrated SATA platfrom device data definition file.
+ *
+ * Saeed Bishara <saeed@marvell.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __LINUX_SATA_MV_H__
+#define __LINUX_SATA_MV_H__
+
+/*
+ * Sata private data
+ */
+struct mv_sata_platform_data {
+	int	n_ports; /* number of sata ports */
+};
+
+#endif
-- 
1.5.2.5

