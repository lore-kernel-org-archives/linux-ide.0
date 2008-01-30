From: saeed.bishara@gmail.com
Subject: [PATCH 1/2 v3] sata_mv: Remove PCI dependency
Date: Wed, 30 Jan 2008 11:50:45 -1100
Message-ID: <1201733446499-git-send-email-saeed.bishara@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host2.marvell.com ([65.219.4.2]:23083 "EHLO maili.marvell.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1765214AbYA3UKy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jan 2008 15:10:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: saeed@marvell.com, saeed.bishara@gmail.com, htejun@gmail.com, liml@rtr.ca, Saeed Bishara <saeed@il.marvell.com>

From: Saeed Bishara <saeed@ubuntu-saeed.il.marvell.com>

The integrated SATA controller is connected directly to the SoC's
internal bus, not via PCI interface. this patch removes the dependency
on the PCI interface.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/Kconfig   |    2 +-
 drivers/ata/sata_mv.c |  132 +++++++++++++++++++++++++++---------------------
 2 files changed, 75 insertions(+), 59 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 2478cca..06e366f 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -69,7 +69,7 @@ config ATA_PIIX
 
 config SATA_MV
 	tristate "Marvell SATA support (HIGHLY EXPERIMENTAL)"
-	depends on PCI && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	help
 	  This option enables support for the Marvell Serial ATA family.
 	  Currently supports 88SX[56]0[48][01] chips.
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 38d4d08..3c1b5c9 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -127,6 +127,9 @@ enum {
 	/* Host Flags */
 	MV_FLAG_DUAL_HC		= (1 << 30),  /* two SATA Host Controllers */
 	MV_FLAG_IRQ_COALESCE	= (1 << 29),  /* IRQ coalescing capability */
+	/* SoC integrated controllers, no PCI interface */
+	MV_FLAG_SOC = (1 << 28),
+
 	MV_COMMON_FLAGS		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI |
 				  ATA_FLAG_PIO_POLLING,
@@ -340,6 +343,7 @@ enum {
 #define IS_GEN_I(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_I)
 #define IS_GEN_II(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_II)
 #define IS_GEN_IIE(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_IIE)
+#define HAS_PCI(host) (!((host)->ports[0]->flags & MV_FLAG_SOC))
 
 enum {
 	/* DMA boundary 0xffff is required by the s/g splitting
@@ -442,7 +446,7 @@ struct mv_hw_ops {
 	int (*reset_hc)(struct mv_host_priv *hpriv, void __iomem *mmio,
 			unsigned int n_hc);
 	void (*reset_flash)(struct mv_host_priv *hpriv, void __iomem *mmio);
-	void (*reset_bus)(struct pci_dev *pdev, void __iomem *mmio);
+	void (*reset_bus)(struct ata_host *host, void __iomem *mmio);
 };
 
 static void mv_irq_clear(struct ata_port *ap);
@@ -459,7 +463,6 @@ static void mv_error_handler(struct ata_port *ap);
 static void mv_eh_freeze(struct ata_port *ap);
 static void mv_eh_thaw(struct ata_port *ap);
 static void mv6_dev_config(struct ata_device *dev);
-static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 
 static void mv5_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
 			   unsigned int port);
@@ -469,7 +472,7 @@ static void mv5_read_preamp(struct mv_host_priv *hpriv, int idx,
 static int mv5_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
 			unsigned int n_hc);
 static void mv5_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio);
-static void mv5_reset_bus(struct pci_dev *pdev, void __iomem *mmio);
+static void mv5_reset_bus(struct ata_host *host, void __iomem *mmio);
 
 static void mv6_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
 			   unsigned int port);
@@ -479,7 +482,7 @@ static void mv6_read_preamp(struct mv_host_priv *hpriv, int idx,
 static int mv6_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
 			unsigned int n_hc);
 static void mv6_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio);
-static void mv_reset_pci_bus(struct pci_dev *pdev, void __iomem *mmio);
+static void mv_reset_pci_bus(struct ata_host *host, void __iomem *mmio);
 static void mv_channel_reset(struct mv_host_priv *hpriv, void __iomem *mmio,
 			     unsigned int port_no);
 static void mv_edma_cfg(struct mv_port_priv *pp, struct mv_host_priv *hpriv,
@@ -690,13 +693,6 @@ static const struct pci_device_id mv_pci_tbl[] = {
 	{ }			/* terminate list */
 };
 
-static struct pci_driver mv_pci_driver = {
-	.name			= DRV_NAME,
-	.id_table		= mv_pci_tbl,
-	.probe			= mv_init_one,
-	.remove			= ata_pci_remove_one,
-};
-
 static const struct mv_hw_ops mv5xxx_ops = {
 	.phy_errata		= mv5_phy_errata,
 	.enable_leds		= mv5_enable_leds,
@@ -716,45 +712,6 @@ static const struct mv_hw_ops mv6xxx_ops = {
 };
 
 /*
- * module options
- */
-static int msi;	      /* Use PCI msi; either zero (off, default) or non-zero */
-
-
-/* move to PCI layer or libata core? */
-static int pci_go_64(struct pci_dev *pdev)
-{
-	int rc;
-
-	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
-		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
-		if (rc) {
-			rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
-			if (rc) {
-				dev_printk(KERN_ERR, &pdev->dev,
-					   "64-bit DMA enable failed\n");
-				return rc;
-			}
-		}
-	} else {
-		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
-		if (rc) {
-			dev_printk(KERN_ERR, &pdev->dev,
-				   "32-bit DMA enable failed\n");
-			return rc;
-		}
-		rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
-		if (rc) {
-			dev_printk(KERN_ERR, &pdev->dev,
-				   "32-bit consistent DMA enable failed\n");
-			return rc;
-		}
-	}
-
-	return rc;
-}
-
-/*
  * Functions
  */
 
@@ -1823,7 +1780,7 @@ static irqreturn_t mv_interrupt(int irq, void *dev_instance)
 
 	n_hcs = mv_get_hc_count(host->ports[0]->flags);
 
-	if (unlikely(irq_stat & PCI_ERR)) {
+	if (unlikely((irq_stat & PCI_ERR) && HAS_PCI(host))) {
 		mv_pci_error(host, mmio);
 		handled = 1;
 		goto out_unlock;	/* skip all other HC irq handling */
@@ -1894,8 +1851,9 @@ static int mv5_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val)
 		return -EINVAL;
 }
 
-static void mv5_reset_bus(struct pci_dev *pdev, void __iomem *mmio)
+static void mv5_reset_bus(struct ata_host *host, void __iomem *mmio)
 {
+	struct pci_dev *pdev = to_pci_dev(host->dev);
 	int early_5080;
 
 	early_5080 = (pdev->device == 0x5080) && (pdev->revision == 0);
@@ -1906,7 +1864,7 @@ static void mv5_reset_bus(struct pci_dev *pdev, void __iomem *mmio)
 		writel(tmp, mmio + MV_PCI_EXP_ROM_BAR_CTL);
 	}
 
-	mv_reset_pci_bus(pdev, mmio);
+	mv_reset_pci_bus(host, mmio);
 }
 
 static void mv5_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio)
@@ -2030,9 +1988,8 @@ static int mv5_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
 
 #undef ZERO
 #define ZERO(reg) writel(0, mmio + (reg))
-static void mv_reset_pci_bus(struct pci_dev *pdev, void __iomem *mmio)
+static void mv_reset_pci_bus(struct ata_host *host, void __iomem *mmio)
 {
-	struct ata_host     *host = dev_get_drvdata(&pdev->dev);
 	struct mv_host_priv *hpriv = host->private_data;
 	u32 tmp;
 
@@ -2676,7 +2633,6 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
 static int mv_init_host(struct ata_host *host, unsigned int board_idx)
 {
 	int rc = 0, n_hc, port, hc;
-	struct pci_dev *pdev = to_pci_dev(host->dev);
 	void __iomem *mmio = host->iomap[MV_PRIMARY_BAR];
 	struct mv_host_priv *hpriv = host->private_data;
 
@@ -2697,7 +2653,7 @@ static int mv_init_host(struct ata_host *host, unsigned int board_idx)
 		goto done;
 
 	hpriv->ops->reset_flash(hpriv, mmio);
-	hpriv->ops->reset_bus(pdev, mmio);
+	hpriv->ops->reset_bus(host, mmio);
 	hpriv->ops->enable_leds(hpriv, mmio);
 
 	for (port = 0; port < host->n_ports; port++) {
@@ -2720,8 +2676,10 @@ static int mv_init_host(struct ata_host *host, unsigned int board_idx)
 
 		mv_port_init(&ap->ioaddr, port_mmio);
 
+#ifdef CONFIG_PCI
 		ata_port_pbar_desc(ap, MV_PRIMARY_BAR, -1, "mmio");
 		ata_port_pbar_desc(ap, MV_PRIMARY_BAR, offset, "port");
+#endif
 	}
 
 	for (hc = 0; hc < n_hc; hc++) {
@@ -2758,6 +2716,55 @@ done:
 	return rc;
 }
 
+#ifdef CONFIG_PCI
+static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
+
+static struct pci_driver mv_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= mv_pci_tbl,
+	.probe			= mv_init_one,
+	.remove			= ata_pci_remove_one,
+};
+
+/*
+ * module options
+ */
+static int msi;	      /* Use PCI msi; either zero (off, default) or non-zero */
+
+
+/* move to PCI layer or libata core? */
+static int pci_go_64(struct pci_dev *pdev)
+{
+	int rc;
+
+	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
+		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
+		if (rc) {
+			rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
+			if (rc) {
+				dev_printk(KERN_ERR, &pdev->dev,
+					   "64-bit DMA enable failed\n");
+				return rc;
+			}
+		}
+	} else {
+		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
+		if (rc) {
+			dev_printk(KERN_ERR, &pdev->dev,
+				   "32-bit DMA enable failed\n");
+			return rc;
+		}
+		rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
+		if (rc) {
+			dev_printk(KERN_ERR, &pdev->dev,
+				   "32-bit consistent DMA enable failed\n");
+			return rc;
+		}
+	}
+
+	return rc;
+}
+
 /**
  *      mv_print_info - Dump key info to kernel log for perusal.
  *      @host: ATA host to print info about
@@ -2886,15 +2893,22 @@ static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return ata_host_activate(host, pdev->irq, mv_interrupt, IRQF_SHARED,
 				 IS_GEN_I(hpriv) ? &mv5_sht : &mv6_sht);
 }
+#endif
 
 static int __init mv_init(void)
 {
-	return pci_register_driver(&mv_pci_driver);
+	int rc = -ENODEV;
+#ifdef CONFIG_PCI
+	rc = pci_register_driver(&mv_pci_driver);
+#endif
+	return rc;
 }
 
 static void __exit mv_exit(void)
 {
+#ifdef CONFIG_PCI
 	pci_unregister_driver(&mv_pci_driver);
+#endif
 }
 
 MODULE_AUTHOR("Brett Russ");
@@ -2903,8 +2917,10 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, mv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
+#ifdef CONFIG_PCI
 module_param(msi, int, 0444);
 MODULE_PARM_DESC(msi, "Enable use of PCI MSI (0=off, 1=on)");
+#endif
 
 module_init(mv_init);
 module_exit(mv_exit);
-- 
1.5.2.5

