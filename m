From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: update atapi disable handling
Date: Thu, 31 Jul 2008 07:52:40 +0900
Message-ID: <4890F0B8.90009@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38330 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752703AbYG3Wxj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jul 2008 18:53:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, chunbo.luo@windriver.com, Andrew Morton <akpm@linux-foundation.org>

Global and per-LLD ATAPI disable checks were done in the command issue
path probably because it was left out during EH conversion.  On
affected machines, this can cause lots of warning messages.  Move them
to where they belong - the probing path.

Reported by Chunbo Luo.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Chunbo Luo <chunbo.luo@windriver.com>
---
 drivers/ata/libata-core.c |   12 +++++++++++-
 drivers/ata/libata-scsi.c |   34 ++--------------------------------
 drivers/ata/libata.h      |    1 -
 3 files changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 303fc0d..3974634 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -121,7 +121,7 @@ static char ata_force_param_buf[PAGE_SIZE] __initdata;
 module_param_string(force, ata_force_param_buf, sizeof(ata_force_param_buf), 0);
 MODULE_PARM_DESC(force, "Force ATA configurations including cable type, link speed and transfer mode (see Documentation/kernel-parameters.txt for details)");
 
-int atapi_enabled = 1;
+static int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
 
@@ -2133,6 +2133,16 @@ int ata_dev_configure(struct ata_device *dev)
 		return 0;
 	}
 
+	if ((!atapi_enabled || (ap->flags & ATA_FLAG_NO_ATAPI)) &&
+	    dev->class == ATA_DEV_ATAPI) {
+		ata_dev_printk(dev, KERN_WARNING,
+			"WARNING: ATAPI is %s, device ignored.\n",
+			atapi_enabled ? "not supported with this driver"
+				      : "disabled");
+		ata_dev_disable(dev);
+		return 0;
+	}
+
 	/* let ACPI work its magic */
 	rc = ata_acpi_on_devcfg(dev);
 	if (rc)
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 57a4364..f07ff44 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2456,36 +2456,6 @@ static struct ata_device *__ata_scsi_find_dev(struct ata_port *ap,
 }
 
 /**
- *	ata_scsi_dev_enabled - determine if device is enabled
- *	@dev: ATA device
- *
- *	Determine if commands should be sent to the specified device.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- *
- *	RETURNS:
- *	0 if commands are not allowed / 1 if commands are allowed
- */
-
-static int ata_scsi_dev_enabled(struct ata_device *dev)
-{
-	if (unlikely(!ata_dev_enabled(dev)))
-		return 0;
-
-	if (!atapi_enabled || (dev->link->ap->flags & ATA_FLAG_NO_ATAPI)) {
-		if (unlikely(dev->class == ATA_DEV_ATAPI)) {
-			ata_dev_printk(dev, KERN_WARNING,
-				       "WARNING: ATAPI is %s, device ignored.\n",
-				       atapi_enabled ? "not supported with this driver" : "disabled");
-			return 0;
-		}
-	}
-
-	return 1;
-}
-
-/**
  *	ata_scsi_find_dev - lookup ata_device from scsi_cmnd
  *	@ap: ATA port to which the device is attached
  *	@scsidev: SCSI device from which we derive the ATA device
@@ -2506,7 +2476,7 @@ ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev)
 {
 	struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);
 
-	if (unlikely(!dev || !ata_scsi_dev_enabled(dev)))
+	if (unlikely(!dev || !ata_dev_enabled(dev)))
 		return NULL;
 
 	return dev;
@@ -3524,7 +3494,7 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *),
 
 	ata_scsi_dump_cdb(ap, cmd);
 
-	if (likely(ata_scsi_dev_enabled(ap->link.device)))
+	if (likely(ata_dev_enabled(ap->link.device)))
 		rc = __ata_scsi_queuecmd(cmd, done, ap->link.device);
 	else {
 		cmd->result = (DID_BAD_TARGET << 16);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 1cf803a..f40a57a 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -66,7 +66,6 @@ enum {
 
 extern unsigned int ata_print_id;
 extern struct workqueue_struct *ata_aux_wq;
-extern int atapi_enabled;
 extern int atapi_passthru16;
 extern int libata_fua;
 extern int libata_noacpi;
