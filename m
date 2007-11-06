From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/12] libata: implement ata_acpi_init_gtm()
Date: Tue,  6 Nov 2007 14:39:07 +0900
Message-ID: <11943275512870-git-send-email-htejun@gmail.com>
References: <1194327550227-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:7441 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752942AbXKFFjQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Nov 2007 00:39:16 -0500
In-Reply-To: <1194327550227-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
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
index 7d982c2..31365b3 100644
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
index 3b9cebe..bad280f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -213,6 +213,7 @@ enum {
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
 	ATA_PFLAG_GTM_VALID	= (1 << 19), /* acpi_gtm data valid */
+	ATA_PFLAG_INIT_GTM_VALID = (1 << 20), /* initial gtm data valid */
 
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
@@ -659,6 +660,7 @@ struct ata_port {
 #ifdef CONFIG_ATA_ACPI
 	acpi_handle		acpi_handle;
 	struct ata_acpi_gtm	acpi_gtm;
+	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
 #endif
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
 };
@@ -956,13 +958,23 @@ enum {
 
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
 unsigned int ata_acpi_gtm_xfermask(struct ata_device *dev,
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

