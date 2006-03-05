From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/6] libata: kill unused xfer_mode functions
Date: Mon, 6 Mar 2006 04:31:57 +0900
Message-ID: <11415871174010-git-send-email-htejun@gmail.com>
References: <11415871161709-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.181]:11875 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751812AbWCETcG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 14:32:06 -0500
Received: by pproxy.gmail.com with SMTP id i75so637256pye
        for <linux-ide@vger.kernel.org>; Sun, 05 Mar 2006 11:32:05 -0800 (PST)
In-Reply-To: <11415871161709-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Preceding xfer_mask changes make the following functions unused.

  ata_pio_modes(), base_from_shift(), ata_pr_blacklisted(), fgb()

Kill them.  Also, as xfer_mode_str[] is now only used by
ata_mode_string(), move it into the function.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

This patch is against upstream + port_task patchset.

 drivers/scsi/libata-core.c |  108 +++++++-------------------------------------
 1 files changed, 18 insertions(+), 90 deletions(-)

7d1819a2066d9286e0a89e11808f7b5be92409b5
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index d211f0b..5acb079 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
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
 /**
  *	ata_port_queue_task - Queue port_task
  *	@ap: The ata_port to queue port_task for
@@ -1728,26 +1696,6 @@ int ata_timing_compute(struct ata_device
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
@@ -2596,13 +2544,6 @@ int ata_dev_revalidate(struct ata_port *
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
@@ -2690,19 +2631,6 @@ static unsigned int ata_dev_xfermask(str
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
-- 
1.2.4


