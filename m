From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/9] libata-acpi: miscellaneous cleanups
Date: Tue, 15 May 2007 03:28:16 +0900
Message-ID: <11791672962396-git-send-email-htejun@gmail.com>
References: <11791672953697-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:17396 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757272AbXENS22 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 May 2007 14:28:28 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1923782nzf
        for <linux-ide@vger.kernel.org>; Mon, 14 May 2007 11:28:27 -0700 (PDT)
In-Reply-To: <11791672953697-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, hare@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

* Add missing LOCKING: and RETURNS: to function comment.

* Don't conditionalize warning messages with ata_msg_probe().  Print
  directly with KERN_WARNING.

* Drop duplicate debug messages.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |   51 ++++++++++++++++++++------------------------
 1 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 4d36d25..ae2077e 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -175,21 +175,17 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
 
 	out_obj = output.pointer;
 	if (out_obj->type != ACPI_TYPE_BUFFER) {
-		if (ata_msg_probe(ap))
-			ata_dev_printk(dev, KERN_DEBUG, "%s: Run _GTF: "
-				"error: expected object type of "
-				" ACPI_TYPE_BUFFER, got 0x%x\n",
-				__FUNCTION__, out_obj->type);
+		ata_dev_printk(dev, KERN_WARNING,
+			       "_GTF unexpected object type 0x%x\n",
+			       out_obj->type);
 		rc = -EINVAL;
 		goto out_free;
 	}
 
 	if (out_obj->buffer.length % REGS_PER_GTF) {
-		if (ata_msg_drv(ap))
-			ata_dev_printk(dev, KERN_ERR,
-				"%s: unexpected GTF length (%d) or addr (0x%p)\n",
-				__FUNCTION__, out_obj->buffer.length,
-				out_obj->buffer.pointer);
+		ata_dev_printk(dev, KERN_WARNING,
+			       "unexpected _GTF length (%d)\n",
+			       out_obj->buffer.length);
 		rc = -EINVAL;
 		goto out_free;
 	}
@@ -320,6 +316,12 @@ static int ata_dev_set_taskfiles(struct ata_device *dev,
  * @ap: the ata_port for the drive
  *
  * This applies to both PATA and SATA drives.
+ *
+ * LOCKING:
+ * EH context.
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
  */
 int ata_acpi_exec_tfs(struct ata_port *ap)
 {
@@ -345,24 +347,14 @@ int ata_acpi_exec_tfs(struct ata_port *ap)
 		ret = ata_dev_get_GTF(dev, &gtf, &ptr_to_free);
 		if (ret == 0)
 			continue;
-		if (ret < 0) {
-			if (ata_msg_probe(ap))
-				ata_port_printk(ap, KERN_DEBUG,
-					"%s: get_GTF error (%d)\n",
-					__FUNCTION__, ret);
+		if (ret < 0)
 			break;
-		}
 		gtf_count = ret;
 
 		ret = ata_dev_set_taskfiles(dev, gtf, gtf_count);
 		kfree(ptr_to_free);
-		if (ret < 0) {
-			if (ata_msg_probe(ap))
-				ata_port_printk(ap, KERN_DEBUG,
-					"%s: set_taskfiles error (%d)\n",
-					__FUNCTION__, ret);
+		if (ret < 0)
 			break;
-		}
 	}
 
 	return ret;
@@ -377,6 +369,12 @@ int ata_acpi_exec_tfs(struct ata_port *ap)
  * ATM this function never returns a failure.  It is an optional
  * method and if it fails for whatever reason, we should still
  * just keep going.
+ *
+ * LOCKING:
+ * EH context.
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
  */
 int ata_acpi_push_id(struct ata_device *dev)
 {
@@ -416,12 +414,9 @@ int ata_acpi_push_id(struct ata_device *dev)
 	swap_buf_le16(dev->id, ATA_ID_WORDS);
 
 	err = ACPI_FAILURE(status) ? -EIO : 0;
-	if (err < 0) {
-		if (ata_msg_probe(ap))
-			ata_dev_printk(dev, KERN_DEBUG,
-				       "%s _SDD error: status = 0x%x\n",
-				       __FUNCTION__, status);
-	}
+	if (err < 0)
+		ata_dev_printk(dev, KERN_WARNING,
+			       "ACPI _SDD failed (AE 0x%x)\n", status);
 
 	/* always return success */
 out:
-- 
1.5.0.3


