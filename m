From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/9] libata: implement ata_acpi_init_gtm()
Date: Fri, 14 Dec 2007 15:15:36 +0900
Message-ID: <11976129421933-git-send-email-htejun@gmail.com>
References: <11976129411285-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:60175 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbXLNGPs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2007 01:15:48 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1544730wah.23
        for <linux-ide@vger.kernel.org>; Thu, 13 Dec 2007 22:15:47 -0800 (PST)
In-Reply-To: <11976129411285-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hancockr@shaw.ca, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>

Add dev->__acpi_init_gtm and store initial GTM values on host
initialization.  If the field is valid, ata_acpi_init_gtm() returns
pointer to the saved GTM structure; otherwise, NULL.  This is to
remember BIOS/firmware programmed initial timing for later use before
reset and mode configuration modify it.  The accessor is there to make
building w/o ACPI easy dev->__acpi_init doesn't exist if ACPI is not
enabled.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Jeff Garzik <jeff@garzik.org>
---
 drivers/ata/libata-acpi.c |    3 +++
 include/linux/libata.h    |   12 ++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index e55cb4b..e4ec391 100644
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
index d3a0caf..bc8ef5b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -212,6 +212,7 @@ enum {
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
 	ATA_PFLAG_GTM_VALID	= (1 << 19), /* acpi_gtm data valid */
+	ATA_PFLAG_INIT_GTM_VALID = (1 << 20), /* initial gtm data valid */
 
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
@@ -654,6 +655,7 @@ struct ata_port {
 #ifdef CONFIG_ATA_ACPI
 	acpi_handle		acpi_handle;
 	struct ata_acpi_gtm	acpi_gtm;
+	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
 #endif
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
 };
@@ -939,10 +941,20 @@ enum {
 
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
+static inline const struct ata_acpi_gtm *ata_acpi_init_gtm(struct ata_port *ap)
+{
+	if (ap->pflags & ATA_PFLAG_INIT_GTM_VALID)
+		return &ap->__acpi_init_gtm;
+	return NULL;
+}
 extern int ata_acpi_cbl_80wire(struct ata_port *ap);
 int ata_acpi_stm(struct ata_port *ap, struct ata_acpi_gtm *stm);
 int ata_acpi_gtm(struct ata_port *ap, struct ata_acpi_gtm *stm);
 #else
+static inline const struct ata_acpi_gtm *ata_acpi_init_gtm(struct ata_port *ap)
+{
+	return NULL;
+}
 static inline int ata_acpi_cbl_80wire(struct ata_port *ap) { return 0; }
 #endif
 
-- 
1.5.2.4

