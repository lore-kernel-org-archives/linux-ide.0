From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 5/13] ATA ACPI: use debugging macros
Date: Wed, 22 Feb 2006 13:55:42 -0800
Message-ID: <20060222135542.33fe242c.randy_d_dunlap@linux.intel.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:60053 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751511AbWBVWLT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Feb 2006 17:11:19 -0500
In-Reply-To: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add more libata-acpi debugging, plus controlled by libata.printk value.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 drivers/scsi/libata-acpi.c |   53 ++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 19 deletions(-)

--- linux-2616-rc4-ata.orig/drivers/scsi/libata-acpi.c
+++ linux-2616-rc4-ata/drivers/scsi/libata-acpi.c
@@ -371,17 +371,20 @@ int do_drive_get_GTF(struct ata_port *ap
 	status = acpi_evaluate_object(atadev->obj_handle, "_GTF",
 					NULL, &output);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_DEBUG
-			"%s: Run _GTF error: status = 0x%x\n",
-			__FUNCTION__, status);
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG
+				"%s: Run _GTF error: status = 0x%x\n",
+				__FUNCTION__, status);
 		goto out;
 	}
 
 	if (!output.length || !output.pointer) {
-		printk(KERN_DEBUG
-			"%s: Run _GTF: length or ptr is NULL (0x%llx, 0x%p)\n",
-			__FUNCTION__,
-			(unsigned long long)output.length, output.pointer);
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: Run _GTF: "
+				"length or ptr is NULL (0x%llx, 0x%p)\n",
+				__FUNCTION__,
+				(unsigned long long)output.length,
+				output.pointer);
 		acpi_os_free(output.pointer);
 		goto out;
 	}
@@ -389,23 +392,32 @@ int do_drive_get_GTF(struct ata_port *ap
 	out_obj = output.pointer;
 	if (out_obj->type != ACPI_TYPE_BUFFER) {
 		acpi_os_free(output.pointer);
-		printk(KERN_DEBUG "%s: Run _GTF: error: "
-			"expected object type of ACPI_TYPE_BUFFER, got 0x%x\n",
-			__FUNCTION__, out_obj->type);
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: Run _GTF: error: "
+				"expected object type of ACPI_TYPE_BUFFER, "
+				"got 0x%x\n",
+				__FUNCTION__, out_obj->type);
 		err = -ENOENT;
 		goto out;
 	}
 
-	if (out_obj->buffer.length % REGS_PER_GTF) {
+	if (!out_obj->buffer.length || !out_obj->buffer.pointer ||
+	    out_obj->buffer.length % REGS_PER_GTF) {
 		if (ata_msg_drv(ap))
-			printk(KERN_ERR "%s: unexpected GTF length (%d)\n",
-				__FUNCTION__, out_obj->buffer.length);
+			printk(KERN_ERR
+				"%s: unexpected GTF length (%d) or addr (0x%p)\n",
+				__FUNCTION__, out_obj->buffer.length,
+				out_obj->buffer.pointer);
 		err = -ENOENT;
 		goto out;
 	}
 
 	*gtf_length = out_obj->buffer.length;
 	*gtf_address = (unsigned long)out_obj->buffer.pointer;
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG "%s: returning "
+			"gtf_length=%d, gtf_address=0x%lx\n",
+			__FUNCTION__, *gtf_length, *gtf_address);
 	err = 0;
 out:
 	return err;
@@ -510,8 +522,9 @@ int do_drive_set_taskfiles(struct ata_po
 
 	if (ata_msg_probe(ap))
 		printk(KERN_DEBUG
-			"%s: total GTF bytes = %u (0x%x), gtf_count = %d\n",
-			__FUNCTION__, gtf_length, gtf_length, gtf_count);
+			"%s: total GTF bytes=%u (0x%x), gtf_count=%d, addr=0x%lx\n",
+			__FUNCTION__, gtf_length, gtf_length, gtf_count,
+			gtf_address);
 	if (gtf_length % REGS_PER_GTF) {
 		if (ata_msg_drv(ap))
 			printk(KERN_ERR "%s: unexpected GTF length (%d)\n",
@@ -553,8 +566,9 @@ int ata_acpi_exec_tfs(struct ata_port *a
 		return 0;
 
 	for (ix = 0; ix < ATA_MAX_DEVICES; ix++) {
-		printk(KERN_DEBUG "%s: call get_GTF, ix=%d\n",
-			__FUNCTION__, ix);
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: call get_GTF, ix=%d\n",
+				__FUNCTION__, ix);
 		ret = do_drive_get_GTF(ap, &ap->device[ix],
 				&gtf_length, &gtf_address);
 		if (ret < 0) {
@@ -564,8 +578,9 @@ int ata_acpi_exec_tfs(struct ata_port *a
 			break;
 		}
 
-		printk(KERN_DEBUG "%s: call set_taskfiles, ix=%d\n",
-			__FUNCTION__, ix);
+		if (ata_msg_probe(ap))
+			printk(KERN_DEBUG "%s: call set_taskfiles, ix=%d\n",
+				__FUNCTION__, ix);
 		ret = do_drive_set_taskfiles(ap, &ap->device[ix],
 				gtf_length, gtf_address);
 		acpi_os_free((void *)gtf_address);
