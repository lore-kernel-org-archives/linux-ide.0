From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 7/7] libata: consider disabled devices in ata_dev_xfermask()
Date: Sun, 2 Apr 2006 17:54:47 +0900
Message-ID: <11439680873666-git-send-email-htejun@gmail.com>
References: <11439680863256-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:54046 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932269AbWDBIy4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 04:54:56 -0400
Received: by zproxy.gmail.com with SMTP id o37so1438213nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 00:54:56 -0800 (PST)
In-Reply-To: <11439680863256-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_bus_probe() now marks failed devices properly and leaves
meaningful transfer mode masks.  This patch makes ata_dev_xfermask()
consider disable devices when determining PIO mode to avoid violating
device selection timing.

While at it, move port-wide resttriction out of device iteration loop
and try to make the function look a bit prettier.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

5d1704cd08f45e1d66415eb0ad45e61793b385ef
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1460cb3..b058602 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2908,23 +2908,34 @@ static void ata_dev_xfermask(struct ata_
 	unsigned long xfer_mask;
 	int i;
 
-	xfer_mask = ata_pack_xfermask(ap->pio_mask, ap->mwdma_mask,
-				      ap->udma_mask);
+	xfer_mask = ata_pack_xfermask(ap->pio_mask,
+				      ap->mwdma_mask, ap->udma_mask);
+
+	/* Apply cable rule here.  Don't apply it early because when
+	 * we handle hot plug the cable type can itself change.
+	 */
+	if (ap->cbl == ATA_CBL_PATA40)
+		xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
 
 	/* FIXME: Use port-wide xfermask for now */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *d = &ap->device[i];
-		if (!ata_dev_enabled(d))
+
+		if (ata_dev_absent(d))
+			continue;
+
+		if (ata_dev_disabled(d)) {
+			/* to avoid violating device selection timing */
+			xfer_mask &= ata_pack_xfermask(d->pio_mask,
+						       UINT_MAX, UINT_MAX);
 			continue;
-		xfer_mask &= ata_pack_xfermask(d->pio_mask, d->mwdma_mask,
-					       d->udma_mask);
+		}
+
+		xfer_mask &= ata_pack_xfermask(d->pio_mask,
+					       d->mwdma_mask, d->udma_mask);
 		xfer_mask &= ata_id_xfermask(d->id);
 		if (ata_dma_blacklisted(d))
 			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
-		/* Apply cable rule here. Don't apply it early because when
-		   we handle hot plug the cable type can itself change */
-		if (ap->cbl == ATA_CBL_PATA40)
-			xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
 	}
 
 	if (ata_dma_blacklisted(dev))
@@ -2935,11 +2946,12 @@ static void ata_dev_xfermask(struct ata_
 		if (hs->simplex_claimed)
 			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 	}
+
 	if (ap->ops->mode_filter)
 		xfer_mask = ap->ops->mode_filter(ap, dev, xfer_mask);
 
-	ata_unpack_xfermask(xfer_mask, &dev->pio_mask, &dev->mwdma_mask,
-			    &dev->udma_mask);
+	ata_unpack_xfermask(xfer_mask, &dev->pio_mask,
+			    &dev->mwdma_mask, &dev->udma_mask);
 }
 
 /**
-- 
1.2.4


