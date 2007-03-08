From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_ali: Remove all the crap again and switch to
 cable_detect method
Date: Thu, 8 Mar 2007 19:23:21 +0000
Message-ID: <20070308192321.5fd01427@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55631 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752618AbXCHSTE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 13:19:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_ali.c linux-2.6.21-rc3-mm2/drivers/ata/pata_ali.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_ali.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_ali.c	2007-03-08 16:17:44.000000000 +0000
@@ -34,7 +34,7 @@
 #include <linux/dmi.h>
 
 #define DRV_NAME "pata_ali"
-#define DRV_VERSION "0.7.3"
+#define DRV_VERSION "0.7.4"
 
 /*
  *	Cable special cases
@@ -90,61 +90,6 @@
 }
 
 /**
- *	ali_early_error_handler	-	reset for eary chip
- *	@ap: ATA port
- *	@deadline: deadline jiffies for the operation
- *
- *	Handle the reset callback for the later chips with cable detect
- */
-
-static int ali_c2_pre_reset(struct ata_port *ap, unsigned long deadline)
-{
-	ap->cbl = ali_c2_cable_detect(ap);
-	return ata_std_prereset(ap, deadline);
-}
-
-static void ali_c2_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, ali_c2_pre_reset,
-			       ata_std_softreset, NULL,
-			       ata_std_postreset);
-}
-
-/**
- *	ali_early_cable_detect	-	cable detection
- *	@ap: ATA port
- *
- *	Perform cable detection for older chipsets. This turns out to be
- *	rather easy to implement
- */
-
-static int ali_early_cable_detect(struct ata_port *ap)
-{
-	return ATA_CBL_PATA40;
-}
-
-/**
- *	ali_early_probe_init	-	reset for early chip
- *	@ap: ATA port
- *	@deadline: deadline jiffies for the operation
- *
- *	Handle the reset callback for the early (pre cable detect) chips.
- */
-
-static int ali_early_pre_reset(struct ata_port *ap, unsigned long deadline)
-{
-	ap->cbl = ali_early_cable_detect(ap);
-	return ata_std_prereset(ap, deadline);
-}
-
-static void ali_early_error_handler(struct ata_port *ap)
-{
-	return ata_bmdma_drive_eh(ap, ali_early_pre_reset,
-				     ata_std_softreset, NULL,
-				     ata_std_postreset);
-}
-
-/**
  *	ali_20_filter		-	filter for earlier ALI DMA
  *	@ap: ALi ATA port
  *	@adev: attached device
@@ -153,7 +98,7 @@
  *	fix that later on. Also ensure we do not do UDMA on WDC drives
  */
 
-static unsigned long ali_20_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long mask)
+static unsigned long ali_20_filter(struct ata_device *adev, unsigned long mask)
 {
 	char model_num[ATA_ID_PROD_LEN + 1];
 	/* No DMA on anything but a disk for now */
@@ -162,7 +107,7 @@
 	ata_id_c_string(adev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 	if (strstr(model_num, "WDC"))
 		return mask &= ~ATA_MASK_UDMA;
-	return ata_pci_default_filter(ap, adev, mask);
+	return ata_pci_default_filter(adev, mask);
 }
 
 /**
@@ -316,7 +261,6 @@
 
 /**
  *	ali_lock_sectors	-	Keep older devices to 255 sector mode
- *	@ap: ATA port
  *	@adev: Device
  *
  *	Called during the bus probe for each device that is found. We use
@@ -368,8 +312,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ali_early_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
@@ -404,8 +349,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ali_early_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -442,8 +388,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ali_c2_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ali_c2_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -479,8 +426,9 @@
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= ali_c2_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ali_c2_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
