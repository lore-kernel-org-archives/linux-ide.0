From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/6] libata: kill unused xfer_mode functions
Date: Mon, 6 Mar 2006 04:35:00 +0900
Message-ID: <20060305193500.GA6419@htj.dyndns.org>
References: <11415871161709-git-send-email-htejun@gmail.com> <11415871174010-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:17046 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750710AbWCETfE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 14:35:04 -0500
Received: by zproxy.gmail.com with SMTP id 13so1079496nzn
        for <linux-ide@vger.kernel.org>; Sun, 05 Mar 2006 11:35:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <11415871174010-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Preceding xfer_mask changes make the following functions unused.

  ata_pio_modes(), base_from_shift(), ata_pr_blacklisted(), fgb()

Kill them.  Also, as xfer_mode_str[] is now only used by
ata_mode_string(), move it into the function.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

This patch is against upstream.

 drivers/scsi/libata-core.c |  108 +++++++-------------------------------------
 1 files changed, 18 insertions(+), 90 deletions(-)

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2006-03-06 04:14:11.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2006-03-06 04:14:30.000000000 +0900
@@ -67,7 +67,6 @@ static void ata_set_mode(struct ata_port
 static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev);
 static unsigned int ata_dev_xfermask(struct ata_port *ap,
 				     struct ata_device *dev);
-static int fgb(u32 bitmap);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -331,25 +330,6 @@ static int ata_xfer_mode2shift(unsigned 
 	return -1;
 }
 
-static const char * const xfer_mode_str[] = {
-	"PIO0",
-	"PIO1",
-	"PIO2",
-	"PIO3",
-	"PIO4",
-	"MWDMA0",
-	"MWDMA1",
-	"MWDMA2",
-	"UDMA/16",
-	"UDMA/25",
-	"UDMA/33",
-	"UDMA/44",
-	"UDMA/66",
-	"UDMA/100",
-	"UDMA/133",
-	"UDMA7",
-};
-
 /**
  *	ata_mode_string - convert xfer_mask to string
  *	@xfer_mask: mask of bits supported; only highest bit counts.
@@ -364,9 +344,26 @@ static const char * const xfer_mode_str[
  *	Constant C string representing highest speed listed in
  *	@mode_mask, or the constant C string "<n/a>".
  */
-
 static const char *ata_mode_string(unsigned int xfer_mask)
 {
+	static const char * const xfer_mode_str[] = {
+		"PIO0",
+		"PIO1",
+		"PIO2",
+		"PIO3",
+		"PIO4",
+		"MWDMA0",
+		"MWDMA1",
+		"MWDMA2",
+		"UDMA/16",
+		"UDMA/25",
+		"UDMA/33",
+		"UDMA/44",
+		"UDMA/66",
+		"UDMA/100",
+		"UDMA/133",
+		"UDMA7",
+	};
 	int highbit;
 
 	highbit = fls(xfer_mask) - 1;
@@ -827,35 +824,6 @@ static unsigned int ata_id_xfermask(cons
 	return ata_pack_xfermask(pio_mask, mwdma_mask, udma_mask);
 }
 
-/*
- *	Compute the PIO modes available for this device. This is not as
- *	trivial as it seems if we must consider early devices correctly.
- *
- *	FIXME: pre IDE drive timing (do we care ?). 
- */
-
-static unsigned int ata_pio_modes(const struct ata_device *adev)
-{
-	u16 modes;
-
-	/* Usual case. Word 53 indicates word 64 is valid */
-	if (adev->id[ATA_ID_FIELD_VALID] & (1 << 1)) {
-		modes = adev->id[ATA_ID_PIO_MODES] & 0x03;
-		modes <<= 3;
-		modes |= 0x7;
-		return modes;
-	}
-
-	/* If word 64 isn't valid then Word 51 high byte holds the PIO timing
-	   number for the maximum. Turn it into a mask and return it */
-	modes = (2 << ((adev->id[ATA_ID_OLD_PIO_MODES] >> 8) & 0xFF)) - 1 ;
-	return modes;
-	/* But wait.. there's more. Design your standards by committee and
-	   you too can get a free iordy field to process. However its the 
-	   speeds not the modes that are supported... Note drivers using the
-	   timing API will get this right anyway */
-}
-
 static inline void
 ata_queue_packet_task(struct ata_port *ap)
 {
@@ -1718,26 +1686,6 @@ int ata_timing_compute(struct ata_device
 	return 0;
 }
 
-static const struct {
-	unsigned int shift;
-	u8 base;
-} xfer_mode_classes[] = {
-	{ ATA_SHIFT_UDMA,	XFER_UDMA_0 },
-	{ ATA_SHIFT_MWDMA,	XFER_MW_DMA_0 },
-	{ ATA_SHIFT_PIO,	XFER_PIO_0 },
-};
-
-static u8 base_from_shift(unsigned int shift)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(xfer_mode_classes); i++)
-		if (xfer_mode_classes[i].shift == shift)
-			return xfer_mode_classes[i].base;
-
-	return 0xff;
-}
-
 static void ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
 {
 	if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))
@@ -2586,13 +2534,6 @@ int ata_dev_revalidate(struct ata_port *
 	return rc;
 }
 
-static void ata_pr_blacklisted(const struct ata_port *ap,
-			       const struct ata_device *dev)
-{
-	printk(KERN_WARNING "ata%u: dev %u is on DMA blacklist, disabling DMA\n",
-		ap->id, dev->devno);
-}
-
 static const char * const ata_dma_blacklist [] = {
 	"WDC AC11000H",
 	"WDC AC22100H",
@@ -2680,19 +2621,6 @@ static unsigned int ata_dev_xfermask(str
 	return xfer_mask;
 }
 
-/* find greatest bit */
-static int fgb(u32 bitmap)
-{
-	unsigned int i;
-	int x = -1;
-
-	for (i = 0; i < 32; i++)
-		if (bitmap & (1 << i))
-			x = i;
-
-	return x;
-}
-
 /**
  *	ata_dev_set_xfermode - Issue SET FEATURES - XFER MODE command
  *	@ap: Port associated with device @dev
