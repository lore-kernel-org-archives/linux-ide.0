From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] libata: make PMP support optional
Date: Tue, 25 Mar 2008 22:25:17 +0900
Message-ID: <12064515172578-git-send-email-htejun@gmail.com>
References: <1206451517133-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:11135 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982AbYCYNZZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:25:25 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1756977rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:25:24 -0700 (PDT)
In-Reply-To: <1206451517133-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca
Cc: Tejun Heo <htejun@gmail.com>

Make PMP support optional by adding CONFIG_SATA_PMP and leaving out
libata-pmp.c if it isn't set.  PMP helpers return constant values if
PMP support is not enabled and PMP declarations alias non-PMP
counterparts.  This makes the compiler to leave out PMP related part
out and LLDs to use non-PMP counterparts automatically.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/Kconfig    |    6 ++++++
 drivers/ata/Makefile   |    3 ++-
 drivers/ata/libata.h   |   17 +++++++++++++++++
 include/linux/libata.h |   27 +++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a3fcc4b..6bbcb93 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -41,6 +41,12 @@ config ATA_ACPI
 	  You can disable this at kernel boot time by using the
 	  option libata.noacpi=1
 
+config SATA_PMP
+	bool "SATA Port Multiplier support"
+	default y
+	help
+	  This option adds support for SATA Port Multipliers.
+
 config SATA_AHCI
 	tristate "AHCI SATA support"
 	depends on PCI
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index e6e41b2..1fbc2aa 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_ATA_GENERIC)	+= ata_generic.o
 # Should be last libata driver
 obj-$(CONFIG_PATA_LEGACY)	+= pata_legacy.o
 
-libata-objs	:= libata-core.o libata-scsi.o libata-eh.o libata-pmp.o
+libata-objs	:= libata-core.o libata-scsi.o libata-eh.o
 libata-$(CONFIG_ATA_SFF)	+= libata-sff.o
+libata-$(CONFIG_SATA_PMP)	+= libata-pmp.o
 libata-$(CONFIG_ATA_ACPI)	+= libata-acpi.o
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index c6dbcfc..6b71341 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -202,9 +202,26 @@ extern int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 extern void ata_eh_finish(struct ata_port *ap);
 
 /* libata-pmp.c */
+#ifdef CONFIG_SATA_PMP
 extern int sata_pmp_scr_read(struct ata_link *link, int reg, u32 *val);
 extern int sata_pmp_scr_write(struct ata_link *link, int reg, u32 val);
 extern int sata_pmp_attach(struct ata_device *dev);
+#else /* CONFIG_SATA_PMP */
+static inline int sata_pmp_scr_read(struct ata_link *link, int reg, u32 *val)
+{
+	return -EINVAL;
+}
+
+static inline int sata_pmp_scr_write(struct ata_link *link, int reg, u32 val)
+{
+	return -EINVAL;
+}
+
+static inline int sata_pmp_attach(struct ata_device *dev)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_SATA_PMP */
 
 /* libata-sff.c */
 #ifdef CONFIG_ATA_SFF
diff --git a/include/linux/libata.h b/include/linux/libata.h
index fd73f05..c4d6625 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1089,6 +1089,7 @@ extern const struct ata_port_operations sata_port_ops;
 /*
  * PMP helpers
  */
+#ifdef CONFIG_SATA_PMP
 static inline bool sata_pmp_supported(struct ata_port *ap)
 {
 	return ap->flags & ATA_FLAG_PMP;
@@ -1103,6 +1104,22 @@ static inline int ata_is_host_link(const struct ata_link *link)
 {
 	return link == &link->ap->link;
 }
+#else /* CONFIG_SATA_PMP */
+static inline bool sata_pmp_supported(struct ata_port *ap)
+{
+	return false;
+}
+
+static inline bool sata_pmp_attached(struct ata_port *ap)
+{
+	return false;
+}
+
+static inline int ata_is_host_link(const struct ata_link *link)
+{
+	return 1;
+}
+#endif /* CONFIG_SATA_PMP */
 
 static inline int sata_srst_pmp(struct ata_link *link)
 {
@@ -1387,11 +1404,21 @@ static inline struct ata_port *ata_shost_to_port(struct Scsi_Host *host)
 /**************************************************************************
  * PMP - drivers/ata/libata-pmp.c
  */
+#ifdef CONFIG_SATA_PMP
+
 extern const struct ata_port_operations sata_pmp_port_ops;
 
 extern int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc);
 extern void sata_pmp_error_handler(struct ata_port *ap);
 
+#else /* CONFIG_SATA_PMP */
+
+#define sata_pmp_port_ops		sata_port_ops
+#define sata_pmp_qc_defer_cmd_switch	ata_std_qc_defer
+#define sata_pmp_error_handler		ata_std_error_handler
+
+#endif /* CONFIG_SATA_PMP */
+
 
 /**************************************************************************
  * SFF - drivers/ata/libata-sff.c
-- 
1.5.2.4

