From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/12] libata: kill ata_id_to_dma_mode()
Date: Tue, 27 Nov 2007 19:43:41 +0900
Message-ID: <11961602303295-git-send-email-htejun@gmail.com>
References: <11961602293422-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:39060 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbXK0KoC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 05:44:02 -0500
Received: by rv-out-0910.google.com with SMTP id k20so840818rvb
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 02:44:02 -0800 (PST)
In-Reply-To: <11961602293422-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>

ata_id_to_dma_mode() isn't quite generic.  The function is basically
privately implemented ata_id_xfermask() combined with hardcoded mode
printing and configuration which are specific to ata_generic.

Kill the function and open code it in generic_set_mode() using generic
xfermode handling functions.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_generic.c |   17 ++++++++++++++++-
 drivers/ata/libata-core.c |   43 -------------------------------------------
 include/linux/libata.h    |    1 -
 3 files changed, 16 insertions(+), 45 deletions(-)

diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index fb5434c..d11a4f1 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -63,7 +63,22 @@ static int generic_set_mode(struct ata_link *link, struct ata_device **unused)
 		/* We do need the right mode information for DMA or PIO
 		   and this comes from the current configuration flags */
 		if (dma_enabled & (1 << (5 + dev->devno))) {
-			ata_id_to_dma_mode(dev, XFER_MW_DMA_0);
+			unsigned int xfer_mask = ata_id_xfermask(dev->id);
+			const char *name;
+
+			if (xfer_mask & (ATA_MASK_MWDMA | ATA_MASK_UDMA))
+				name = ata_mode_string(xfer_mask);
+			else {
+				/* SWDMA perhaps? */
+				name = "DMA";
+				xfer_mask |= ata_xfer_mode2mask(XFER_MW_DMA_0);
+			}
+
+			ata_dev_printk(dev, KERN_INFO, "configured for %s\n",
+				       name);
+
+			dev->xfer_mode = ata_xfer_mask2mode(xfer_mask);
+			dev->xfer_shift = ata_xfer_mode2shift(dev->xfer_mode);
 			dev->flags &= ~ATA_DFLAG_PIO;
 		} else {
 			ata_dev_printk(dev, KERN_INFO, "configured for PIO\n");
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4f06ba7..88ed491 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1286,48 +1286,6 @@ static int ata_hpa_resize(struct ata_device *dev)
 }
 
 /**
- *	ata_id_to_dma_mode	-	Identify DMA mode from id block
- *	@dev: device to identify
- *	@unknown: mode to assume if we cannot tell
- *
- *	Set up the timing values for the device based upon the identify
- *	reported values for the DMA mode. This function is used by drivers
- *	which rely upon firmware configured modes, but wish to report the
- *	mode correctly when possible.
- *
- *	In addition we emit similarly formatted messages to the default
- *	ata_dev_set_mode handler, in order to provide consistency of
- *	presentation.
- */
-
-void ata_id_to_dma_mode(struct ata_device *dev, u8 unknown)
-{
-	unsigned int mask;
-	u8 mode;
-
-	/* Pack the DMA modes */
-	mask = ((dev->id[63] >> 8) << ATA_SHIFT_MWDMA) & ATA_MASK_MWDMA;
-	if (dev->id[53] & 0x04)
-		mask |= ((dev->id[88] >> 8) << ATA_SHIFT_UDMA) & ATA_MASK_UDMA;
-
-	/* Select the mode in use */
-	mode = ata_xfer_mask2mode(mask);
-
-	if (mode != 0xff) {
-		ata_dev_printk(dev, KERN_INFO, "configured for %s\n",
-		       ata_mode_string(mask));
-	} else {
-		/* SWDMA perhaps ? */
-		mode = unknown;
-		ata_dev_printk(dev, KERN_INFO, "configured for DMA\n");
-	}
-
-	/* Configure the device reporting */
-	dev->xfer_mode = mode;
-	dev->xfer_shift = ata_xfer_mode2shift(mode);
-}
-
-/**
  *	ata_noop_dev_select - Select device 0/1 on ATA bus
  *	@ap: ATA channel to manipulate
  *	@device: ATA device (numbered from zero) to select
@@ -7620,7 +7578,6 @@ EXPORT_SYMBOL_GPL(ata_host_resume);
 #endif /* CONFIG_PM */
 EXPORT_SYMBOL_GPL(ata_id_string);
 EXPORT_SYMBOL_GPL(ata_id_c_string);
-EXPORT_SYMBOL_GPL(ata_id_to_dma_mode);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 
 EXPORT_SYMBOL_GPL(ata_pio_need_iordy);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2a8c925..006183e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -887,7 +887,6 @@ extern void ata_id_string(const u16 *id, unsigned char *s,
 			  unsigned int ofs, unsigned int len);
 extern void ata_id_c_string(const u16 *id, unsigned char *s,
 			    unsigned int ofs, unsigned int len);
-extern void ata_id_to_dma_mode(struct ata_device *dev, u8 unknown);
 extern void ata_bmdma_setup(struct ata_queued_cmd *qc);
 extern void ata_bmdma_start(struct ata_queued_cmd *qc);
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
-- 
1.5.2.4

