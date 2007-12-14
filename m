From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 9/9] libata-acpi: implement _GTF command filtering and filter out LOCK commands
Date: Fri, 14 Dec 2007 15:15:41 +0900
Message-ID: <11976129432558-git-send-email-htejun@gmail.com>
References: <11976129411285-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:60196 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbXLNGPx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2007 01:15:53 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1544779wah.23
        for <linux-ide@vger.kernel.org>; Thu, 13 Dec 2007 22:15:52 -0800 (PST)
In-Reply-To: <11976129411285-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement _GTF command filtering which can be controlled by
libata.acpi_filter kernel parameter and filter LOCK commands using it.
DCO FREEZE LOCK, SECURITY FREEZE LOCK and SET MAX [FREEZE] LOCK are
filtered by default.

Note that detecting SET MAX LOCK requires looking at the previous
command.  This adds a bit to code complexity.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |  148 +++++++++++++++++++++++++++++++-------------
 1 files changed, 104 insertions(+), 44 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 1981112..b487268 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2006 Randy Dunlap
  */
 
+#include <linux/module.h>
 #include <linux/ata.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -25,6 +26,16 @@
 #include <acpi/acmacros.h>
 #include <acpi/actypes.h>
 
+enum {
+	ATA_ACPI_FILTER_LOCK	= 1 << 0,
+
+	ATA_ACPI_FILTER_DEFAULT	= ATA_ACPI_FILTER_LOCK,
+};
+
+static unsigned int ata_acpi_gtf_filter = ATA_ACPI_FILTER_DEFAULT;
+module_param_named(acpi_gtf_filter, ata_acpi_gtf_filter, int, 0644);
+MODULE_PARM_DESC(acpi_gtf_filter, "filter mask for ACPI _GTF commands, set to filter out (0x1=lock/freeze lock)");
+
 #define NO_PORT_MULT		0xffff
 #define SATA_ADR(root, pmp)	(((root) << 16) | (pmp))
 
@@ -428,6 +439,51 @@ int ata_acpi_cbl_80wire(struct ata_port *ap)
 
 EXPORT_SYMBOL_GPL(ata_acpi_cbl_80wire);
 
