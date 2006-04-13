From: Brian King <brking@us.ibm.com>
Subject: [PATCH 3/4] libata: Add ata_scsi_dev_disabled
Date: Thu, 13 Apr 2006 14:52:17 -0500
Message-ID: <200604131952.k3DJqHH8009570@d03av04.boulder.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:5833 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964868AbWDMTwT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Apr 2006 15:52:19 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3DJqIq3003283
	for <linux-ide@vger.kernel.org>; Thu, 13 Apr 2006 15:52:18 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3DJmlQC271514
	for <linux-ide@vger.kernel.org>; Thu, 13 Apr 2006 13:48:47 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k3DJqIM9009598
	for <linux-ide@vger.kernel.org>; Thu, 13 Apr 2006 13:52:18 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, brking@us.ibm.com


Separate out parts of ata_scsi_find_dev to be reused in
future SAS/SATA patches.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 libata-dev-bjking1/drivers/scsi/libata-scsi.c |   40 ++++++++++++++++++++------
 1 files changed, 31 insertions(+), 9 deletions(-)

diff -puN drivers/scsi/libata-scsi.c~libata_scsi_enabled drivers/scsi/libata-scsi.c
--- libata-dev/drivers/scsi/libata-scsi.c~libata_scsi_enabled	2006-04-13 14:45:58.000000000 -0500
+++ libata-dev-bjking1/drivers/scsi/libata-scsi.c	2006-04-13 14:45:58.000000000 -0500
@@ -2175,6 +2175,36 @@ static unsigned int atapi_xlat(struct at
 }
 
 /**
+ *	ata_scsi_dev_enabled - determine if device is enabled
+ *	@ap: ATA port to which the device is attached
+ *	@dev: ATA device
+ *
+ *	Determine if commands should be sent to the specified device.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	0 if commands are not allowed / 1 if commands are allowed
+ */
+
+static int ata_scsi_dev_enabled(struct ata_port *ap, struct ata_device *dev)
+{
+	if (unlikely(!ata_dev_enabled(dev)))
+		return 0;
+
+	if (!atapi_enabled || (ap->flags & ATA_FLAG_NO_ATAPI)) {
+		if (unlikely(dev->class == ATA_DEV_ATAPI)) {
+			printk(KERN_WARNING "ata%u(%u): WARNING: ATAPI is %s, device ignored.\n",
+			       ap->id, dev->devno, atapi_enabled ? "not supported with this driver" : "disabled");
+			return 0;
+		}
+	}
+
+	return 1;
+}
+
+/**
  *	ata_scsi_find_dev - lookup ata_device from scsi_cmnd
  *	@ap: ATA port to which the device is attached
  *	@scsidev: SCSI device from which we derive the ATA device
@@ -2206,17 +2236,9 @@ ata_scsi_find_dev(struct ata_port *ap, c
 		     (scsidev->lun != 0)))
 		return NULL;
 
-	if (unlikely(!ata_dev_enabled(dev)))
+	if (unlikely(!ata_scsi_dev_enabled(ap, dev)))
 		return NULL;
 
-	if (!atapi_enabled || (ap->flags & ATA_FLAG_NO_ATAPI)) {
-		if (unlikely(dev->class == ATA_DEV_ATAPI)) {
-			printk(KERN_WARNING "ata%u(%u): WARNING: ATAPI is %s, device ignored.\n",
-			       ap->id, dev->devno, atapi_enabled ? "not supported with this driver" : "disabled");
-			return NULL;
-		}
-	}
-
 	return dev;
 }
 
_
