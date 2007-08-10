From: akpm@linux-foundation.org
Subject: [patch 24/25] pata_cmd64x: Set up MWDMA modes properly
Date: Fri, 10 Aug 2007 13:59:49 -0700
Message-ID: <200708102059.l7AKxnUd008639@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42386 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765998AbXHJVQb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 17:16:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, mikpe@it.uu.se

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Set the MWDMA timing by updating the correct registers.  Split the PIO path as
this is mostly shared code.  Wants testing.

Signed-off-by: Alan Cox <alan@redhat.com>
Tested-by: Mikael Pettersson <mikpe@it.uu.se>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_cmd64x.c |   37 +++++++++++++++++++++++++-----------
 1 files changed, 26 insertions(+), 11 deletions(-)

diff -puN drivers/ata/pata_cmd64x.c~pata_cmd64x-set-up-mwdma-modes-properly drivers/ata/pata_cmd64x.c
--- a/drivers/ata/pata_cmd64x.c~pata_cmd64x-set-up-mwdma-modes-properly
+++ a/drivers/ata/pata_cmd64x.c
@@ -31,7 +31,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_cmd64x"
-#define DRV_VERSION "0.2.4"
+#define DRV_VERSION "0.2.5"
 
 /*
  * CMD64x specific registers definition.
@@ -88,14 +88,15 @@ static int cmd648_cable_detect(struct at
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
@@ -117,8 +118,9 @@ static void cmd64x_set_piomode(struct at
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
@@ -168,6 +170,20 @@ static void cmd64x_set_piomode(struct at
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
@@ -180,9 +196,6 @@ static void cmd64x_set_dmamode(struct at
 	static const u8 udma_data[] = {
 		0x30, 0x20, 0x10, 0x20, 0x10, 0x00
 	};
-	static const u8 mwdma_data[] = {
-		0x30, 0x20, 0x10
-	};
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 regU, regD;
@@ -208,8 +221,10 @@ static void cmd64x_set_dmamode(struct at
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
 
_
