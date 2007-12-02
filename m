From: saeed.bishara@gmail.com
Subject: [PATCH 2/2] [libata] sata_mv: Support integrated controllers
Date: Sun,  2 Dec 2007 17:43:17 +0200
Message-ID: <11966102001423-git-send-email-saeed.bishara@gmail.com>
References: <11966101971581-git-send-email-saeed.bishara@gmail.com> <1196610199229-git-send-email-saeed.bishara@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host2.marvell.com ([65.219.4.2]:55458 "EHLO maili.marvell.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750813AbXLBPl3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Dec 2007 10:41:29 -0500
In-Reply-To: <1196610199229-git-send-email-saeed.bishara@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Saeed Bishara <saeed@marvell.com>

From: Saeed Bishara <saeed@marvell.com>

Marvell's Orion SoC includes SATA controllers based on Marvell's
PCI-to-SATA 88SX controllers. The integrated SATA unit is connected
directly to the internal bus of the Orion SoC, and not via PCI.
This patch extends the libATA sata_mv driver to support those
controllers.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c   |  392 ++++++++++++++++++++++++++++++++++++++++-------
 include/linux/sata_mv.h |   21 +++
 2 files changed, 358 insertions(+), 55 deletions(-)
 create mode 100644 include/linux/sata_mv.h

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index cbd3f1b..cace07c 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -67,6 +67,8 @@
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/sata_mv.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
@@ -125,6 +127,9 @@ enum {
 	/* Host Flags */
 	MV_FLAG_DUAL_HC		= (1 << 30),  /* two SATA Host Controllers */
 	MV_FLAG_IRQ_COALESCE	= (1 << 29),  /* IRQ coalescing capability */
+	/* integrated controllers, no PCI interface */
+	MV_FLAG_INTEGRATED = (1 << 28),
+
 	MV_COMMON_FLAGS		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI |
 				  ATA_FLAG_PIO_POLLING,
@@ -170,6 +175,8 @@ enum {
 
 	HC_MAIN_IRQ_CAUSE_OFS	= 0x1d60,
 	HC_MAIN_IRQ_MASK_OFS	= 0x1d64,
+	HC_INTEGRATED_MAIN_IRQ_CAUSE_OFS = 0x20020,
+	HC_INTEGRATED_MAIN_IRQ_MASK_OFS = 0x20024,
 	PORT0_ERR		= (1 << 0),	/* shift by port # */
 	PORT0_DONE		= (1 << 1),	/* shift by port # */
 	HC0_IRQ_PEND		= 0x1ff,	/* bits 0-8 = HC0's ports */
@@ -185,12 +192,14 @@ enum {
 	TWSI_INT		= (1 << 24),
 	HC_MAIN_RSVD		= (0x7f << 25),	/* bits 31-25 */
 	HC_MAIN_RSVD_5		= (0x1fff << 19), /* bits 31-19 */
+	HC_MAIN_RSVD_INTEGRATED = (0x3fffffb << 6),     /* bits 31-9, 7-6 */
 	HC_MAIN_MASKED_IRQS	= (TRAN_LO_DONE | TRAN_HI_DONE |
 				   PORTS_0_7_COAL_DONE | GPIO_INT | TWSI_INT |
 				   HC_MAIN_RSVD),
 	HC_MAIN_MASKED_IRQS_5	= (PORTS_0_3_COAL_DONE | PORTS_4_7_COAL_DONE |
 				   HC_MAIN_RSVD_5),
-
+	HC_MAIN_MASKED_IRQS_INTEGRATED = (PORTS_0_3_COAL_DONE |
+					  HC_MAIN_RSVD_INTEGRATED),
 	/* SATAHC registers */
 	HC_CFG_OFS		= 0,
 
@@ -312,6 +321,7 @@ enum {
 #define IS_GEN_I(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_I)
 #define IS_GEN_II(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_II)
 #define IS_GEN_IIE(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_IIE)
+#define HAS_PCI(host) (!((host)->ports[0]->flags & MV_FLAG_INTEGRATED))
 
 enum {
 	/* DMA boundary 0xffff is required by the s/g splitting
@@ -336,6 +346,7 @@ enum chip_type {
 	chip_608x,
 	chip_6042,
 	chip_7042,
+	chip_integrated,
 };
 
 /* Command ReQuest Block: 32B */
@@ -398,11 +409,15 @@ struct mv_hw_ops {
 	int (*reset_hc)(struct mv_host_priv *hpriv, void __iomem *mmio,
 			unsigned int n_hc);
 	void (*reset_flash)(struct mv_host_priv *hpriv, void __iomem *mmio);
-	void (*reset_bus)(struct pci_dev *pdev, void __iomem *mmio);
+	void (*reset_bus)(struct ata_host *host, void __iomem *mmio);
 };
 
 struct mv_host_priv {
 	u32			hp_flags;
+	int			n_ports;
+	void __iomem		*base;
+	void __iomem		*main_cause_reg_addr;
+	void __iomem		*main_mask_reg_addr;
 	struct mv_port_signal	signal[8];
 	const struct mv_hw_ops	*ops;
 };
@@ -422,8 +437,11 @@ static void mv_post_int_cmd(struct ata_queued_cmd *qc);
 static void mv_eh_freeze(struct ata_port *ap);
 static void mv_eh_thaw(struct ata_port *ap);
 #ifdef CONFIG_PCI
-static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
+static int mv_pci_init_one(struct pci_dev *pdev,
+			   const struct pci_device_id *ent);
 #endif
+static int mv_platform_probe(struct platform_device *pdev);
+static int __devexit mv_platform_remove(struct platform_device *pdev);
 
 static void mv5_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
 			   unsigned int port);
@@ -433,7 +451,7 @@ static void mv5_read_preamp(struct mv_host_priv *hpriv, int idx,
 static int mv5_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
 			unsigned int n_hc);
 static void mv5_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio);
-static void mv5_reset_bus(struct pci_dev *pdev, void __iomem *mmio);
+static void mv5_reset_bus(struct ata_host *host, void __iomem *mmio);
 
 static void mv6_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
 			   unsigned int port);
@@ -443,7 +461,16 @@ static void mv6_read_preamp(struct mv_host_priv *hpriv, int idx,
 static int mv6_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
 			unsigned int n_hc);
 static void mv6_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio);
-static void mv_reset_pci_bus(struct pci_dev *pdev, void __iomem *mmio);
+static void mv_integrated_enable_leds(struct mv_host_priv *hpriv,
+				      void __iomem *mmio);
+static void mv_integrated_read_preamp(struct mv_host_priv *hpriv, int idx,
+				      void __iomem *mmio);
+static int mv_integrated_reset_hc(struct mv_host_priv *hpriv,
+				  void __iomem *mmio, unsigned int n_hc);
+static void mv_integrated_reset_flash(struct mv_host_priv *hpriv,
+				      void __iomem *mmio);
+static void mv_integrated_reset_bus(struct ata_host *host, void __iomem *mmio);
+static void mv_reset_pci_bus(struct ata_host *host, void __iomem *mmio);
 static void mv_channel_reset(struct mv_host_priv *hpriv, void __iomem *mmio,
 			     unsigned int port_no);
 
@@ -611,6 +638,12 @@ static const struct ata_port_info mv_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv_iie_ops,
 	},
+	{  /* chip_integrated */
+		.flags = MV_COMMON_FLAGS | MV_FLAG_INTEGRATED,
+		.pio_mask = 0x1f,      /* pio0-4 */
+		.udma_mask = ATA_UDMA6,
+		.port_ops = &mv_iie_ops,
+	},
 };
 
 static const struct pci_device_id mv_pci_tbl[] = {
@@ -644,10 +677,21 @@ static const struct pci_device_id mv_pci_tbl[] = {
 static struct pci_driver mv_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= mv_pci_tbl,
-	.probe			= mv_init_one,
+	.probe			= mv_pci_init_one,
 	.remove			= ata_pci_remove_one,
 };
 #endif
+
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
 static const struct mv_hw_ops mv5xxx_ops = {
 	.phy_errata		= mv5_phy_errata,
 	.enable_leds		= mv5_enable_leds,
@@ -666,6 +710,15 @@ static const struct mv_hw_ops mv6xxx_ops = {
 	.reset_bus		= mv_reset_pci_bus,
 };
 
+static const struct mv_hw_ops mv_integrated_ops = {
+	.phy_errata		= mv6_phy_errata,
+	.enable_leds		= mv_integrated_enable_leds,
+	.read_preamp		= mv_integrated_read_preamp,
+	.reset_hc		= mv_integrated_reset_hc,
+	.reset_flash		= mv_integrated_reset_flash,
+	.reset_bus		= mv_integrated_reset_bus,
+};
+
 /*
  * Functions
  */
@@ -704,9 +757,15 @@ static inline void __iomem *mv_port_base(void __iomem *base, unsigned int port)
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
@@ -1551,16 +1610,21 @@ static void mv_intr_edma(struct ata_port *ap)
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
@@ -1571,7 +1635,7 @@ static void mv_host_intr(struct ata_host *host, u32 relevant, unsigned int hc)
 	VPRINTK("ENTER, hc%u relevant=0x%08x HC IRQ cause=0x%08x\n",
 		hc, relevant, hc_irq_cause);
 
-	for (port = port0; port < port0 + MV_PORTS_PER_HC; port++) {
+	for (port = port0; port < port0 + last_port; port++) {
 		struct ata_port *ap = host->ports[port];
 		struct mv_port_priv *pp = ap->private_data;
 		int have_err_bits, hard_port, shift;
@@ -1665,11 +1729,12 @@ static void mv_pci_error(struct ata_host *host, void __iomem *mmio)
 static irqreturn_t mv_interrupt(int irq, void *dev_instance)
 {
 	struct ata_host *host = dev_instance;
+	struct mv_host_priv *hpriv = host->private_data;
 	unsigned int hc, handled = 0, n_hcs;
-	void __iomem *mmio = host->iomap[MV_PRIMARY_BAR];
+	void __iomem *mmio = hpriv->base;
 	u32 irq_stat;
 
-	irq_stat = readl(mmio + HC_MAIN_IRQ_CAUSE_OFS);
+	irq_stat = readl(hpriv->main_cause_reg_addr);
 
 	/* check the cases where we either have nothing pending or have read
 	 * a bogus register value which can indicate HW removal or PCI fault
@@ -1680,7 +1745,7 @@ static irqreturn_t mv_interrupt(int irq, void *dev_instance)
 	n_hcs = mv_get_hc_count(host->ports[0]->flags);
 	spin_lock(&host->lock);
 
-	if (unlikely(irq_stat & PCI_ERR)) {
+	if (unlikely(irq_stat & PCI_ERR) && HAS_PCI(host)) {
 		mv_pci_error(host, mmio);
 		handled = 1;
 		goto out_unlock;	/* skip all other HC irq handling */
@@ -1727,7 +1792,8 @@ static unsigned int mv5_scr_offset(unsigned int sc_reg_in)
 
 static int mv5_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u32 *val)
 {
-	void __iomem *mmio = ap->host->iomap[MV_PRIMARY_BAR];
+	struct mv_host_priv *hpriv = ap->host->private_data;
+	void __iomem *mmio = hpriv->base;
 	void __iomem *addr = mv5_phy_base(mmio, ap->port_no);
 	unsigned int ofs = mv5_scr_offset(sc_reg_in);
 
@@ -1740,7 +1806,8 @@ static int mv5_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u32 *val)
 
 static int mv5_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val)
 {
-	void __iomem *mmio = ap->host->iomap[MV_PRIMARY_BAR];
+	struct mv_host_priv *hpriv = ap->host->private_data;
+	void __iomem *mmio = hpriv->base;
 	void __iomem *addr = mv5_phy_base(mmio, ap->port_no);
 	unsigned int ofs = mv5_scr_offset(sc_reg_in);
 
@@ -1751,8 +1818,9 @@ static int mv5_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val)
 		return -EINVAL;
 }
 
-static void mv5_reset_bus(struct pci_dev *pdev, void __iomem *mmio)
+static void mv5_reset_bus(struct ata_host *host, void __iomem *mmio)
 {
+	struct pci_dev *pdev = to_pci_dev(host->dev);
 	int early_5080;
 
 	early_5080 = (pdev->device == 0x5080) && (pdev->revision == 0);
@@ -1763,7 +1831,7 @@ static void mv5_reset_bus(struct pci_dev *pdev, void __iomem *mmio)
 		writel(tmp, mmio + MV_PCI_EXP_ROM_BAR_CTL);
 	}
 
-	mv_reset_pci_bus(pdev, mmio);
+	mv_reset_pci_bus(host, mmio);
 }
 
 static void mv5_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio)
