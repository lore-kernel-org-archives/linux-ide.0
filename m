From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: implement and use DMA mask configuration helper
Date: Fri, 9 Mar 2007 19:49:45 +0900
Message-ID: <20070309104945.GG32687@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:58851 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767161AbXCIKtq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 05:49:46 -0500
Received: by wr-out-0506.google.com with SMTP id 71so1254826wri
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 02:49:46 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Implement and use DMA mask configuration helper.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This function probably belongs to pci layer.  Put it in libata with
pci_test_bits() for the time being.

 drivers/ata/ahci.c          |   36 +++++----------------
 drivers/ata/libata-core.c   |   70 +++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-sff.c    |    5 +--
 drivers/ata/pata_cs5520.c   |   14 +++-----
 drivers/ata/pata_pdc2027x.c |    6 +---
 drivers/ata/pata_scc.c      |    5 +--
 drivers/ata/pdc_adma.c      |   21 +------------
 drivers/ata/sata_inic162x.c |   14 +-------
 drivers/ata/sata_mv.c       |   36 +---------------------
 drivers/ata/sata_nv.c       |   17 +++-------
 drivers/ata/sata_promise.c  |    5 +--
 drivers/ata/sata_qstor.c    |   50 ++++---------------------------
 drivers/ata/sata_sil.c      |    5 +--
 drivers/ata/sata_sil24.c    |   27 ++---------------
 drivers/ata/sata_sis.c      |    5 +--
 drivers/ata/sata_svw.c      |    5 +--
 drivers/ata/sata_sx4.c      |    5 +--
 drivers/ata/sata_uli.c      |    5 +--
 drivers/ata/sata_via.c      |    5 +--
 drivers/ata/sata_vsc.c      |    5 +--
 include/linux/libata.h      |    2 +
 21 files changed, 115 insertions(+), 228 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 4242c70..fd9acf3 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1559,39 +1559,21 @@ static int ahci_host_init(struct ata_probe_ent *probe_ent)
 	struct ahci_host_priv *hpriv = probe_ent->private_data;
 	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
 	void __iomem *mmio = probe_ent->iomap[AHCI_PCI_BAR];
-	unsigned int i, using_dac;
+	unsigned int i;
+	u64 dma_mask;
 	int rc;
 
 	rc = ahci_reset_controller(mmio, pdev);
 	if (rc)
 		return rc;
 
-	using_dac = hpriv->cap & HOST_CAP_64;
-	if (using_dac &&
-	    !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
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
+	dma_mask = DMA_32BIT_MASK;
+	if (hpriv->cap & HOST_CAP_64)
+		dma_mask = DMA_64BIT_MASK;
+
+	rc = pci_configure_dma_masks(pdev, dma_mask, NULL);
+	if (rc)
+		return rc;
 
 	for (i = 0; i < probe_ent->n_ports; i++)
 		ahci_setup_port(&probe_ent->port[i], mmio, i);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0520950..6e124bd 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6094,6 +6094,75 @@ int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits)
 	return (tmp == bits->val) ? 1 : 0;
 }
 
+/**
+ *	pci_configure_dma_masks - PCI DMA mask configuration helper
+ *	@pdev: target PCI device
+ *	@dma_mask: target DMA mask
+ *	@configured_mask: out parameter for configured DMA mask (can be NULL)
+ *
+ *	Helper to configure PCI DMA mask.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+/* move to PCI layer */
+int pci_configure_dma_masks(struct pci_dev *pdev, u64 dma_mask,
+			    u64 *configured_mask)
+{
+	char *reason;
+	int rc = 0;
+
+	if (dma_mask == DMA_64BIT_MASK) {
+		if (pci_set_dma_mask(pdev, DMA_64BIT_MASK) == 0) {
+			rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
+			if (rc) {
+				rc = pci_set_consistent_dma_mask(pdev,
+							DMA_32BIT_MASK);
+				if (rc) {
+					reason = "64-bit DMA enable failed";
+					goto err;
+				}
+			}
+		} else {
+			rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
+			if (rc) {
+				reason = "32-bit DMA enable failed";
+				goto err;
+			}
+			rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
+			if (rc) {
+				reason = "32-bit consistent DMA enable failed";
+				goto err;
+			}
+
+			dma_mask = DMA_32BIT_MASK;
+		}
+	} else if (dma_mask) {
+		rc = pci_set_dma_mask(pdev, dma_mask);
+		if (rc) {
+			reason = "failed to set DMA mask";
+			goto err;
+		}
+		rc = pci_set_consistent_dma_mask(pdev, dma_mask);
+		if (rc) {
+			reason = "failed to set consistent DMA mask";
+			goto err;
+		}
+	}
+
+	if (configured_mask)
+		*configured_mask = dma_mask;
+
+	return rc;
+
+ err:
+	dev_printk(KERN_ERR, &pdev->dev, "%s (errno=%d)\n", reason, rc);
+	return rc;
+}
+
 #ifdef CONFIG_PM
 void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
