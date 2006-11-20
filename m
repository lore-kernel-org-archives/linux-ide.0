From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix SCSI/ATA device association during hotplug
Date: Mon, 20 Nov 2006 18:25:34 +0900
Message-ID: <20061120092534.GP2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:3406 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S934035AbWKTJZn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Nov 2006 04:25:43 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2279095nfa
        for <linux-ide@vger.kernel.org>; Mon, 20 Nov 2006 01:25:42 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Two subtle hotplug related bugs are found.

* SCSI didn't use to issue commands to devices in SDEV_CANCEL state
  but now it does.  For ATA devices, it means that SYNCHRONIZE_CACHE
  is issued even after libata tells SCSI midlayer that the SCSI device
  is offline now.  When devices are swapped, SYNCHRONIZE_CACHE for the
  previous device can be issued to the later device.

* Devices can be swapped while SCSI probing is in progress.  SCSI
  device used to get associated with ATA device only after probing is
  complete, which means that SCSI device detaching is not performed
  while probing.  This can result in mismatch between SCSI device and
  ATA device (e.g. sd attached to ATAPI device) if devices are
  swapped after INQUIRY but before probing is complete.

This patch makes libata associate new SCSI device with ATA device
before INQUIRY is issued and check whether SCSI device issuing a
command matches dev->sdev on each command.  Both bugs are fixed by
this tighter coupling between SCSI device and ATA device.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-scsi.c |   51 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 12 deletions(-)

Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -54,9 +54,9 @@
 typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, const u8 *scsicmd);
 
 static struct ata_device * __ata_scsi_find_dev(struct ata_port *ap,
-					const struct scsi_device *scsidev);
+					       struct scsi_device *scsidev);
 static struct ata_device * ata_scsi_find_dev(struct ata_port *ap,
-					    const struct scsi_device *scsidev);
+					     struct scsi_device *scsidev);
 static int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 			      unsigned int id, unsigned int lun);
 
@@ -877,7 +877,7 @@ void ata_scsi_slave_destroy(struct scsi_
 
 	spin_lock_irqsave(ap->lock, flags);
 	dev = __ata_scsi_find_dev(ap, sdev);
-	if (dev && dev->sdev) {
+	if (dev) {
 		/* SCSI device already in CANCEL state, no need to offline it */
 		dev->sdev = NULL;
 		dev->flags |= ATA_DFLAG_DETACH;
@@ -2509,13 +2509,29 @@ static struct ata_device * ata_find_dev(
 }
 
 static struct ata_device * __ata_scsi_find_dev(struct ata_port *ap,
-					const struct scsi_device *scsidev)
+					       struct scsi_device *scsidev)
 {
+	struct ata_device *dev;
+
 	/* skip commands not addressed to targets we simulate */
 	if (unlikely(scsidev->channel || scsidev->lun))
 		return NULL;
 
-	return ata_find_dev(ap, scsidev->id);
+	dev = ata_find_dev(ap, scsidev->id);
+
+	if (likely(dev && dev->sdev == scsidev))
+		return dev;
+
+	/* if the ATA device is avialable and SCSI device is looking
+	 * for partner, match them.  For details, read comment in
+	 * ata_scsi_scan_host().
+	 */
+	if (dev && !dev->sdev && scsidev->sdev_state == SDEV_CREATED)
+		dev->sdev = scsidev;
+	else
+		dev = NULL;
+
+	return dev;
 }
 
 /**
@@ -2565,7 +2581,7 @@ static int ata_scsi_dev_enabled(struct a
  *	Associated ATA device, or %NULL if not found.
  */
 static struct ata_device *
-ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev)
+ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev)
 {
 	struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);
 
@@ -2964,16 +2980,27 @@ void ata_scsi_scan_host(struct ata_port 
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
-		struct scsi_device *sdev;
 
 		if (!ata_dev_enabled(dev) || dev->sdev)
 			continue;
 
-		sdev = __scsi_add_device(ap->scsi_host, 0, i, 0, NULL);
-		if (!IS_ERR(sdev)) {
-			dev->sdev = sdev;
-			scsi_device_put(sdev);
-		}
+		/* Try to attach new SCSI device.  SCSI midlayer
+		 * doesn't supply separate interfaces for allocating
+		 * and probing, so in this function, we can associate
+		 * new SCSI device with its target ATA device only
+		 * after probing is complete.
+		 *
+		 * However, hotplug event may occur during probing and
+		 * we might have to detach a SCSI device which is in
+		 * the middle of probing.  So, we need to associate
+		 * new SCSI device with its target ATA device before
+		 * the first INQUIRY is complete.
+		 *
+		 * This is achieved by automatically associating sdev
+		 * in SDEV_CREATED state with NULL dev->sdev in
+		 * __ata_scsi_find_dev().
+		 */
+		scsi_add_device(ap->scsi_host, 0, i, 0);
 	}
 }
 