@@ -1887,7 +1955,7 @@ static int mv5_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
 
 #undef ZERO
 #define ZERO(reg) writel(0, mmio + (reg))
-static void mv_reset_pci_bus(struct pci_dev *pdev, void __iomem *mmio)
+static void mv_reset_pci_bus(struct ata_host *host, void __iomem *mmio)
 {
 	u32 tmp;
 
@@ -2076,6 +2144,93 @@ static void mv6_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
 	writel(m2, port_mmio + PHY_MODE2);
 }
 
+/* TODO: use the generic LED interface to configure the SATA Presence */
+/* & Acitivy LEDs on the board */
+static void mv_integrated_enable_leds(struct mv_host_priv *hpriv,
+				      void __iomem *mmio)
+{
+	return;
+}
+
+static void mv_integrated_read_preamp(struct mv_host_priv *hpriv, int idx,
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
+static void mv_integrated_reset_hc_port(struct mv_host_priv *hpriv,
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
+static void mv_integrated_reset_one_hc(struct mv_host_priv *hpriv,
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
+static int mv_integrated_reset_hc(struct mv_host_priv *hpriv,
+				  void __iomem *mmio, unsigned int n_hc)
+{
+	unsigned int port;
+
+	for (port = 0; port < hpriv->n_ports; port++)
+		mv_integrated_reset_hc_port(hpriv, mmio, port);
+
+	mv_integrated_reset_one_hc(hpriv, mmio);
+
+	return 0;
+}
+
+static void mv_integrated_reset_flash(struct mv_host_priv *hpriv,
+				      void __iomem *mmio)
+{
+	return;
+}
+
+static void mv_integrated_reset_bus(struct ata_host *host, void __iomem *mmio)
+{
+	return;
+}
+
 static void mv_channel_reset(struct mv_host_priv *hpriv, void __iomem *mmio,
 			     unsigned int port_no)
 {
@@ -2240,7 +2395,7 @@ static int mv_hardreset(struct ata_link *link, unsigned int *class,
 {
 	struct ata_port *ap = link->ap;
 	struct mv_host_priv *hpriv = ap->host->private_data;
-	void __iomem *mmio = ap->host->iomap[MV_PRIMARY_BAR];
+	void __iomem *mmio = hpriv->base;
 
 	mv_stop_dma(ap);
 
@@ -2286,7 +2441,7 @@ static void mv_post_int_cmd(struct ata_queued_cmd *qc)
 
 static void mv_eh_freeze(struct ata_port *ap)
 {
-	void __iomem *mmio = ap->host->iomap[MV_PRIMARY_BAR];
+	struct mv_host_priv *hpriv = ap->host->private_data;
 	unsigned int hc = (ap->port_no > 3) ? 1 : 0;
 	u32 tmp, mask;
 	unsigned int shift;
@@ -2300,13 +2455,14 @@ static void mv_eh_freeze(struct ata_port *ap)
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
@@ -2333,8 +2489,8 @@ static void mv_eh_thaw(struct ata_port *ap)
 	writel(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
 
 	/* enable assertion of portN err, done events */
-	tmp = readl(mmio + HC_MAIN_IRQ_MASK_OFS);
-	writelfl(tmp | mask, mmio + HC_MAIN_IRQ_MASK_OFS);
+	tmp = readl(hpriv->main_mask_reg_addr);
+	writelfl(tmp | mask, hpriv->main_mask_reg_addr);
 }
 
 /**
@@ -2471,9 +2627,13 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
 			break;
 		}
 		break;
+	case chip_integrated:
+		hpriv->ops = &mv_integrated_ops;
+		hp_flags |= MV_HP_ERRATA_60X1C0;
+		break;
 
 	default:
-		dev_printk(KERN_ERR, &pdev->dev,
+		dev_printk(KERN_ERR, host->dev,
 			   "BUG: invalid board index %u\n", board_idx);
 		return 1;
 	}
@@ -2497,17 +2657,26 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
 static int mv_init_host(struct ata_host *host, unsigned int board_idx)
 {
 	int rc = 0, n_hc, port, hc;
-	struct pci_dev *pdev = to_pci_dev(host->dev);
-	void __iomem *mmio = host->iomap[MV_PRIMARY_BAR];
 	struct mv_host_priv *hpriv = host->private_data;
-
-	/* global interrupt mask */
-	writel(0, mmio + HC_MAIN_IRQ_MASK_OFS);
+	void __iomem *mmio = hpriv->base;
 
 	rc = mv_chip_id(host, board_idx);
 	if (rc)
 		goto done;
 
+	if (HAS_PCI(host)) {
+		hpriv->main_cause_reg_addr = hpriv->base +
+		  HC_MAIN_IRQ_CAUSE_OFS;
+		hpriv->main_mask_reg_addr = hpriv->base + HC_MAIN_IRQ_MASK_OFS;
+	} else {
+		hpriv->main_cause_reg_addr = hpriv->base +
+		  HC_INTEGRATED_MAIN_IRQ_CAUSE_OFS;
+		hpriv->main_mask_reg_addr = hpriv->base +
+		  HC_INTEGRATED_MAIN_IRQ_MASK_OFS;
+	}
+	/* global interrupt mask */
+	writel(0, hpriv->main_mask_reg_addr);
+
 	n_hc = mv_get_hc_count(host->ports[0]->flags);
 
 	for (port = 0; port < host->n_ports; port++)
@@ -2518,7 +2687,7 @@ static int mv_init_host(struct ata_host *host, unsigned int board_idx)
 		goto done;
 
 	hpriv->ops->reset_flash(hpriv, mmio);
-	hpriv->ops->reset_bus(pdev, mmio);
+	hpriv->ops->reset_bus(host, mmio);
 	hpriv->ops->enable_leds(hpriv, mmio);
 
 	for (port = 0; port < host->n_ports; port++) {
@@ -2537,13 +2706,15 @@ static int mv_init_host(struct ata_host *host, unsigned int board_idx)
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
 
@@ -2559,26 +2730,123 @@ static int mv_init_host(struct ata_host *host, unsigned int board_idx)
 		writelfl(0, hc_mmio + HC_IRQ_CAUSE_OFS);
 	}
 
-	/* Clear any currently outstanding host interrupt conditions */
-	writelfl(0, mmio + PCI_IRQ_CAUSE_OFS);
+	if (HAS_PCI(host)) {
+		/* Clear any currently outstanding host interrupt conditions */
+		writelfl(0, mmio + PCI_IRQ_CAUSE_OFS);
 
-	/* and unmask interrupt generation for host regs */
-	writelfl(PCI_UNMASK_ALL_IRQS, mmio + PCI_IRQ_MASK_OFS);
+		/* and unmask interrupt generation for host regs */
+		writelfl(PCI_UNMASK_ALL_IRQS, mmio + PCI_IRQ_MASK_OFS);
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
+			readl(mmio + PCI_IRQ_CAUSE_OFS),
+			readl(mmio + PCI_IRQ_MASK_OFS));
+	} else {
+		writelfl(~HC_MAIN_MASKED_IRQS_INTEGRATED,
+			 hpriv->main_mask_reg_addr);
+		VPRINTK("HC MAIN IRQ cause/mask=0x%08x/0x%08x\n",
+			readl(hpriv->main_cause_reg_addr),
+			readl(hpriv->main_mask_reg_addr));
+	}
+done:
 
-	if (IS_GEN_I(hpriv))
-		writelfl(~HC_MAIN_MASKED_IRQS_5, mmio + HC_MAIN_IRQ_MASK_OFS);
-	else
-		writelfl(~HC_MAIN_MASKED_IRQS, mmio + HC_MAIN_IRQ_MASK_OFS);
+	return rc;
+}
 
-	VPRINTK("HC MAIN IRQ cause/mask=0x%08x/0x%08x "
-		"PCI int cause/mask=0x%08x/0x%08x\n",
-		readl(mmio + HC_MAIN_IRQ_CAUSE_OFS),
-		readl(mmio + HC_MAIN_IRQ_MASK_OFS),
-		readl(mmio + PCI_IRQ_CAUSE_OFS),
-		readl(mmio + PCI_IRQ_MASK_OFS));
+/**
+ *      mv_platform_probe - handle a positive probe of an integrated Marvell
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
+	    { &mv_port_info[chip_integrated], NULL };
+	struct ata_host *host;
+	struct mv_host_priv *hpriv;
+	struct resource *res;
+	int n_ports, rc;
 
-done:
-	return rc;
+	if (!printed_version++)
+		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
+
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
+	pdev->dev.coherent_dma_mask = DMA_32BIT_MASK;
+
+	/* initialize adapter */
+	rc = mv_init_host(host, chip_integrated);
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
 
 #ifdef CONFIG_PCI
@@ -2665,14 +2933,15 @@ static void mv_print_info(struct ata_host *host)
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
@@ -2692,6 +2961,7 @@ static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!host || !hpriv)
 		return -ENOMEM;
 	host->private_data = hpriv;
+	hpriv->n_ports = n_ports;
 
 	/* acquire resources */
 	rc = pcim_enable_device(pdev);
@@ -2704,6 +2974,7 @@ static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 	host->iomap = pcim_iomap_table(pdev);
+	hpriv->base = host->iomap[MV_PRIMARY_BAR];
 
 	rc = pci_go_64(pdev);
 	if (rc)
@@ -2732,7 +3003,7 @@ static int __init mv_pci_register_driver(void)
 	return pci_register_driver(&mv_pci_driver);
 }
 
-static void __exit mv_pci_unregister_driver(void)
+static void mv_pci_unregister_driver(void)
 {
 	pci_unregister_driver(&mv_pci_driver);
 }
@@ -2748,12 +3019,23 @@ static void __exit mv_pci_unregister_driver(void)
 #endif
 static int __init mv_init(void)
 {
-	return mv_pci_register_driver();
+	int retval = 0;
+
+	retval = mv_pci_register_driver();
+	if (retval < 0)
+		return retval;
+
+	retval = platform_driver_register(&mv_platform_driver);
+	if (retval < 0)
+		mv_pci_unregister_driver();
+
+	return retval;
 }
 
 static void __exit mv_exit(void)
 {
 	mv_pci_unregister_driver();
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
1.5.0.6

