From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 7/9] libata-acpi: improve _GTF execution error handling and reporting
Date: Fri, 14 Dec 2007 15:15:39 +0900
Message-ID: <11976129433239-git-send-email-htejun@gmail.com>
References: <11976129411285-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:60233 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101AbXLNGPw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2007 01:15:52 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1544773wah.23
        for <linux-ide@vger.kernel.org>; Thu, 13 Dec 2007 22:15:52 -0800 (PST)
In-Reply-To: <11976129411285-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

As _GTF commands can't transfer data, device error never signals
transfer error.  It indicates that the device vetoed the operation, so
it's meaningless to retry.

This patch makes libata-acpi to report and continue on device errors
when executing _GTF commands.  Also commands rejected by device don't
contributed to the number of _GTF commands executed.

While at it, update _GTF execution reporting such that all successful
commands are logged at KERN_DEBUG and rename taskfile_load_raw() to
ata_acpi_run_tf() for consistency.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |   77 +++++++++++++++++++++++++++------------------
 1 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index a118c3a..e68e918 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -429,7 +429,7 @@ int ata_acpi_cbl_80wire(struct ata_port *ap)
 EXPORT_SYMBOL_GPL(ata_acpi_cbl_80wire);
 
 /**
- * taskfile_load_raw - send taskfile registers to host controller
+ * ata_acpi_run_tf - send taskfile registers to host controller
  * @dev: target ATA device
  * @gtf: raw ATA taskfile register set (0x1f1 - 0x1f7)
  *
@@ -448,14 +448,17 @@ EXPORT_SYMBOL_GPL(ata_acpi_cbl_80wire);
  * EH context.
  *
  * RETURNS:
- * 0 on success, -errno on failure.
+ * 1 if command is executed successfully.  0 if ignored or rejected,
+ * -errno on other errors.
  */
-static int taskfile_load_raw(struct ata_device *dev,
-			      const struct ata_acpi_gtf *gtf)
+static int ata_acpi_run_tf(struct ata_device *dev,
+			   const struct ata_acpi_gtf *gtf)
 {
-	struct ata_port *ap = dev->link->ap;
 	struct ata_taskfile tf, rtf;
 	unsigned int err_mask;
+	const char *level;
+	char msg[60];
+	int rc;
 
 	if ((gtf->tf[0] == 0) && (gtf->tf[1] == 0) && (gtf->tf[2] == 0)
 	    && (gtf->tf[3] == 0) && (gtf->tf[4] == 0) && (gtf->tf[5] == 0)
@@ -475,24 +478,39 @@ static int taskfile_load_raw(struct ata_device *dev,
 	tf.device  = gtf->tf[5];	/* 0x1f6 */
 	tf.command = gtf->tf[6];	/* 0x1f7 */
 
-	if (ata_msg_probe(ap))
-		ata_dev_printk(dev, KERN_DEBUG, "executing ACPI cmd "
-			       "%02x/%02x:%02x:%02x:%02x:%02x:%02x\n",
-			       tf.command, tf.feature, tf.nsect,
-			       tf.lbal, tf.lbam, tf.lbah, tf.device);
-
 	rtf = tf;
 	err_mask = ata_exec_internal(dev, &rtf, NULL, DMA_NONE, NULL, 0, 0);
-	if (err_mask) {
-		ata_dev_printk(dev, KERN_ERR,
-			"ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x failed "
-			"(Emask=0x%x Stat=0x%02x Err=0x%02x)\n",
-			tf.command, tf.feature, tf.nsect, tf.lbal, tf.lbam,
-			tf.lbah, tf.device, err_mask, rtf.command, rtf.feature);
-		return -EIO;
+
+	switch (err_mask) {
+	case 0:
+		level = KERN_DEBUG;
+		snprintf(msg, sizeof(msg), "succeeded");
+		rc = 1;
+		break;
+
+	case AC_ERR_DEV:
+		level = KERN_INFO;
+		snprintf(msg, sizeof(msg),
+			 "rejected by device (Stat=0x%02x Err=0x%02x)",
+			 rtf.command, rtf.feature);
+		rc = 0;
+		break;
+
+	default:
+		level = KERN_ERR;
+		snprintf(msg, sizeof(msg),
+			 "failed (Emask=0x%x Stat=0x%02x Err=0x%02x)",
+			 err_mask, rtf.command, rtf.feature);
+		rc = -EIO;
+		break;
 	}
 
-	return 0;
+	ata_dev_printk(dev, level,
+		       "ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x %s\n",
+		       tf.command, tf.feature, tf.nsect, tf.lbal,
+		       tf.lbam, tf.lbah, tf.device, msg);
+
+	return rc;
 }
 
 /**
@@ -522,22 +540,19 @@ static int ata_acpi_exec_tfs(struct ata_device *dev, int *nr_executed)
 	gtf_count = rc;
 
 	/* execute them */
-	for (i = 0, rc = 0; i < gtf_count; i++) {
-		int tmp;
-
-		/* ACPI errors are eventually ignored.  Run till the
-		 * end even after errors.
-		 */
-		tmp = taskfile_load_raw(dev, gtf++);
-		if (!rc)
-			rc = tmp;
-
-		(*nr_executed)++;
+	for (i = 0; i < gtf_count; i++) {
+		rc = ata_acpi_run_tf(dev, gtf++);
+		if (rc < 0)
+			break;
+		if (rc)
+			(*nr_executed)++;
 	}
 
 	kfree(ptr_to_free);
 
-	return rc;
+	if (rc < 0)
+		return rc;
+	return 0;
 }
 
 /**
-- 
1.5.2.4

