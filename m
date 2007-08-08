From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_cmd64x: Set up MWDMA modes properly
Date: Wed, 8 Aug 2007 14:33:20 +0100
Message-ID: <20070808143320.0de8c5d9@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47052 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759670AbXHHNZz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 09:25:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, akpm@osdl.org, jeff@garzik.org

Set the MWDMA timing by updating the correct registers. Split the PIO
path as this is mostly shared code. Wants testing.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/drivers/ata/pata_cmd64x.c linux-2.6.23rc1-mm1/drivers/ata/pata_cmd64x.c
--- linux.vanilla-2.6.23rc1-mm1/drivers/ata/pata_cmd64x.c	2007-07-26 15:01:52.000000000 +0100
+++ linux-2.6.23rc1-mm1/drivers/ata/pata_cmd64x.c	2007-08-08 11:52:23.000000000 +0100
@@ -31,7 +31,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_cmd64x"
-#define DRV_VERSION "0.2.3"
+#define DRV_VERSION "0.2.4"
 
 /*
  * CMD64x specific registers definition.
@@ -88,14 +88,15 @@
 }
 
 /**
- *	cmd64x_set_piomode	-	set initial PIO mode data
+ *	cmd64x_set_piomode	-	set PIO and MWDMA timing
  *	@ap: ATA interface
  *	@adev: ATA device
+ *	@mode: mode
  *
- *	Called to do the PIO mode setup.
+ *	Called to do the PIO and MWDMA mode setup.
  */
 
-static void cmd64x_set_piomode(struct ata_port *ap, struct ata_device *adev)
+static void cmd64x_set_timing(struct ata_port *ap, struct ata_device *adev, u8 mode)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct ata_timing t;
@@ -117,8 +118,9 @@
 	int arttim = arttim_port[ap->port_no][adev->devno];
 	int drwtim = drwtim_port[ap->port_no][adev->devno];
 
-
-	if (ata_timing_compute(adev, adev->pio_mode, &t, T, 0) < 0) {
+	/* ata_timing_compute is smart and will produce timings for MWDMA
+	   that don't violate the drives PIO capabilities. */
+	if (ata_timing_compute(adev, mode, &t, T, 0) < 0) {
 		printk(KERN_ERR DRV_NAME ": mode computation failed.\n");
 		return;
 	}
@@ -168,6 +170,20 @@
 }
 
 /**
+ *	cmd64x_set_piomode	-	set initial PIO mode data
+ *	@ap: ATA interface
+ *	@adev: ATA device
+ *
+ *	Used when configuring the devices ot set the PIO timings. All the
+ *	actual work is done by the PIO/MWDMA setting helper
+ */
+
+static void cmd64x_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	cmd64x_set_timing(ap, adev, adev->pio_mode);
+}
+
+/**
  *	cmd64x_set_dmamode	-	set initial DMA mode data
  *	@ap: ATA interface
  *	@adev: ATA device
@@ -180,9 +196,6 @@
 	static const u8 udma_data[] = {
 		0x30, 0x20, 0x10, 0x20, 0x10, 0x00
 	};
-	static const u8 mwdma_data[] = {
-		0x30, 0x20, 0x10
-	};
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 regU, regD;
@@ -208,8 +221,10 @@
 		regU |= 1 << adev->devno; /* UDMA on */
 		if (adev->dma_mode > 2)	/* 15nS timing */
 			regU |= 4 << adev->devno;
-	} else
-		regD |= mwdma_data[adev->dma_mode - XFER_MW_DMA_0] << shift;
+	} else {
+		regU &= ~ (1 << adev->devno);	/* UDMA off */
+		cmd64x_set_timing(ap, adev, adev->dma_mode);
+	}
 
 	regD |= 0x20 << adev->devno;
 
