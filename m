From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: implement dev->acpi_init_gtm
Date: Sat, 03 Nov 2007 00:20:10 +0900
Message-ID: <472B402A.4030009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:21961 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509AbXKBPUU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 11:20:20 -0400
Received: by wa-out-1112.google.com with SMTP id v27so979803wah
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 08:20:18 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Add dev->acpi_init_gtm and store initial GTM values on host
initialization.  If the field is valid, ATA_PFLAG_INIT_GTM_VALID flag
is set.  This is to remember BIOS/firmware programmed initial timing
for later use before reset and mode configuration modify it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |    3 +++
 include/linux/libata.h    |    2 ++
 2 files changed, 5 insertions(+)

Index: work/drivers/ata/libata-acpi.c
===================================================================
--- work.orig/drivers/ata/libata-acpi.c
+++ work/drivers/ata/libata-acpi.c
@@ -94,6 +94,9 @@ static void ata_acpi_associate_ide_port(
 
 		dev->acpi_handle = acpi_get_child(ap->acpi_handle, i);
 	}
+
+	if (ata_acpi_gtm(ap, &ap->acpi_init_gtm) == 0)
+		ap->pflags |= ATA_PFLAG_INIT_GTM_VALID;
 }
 
 static void ata_acpi_handle_hotplug(struct ata_port *ap, struct kobject *kobj,
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -209,6 +209,7 @@ enum {
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
 	ATA_PFLAG_GTM_VALID	= (1 << 19), /* acpi_gtm data valid */
+	ATA_PFLAG_INIT_GTM_VALID = (1 << 20), /* initial gtm data valid */
 
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
@@ -633,6 +634,7 @@ struct ata_port {
 #ifdef CONFIG_ATA_ACPI
 	acpi_handle		acpi_handle;
 	struct ata_acpi_gtm	acpi_gtm;
+	struct ata_acpi_gtm	acpi_init_gtm;
 #endif
 	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
 };
