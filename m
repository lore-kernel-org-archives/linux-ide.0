From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/2] libata-core: Expose gtm methods for driver use
Date: Thu, 4 Oct 2007 21:28:18 +0100
Message-ID: <20071004212818.6e1a6450@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36702 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754695AbXJDUXv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 16:23:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org


Talk to the dark side our driver has to, yes. Much misleading is the
data. Store it in a structure we do so that it may be parsed.

Signed-off-by: Alan Cox <alan@redhat.com>
-- 
Whats small, old and shouts phrases out of order across mountains ?
Yodla..



diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index a276c06..43c4fd7 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -142,7 +142,7 @@ void ata_acpi_associate(struct ata_host 
  * RETURNS:
  * 0 on success, -ENOENT if _GTM doesn't exist, -errno on failure.
  */
-static int ata_acpi_gtm(const struct ata_port *ap, struct ata_acpi_gtm *gtm)
+int ata_acpi_gtm(const struct ata_port *ap, struct ata_acpi_gtm *gtm)
 {
 	struct acpi_buffer output = { .length = ACPI_ALLOCATE_BUFFER };
 	union acpi_object *out_obj;
@@ -186,6 +186,8 @@ static int ata_acpi_gtm(const struct ata
 	return rc;
 }
 
+EXPORT_SYMBOL_GPL(ata_acpi_gtm);
+
 /**
  * ata_acpi_stm - execute _STM
  * @ap: target ATA port
@@ -199,7 +201,7 @@ static int ata_acpi_gtm(const struct ata
  * RETURNS:
  * 0 on success, -ENOENT if _STM doesn't exist, -errno on failure.
  */
-static int ata_acpi_stm(const struct ata_port *ap, struct ata_acpi_gtm *stm)
+int ata_acpi_stm(const struct ata_port *ap, struct ata_acpi_gtm *stm)
 {
 	acpi_status status;
 	struct acpi_object_list         input;
@@ -231,6 +233,8 @@ static int ata_acpi_stm(const struct ata
 	return 0;
 }
 
+EXPORT_SYMBOL_GPL(ata_acpi_stm);
+
 /**
  * ata_dev_get_GTF - get the drive bootup default taskfile settings
  * @dev: target ATA device

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 84dfc23..751aabc 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -929,6 +929,8 @@ enum {
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
 extern int ata_acpi_cbl_80wire(struct ata_port *ap);
+int ata_acpi_stm(const struct ata_port *ap, struct ata_acpi_gtm *stm);
+int ata_acpi_gtm(const struct ata_port *ap, struct ata_acpi_gtm *stm);
 #else
 static inline int ata_acpi_cbl_80wire(struct ata_port *ap) { return 0; }
 #endif

