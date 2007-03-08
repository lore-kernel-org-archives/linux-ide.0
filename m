From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Change prototype of mode_filter to remove ata_port
 *
Date: Thu, 8 Mar 2007 23:45:42 +0000
Message-ID: <20070308234542.01176a18@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52165 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030824AbXCHWlg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 17:41:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

With Tejun having added adev->ap some time ago we can get rid of the
almost unused port being passed to mode filters. And while we are doing filters,
lets turn on the !IORDY filter as well.

(Versus -mm tree and queued diffs so may not 100% match your tree Jeff
but cc'd so you can comment on if this is a good idea or
not)

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/include/linux/libata.h linux-2.6.21-rc3-mm2/include/linux/libata.h
--- linux.vanilla-2.6.21-rc3-mm2/include/linux/libata.h	2007-03-08 16:01:12.000000000 +0000
+++ linux-2.6.21-rc3-mm2/include/linux/libata.h	2007-03-08 16:09:00.000000000 +0000
@@ -589,7 +590,7 @@
 
 	void (*set_piomode) (struct ata_port *, struct ata_device *);
 	void (*set_dmamode) (struct ata_port *, struct ata_device *);
-	unsigned long (*mode_filter) (const struct ata_port *, struct ata_device *, unsigned long);
+	unsigned long (*mode_filter) (struct ata_device *, unsigned long);
 
 	void (*tf_load) (struct ata_port *ap, const struct ata_taskfile *tf);
 	void (*tf_read) (struct ata_port *ap, struct ata_taskfile *tf);
@@ -875,7 +874,7 @@
 extern struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int portmask);
 extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
-extern unsigned long ata_pci_default_filter(const struct ata_port *, struct ata_device *, unsigned long);
+extern unsigned long ata_pci_default_filter(struct ata_device *, unsigned long);
 #endif /* CONFIG_PCI */
 
 /*
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-core.c linux-2.6.21-rc3-mm2/drivers/ata/libata-core.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-core.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/libata-core.c	2007-03-08 16:02:52.000000000 +0000
@@ -3559,8 +3577,11 @@
 			       "other device, disabling DMA\n");
 	}
 
+	if (ap->flags & ATA_FLAG_NO_IORDY)
+		xfer_mask &= ata_pio_mask_no_iordy(dev);
+
 	if (ap->ops->mode_filter)
-		xfer_mask = ap->ops->mode_filter(ap, dev, xfer_mask);
+		xfer_mask = ap->ops->mode_filter(dev, xfer_mask);
 
 	/* Apply cable rule here.  Don't apply it early because when
 	 * we handle hot plug the cable type can itself change.
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_hpt37x.c linux-2.6.21-rc3-mm2/drivers/ata/pata_hpt37x.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_hpt37x.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_hpt37x.c	2007-03-08 17:08:53.000000000 +0000
@@ -397,13 +272,12 @@
 
 /**
  *	hpt370_filter	-	mode selection filter
- *	@ap: ATA interface
  *	@adev: ATA device
  *
  *	Block UDMA on devices that cause trouble with this controller.
  */
 
-static unsigned long hpt370_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long mask)
+static unsigned long hpt370_filter(struct ata_device *adev, unsigned long mask)
 {
 	if (adev->class == ATA_DEV_ATA) {
 		if (hpt_dma_blacklisted(adev, "UDMA", bad_ata33))
@@ -411,24 +285,23 @@
 		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
 			mask &= ~(0x1F << ATA_SHIFT_UDMA);
 	}
-	return ata_pci_default_filter(ap, adev, mask);
+	return ata_pci_default_filter(adev, mask);
 }
 
 /**
  *	hpt370a_filter	-	mode selection filter
- *	@ap: ATA interface
  *	@adev: ATA device
  *
  *	Block UDMA on devices that cause trouble with this controller.
  */
 
