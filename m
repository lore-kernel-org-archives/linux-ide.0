From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/9] libata-acpi: improve ACPI disabling
Date: Fri, 14 Dec 2007 15:15:38 +0900
Message-ID: <11976129421179-git-send-email-htejun@gmail.com>
References: <11976129411285-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:60175 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbXLNGPv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2007 01:15:51 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1544730wah.23
        for <linux-ide@vger.kernel.org>; Thu, 13 Dec 2007 22:15:51 -0800 (PST)
In-Reply-To: <11976129411285-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

* If _GTF evalution fails, it's pointless to retry.  Just disable ATA
  ACPI.

* After disabling ACPI, return success iff the number of executed _GTF
  command equals zero.  Otherwise, tell EH to retry.  This change
  fixes bogus 1 return bug where ata_acpi_on_devcfg() expects the
  caller to reload IDENTIFY data and continue but the caller
  interprets it as an error.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |   60 +++++++++++++++++++++++++++++---------------
 1 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 5785cac..a118c3a 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -314,8 +314,8 @@ EXPORT_SYMBOL_GPL(ata_acpi_stm);
  * EH context.
  *
  * RETURNS:
- * Number of taskfiles on success, 0 if _GTF doesn't exist or doesn't
- * contain valid data.
+ * Number of taskfiles on success, 0 if _GTF doesn't exist.  -EINVAL
+ * if _GTF is invalid.
  */
 static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
 			   void **ptr_to_free)
@@ -342,6 +342,7 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
 			ata_dev_printk(dev, KERN_WARNING,
 				       "_GTF evaluation failed (AE 0x%x)\n",
 				       status);
+			rc = -EINVAL;
 		}
 		goto out_free;
 	}
@@ -353,6 +354,7 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
 				__FUNCTION__,
 				(unsigned long long)output.length,
 				output.pointer);
+		rc = -EINVAL;
 		goto out_free;
 	}
 
@@ -361,6 +363,7 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
 		ata_dev_printk(dev, KERN_WARNING,
 			       "_GTF unexpected object type 0x%x\n",
 			       out_obj->type);
+		rc = -EINVAL;
 		goto out_free;
 	}
 
@@ -368,6 +371,7 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
 		ata_dev_printk(dev, KERN_WARNING,
 			       "unexpected _GTF length (%d)\n",
 			       out_obj->buffer.length);
+		rc = -EINVAL;
 		goto out_free;
 	}
 
@@ -494,6 +498,7 @@ static int taskfile_load_raw(struct ata_device *dev,
 /**
  * ata_acpi_exec_tfs - get then write drive taskfile settings
  * @dev: target ATA device
+ * @nr_executed: out paramter for the number of executed commands
  *
  * Evaluate _GTF and excute returned taskfiles.
  *
@@ -501,17 +506,20 @@ static int taskfile_load_raw(struct ata_device *dev,
  * EH context.
  *
  * RETURNS:
- * Number of executed taskfiles on success, 0 if _GTF doesn't exist or
- * doesn't contain valid data.  -errno on other errors.
+ * Number of executed taskfiles on success, 0 if _GTF doesn't exist.
+ * -errno on other errors.
  */
-static int ata_acpi_exec_tfs(struct ata_device *dev)
+static int ata_acpi_exec_tfs(struct ata_device *dev, int *nr_executed)
 {
 	struct ata_acpi_gtf *gtf = NULL;
 	void *ptr_to_free = NULL;
 	int gtf_count, i, rc;
 
 	/* get taskfiles */
-	gtf_count = ata_dev_get_GTF(dev, &gtf, &ptr_to_free);
+	rc = ata_dev_get_GTF(dev, &gtf, &ptr_to_free);
+	if (rc < 0)
+		return rc;
+	gtf_count = rc;
 
 	/* execute them */
 	for (i = 0, rc = 0; i < gtf_count; i++) {
@@ -523,12 +531,12 @@ static int ata_acpi_exec_tfs(struct ata_device *dev)
 		tmp = taskfile_load_raw(dev, gtf++);
 		if (!rc)
 			rc = tmp;
+
+		(*nr_executed)++;
 	}
 
 	kfree(ptr_to_free);
 
-	if (rc == 0)
-		return gtf_count;
 	return rc;
 }
 
@@ -667,6 +675,8 @@ int ata_acpi_on_devcfg(struct ata_device *dev)
 	struct ata_port *ap = dev->link->ap;
 	struct ata_eh_context *ehc = &ap->link.eh_context;
 	int acpi_sata = ap->flags & ATA_FLAG_ACPI_SATA;
+	int nr_executed = 0;
+	const char *reason;
 	int rc;
 
 	if (!dev->acpi_handle)
@@ -685,14 +695,14 @@ int ata_acpi_on_devcfg(struct ata_device *dev)
 	}
 
 	/* do _GTF */
-	rc = ata_acpi_exec_tfs(dev);
-	if (rc < 0)
+	rc = ata_acpi_exec_tfs(dev, &nr_executed);
+	if (rc)
 		goto acpi_err;
 
 	dev->flags &= ~ATA_DFLAG_ACPI_PENDING;
 
 	/* refresh IDENTIFY page if any _GTF command has been executed */
-	if (rc > 0) {
+	if (nr_executed) {
 		rc = ata_dev_reread_id(dev, 0);
 		if (rc < 0) {
 			ata_dev_printk(dev, KERN_ERR, "failed to IDENTIFY "
@@ -704,17 +714,25 @@ int ata_acpi_on_devcfg(struct ata_device *dev)
 	return 0;
 
  acpi_err:
-	/* let EH retry on the first failure, disable ACPI on the second */
-	if (dev->flags & ATA_DFLAG_ACPI_FAILED) {
-		ata_dev_printk(dev, KERN_WARNING, "ACPI on devcfg failed the "
-			       "second time, disabling (errno=%d)\n", rc);
+	/* fail and let EH retry once more for unknown IO errors */
+	if (rc != -EINVAL && !(dev->flags & ATA_DFLAG_ACPI_FAILED)) {
+		dev->flags |= ATA_DFLAG_ACPI_FAILED;
+		return rc;
+	}
 
-		dev->acpi_handle = NULL;
+	if (rc == -EINVAL)
+		reason = "_GTF invalid";
+	else
+		reason = "failed the second time";
+
+	ata_dev_printk(dev, KERN_WARNING, "ACPI: %s, disabled\n", reason);
+	dev->acpi_handle = NULL;
+
+	/* We can safely continue if no _GTF command has been executed
+	 * and port is not frozen.
+	 */
+	if (!nr_executed && !(ap->pflags & ATA_PFLAG_FROZEN))
+		return 0;
 
-		/* if port is working, request IDENTIFY reload and continue */
-		if (!(ap->pflags & ATA_PFLAG_FROZEN))
-			rc = 1;
-	}
-	dev->flags |= ATA_DFLAG_ACPI_FAILED;
 	return rc;
 }
-- 
1.5.2.4

