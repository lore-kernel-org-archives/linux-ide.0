From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 1/4] libata: fix device iteration bugs
Date: Sun, 26 Oct 2008 15:50:11 +0900
Message-ID: <49041323.9020309@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51165 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbYJZGuU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Oct 2008 02:50:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

There were several places where only enabled devices should be
iterated over but device enabledness wasn't checked.

* IDENTIFY data 40 wire check in cable_is_40wire()
* xfer_mode/ncq_enabled saving in ata_scsi_error()
* DUBIOUS_XFER handling in ata_set_mode()

While at it, reformat comment in cable_is_40wire().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Jeff, this four patch series fixes iteration bugs and improves
iterators and fix ata_port_detach() related bugs.  The iterator change
is a bit big for #upstream-fixes but it's fairly straight forward and
I verified them in most combinations, so it should be pretty safe.

Thanks.

 drivers/ata/libata-core.c |   18 ++++++++----------
 drivers/ata/libata-eh.c   |    9 +++++++++
 2 files changed, 17 insertions(+), 10 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -4169,18 +4169,16 @@ static int cable_is_40wire(struct ata_po
 	if (ap->cbl == ATA_CBL_PATA40_SHORT)
 		return 0;
 	/* If the controller doesn't know we scan
-
-	   - Note: We look for all 40 wire detects at this point.
-	     Any 80 wire detect is taken to be 80 wire cable
-	     because
-	     - In many setups only the one drive (slave if present)
-               will give a valid detect
-             - If you have a non detect capable drive you don't
-               want it to colour the choice
-        */
+	 *
+	 * - Note: We look for all 40 wire detects at this point.  Any
+	 *   80 wire detect is taken to be 80 wire cable because - In
+	 *   many setups only the one drive (slave if present) will
+	 *   give a valid detect - If you have a non detect capable
+	 *   drive you don't want it to colour the choice
+	 */
 	ata_port_for_each_link(link, ap) {
 		ata_link_for_each_dev(dev, link) {
-			if (!ata_is_40wire(dev))
+			if (ata_dev_enabled(dev) && !ata_is_40wire(dev))
 				return 0;
 		}
 	}
Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -603,6 +603,9 @@ void ata_scsi_error(struct Scsi_Host *ho
 			ata_link_for_each_dev(dev, link) {
 				int devno = dev->devno;
 
+				if (!ata_dev_enabled(dev))
+					continue;
+
 				ehc->saved_xfer_mode[devno] = dev->xfer_mode;
 				if (ata_ncq_enabled(dev))
 					ehc->saved_ncq_enabled |= 1 << devno;
@@ -2790,6 +2793,9 @@ int ata_set_mode(struct ata_link *link,
 
 	/* if data transfer is verified, clear DUBIOUS_XFER on ering top */
 	ata_link_for_each_dev(dev, link) {
+		if (!ata_dev_enabled(dev))
+			continue;
+
 		if (!(dev->flags & ATA_DFLAG_DUBIOUS_XFER)) {
 			struct ata_ering_entry *ent;
 
@@ -2811,6 +2817,9 @@ int ata_set_mode(struct ata_link *link,
 		u8 saved_xfer_mode = ehc->saved_xfer_mode[dev->devno];
 		u8 saved_ncq = !!(ehc->saved_ncq_enabled & (1 << dev->devno));
 
+		if (!ata_dev_enabled(dev))
+			continue;
+
 		if (dev->xfer_mode != saved_xfer_mode ||
 		    ata_ncq_enabled(dev) != saved_ncq)
 			dev->flags |= ATA_DFLAG_DUBIOUS_XFER;
