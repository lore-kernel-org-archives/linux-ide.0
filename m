From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Report PIO/DMA status when overriding set_mode
Date: Mon, 5 Feb 2007 16:33:44 +0000
Message-ID: <20070205163344.010a9892@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56890 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751532AbXBEQUv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 11:20:51 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Currently we don't report PIO/DMA information in the case we are using
firmware mode setup by drivers, or where the value is meaningless. Even
when we don't know the mode, or the mode is meaningless it would be nice
to report PIO or DMA and to keep stylistic consistency. For MW/UDMA we
can report the actual firmware set mode and we add a helper for this.

This patch for now is just a proposal for comment

(and while we could guess the PIO mode by playing with the command
registers and timing them I don't think its worth it)

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/drivers/ata/ata_generic.c linux-2.6.20-rc6-mm3/drivers/ata/ata_generic.c
--- linux.vanilla-2.6.20-rc6-mm3/drivers/ata/ata_generic.c	2007-01-31 14:20:39.000000000 +0000
+++ linux-2.6.20-rc6-mm3/drivers/ata/ata_generic.c	2007-02-01 16:04:20.000000000 +0000
@@ -90,10 +90,10 @@
 			/* We do need the right mode information for DMA or PIO
 			   and this comes from the current configuration flags */
 			if (dma_enabled & (1 << (5 + i))) {
-				dev->xfer_mode = XFER_MW_DMA_0;
-				dev->xfer_shift = ATA_SHIFT_MWDMA;
+				ata_id_to_dma_mode(dev, XFER_MW_DMA_0);
 				dev->flags &= ~ATA_DFLAG_PIO;
 			} else {
+				ata_dev_printk(dev, KERN_INFO, "configured for PIO\n");
 				dev->xfer_mode = XFER_PIO_0;
 				dev->xfer_shift = ATA_SHIFT_PIO;
 				dev->flags |= ATA_DFLAG_PIO;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/drivers/ata/libata-core.c linux-2.6.20-rc6-mm3/drivers/ata/libata-core.c
--- linux.vanilla-2.6.20-rc6-mm3/drivers/ata/libata-core.c	2007-01-31 14:20:39.000000000 +0000
+++ linux-2.6.20-rc6-mm3/drivers/ata/libata-core.c	2007-02-01 16:14:01.000000000 +0000
@@ -887,6 +887,48 @@
 }
 
 /**
+ *	ata_id_to_dma_mode	-	Identify DMA mode from id block
+ *	@dev: device to identify
+ *	@mode: mode to assume if we cannot tell
+ *
+ *	Set up the timing values for the device based upon the identify
+ *	reported values for the DMA mode. This function is used by drivers
+ *	which rely upon firmware configured modes, but wish to report the
+ *	mode correctly when possible.
+ *
+ *	In addition we emit similarly formatted messages to the default
+ *	ata_dev_set_mode handler, in order to provide consistency of
+ *	presentation.
+ */
+
+void ata_id_to_dma_mode(struct ata_device *dev, u8 unknown)
+{
+	unsigned int mask;
+	u8 mode;
+
+	/* Pack the DMA modes */
+	mask = ((dev->id[63] >> 8) << ATA_SHIFT_MWDMA) & ATA_MASK_MWDMA;
+	if (dev->id[53] & 0x04)
+		mask |= ((dev->id[88] >> 8) << ATA_SHIFT_UDMA) & ATA_MASK_UDMA;
+
+	/* Select the mode in use */
+	mode = ata_xfer_mask2mode(mask);
+
+	if (mode != 0) {
+		ata_dev_printk(dev, KERN_INFO, "configured for %s\n",
+		       ata_mode_string(mask));
+	} else {
+		/* SWDMA perhaps ? */
+		mode = unknown;
+		ata_dev_printk(dev, KERN_INFO, "configured for DMA\n");
+	}
+
+	/* Configure the device reporting */
+	dev->xfer_mode = mode;
+	dev->xfer_shift = ata_xfer_mode2shift(mode);
+}
+
+/**
  *	ata_noop_dev_select - Select device 0/1 on ATA bus
  *	@ap: ATA channel to manipulate
  *	@device: ATA device (numbered from zero) to select
@@ -6468,6 +6556,7 @@
 EXPORT_SYMBOL_GPL(ata_host_resume);
 EXPORT_SYMBOL_GPL(ata_id_string);
 EXPORT_SYMBOL_GPL(ata_id_c_string);
+EXPORT_SYMBOL_GPL(ata_id_to_dma_mode);
 EXPORT_SYMBOL_GPL(ata_device_blacklisted);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/drivers/ata/pata_it821x.c linux-2.6.20-rc6-mm3/drivers/ata/pata_it821x.c
--- linux.vanilla-2.6.20-rc6-mm3/drivers/ata/pata_it821x.c	2007-01-31 14:20:39.000000000 +0000
+++ linux-2.6.20-rc6-mm3/drivers/ata/pata_it821x.c	2007-02-01 16:04:54.000000000 +0000
@@ -503,10 +503,12 @@
 			/* We do need the right mode information for DMA or PIO
 			   and this comes from the current configuration flags */
 			if (dma_enabled & (1 << (5 + i))) {
+				ata_dev_printk(dev, KERN_INFO, "configured for PIO\n");
 				dev->xfer_mode = XFER_MW_DMA_0;
 				dev->xfer_shift = ATA_SHIFT_MWDMA;
 				dev->flags &= ~ATA_DFLAG_PIO;
 			} else {
+				ata_dev_printk(dev, KERN_INFO, "configured for DMA\n");
 				dev->xfer_mode = XFER_PIO_0;
 				dev->xfer_shift = ATA_SHIFT_PIO;
 				dev->flags |= ATA_DFLAG_PIO;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/drivers/ata/pata_platform.c linux-2.6.20-rc6-mm3/drivers/ata/pata_platform.c
--- linux.vanilla-2.6.20-rc6-mm3/drivers/ata/pata_platform.c	2007-01-31 14:20:39.000000000 +0000
+++ linux-2.6.20-rc6-mm3/drivers/ata/pata_platform.c	2007-02-01 16:06:36.000000000 +0000
@@ -43,6 +43,7 @@
 			dev->pio_mode = dev->xfer_mode = XFER_PIO_0;
 			dev->xfer_shift = ATA_SHIFT_PIO;
 			dev->flags |= ATA_DFLAG_PIO;
+			ata_dev_printk(dev, KERN_INFO, "configured for PIO\n");
 		}
 	}
 	return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/drivers/ata/pata_rz1000.c linux-2.6.20-rc6-mm3/drivers/ata/pata_rz1000.c
