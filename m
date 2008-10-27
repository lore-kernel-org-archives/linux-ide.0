From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 1/4 UPDATED] libata: fix device iteration
 bugs
Date: Mon, 27 Oct 2008 19:59:23 +0900
Message-ID: <49059F0B.3000508@kernel.org>
References: <49041323.9020309@kernel.org> <49044ABA.7050104@ru.mvista.com> <490584EF.8040700@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59290 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbYJ0K7j (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 06:59:39 -0400
In-Reply-To: <490584EF.8040700@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

There were several places where only enabled devices should be
iterated over but device enabledness wasn't checked.

* IDENTIFY data 40 wire check in cable_is_40wire()
* xfer_mode/ncq_enabled saving in ata_scsi_error()
* DUBIOUS_XFER handling in ata_set_mode()

While at it, reformat comments in cable_is_40wire().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Comments reformatted as per Sergei's comment.

 drivers/ata/libata-core.c |   32 ++++++++++++++++++--------------
 drivers/ata/libata-eh.c   |    9 +++++++++
 2 files changed, 27 insertions(+), 14 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -4158,29 +4158,33 @@ static int cable_is_40wire(struct ata_po
 	struct ata_link *link;
 	struct ata_device *dev;
 
-	/* If the controller thinks we are 40 wire, we are */
+	/* If the controller thinks we are 40 wire, we are. */
 	if (ap->cbl == ATA_CBL_PATA40)
 		return 1;
-	/* If the controller thinks we are 80 wire, we are */
+
+	/* If the controller thinks we are 80 wire, we are. */
 	if (ap->cbl == ATA_CBL_PATA80 || ap->cbl == ATA_CBL_SATA)
 		return 0;
-	/* If the system is known to be 40 wire short cable (eg laptop),
-	   then we allow 80 wire modes even if the drive isn't sure */
+
+	/* If the system is known to be 40 wire short cable (eg
+	 * laptop), then we allow 80 wire modes even if the drive
+	 * isn't sure.
+	 */
 	if (ap->cbl == ATA_CBL_PATA40_SHORT)
 		return 0;
-	/* If the controller doesn't know we scan
 
-	   - Note: We look for all 40 wire detects at this point.
-	     Any 80 wire detect is taken to be 80 wire cable
-	     because
-	     - In many setups only the one drive (slave if present)
-               will give a valid detect
-             - If you have a non detect capable drive you don't
-               want it to colour the choice
-        */
+	/* If the controller doesn't know, we scan.
+	 *
+	 * Note: We look for all 40 wire detects at this point.  Any
+	 *       80 wire detect is taken to be 80 wire cable because
+	 * - in many setups only the one drive (slave if present) will
+	 *   give a valid detect
+	 * - if you have a non detect capable drive you don't want it
+	 *   to colour the choice
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
