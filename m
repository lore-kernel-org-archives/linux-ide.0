From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata-acpi: missing _SDD is not an error
Date: Wed, 18 Nov 2009 22:24:21 +0900
Message-ID: <4B03F585.3090000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41282 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753691AbZKRNY2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Nov 2009 08:24:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>

Missing _SDD is not an error.  Don't treat it as one.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/ata/libata-acpi.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index b0882cd..1245838 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -807,12 +807,11 @@ static int ata_acpi_exec_tfs(struct ata_device *dev, int *nr_executed)
  * EH context.
  *
  * RETURNS:
- * 0 on success, -errno on failure.
+ * 0 on success, -ENOENT if _SDD doesn't exist, -errno on failure.
  */
 static int ata_acpi_push_id(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->link->ap;
-	int err;
 	acpi_status status;
 	struct acpi_object_list input;
 	union acpi_object in_params[1];
@@ -835,12 +834,16 @@ static int ata_acpi_push_id(struct ata_device *dev)
 	status = acpi_evaluate_object(dev->acpi_handle, "_SDD", &input, NULL);
 	swap_buf_le16(dev->id, ATA_ID_WORDS);
 
-	err = ACPI_FAILURE(status) ? -EIO : 0;
-	if (err < 0)
+	if (status == AE_NOT_FOUND)
+		return -ENOENT;
+
+	if (ACPI_FAILURE(status)) {
 		ata_dev_printk(dev, KERN_WARNING,
 			       "ACPI _SDD failed (AE 0x%x)\n", status);
+		return -EIO;
+	}
 
-	return err;
+	return 0;
 }
 
 /**
@@ -971,7 +974,7 @@ int ata_acpi_on_devcfg(struct ata_device *dev)
 	/* do _SDD if SATA */
 	if (acpi_sata) {
 		rc = ata_acpi_push_id(dev);
-		if (rc)
+		if (rc && rc != -ENOENT)
 			goto acpi_err;
 	}
 
