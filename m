From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/12] libata: implement ata_acpi_init_gtm()
Date: Tue, 27 Nov 2007 19:43:46 +0900
Message-ID: <11961602313154-git-send-email-htejun@gmail.com>
References: <11961602293422-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:39060 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755314AbXK0KoH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 05:44:07 -0500
Received: by rv-out-0910.google.com with SMTP id k20so840818rvb
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 02:44:07 -0800 (PST)
In-Reply-To: <11961602293422-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>

Add dev->__acpi_init_gtm and store initial GTM values on host
initialization.  If the field is valid, ata_acpi_init_gtm() returns
pointer to the saved GTM structure; otherwise, NULL.  This is to
remember BIOS/firmware programmed initial timing for later use before
reset and mode configuration modify it.  The accessor is there to make
building w/o ACPI easy dev->__acpi_init doesn't exist if ACPI is not
enabled.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |    3 +++
 include/linux/libata.h    |   14 +++++++++++++-
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index ba6b61c..357f9a2 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -94,6 +94,9 @@ static void ata_acpi_associate_ide_port(struct ata_port *ap)
 
 		dev->acpi_handle = acpi_get_child(ap->acpi_handle, i);
 	}
+
+	if (ata_acpi_gtm(ap, &ap->__acpi_init_gtm) == 0)
+		ap->pflags |= ATA_PFLAG_INIT_GTM_VALID;
 }
 
 static void ata_acpi_handle_hotplug(struct ata_port *ap, struct kobject *kobj,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a7b999a..f056b2c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -213,6 +213,7 @@ enum {
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
 	ATA_PFLAG_GTM_VALID	= (1 << 19), /* acpi_gtm data valid */
+	ATA_PFLAG_INIT_GTM_VALID = (1 << 20), /* initial gtm data valid */
 
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
@@ -662,6 +663,7 @@ struct ata_port {
 #ifdef CONFIG_ATA_ACPI
 	acpi_handle		acpi_handle;
 	struct ata_acpi_gtm	acpi_gtm;
+	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
 #endif
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
 };
@@ -958,13 +960,23 @@ enum {
 
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
+static inline const struct ata_acpi_gtm *ata_acpi_init_gtm(struct ata_port *ap)
+{
+	if (ap->pflags & ATA_PFLAG_INIT_GTM_VALID)
+		return &ap->__acpi_init_gtm;
+	return NULL;
+}
 extern int ata_acpi_cbl_80wire(struct ata_port *ap);
 int ata_acpi_stm(const struct ata_port *ap, struct ata_acpi_gtm *stm);
 int ata_acpi_gtm(const struct ata_port *ap, struct ata_acpi_gtm *stm);
 unsigned long ata_acpi_gtm_xfermask(struct ata_device *dev,
 				    const struct ata_acpi_gtm *gtm);
-
 #else
+static inline const struct ata_acpi_gtm *ata_acpi_init_gtm(struct ata_port *ap)
+{
+	return NULL;
+}
+
 static inline int ata_acpi_cbl_80wire(struct ata_port *ap) { return 0; }
 
 static inline int ata_acpi_stm(const struct ata_port *ap,
-- 
1.5.2.4