--- linux.vanilla-2.6.20-rc6-mm3/drivers/ata/pata_rz1000.c	2007-01-31 14:20:39.000000000 +0000
+++ linux-2.6.20-rc6-mm3/drivers/ata/pata_rz1000.c	2007-02-01 16:05:44.000000000 +0000
@@ -71,6 +71,7 @@
 			dev->xfer_mode = XFER_PIO_0;
 			dev->xfer_shift = ATA_SHIFT_PIO;
 			dev->flags |= ATA_DFLAG_PIO;
+			ata_dev_printk(dev, KERN_INFO, "configured for PIO\n");
 		}
 	}
 	return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/include/linux/libata.h linux-2.6.20-rc6-mm3/include/linux/libata.h
--- linux.vanilla-2.6.20-rc6-mm3/include/linux/libata.h	2007-01-31 14:20:43.000000000 +0000
+++ linux-2.6.20-rc6-mm3/include/linux/libata.h	2007-02-01 16:11:57.000000000 +0000
@@ -795,6 +796,7 @@
 			  unsigned int ofs, unsigned int len);
 extern void ata_id_c_string(const u16 *id, unsigned char *s,
 			    unsigned int ofs, unsigned int len);
+extern void ata_id_to_dma_mode(struct ata_device *dev, u8 unknown);
 extern unsigned long ata_device_blacklisted(const struct ata_device *dev);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
