From: Robert Hancock <hancockr@shaw.ca>
Subject: [PATCH -mm] libata: warn if speed limited due to 40-wire cable
Date: Fri, 09 Feb 2007 22:49:27 -0600
Message-ID: <45CD4ED7.6000501@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:31277 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbXBJEuL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Feb 2007 23:50:11 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

Print an explicit warning when a device's UDMA mode is limited due to
a 40-wire cable being detected, so that users have some idea why their
device isn't running as fast as it should.

This moves the application of the drive's mode masks before the cable
rule, so that can tell whether the rate is being limited by the cable
and not the drive or controller.

I haven't tested whether the message actually shows up, as my system
isn't horked in this manner..

Signed-off-by: Robert Hancock <hancockr@shaw.ca>

--- linux-2.6.20-rc6-mm3/drivers/ata/libata-core.c	2007-02-04 21:48:25.000000000 -0600
+++ linux-2.6.20-rc6-mm3edit/drivers/ata/libata-core.c	2007-02-09 21:04:14.000000000 -0600
@@ -3393,22 +3393,24 @@ static void ata_dev_xfermask(struct ata_
 	xfer_mask = ata_pack_xfermask(ap->pio_mask,
 				      ap->mwdma_mask, ap->udma_mask);
 
+	/* drive modes available */
+	xfer_mask &= ata_pack_xfermask(dev->pio_mask,
+				       dev->mwdma_mask, dev->udma_mask);
+	xfer_mask &= ata_id_xfermask(dev->id);
+
 	/* Apply cable rule here.  Don't apply it early because when
 	 * we handle hot plug the cable type can itself change.
+	 * Unknown or 80 wire cables reported host side are checked
+	 * drive side as well. Cases where we know a 40wire cable
+	 * is used safely for 80 are not checked here.
 	 */
-	if (ap->cbl == ATA_CBL_PATA40)
-		xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
-	/* Apply drive side cable rule. Unknown or 80 pin cables reported
-	 * host side are checked drive side as well. Cases where we know a
-	 * 40wire cable is used safely for 80 are not checked here.
-	 */
-        if (ata_drive_40wire(dev->id) && (ap->cbl == ATA_CBL_PATA_UNK || ap->cbl == ATA_CBL_PATA80))
+	if ((xfer_mask & (0xF8 << ATA_SHIFT_UDMA)) &&
+	    ((ap->cbl == ATA_CBL_PATA40) ||
+	     (ata_drive_40wire(dev->id) &&
+	      (ap->cbl == ATA_CBL_PATA_UNK || ap->cbl == ATA_CBL_PATA80)))) {
+	      	ata_dev_printk(dev, KERN_WARNING, "limited to UDMA2 due to 40-wire cable\n");
 		xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
-
-
-	xfer_mask &= ata_pack_xfermask(dev->pio_mask,
-				       dev->mwdma_mask, dev->udma_mask);
-	xfer_mask &= ata_id_xfermask(dev->id);
+	}
 
 	/*
 	 *	CFA Advanced TrueIDE timings are not allowed on a shared

