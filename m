From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/9] libata: implement per-dev xfermask
Date: Sat, 5 Aug 2006 06:01:33 +0900
Message-ID: <11547252932391-git-send-email-htejun@gmail.com>
References: <11547252923301-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.205]:29803 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161447AbWHDVBj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Aug 2006 17:01:39 -0400
Received: by nz-out-0102.google.com with SMTP id n1so109138nzf
        for <linux-ide@vger.kernel.org>; Fri, 04 Aug 2006 14:01:38 -0700 (PDT)
In-Reply-To: <11547252923301-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, davej@redhat.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement per-dev xfermask.  libata used to determine xfermask
per-port - the fastest mode of the slowest device on the port.  This
patch enables per-dev xfermask.

Original patch is from Alan Cox <alan@redhat.com>.  The following
changes are made by me.

* simplex warning message is added
* fix port-wide PIO mode selection to aovid violating device selection
  timing.

Cc: Alan Cox <alan@redhat.com>
Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   49 +++++++++++++++++++-------------------------
 1 files changed, 21 insertions(+), 28 deletions(-)

fd045a27aab1d64997f30a97f64e7aac355dd14d
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1810bb2..7e1f3ee 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3040,10 +3040,6 @@ static int ata_dma_blacklisted(const str
  *	known limits including host controller limits, device
  *	blacklist, etc...
  *
- *	FIXME: The current implementation limits all transfer modes to
- *	the fastest of the lowested device on the port.  This is not
- *	required on most controllers.
- *
  *	LOCKING:
  *	None.
  */
@@ -3054,6 +3050,7 @@ static void ata_dev_xfermask(struct ata_
 	unsigned long xfer_mask;
 	int i;
 
+	/* controller modes available */
 	xfer_mask = ata_pack_xfermask(ap->pio_mask,
 				      ap->mwdma_mask, ap->udma_mask);
 
@@ -3063,34 +3060,30 @@ static void ata_dev_xfermask(struct ata_
 	if (ap->cbl == ATA_CBL_PATA40)
 		xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
 
-	/* FIXME: Use port-wide xfermask for now */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *d = &ap->device[i];
-
-		if (ata_dev_absent(d))
-			continue;
-
-		if (ata_dev_disabled(d)) {
-			/* to avoid violating device selection timing */
-			xfer_mask &= ata_pack_xfermask(d->pio_mask,
-						       UINT_MAX, UINT_MAX);
-			continue;
-		}
-
-		xfer_mask &= ata_pack_xfermask(d->pio_mask,
-					       d->mwdma_mask, d->udma_mask);
-		xfer_mask &= ata_id_xfermask(d->id);
-		if (ata_dma_blacklisted(d))
-			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
-	}
+	xfer_mask &= ata_pack_xfermask(dev->pio_mask,
+				       dev->mwdma_mask, dev->udma_mask);
+	xfer_mask &= ata_id_xfermask(dev->id);
 
-	if (ata_dma_blacklisted(dev))
+	if (ata_dma_blacklisted(dev)) {
+		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 		ata_dev_printk(dev, KERN_WARNING,
 			       "device is on DMA blacklist, disabling DMA\n");
+	}
+
+	if ((hs->flags & ATA_HOST_SIMPLEX) && hs->simplex_claimed) {
+		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
+		ata_dev_printk(dev, KERN_WARNING, "simplex DMA is claimed by "
+			       "other device, disabling DMA\n");
+	}
 
-	if (hs->flags & ATA_HOST_SIMPLEX) {
-		if (hs->simplex_claimed)
-			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
+	/* Use the lowest common PIO mode to avoid violating device
+	 * selection timing.
+	 */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *d = &ap->device[i];
+		if (!ata_dev_absent(d))
+			xfer_mask &= ata_pack_xfermask(d->pio_mask,
+						       UINT_MAX, UINT_MAX);
 	}
 
 	if (ap->ops->mode_filter)
-- 
1.3.2