+static void ata_acpi_gtf_to_tf(struct ata_device *dev,
+			       const struct ata_acpi_gtf *gtf,
+			       struct ata_taskfile *tf)
+{
+	ata_tf_init(dev, tf);
+
+	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf->protocol = ATA_PROT_NODATA;
+	tf->feature = gtf->tf[0];	/* 0x1f1 */
+	tf->nsect   = gtf->tf[1];	/* 0x1f2 */
+	tf->lbal    = gtf->tf[2];	/* 0x1f3 */
+	tf->lbam    = gtf->tf[3];	/* 0x1f4 */
+	tf->lbah    = gtf->tf[4];	/* 0x1f5 */
+	tf->device  = gtf->tf[5];	/* 0x1f6 */
+	tf->command = gtf->tf[6];	/* 0x1f7 */
+}
+
+static int ata_acpi_filter_tf(const struct ata_taskfile *tf,
+			      const struct ata_taskfile *ptf)
+{
+	if (ata_acpi_gtf_filter & ATA_ACPI_FILTER_LOCK) {
+		/* BIOS writers, sorry but we don't wanna lock
+		 * features unless the user explicitly said so.
+		 */
+
+		/* DEVICE CONFIGURATION FREEZE LOCK */
+		if (tf->command == ATA_CMD_CONF_OVERLAY &&
+		    tf->feature == ATA_DCO_FREEZE_LOCK)
+			return 1;
+
+		/* SECURITY FREEZE LOCK */
+		if (tf->command == ATA_CMD_SEC_FREEZE_LOCK)
+			return 1;
+
+		/* SET MAX LOCK and SET MAX FREEZE LOCK */
+		if ((!ptf || ptf->command != ATA_CMD_READ_NATIVE_MAX) &&
+		    tf->command == ATA_CMD_SET_MAX &&
+		    (tf->feature == ATA_SET_MAX_LOCK ||
+		     tf->feature == ATA_SET_MAX_FREEZE_LOCK))
+			return 1;
+	}
+
+	return 0;
+}
+
 /**
  * ata_acpi_run_tf - send taskfile registers to host controller
  * @dev: target ATA device
@@ -448,13 +504,15 @@ EXPORT_SYMBOL_GPL(ata_acpi_cbl_80wire);
  * EH context.
  *
  * RETURNS:
- * 1 if command is executed successfully.  0 if ignored or rejected,
- * -errno on other errors.
+ * 1 if command is executed successfully.  0 if ignored, rejected or
+ * filtered out, -errno on other errors.
  */
 static int ata_acpi_run_tf(struct ata_device *dev,
-			   const struct ata_acpi_gtf *gtf)
+			   const struct ata_acpi_gtf *gtf,
+			   const struct ata_acpi_gtf *prev_gtf)
 {
-	struct ata_taskfile tf, rtf;
+	struct ata_taskfile *pptf = NULL;
+	struct ata_taskfile tf, ptf, rtf;
 	unsigned int err_mask;
 	const char *level;
 	char msg[60];
@@ -465,44 +523,44 @@ static int ata_acpi_run_tf(struct ata_device *dev,
 	    && (gtf->tf[6] == 0))
 		return 0;
 
-	ata_tf_init(dev, &tf);
-
-	/* convert gtf to tf */
-	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE; /* TBD */
-	tf.protocol = ATA_PROT_NODATA;
-	tf.feature = gtf->tf[0];	/* 0x1f1 */
-	tf.nsect   = gtf->tf[1];	/* 0x1f2 */
-	tf.lbal    = gtf->tf[2];	/* 0x1f3 */
-	tf.lbam    = gtf->tf[3];	/* 0x1f4 */
-	tf.lbah    = gtf->tf[4];	/* 0x1f5 */
-	tf.device  = gtf->tf[5];	/* 0x1f6 */
-	tf.command = gtf->tf[6];	/* 0x1f7 */
-
-	rtf = tf;
-	err_mask = ata_exec_internal(dev, &rtf, NULL, DMA_NONE, NULL, 0, 0);
-
-	switch (err_mask) {
-	case 0:
-		level = KERN_DEBUG;
-		snprintf(msg, sizeof(msg), "succeeded");
-		rc = 1;
-		break;
-
-	case AC_ERR_DEV:
+	ata_acpi_gtf_to_tf(dev, gtf, &tf);
+	if (prev_gtf) {
+		ata_acpi_gtf_to_tf(dev, prev_gtf, &ptf);
+		pptf = &ptf;
+	}
+
+	if (!ata_acpi_filter_tf(&tf, pptf)) {
+		rtf = tf;
+		err_mask = ata_exec_internal(dev, &rtf, NULL,
+					     DMA_NONE, NULL, 0, 0);
+
+		switch (err_mask) {
+		case 0:
+			level = KERN_DEBUG;
+			snprintf(msg, sizeof(msg), "succeeded");
+			rc = 1;
+			break;
+
+		case AC_ERR_DEV:
+			level = KERN_INFO;
+			snprintf(msg, sizeof(msg),
+				 "rejected by device (Stat=0x%02x Err=0x%02x)",
+				 rtf.command, rtf.feature);
+			rc = 0;
+			break;
+
+		default:
+			level = KERN_ERR;
+			snprintf(msg, sizeof(msg),
+				 "failed (Emask=0x%x Stat=0x%02x Err=0x%02x)",
+				 err_mask, rtf.command, rtf.feature);
+			rc = -EIO;
+			break;
+		}
+	} else {
 		level = KERN_INFO;
-		snprintf(msg, sizeof(msg),
-			 "rejected by device (Stat=0x%02x Err=0x%02x)",
-			 rtf.command, rtf.feature);
+		snprintf(msg, sizeof(msg), "filtered out");
 		rc = 0;
-		break;
-
-	default:
-		level = KERN_ERR;
-		snprintf(msg, sizeof(msg),
-			 "failed (Emask=0x%x Stat=0x%02x Err=0x%02x)",
-			 err_mask, rtf.command, rtf.feature);
-		rc = -EIO;
-		break;
 	}
 
 	ata_dev_printk(dev, level,
@@ -529,7 +587,7 @@ static int ata_acpi_run_tf(struct ata_device *dev,
  */
 static int ata_acpi_exec_tfs(struct ata_device *dev, int *nr_executed)
 {
-	struct ata_acpi_gtf *gtf = NULL;
+	struct ata_acpi_gtf *gtf = NULL, *pgtf = NULL;
 	void *ptr_to_free = NULL;
 	int gtf_count, i, rc;
 
@@ -540,12 +598,14 @@ static int ata_acpi_exec_tfs(struct ata_device *dev, int *nr_executed)
 	gtf_count = rc;
 
 	/* execute them */
-	for (i = 0; i < gtf_count; i++) {
-		rc = ata_acpi_run_tf(dev, gtf++);
+	for (i = 0; i < gtf_count; i++, gtf++) {
+		rc = ata_acpi_run_tf(dev, gtf, pgtf);
 		if (rc < 0)
 			break;
-		if (rc)
+		if (rc) {
 			(*nr_executed)++;
+			pgtf = gtf;
+		}
 	}
 
 	kfree(ptr_to_free);
-- 
1.5.2.4

