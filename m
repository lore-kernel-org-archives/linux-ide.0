From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/6] sgiioc4: use ide_tune_dma()
Date: Wed, 11 Jul 2007 02:06:07 +0200
Message-ID: <200707110206.07157.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:5207 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158AbXGJXwb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 19:52:31 -0400
Received: by wr-out-0506.google.com with SMTP id i30so694401wra
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 16:52:30 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeremy Higdon <jeremy@sgi.com>


* Add DRV_NAME define and use it instead of sgiioc4_chipset.name.

* Remove no longer needed sgiioc4_chipset.

* Remove needless clearing of ->atapi_dma from ide_dma_sgiioc4().

* Fix ide_dma_sgiioc4() to return success/failure.  Check return value in
  sgiioc4_ide_setup_pci_device() and set hwif->autodma accordingly.  Also add
  missing setting of drive->autodma.

* Add sgiioc4_speedproc() (implementation of ->speedproc method).

* Fix ->mwdma_mask (MWDMA2 mask is 0x04 not 0x02) and remove incorrect
  ->swdma_mask.  Also remove needless initialization of ->ultra_mask.

* Use ide_tune_dma() in sgiioc4_ide_dma_check(), this fixes following bugs:
  - DMA capability bit not being checked on the device
  - DMA blacklist not being checked
  - MWDMA2 mode support by device not being checked

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeremy Higdon <jeremy@sgi.com>
---
 drivers/ide/pci/sgiioc4.c |   86 +++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -34,6 +34,8 @@
 
 #include <linux/ide.h>
 
+#define DRV_NAME "SGIIOC4"
+
 /* IOC4 Specific Definitions */
 #define IOC4_CMD_OFFSET		0x100
 #define IOC4_CTRL_OFFSET	0x120
@@ -289,15 +291,26 @@ static void sgiioc4_dma_off_quietly(ide_
 	drive->hwif->dma_host_off(drive);
 }
 
+static int sgiioc4_speedproc(ide_drive_t *drive, const u8 speed)
+{
+	if (speed != XFER_MW_DMA_2)
+		return 1;
+
+	return ide_config_drive_speed(drive, speed);
+}
+
 static int sgiioc4_ide_dma_check(ide_drive_t *drive)
 {
-	/* FIXME: check for available DMA modes */
-	if (ide_config_drive_speed(drive, XFER_MW_DMA_2) != 0) {
-		printk(KERN_WARNING "%s: couldn't set MWDMA2 mode, "
-				    "using PIO instead\n", drive->name);
-		return -1;
-	} else
+	if (ide_tune_dma(drive))
 		return 0;
+
+	/*
+	 * ->set_pio_mode is not implemented currently
+	 * so this is just for the completness
+	 */
+	ide_set_max_pio(drive);
+
+	return -1;
 }
 
 /* returns 1 if dma irq issued, 0 otherwise */
@@ -353,7 +366,7 @@ sgiioc4_INB(unsigned long port)
 }
 
 /* Creates a dma map for the scatter-gather list entries */
-static void __devinit
+static int __devinit
 ide_dma_sgiioc4(ide_hwif_t * hwif, unsigned long dma_base)
 {
 	void __iomem *virt_dma_base;
@@ -369,7 +382,7 @@ ide_dma_sgiioc4(ide_hwif_t * hwif, unsig
 		       "ALREADY in use\n",
 		       __FUNCTION__, hwif->name, (void *) dma_base,
 		       (void *) dma_base + num_ports - 1);
-		goto dma_alloc_failure;
+		return -1;
 	}
 
 	virt_dma_base = ioremap(dma_base, num_ports);
