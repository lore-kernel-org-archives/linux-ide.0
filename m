From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: separate PMP support code from core code
Date: Tue, 25 Mar 2008 22:25:15 +0900
Message-ID: <1206451517803-git-send-email-htejun@gmail.com>
References: <1206451517133-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.182]:33404 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbYCYNZY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:25:24 -0400
Received: by el-out-1112.google.com with SMTP id v27so1726982ele.17
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:25:23 -0700 (PDT)
In-Reply-To: <1206451517133-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca
Cc: Tejun Heo <htejun@gmail.com>

Most of PMP support code is already in libata-pmp.c.  All that are in
libata-core.c are sata_pmp_port_ops and EXPORTs.  Move them to
libata-pmp.c.  Also, collect PMP related prototypes and declarations
in header files and move them right above of SFF stuff.

This change is to make PMP support optional.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   13 -------------
 drivers/ata/libata-pmp.c  |   12 ++++++++++++
 drivers/ata/libata.h      |   10 +++++-----
 include/linux/libata.h    |   17 ++++++++++-------
 4 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 22f3140..51d7959 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -86,15 +86,6 @@ const struct ata_port_operations sata_port_ops = {
 	.hardreset		= sata_std_hardreset,
 };
 
-const struct ata_port_operations sata_pmp_port_ops = {
-	.inherits		= &sata_port_ops,
-
-	.pmp_prereset		= ata_std_prereset,
-	.pmp_hardreset		= sata_std_hardreset,
-	.pmp_postreset		= ata_std_postreset,
-	.error_handler		= sata_pmp_error_handler,
-};
-
 static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
@@ -6140,7 +6131,6 @@ EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
 EXPORT_SYMBOL_GPL(sata_deb_timing_long);
 EXPORT_SYMBOL_GPL(ata_base_port_ops);
 EXPORT_SYMBOL_GPL(sata_port_ops);
-EXPORT_SYMBOL_GPL(sata_pmp_port_ops);
 EXPORT_SYMBOL_GPL(ata_dummy_port_ops);
 EXPORT_SYMBOL_GPL(ata_dummy_port_info);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
@@ -6219,9 +6209,6 @@ EXPORT_SYMBOL_GPL(ata_pci_device_resume);
 #endif /* CONFIG_PM */
 #endif /* CONFIG_PCI */
 
-EXPORT_SYMBOL_GPL(sata_pmp_qc_defer_cmd_switch);
-EXPORT_SYMBOL_GPL(sata_pmp_error_handler);
-
 EXPORT_SYMBOL_GPL(__ata_ehi_push_desc);
 EXPORT_SYMBOL_GPL(ata_ehi_push_desc);
 EXPORT_SYMBOL_GPL(ata_ehi_clear_desc);
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 9c99861..bb10c06 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -11,6 +11,14 @@
 #include <linux/libata.h>
 #include "libata.h"
 
+const struct ata_port_operations sata_pmp_port_ops = {
+	.inherits		= &sata_port_ops,
+	.pmp_prereset		= ata_std_prereset,
+	.pmp_hardreset		= sata_std_hardreset,
+	.pmp_postreset		= ata_std_postreset,
+	.error_handler		= sata_pmp_error_handler,
+};
+
 /**
  *	sata_pmp_read - read PMP register
  *	@link: link to read PMP register for
@@ -1012,3 +1020,7 @@ void sata_pmp_error_handler(struct ata_port *ap)
 	sata_pmp_eh_recover(ap);
 	ata_eh_finish(ap);
 }
+
+EXPORT_SYMBOL_GPL(sata_pmp_port_ops);
+EXPORT_SYMBOL_GPL(sata_pmp_qc_defer_cmd_switch);
+EXPORT_SYMBOL_GPL(sata_pmp_error_handler);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 45e1786..c6dbcfc 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -178,11 +178,6 @@ extern void ata_schedule_scsi_eh(struct Scsi_Host *shost);
 extern void ata_scsi_dev_rescan(struct work_struct *work);
 extern int ata_bus_probe(struct ata_port *ap);
 
-/* libata-pmp.c */
-extern int sata_pmp_scr_read(struct ata_link *link, int reg, u32 *val);
-extern int sata_pmp_scr_write(struct ata_link *link, int reg, u32 val);
-extern int sata_pmp_attach(struct ata_device *dev);
-
 /* libata-eh.c */
 extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
 extern void ata_scsi_error(struct Scsi_Host *host);
@@ -206,6 +201,11 @@ extern int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 			  struct ata_link **r_failed_disk);
 extern void ata_eh_finish(struct ata_port *ap);
 
+/* libata-pmp.c */
+extern int sata_pmp_scr_read(struct ata_link *link, int reg, u32 *val);
+extern int sata_pmp_scr_write(struct ata_link *link, int reg, u32 val);
+extern int sata_pmp_attach(struct ata_device *dev);
+
 /* libata-sff.c */
 #ifdef CONFIG_ATA_SFF
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 817ecd5..a1a9f3f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1024,12 +1024,6 @@ static inline int ata_acpi_cbl_80wire(struct ata_port *ap,
 #endif
 
 /*
- * PMP - drivers/ata/libata-pmp.c
- */
-extern int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc);
-extern void sata_pmp_error_handler(struct ata_port *ap);
-
-/*
  * EH - drivers/ata/libata-eh.c
  */
 extern void ata_port_schedule_eh(struct ata_port *ap);
@@ -1072,7 +1066,6 @@ extern void ata_std_error_handler(struct ata_port *ap);
  */
 extern const struct ata_port_operations ata_base_port_ops;
 extern const struct ata_port_operations sata_port_ops;
-extern const struct ata_port_operations sata_pmp_port_ops;
 
 #define ATA_BASE_SHT(drv_name)					\
 	.module			= THIS_MODULE,			\
@@ -1370,6 +1363,16 @@ static inline struct ata_port *ata_shost_to_port(struct Scsi_Host *host)
 	return *(struct ata_port **)&host->hostdata[0];
 }
 
+
+/**************************************************************************
+ * PMP - drivers/ata/libata-pmp.c
+ */
+extern const struct ata_port_operations sata_pmp_port_ops;
+
+extern int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc);
+extern void sata_pmp_error_handler(struct ata_port *ap);
+
+
 /**************************************************************************
  * SFF - drivers/ata/libata-sff.c
  */
-- 
1.5.2.4

