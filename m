From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes 1/2] libata: uninline atapi_cmd_type()
Date: Wed, 02 Apr 2008 17:28:46 +0900
Message-ID: <47F343BE.4030103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.244]:17061 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbYDBI2x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Apr 2008 04:28:53 -0400
Received: by hs-out-0708.google.com with SMTP id 4so2038442hsl.5
        for <linux-ide@vger.kernel.org>; Wed, 02 Apr 2008 01:28:52 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Uninline atapi_cmd_type().  It doesn't really have to be inline and
more case will be added which need to access unexported libata
variable.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   34 ++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |   22 +---------------------
 2 files changed, 35 insertions(+), 21 deletions(-)

Index: work1/drivers/ata/libata-core.c
===================================================================
--- work1.orig/drivers/ata/libata-core.c
+++ work1/drivers/ata/libata-core.c
@@ -385,6 +385,39 @@ static void ata_force_horkage(struct ata
 }
 
 /**
+ *	atapi_cmd_type - Determine ATAPI command type from SCSI opcode
+ *	@opcode: SCSI opcode
+ *
+ *	Determine ATAPI command type from @opcode.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	ATAPI_{READ|WRITE|READ_CD|PASS_THRU|MISC}
+ */
+int atapi_cmd_type(u8 opcode)
+{
+	switch (opcode) {
+	case GPCMD_READ_10:
+	case GPCMD_READ_12:
+		return ATAPI_READ;
+
+	case GPCMD_WRITE_10:
+	case GPCMD_WRITE_12:
+	case GPCMD_WRITE_AND_VERIFY_10:
+		return ATAPI_WRITE;
+
+	case GPCMD_READ_CD:
+	case GPCMD_READ_CD_MSF:
+		return ATAPI_READ_CD;
+
+	default:
+		return ATAPI_MISC;
+	}
+}
+
+/**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
  *	@tf: Taskfile to convert
  *	@pmp: Port multiplier port
@@ -7876,6 +7909,7 @@ EXPORT_SYMBOL_GPL(ata_tf_read);
 EXPORT_SYMBOL_GPL(ata_noop_dev_select);
 EXPORT_SYMBOL_GPL(ata_std_dev_select);
 EXPORT_SYMBOL_GPL(sata_print_link_status);
+EXPORT_SYMBOL_GPL(atapi_cmd_type);
 EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 EXPORT_SYMBOL_GPL(ata_tf_from_fis);
 EXPORT_SYMBOL_GPL(ata_pack_xfermask);
Index: work1/include/linux/libata.h
===================================================================
--- work1.orig/include/linux/libata.h
+++ work1/include/linux/libata.h
@@ -869,6 +869,7 @@ extern unsigned int ata_dev_try_classify
  */
 extern void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf);
 extern void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
+extern int atapi_cmd_type(u8 opcode);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 			  u8 pmp, int is_cmd, u8 *fis);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
@@ -1444,27 +1445,6 @@ static inline int ata_try_flush_cache(co
 	       ata_id_has_flush_ext(dev->id);
 }
 
-static inline int atapi_cmd_type(u8 opcode)
-{
-	switch (opcode) {
-	case GPCMD_READ_10:
-	case GPCMD_READ_12:
-		return ATAPI_READ;
-
-	case GPCMD_WRITE_10:
-	case GPCMD_WRITE_12:
-	case GPCMD_WRITE_AND_VERIFY_10:
-		return ATAPI_WRITE;
-
-	case GPCMD_READ_CD:
-	case GPCMD_READ_CD_MSF:
-		return ATAPI_READ_CD;
-
-	default:
-		return ATAPI_MISC;
-	}
-}
-
 static inline unsigned int ac_err_mask(u8 status)
 {
 	if (status & (ATA_BUSY | ATA_DRQ))
