From: saeed.bishara@gmail.com
Subject: [PATCH 1/2] [libata] sata_mv: Remove PCI dependency
Date: Sun,  2 Dec 2007 17:43:16 +0200
Message-ID: <1196610199229-git-send-email-saeed.bishara@gmail.com>
References: <11966101971581-git-send-email-saeed.bishara@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host2.marvell.com ([65.219.4.2]:55455 "EHLO maili.marvell.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750813AbXLBPl1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Dec 2007 10:41:27 -0500
In-Reply-To: <11966101971581-git-send-email-saeed.bishara@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Saeed Bishara <saeed@marvell.com>

From: Saeed Bishara <saeed@marvell.com>

The integrated SATA controller is connected directly to the SoC's
internal bus, not via PCI interface. this patch removes the dependency
on the PCI interface.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/Kconfig   |    2 +-
 drivers/ata/sata_mv.c |  113 ++++++++++++++++++++++++++++++-------------------
 2 files changed, 71 insertions(+), 44 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index ba63619..c60842b 100644
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
index 97c3e11..cbd3f1b 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -421,7 +421,9 @@ static void mv_error_handler(struct ata_port *ap);
 static void mv_post_int_cmd(struct ata_queued_cmd *qc);
 static void mv_eh_freeze(struct ata_port *ap);
 static void mv_eh_thaw(struct ata_port *ap);
+#ifdef CONFIG_PCI
 static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
+#endif
 
 static void mv5_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
 			   unsigned int port);
@@ -638,14 +640,14 @@ static const struct pci_device_id mv_pci_tbl[] = {
 
 	{ }			/* terminate list */
 };
-
+#ifdef CONFIG_PCI
 static struct pci_driver mv_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= mv_pci_tbl,
 	.probe			= mv_init_one,
 	.remove			= ata_pci_remove_one,
 };
-
+#endif
 static const struct mv_hw_ops mv5xxx_ops = {
 	.phy_errata		= mv5_phy_errata,
 	.enable_leds		= mv5_enable_leds,
@@ -665,45 +667,6 @@ static const struct mv_hw_ops mv6xxx_ops = {
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
 
@@ -2578,8 +2541,10 @@ static int mv_init_host(struct ata_host *host, unsigned int board_idx)
 
 		mv_port_init(&ap->ioaddr, port_mmio);
 
+#ifdef CONFIG_PCI
 		ata_port_pbar_desc(ap, MV_PRIMARY_BAR, -1, "mmio");
 		ata_port_pbar_desc(ap, MV_PRIMARY_BAR, offset, "port");
+#endif
 	}
 
 	for (hc = 0; hc < n_hc; hc++) {
@@ -2616,6 +2581,47 @@ done:
 	return rc;
 }
 
+#ifdef CONFIG_PCI
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
@@ -2721,15 +2727,34 @@ static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 				 IS_GEN_I(hpriv) ? &mv5_sht : &mv6_sht);
 }
 
-static int __init mv_init(void)
+static int __init mv_pci_register_driver(void)
 {
 	return pci_register_driver(&mv_pci_driver);
 }
 
-static void __exit mv_exit(void)
+static void __exit mv_pci_unregister_driver(void)
 {
 	pci_unregister_driver(&mv_pci_driver);
 }
+#else
+static int __init mv_pci_register_driver(void)
+{
+	return 0;
+}
+
+static void __exit mv_pci_unregister_driver(void)
+{
+}
+#endif
+static int __init mv_init(void)
+{
+	return mv_pci_register_driver();
+}
+
+static void __exit mv_exit(void)
+{
+	mv_pci_unregister_driver();
+}
 
 MODULE_AUTHOR("Brett Russ");
 MODULE_DESCRIPTION("SCSI low-level driver for Marvell SATA controllers");
@@ -2737,8 +2762,10 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, mv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
+#ifdef CONFIG_PCI
 module_param(msi, int, 0444);
 MODULE_PARM_DESC(msi, "Enable use of PCI MSI (0=off, 1=on)");
+#endif
 
 module_init(mv_init);
 module_exit(mv_exit);
-- 
1.5.0.6