-static unsigned long hpt370a_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long mask)
+static unsigned long hpt370a_filter(struct ata_device *adev, unsigned long mask)
 {
 	if (adev->class != ATA_DEV_ATA) {
 		if (hpt_dma_blacklisted(adev, "UDMA100", bad_ata100_5))
 			mask &= ~ (0x1F << ATA_SHIFT_UDMA);
 	}
-	return ata_pci_default_filter(ap, adev, mask);
+	return ata_pci_default_filter(adev, mask);
 }
 
 /**
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_pdc2027x.c linux-2.6.21-rc3-mm2/drivers/ata/pata_pdc2027x.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_pdc2027x.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_pdc2027x.c	2007-03-08 16:34:56.000000000 +0000
@@ -179,7 +183,8 @@
 	.port_disable		= ata_port_disable,
 	.set_piomode		= pdc2027x_set_piomode,
 	.set_dmamode		= pdc2027x_set_dmamode,
-	.post_set_mode		= pdc2027x_post_set_mode,
+	.set_mode		= pdc2027x_set_mode,
+	.mode_filter		= pdc2027x_mode_filter,
 
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
@@ -200,6 +205,7 @@
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= pdc2027x_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= pdc2027x_cable_detect,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -445,17 +473,22 @@
 }
 
 /**
- *	pdc2027x_post_set_mode - Set the timing registers back to correct values.
+ *	pdc2027x_set_mode - Set the timing registers back to correct values.
  *	@ap: Port to configure
+ *	@r_failed: Returned device for failure
  *
  *	The pdc2027x hardware will look at "SET FEATURES" and change the timing registers
  *	automatically. The values set by the hardware might be incorrect, under 133Mhz PLL.
  *	This function overwrites the possibly incorrect values set by the hardware to be correct.
  */
-static void pdc2027x_post_set_mode(struct ata_port *ap)
+static int pdc2027x_set_mode(struct ata_port *ap, struct ata_device **r_failed)
 {
 	int i;
 
+	i = ata_do_set_mode(ap, r_failed);
+	if (i < 0)
+		return i;
+
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
 
@@ -477,6 +510,7 @@
 			}
 		}
 	}
+	return 0;
 }
 
 /**
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_serverworks.c linux-2.6.21-rc3-mm2/drivers/ata/pata_serverworks.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_serverworks.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_serverworks.c	2007-03-08 16:35:59.000000000 +0000
@@ -193,31 +185,31 @@
 
 /**
  *	serverworks_osb4_filter	-	mode selection filter
- *	@ap: ATA interface
  *	@adev: ATA device
+ *	@mask: Mask of proposed modes
  *
  *	Filter the offered modes for the device to apply controller
  *	specific rules. OSB4 requires no UDMA for disks due to a FIFO
  *	bug we hit.
  */
 
-static unsigned long serverworks_osb4_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long mask)
+static unsigned long serverworks_osb4_filter(struct ata_device *adev, unsigned long mask)
 {
 	if (adev->class == ATA_DEV_ATA)
 		mask &= ~ATA_MASK_UDMA;
-	return ata_pci_default_filter(ap, adev, mask);
+	return ata_pci_default_filter(adev, mask);
 }
 
 
 /**
  *	serverworks_csb_filter	-	mode selection filter
- *	@ap: ATA interface
  *	@adev: ATA device
+ *	@mask: Mask of proposed modes
  *
  *	Check the blacklist and disable UDMA5 if matched
  */
 
-static unsigned long serverworks_csb_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long mask)
+static unsigned long serverworks_csb_filter(struct ata_device *adev, unsigned long mask)
 {
 	const char *p;
 	char model_num[ATA_ID_PROD_LEN + 1];
@@ -225,7 +217,7 @@
 
 	/* Disk, UDMA */
 	if (adev->class != ATA_DEV_ATA)
-		return ata_pci_default_filter(ap, adev, mask);
+		return ata_pci_default_filter(adev, mask);
 
 	/* Actually do need to check */
 	ata_id_c_string(adev->id, model_num, ATA_ID_PROD, sizeof(model_num));
@@ -234,7 +226,7 @@
 		if (!strcmp(p, model_num))
 			mask &= ~(0x1F << ATA_SHIFT_UDMA);
 	}
-	return ata_pci_default_filter(ap, adev, mask);
+	return ata_pci_default_filter(adev, mask);
 }
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-sff.c linux-2.6.21-rc3-mm2/drivers/ata/libata-sff.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-sff.c	2007-03-08 15:59:20.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/libata-sff.c	2007-03-08 16:03:01.000000000 +0000
@@ -893,12 +893,12 @@
 	return 0;
 }
 
-unsigned long ata_pci_default_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long xfer_mask)
+unsigned long ata_pci_default_filter(struct ata_device *adev, unsigned long xfer_mask)
 {
 	/* Filter out DMA modes if the device has been configured by
 	   the BIOS as PIO only */
 
-	if (ap->ioaddr.bmdma_addr == 0)
+	if (adev->ap->ioaddr.bmdma_addr == 0)
 		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 	return xfer_mask;
 }
