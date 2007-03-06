From: akpm@linux-foundation.org
Subject: [patch 02/30] libata: warn if speed limited due to 40-wire cable
Date: Tue, 06 Mar 2007 02:37:51 -0800
Message-ID: <200703061037.l26AbpOo019457@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34371 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934032AbXCFKiF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, hancockr@shaw.ca, alan@lxorguk.ukuu.org.uk

From: Robert Hancock <hancockr@shaw.ca>

Warn the user if a drive's transfer rate is limited because of a 40-wire
cable detection.

Signed-off-by: Robert Hancock <hancockr@shaw.ca>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |   33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff -puN drivers/ata/libata-core.c~libata-warn-if-speed-limited-due-to-40-wire-cable-v2 drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~libata-warn-if-speed-limited-due-to-40-wire-cable-v2
+++ a/drivers/ata/libata-core.c
@@ -3405,19 +3405,7 @@ static void ata_dev_xfermask(struct ata_
 	xfer_mask = ata_pack_xfermask(ap->pio_mask,
 				      ap->mwdma_mask, ap->udma_mask);
 
-	/* Apply cable rule here.  Don't apply it early because when
-	 * we handle hot plug the cable type can itself change.
-	 */
-	if (ap->cbl == ATA_CBL_PATA40)
-		xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
-	/* Apply drive side cable rule. Unknown or 80 pin cables reported
-	 * host side are checked drive side as well. Cases where we know a
-	 * 40wire cable is used safely for 80 are not checked here.
-	 */
-        if (ata_drive_40wire(dev->id) && (ap->cbl == ATA_CBL_PATA_UNK || ap->cbl == ATA_CBL_PATA80))
-		xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
-
-
+	/* drive modes available */
 	xfer_mask &= ata_pack_xfermask(dev->pio_mask,
 				       dev->mwdma_mask, dev->udma_mask);
 	xfer_mask &= ata_id_xfermask(dev->id);
@@ -3448,6 +3436,25 @@ static void ata_dev_xfermask(struct ata_
 	if (ap->ops->mode_filter)
 		xfer_mask = ap->ops->mode_filter(ap, dev, xfer_mask);
 
+	/* Apply cable rule here.  Don't apply it early because when
+	 * we handle hot plug the cable type can itself change.
+	 * Check this last so that we know if the transfer rate was
+	 * solely limited by the cable.
+	 * Unknown or 80 wire cables reported host side are checked
+	 * drive side as well. Cases where we know a 40wire cable
+	 * is used safely for 80 are not checked here.
+	 */
+	if (xfer_mask & (0xF8 << ATA_SHIFT_UDMA))
+		/* UDMA/44 or higher would be available */
+		if((ap->cbl == ATA_CBL_PATA40) ||
+   		    (ata_drive_40wire(dev->id) &&
+		     (ap->cbl == ATA_CBL_PATA_UNK ||
+                     ap->cbl == ATA_CBL_PATA80))) {
+		      	ata_dev_printk(dev, KERN_WARNING,
+				 "limited to UDMA/33 due to 40-wire cable\n");
+			xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
+		}
+
 	ata_unpack_xfermask(xfer_mask, &dev->pio_mask,
 			    &dev->mwdma_mask, &dev->udma_mask);
 }
_