@@ -6373,6 +6442,7 @@ EXPORT_SYMBOL_GPL(ata_timing_merge);
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
+EXPORT_SYMBOL_GPL(pci_configure_dma_masks);
 EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index df9c83b..dfd906c 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -839,10 +839,7 @@ int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 	}
 
 	/* TODO: If we get no DMA mask we should fall back to PIO */
-	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		goto err_out;
-	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
 	if (rc)
 		goto err_out;
 
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 7ef8342..6bddae5 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -210,7 +210,7 @@ static int __devinit cs5520_init_one(struct pci_dev *dev, const struct pci_devic
 	u8 pcicfg;
 	void *iomap[5];
 	static struct ata_probe_ent probe[2];
-	int ports = 0;
+	int ports = 0, rc;
 
 	/* IDE port enable bits */
 	pci_read_config_byte(dev, 0x60, &pcicfg);
@@ -230,14 +230,10 @@ static int __devinit cs5520_init_one(struct pci_dev *dev, const struct pci_devic
 		return -ENODEV;
 	}
 	pci_set_master(dev);
-	if (pci_set_dma_mask(dev, DMA_32BIT_MASK)) {
-		printk(KERN_ERR DRV_NAME ": unable to configure DMA mask.\n");
-		return -ENODEV;
-	}
-	if (pci_set_consistent_dma_mask(dev, DMA_32BIT_MASK)) {
-		printk(KERN_ERR DRV_NAME ": unable to configure consistent DMA mask.\n");
-		return -ENODEV;
-	}
+
+	rc = pci_configure_dma_masks(dev, DMA_32BIT_MASK, NULL);
+	if (rc)
+		return rc;
 
 	/* Map IO ports */
 	iomap[0] = devm_ioport_map(&dev->dev, 0x1F0, 8);
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 93bcdad..3ab66fd 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -772,11 +772,7 @@ static int __devinit pdc2027x_init_one(struct pci_dev *pdev, const struct pci_de
 	if (rc)
 		return rc;
 
-	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-
-	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index f3ed141..ee0c533 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -1115,10 +1115,7 @@ static int scc_host_init(struct ata_probe_ent *probe_ent)
 
 	probe_ent->n_ports = 1;
 
-	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 5dd3ca8..9448aab 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -600,25 +600,6 @@ static void adma_host_init(unsigned int chip_id,
 		adma_reset_engine(ADMA_REGS(mmio_base, port_no));
 }
 
-static int adma_set_dma_masks(struct pci_dev *pdev, void __iomem *mmio_base)
-{
-	int rc;
-
-	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
-	if (rc) {
-		dev_printk(KERN_ERR, &pdev->dev,
-			"32-bit DMA enable failed\n");
-		return rc;
-	}
-	rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
-	if (rc) {
-		dev_printk(KERN_ERR, &pdev->dev,
-			"32-bit consistent DMA enable failed\n");
-		return rc;
-	}
-	return 0;
-}
-
 static int adma_ata_init_one(struct pci_dev *pdev,
 			     const struct pci_device_id *ent)
 {
@@ -643,7 +624,7 @@ static int adma_ata_init_one(struct pci_dev *pdev,
 		return rc;
 	mmio_base = pcim_iomap_table(pdev)[ADMA_MMIO_BAR];
 
-	rc = adma_set_dma_masks(pdev, mmio_base);
+	rc = pci_configure_dma_masks(pdev, DMA_32BIT_MASK, NULL);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 6686c22..733d1f4 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -682,19 +682,9 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	iomap = pcim_iomap_table(pdev);
 
 	/* Set dma_mask.  This devices doesn't support 64bit addressing. */
-	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
-	if (rc) {
-		dev_printk(KERN_ERR, &pdev->dev,
-			   "32-bit DMA enable failed\n");
-		return rc;
-	}
-
-	rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
-	if (rc) {
-		dev_printk(KERN_ERR, &pdev->dev,
-			   "32-bit consistent DMA enable failed\n");
+	rc = pci_configure_dma_masks(pdev, DMA_32BIT_MASK, NULL);
+	if (rc)
 		return rc;
-	}
 
 	probe_ent = devm_kzalloc(&pdev->dev, sizeof(*probe_ent), GFP_KERNEL);
 	hpriv = devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 7b73c73..ed07f7a 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -581,40 +581,6 @@ static const struct mv_hw_ops mv6xxx_ops = {
  */
 static int msi;	      /* Use PCI msi; either zero (off, default) or non-zero */
 
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
 /*
  * Functions
  */
@@ -2349,7 +2315,7 @@ static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	rc = pci_go_64(pdev);
+	rc = pci_configure_dma_masks(pdev, DMA_64BIT_MASK, NULL);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 388d07f..eb0f877 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1474,7 +1474,7 @@ static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	u32 bar;
 	void __iomem *base;
 	unsigned long type = ent->driver_data;
-	int mask_set = 0;
+	u64 dma_mask = ATA_DMA_MASK;
 
         // Make sure this is a SATA controller by counting the number of bars
         // (NVIDIA SATA controllers will always have six bars).  Otherwise,
@@ -1499,19 +1499,12 @@ static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if(type >= CK804 && adma_enabled) {
 		dev_printk(KERN_NOTICE, &pdev->dev, "Using ADMA mode\n");
 		type = ADMA;
-		if(!pci_set_dma_mask(pdev, DMA_64BIT_MASK) &&
-		   !pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK))
-			mask_set = 1;
+		dma_mask = DMA_64BIT_MASK;
 	}
 
-	if(!mask_set) {
-		rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
-		if (rc)
-			return rc;
-		rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
-		if (rc)
-			return rc;
-	}
+	rc = pci_configure_dma_masks(pdev, dma_mask, NULL);
+	if (rc)
+		return rc;
 
 	rc = -ENOMEM;
 
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 2339813..71a05ad 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -873,10 +873,7 @@ static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	if (rc)
 		return rc;
 
-	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 8786b45..b1faaaf 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -560,49 +560,6 @@ static void qs_host_init(unsigned int chip_id, struct ata_probe_ent *pe)
 	writeb(1, mmio_base + QS_HCT_CTRL); /* enable host interrupts */
 }
 
-/*
- * The QStor understands 64-bit buses, and uses 64-bit fields
- * for DMA pointers regardless of bus width.  We just have to
- * make sure our DMA masks are set appropriately for whatever
- * bridge lies between us and the QStor, and then the DMA mapping
- * code will ensure we only ever "see" appropriate buffer addresses.
- * If we're 32-bit limited somewhere, then our 64-bit fields will
- * just end up with zeros in the upper 32-bits, without any special
- * logic required outside of this routine (below).
- */
-static int qs_set_dma_masks(struct pci_dev *pdev, void __iomem *mmio_base)
-{
-	u32 bus_info = readl(mmio_base + QS_HID_HPHY);
-	int rc, have_64bit_bus = (bus_info & QS_HPHY_64BIT);
-
-	if (have_64bit_bus &&
-	    !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
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
-				"32-bit DMA enable failed\n");
-			return rc;
-		}
-		rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
-		if (rc) {
-			dev_printk(KERN_ERR, &pdev->dev,
-				"32-bit consistent DMA enable failed\n");
-			return rc;
-		}
-	}
-	return 0;
-}
-
 static int qs_ata_init_one(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
@@ -611,6 +568,7 @@ static int qs_ata_init_one(struct pci_dev *pdev,
 	void __iomem * const *iomap;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int rc, port_no;
+	u64 dma_mask;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
@@ -627,7 +585,11 @@ static int qs_ata_init_one(struct pci_dev *pdev,
 		return rc;
 	iomap = pcim_iomap_table(pdev);
 
-	rc = qs_set_dma_masks(pdev, iomap[QS_MMIO_BAR]);
+	dma_mask = DMA_32BIT_MASK;
+	if (readl(iomap[QS_MMIO_BAR] + QS_HID_HPHY) & QS_HPHY_64BIT)
+		dma_mask = DMA_64BIT_MASK;
+
+	rc = pci_configure_dma_masks(pdev, dma_mask, NULL);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 170d36e..10e3aea 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -651,10 +651,7 @@ static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 7e3242e..ad5add7 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1073,30 +1073,9 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/*
 	 * Configure the device
 	 */
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
+	rc = pci_configure_dma_masks(pdev, DMA_64BIT_MASK, NULL);
+	if (rc)
+		return rc;
 
 	/* Apply workaround for completion IRQ loss on PCI-X errata */
 	if (probe_ent->port_flags & SIL24_FLAG_PCIX_IRQ_WOC) {
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 1879e0c..75c5683 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -276,10 +276,7 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		return rc;
 	}
 
-	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index b121195..e83a608 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -418,10 +418,7 @@ static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	if (rc)
 		return rc;
 
-	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 1a081c3..29a68a7 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -1341,10 +1341,7 @@ static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *
 	if (rc)
 		return rc;
 
-	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index d659ace..bfdb73e 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -205,10 +205,7 @@ static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		return rc;
 	}
 
-	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 598e6a2..1b43062 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -565,10 +565,7 @@ static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 			return -ENODEV;
 		}
 
-	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	rc = pci_configure_dma_masks(pdev, ATA_DMA_MASK, NULL);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 170bad1..675508f 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -395,10 +395,7 @@ static int __devinit vsc_sata_init_one (struct pci_dev *pdev, const struct pci_d
 	/*
 	 * Use 32 bit DMA mask, because 64 bit address support is poor.
 	 */
-	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
-	if (rc)
-		return rc;
-	rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
+	rc = pci_configure_dma_masks(pdev, DMA_32BIT_MASK, NULL);
 	if (rc)
 		return rc;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 065f494..911ac4e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -872,6 +872,8 @@ struct pci_bits {
 extern struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int portmask);
 extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
+extern int pci_configure_dma_masks(struct pci_dev *pdev, u64 dma_mask,
+				   u64 *configured_mask);
 extern unsigned long ata_pci_default_filter(const struct ata_port *, struct ata_device *, unsigned long);
 #endif /* CONFIG_PCI */
 
-- 
1.5.0.1

