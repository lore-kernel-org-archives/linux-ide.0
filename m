From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] isolate and rework cable logic try 2
Date: Fri, 8 Feb 2008 15:58:33 +0000
Message-ID: <20080208155833.4367f921@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44894 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932894AbYBHQFF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Feb 2008 11:05:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-mm1/drivers/ata/libata-core.c linux-2.6.24-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.24-mm1/drivers/ata/libata-core.c	2008-02-06 14:14:39.000000000 +0000
+++ linux-2.6.24-mm1/drivers/ata/libata-core.c	2008-02-08 15:56:43.000000000 +0000
@@ -4258,6 +4258,49 @@
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
@@ -4325,10 +4368,7 @@
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
