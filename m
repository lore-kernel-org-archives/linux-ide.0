From: akpm@linux-foundation.org
Subject: [patch 1/3] libata: isolate and rework cable logic
Date: Tue, 04 Mar 2008 15:16:16 -0800
Message-ID: <200803042316.m24NGG37002480@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58553 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933697AbYCDXRh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Mar 2008 18:17:37 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |   48 +++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 4 deletions(-)

diff -puN drivers/ata/libata-core.c~libata-isolate-and-rework-cable-logic drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~libata-isolate-and-rework-cable-logic
+++ a/drivers/ata/libata-core.c
@@ -4274,6 +4274,49 @@ static int ata_is_40wire(struct ata_devi
 }
 
 /**
+ *	cable_is_40wire		-	40/80/SATA decider
+ *	@ap: port to consider
+ *
+ *	This function encapsulates the policy for speed management
+ *	in one place. At the moment we don't cache the result but
+ *	there is a good case for setting ap->cbl to the result when
+ *	we are called with unknown cables (and figuring out if it
+ *	impacts hotplug at all).
+ *
+ *	Return 1 if the cable appears to be 40 wire.
+ */
+
+static int cable_is_40wire(struct ata_port *ap)
+{
+	struct ata_link *link;
+	struct ata_device *dev;
+
+	/* If the controller thinks we are 40 wire, we are */
+	if (ap->cbl == ATA_CBL_PATA40)
+		return 1;
+	/* If the controller thinks we are 80 wire, we are */
+	if (ap->cbl == ATA_CBL_PATA80 || ap->cbl == ATA_CBL_SATA)
+		return 0;
+	/* If the controller doesn't know we scan
+
+	   - Note: We look for all 40 wire detects at this point.
+	     Any 80 wire detect is taken to be 80 wire cable
+	     because
+	     - In many setups only the one drive (slave if present)
+               will give a valid detect
+             - If you have a non detect capable drive you don't
+               want it to colour the choice
+        */
+	ata_port_for_each_link(link, ap) {
+		ata_link_for_each_dev(dev, link) {
+			if (!ata_is_40wire(dev))
+				return 0;
+		}
+	}
+	return 1;
+}
+
+/**
  *	ata_dev_xfermask - Compute supported xfermask of the given device
  *	@dev: Device to compute xfermask for
  *
@@ -4341,10 +4384,7 @@ static void ata_dev_xfermask(struct ata_
 	 */
 	if (xfer_mask & (0xF8 << ATA_SHIFT_UDMA))
 		/* UDMA/44 or higher would be available */
-		if ((ap->cbl == ATA_CBL_PATA40) ||
-		    (ata_is_40wire(dev) &&
-		    (ap->cbl == ATA_CBL_PATA_UNK ||
-		     ap->cbl == ATA_CBL_PATA80))) {
+		if (cable_is_40wire(ap)) {
 			ata_dev_printk(dev, KERN_WARNING,
 				 "limited to UDMA/33 due to 40-wire cable\n");
 			xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
_
