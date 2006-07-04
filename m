From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 23/24] libata: Enable per device speed setting
Date: Tue, 4 Jul 2006 18:15:25 +0000 (UTC)
Message-ID: <11520361272182-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036119810-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361203144-git-send-email-alan@lxo
 rguk.ukuu.org.uk> <11520361212843-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036122125!
 0-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361233826-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361232889-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361243147-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361254139-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361251284-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57742 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932318AbWGDSPI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:15:08 -0400
Date: Maw, 04 Gor 2006 19:01:47 +0100
In-Reply-To: <11520361251284-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>

From: Alan Cox <alan@redhat.com>

Testing says that nothing seems to break when we do this.

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/libata-core.c |   36 ++++++++++++++----------------------
 1 files changed, 14 insertions(+), 22 deletions(-)

6f3a15e1fd177bab7bb093c23bdefac6fbf6253a
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index cc6ae67..75eb556 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3047,6 +3047,7 @@ static void ata_dev_xfermask(struct ata_
 	unsigned long xfer_mask;
 	int i;
 
+	/* Controller modes available */
 	xfer_mask = ata_pack_xfermask(ap->pio_mask,
 				      ap->mwdma_mask, ap->udma_mask);
 
@@ -3056,30 +3057,21 @@ static void ata_dev_xfermask(struct ata_
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
+	if (ata_dev_disabled(dev)) {
+		/* to avoid violating device selection timing */
+		xfer_mask &= ata_pack_xfermask(dev->pio_mask,
+					       UINT_MAX, UINT_MAX);
+		goto out;
+	}
+	xfer_mask &= ata_pack_xfermask(dev->pio_mask, 
+					dev->mwdma_mask, dev->udma_mask);
+	xfer_mask &= ata_id_xfermask(dev->id);
 
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
 
 	if (hs->flags & ATA_HOST_SIMPLEX) {
 		if (hs->simplex_claimed)
@@ -3088,7 +3080,7 @@ static void ata_dev_xfermask(struct ata_
 
 	if (ap->ops->mode_filter)
 		xfer_mask = ap->ops->mode_filter(ap, dev, xfer_mask);
-
+out:
 	ata_unpack_xfermask(xfer_mask, &dev->pio_mask,
 			    &dev->mwdma_mask, &dev->udma_mask);
 }
-- 
1.2.GIT