@@ -395,7 +408,7 @@ ide_dma_sgiioc4(ide_hwif_t * hwif, unsig
 
 	if (pad) {
 		ide_set_hwifdata(hwif, pad);
-		return;
+		return 0;
 	}
 
 	pci_free_consistent(hwif->pci_dev,
@@ -413,10 +426,7 @@ dma_pci_alloc_failure:
 dma_remap_failure:
 	release_mem_region(dma_base, num_ports);
 
-dma_alloc_failure:
-	/* Disable DMA because we couldnot allocate any DMA maps */
-	hwif->autodma = 0;
-	hwif->atapi_dma = 0;
+	return -1;
 }
 
 /* Initializes the IOC4 DMA Engine */
@@ -581,14 +591,11 @@ static void __devinit
 ide_init_sgiioc4(ide_hwif_t * hwif)
 {
 	hwif->mmio = 1;
-	hwif->autodma = 1;
 	hwif->atapi_dma = 1;
-	hwif->ultra_mask = 0x0;	/* Disable Ultra DMA */
-	hwif->mwdma_mask = 0x2;	/* Multimode-2 DMA  */
-	hwif->swdma_mask = 0x2;
+	hwif->mwdma_mask = 0x04;
 	hwif->pio_mask = 0x00;
 	hwif->set_pio_mode = NULL; /* Sets timing for PIO mode */
-	hwif->speedproc = NULL;	/* Sets timing for DMA &/or PIO modes */
+	hwif->speedproc = &sgiioc4_speedproc;
 	hwif->selectproc = NULL;/* Use the default routine to select drive */
 	hwif->reset_poll = NULL;/* No HBA specific reset_poll needed */
 	hwif->pre_reset = NULL;	/* No HBA specific pre_set needed */
@@ -615,7 +622,7 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 }
 
 static int __devinit
-sgiioc4_ide_setup_pci_device(struct pci_dev *dev, ide_pci_device_t * d)
+sgiioc4_ide_setup_pci_device(struct pci_dev *dev)
 {
 	unsigned long cmd_base, dma_base, irqport;
 	unsigned long bar0, cmd_phys_base, ctl;
@@ -632,7 +639,8 @@ sgiioc4_ide_setup_pci_device(struct pci_
 			break;
 	}
 	if (h == MAX_HWIFS) {
-		printk(KERN_ERR "%s: too many IDE interfaces, no room in table\n", d->name);
+		printk(KERN_ERR "%s: too many IDE interfaces, no room in table\n",
+				DRV_NAME);
 		return -ENOMEM;
 	}
 
@@ -641,7 +649,7 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	virt_base = ioremap(bar0, pci_resource_len(dev, 0));
 	if (virt_base == NULL) {
 		printk(KERN_ERR "%s: Unable to remap BAR 0 address: 0x%lx\n",
-			d->name, bar0);
+				DRV_NAME, bar0);
 		return -ENOMEM;
 	}
 	cmd_base = (unsigned long) virt_base + IOC4_CMD_OFFSET;
@@ -672,7 +680,6 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	hwif->chipset = ide_pci;
 	hwif->pci_dev = dev;
 	hwif->channel = 0;	/* Single Channel chip */
-	hwif->cds = (struct ide_pci_device_s *) d;
 	hwif->gendev.parent = &dev->dev;/* setup proper ancestral information */
 
 	/* The IOC4 uses MMIO rather than Port IO. */
@@ -683,11 +690,14 @@ sgiioc4_ide_setup_pci_device(struct pci_
 
 	ide_init_sgiioc4(hwif);
 
-	if (dma_base)
-		ide_dma_sgiioc4(hwif, dma_base);
-	else
+	hwif->autodma = 0;
+
+	if (dma_base && ide_dma_sgiioc4(hwif, dma_base) == 0) {
+		hwif->autodma = 1;
+		hwif->drives[1].autodma = hwif->drives[0].autodma = 1;
+	} else
 		printk(KERN_INFO "%s: %s Bus-Master DMA disabled\n",
-		       hwif->name, d->name);
+				 hwif->name, DRV_NAME);
 
 	if (probe_hwif_init(hwif))
 		return -EIO;
@@ -699,7 +709,7 @@ sgiioc4_ide_setup_pci_device(struct pci_
 }
 
 static unsigned int __devinit
-pci_init_sgiioc4(struct pci_dev *dev, ide_pci_device_t * d)
+pci_init_sgiioc4(struct pci_dev *dev)
 {
 	unsigned int class_rev;
 	int ret;
@@ -707,30 +717,20 @@ pci_init_sgiioc4(struct pci_dev *dev, id
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
 	printk(KERN_INFO "%s: IDE controller at PCI slot %s, revision %d\n",
-			d->name, pci_name(dev), class_rev);
+			 DRV_NAME, pci_name(dev), class_rev);
 	if (class_rev < IOC4_SUPPORTED_FIRMWARE_REV) {
 		printk(KERN_ERR "Skipping %s IDE controller in slot %s: "
-			"firmware is obsolete - please upgrade to revision"
-			"46 or higher\n", d->name, pci_name(dev));
+				"firmware is obsolete - please upgrade to "
+				"revision46 or higher\n",
+				DRV_NAME, pci_name(dev));
 		ret = -EAGAIN;
 		goto out;
 	}
-	ret = sgiioc4_ide_setup_pci_device(dev, d);
+	ret = sgiioc4_ide_setup_pci_device(dev);
 out:
 	return ret;
 }
 
-static ide_pci_device_t sgiioc4_chipset __devinitdata = {
-	 /* Channel 0 */
-	 .name = "SGIIOC4",
-	 .init_hwif = ide_init_sgiioc4,
-	 .init_dma = ide_dma_sgiioc4,
-	 .autodma = AUTODMA,
-	 /* SGI IOC4 doesn't have enablebits. */
-	 .bootable = ON_BOARD,
-	 .host_flags = IDE_HFLAG_SINGLE,
-};
-
 int
 ioc4_ide_attach_one(struct ioc4_driver_data *idd)
 {
@@ -740,7 +740,7 @@ ioc4_ide_attach_one(struct ioc4_driver_d
 	if (idd->idd_variant == IOC4_VARIANT_PCI_RT)
 		return 0;
 
-	return pci_init_sgiioc4(idd->idd_pdev, &sgiioc4_chipset);
+	return pci_init_sgiioc4(idd->idd_pdev);
 }
 
 static struct ioc4_submodule ioc4_ide_submodule = {
