From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/9] libata: implement per-dev xfermask
Date: Thu, 10 Aug 2006 17:16:29 +0900
Message-ID: <11551977893543-git-send-email-htejun@gmail.com>
References: <11551977882917-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:25871 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751458AbWHJIQi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 04:16:38 -0400
Received: by ug-out-1314.google.com with SMTP id m3so396511ugc
        for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 01:16:36 -0700 (PDT)
In-Reply-To: <11551977882917-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement per-dev xfermask.  libata used to determine xfermask
per-port - the fastest mode of the slowest device on the port.  This
patch enables per-dev xfermask.

Original patch is from Alan Cox <alan@redhat.com>.  The following
changes are made by me.

* simplex warning message is added
* remove disabled device handling code which is never invoked
  (originally for choosing port-wide lowest PIO mode)

Cc: Alan Cox <alan@redhat.com>
Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   40 +++++++++++-----------------------------
 1 files changed, 11 insertions(+), 29 deletions(-)

37deecb5139ee431233781a9a093d9fcaab54c5b
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 38fc75d..4e6c2e8 100644
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
@@ -3052,8 +3048,8 @@ static void ata_dev_xfermask(struct ata_
 	struct ata_port *ap = dev->ap;
 	struct ata_host_set *hs = ap->host_set;
 	unsigned long xfer_mask;
-	int i;
 
+	/* controller modes available */
 	xfer_mask = ata_pack_xfermask(ap->pio_mask,
 				      ap->mwdma_mask, ap->udma_mask);
 
@@ -3063,34 +3059,20 @@ static void ata_dev_xfermask(struct ata_
 	if (ap->cbl == ATA_CBL_PATA40)
 		xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
 
-	/* FIXME: Use port-wide xfermask for now */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *d = &ap->device[i];
-
-		if (ata_dev_absent(d))
-			continue;
+	xfer_mask &= ata_pack_xfermask(dev->pio_mask,
+				       dev->mwdma_mask, dev->udma_mask);
+	xfer_mask &= ata_id_xfermask(dev->id);
 
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
-
-	if (ata_dma_blacklisted(dev))
+	if (ata_dma_blacklisted(dev)) {
+		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 		ata_dev_printk(dev, KERN_WARNING,
 			       "device is on DMA blacklist, disabling DMA\n");
+	}
 
-	if (hs->flags & ATA_HOST_SIMPLEX) {
-		if (hs->simplex_claimed)
-			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
+	if ((hs->flags & ATA_HOST_SIMPLEX) && hs->simplex_claimed) {
+		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
+		ata_dev_printk(dev, KERN_WARNING, "simplex DMA is claimed by "
+			       "other device, disabling DMA\n");
 	}
 
 	if (ap->ops->mode_filter)
-- 
1.3.2


