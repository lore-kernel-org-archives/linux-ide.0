From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/10] libata-acpi: adjust constness in ata_acpi_gtm/stm() parameters
Date: Sat, 15 Dec 2007 15:04:57 +0900
Message-ID: <11976987061239-git-send-email-htejun@gmail.com>
References: <11976987063011-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:52978 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757002AbXLOGFN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Dec 2007 01:05:13 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1193512rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 14 Dec 2007 22:05:12 -0800 (PST)
In-Reply-To: <11976987063011-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

* No internal function uses const ata_port.  Drop const from @ap.

* Make ata_acpi_stm() copy @stm before using it and change @stm to
  const.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |    7 ++++---
 include/linux/libata.h    |    4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 545ea86..8ae36ad 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -200,7 +200,7 @@ void ata_acpi_associate(struct ata_host *host)
  * RETURNS:
  * 0 on success, -ENOENT if _GTM doesn't exist, -errno on failure.
  */
-int ata_acpi_gtm(const struct ata_port *ap, struct ata_acpi_gtm *gtm)
+int ata_acpi_gtm(struct ata_port *ap, struct ata_acpi_gtm *gtm)
 {
 	struct acpi_buffer output = { .length = ACPI_ALLOCATE_BUFFER };
 	union acpi_object *out_obj;
@@ -259,15 +259,16 @@ EXPORT_SYMBOL_GPL(ata_acpi_gtm);
  * RETURNS:
  * 0 on success, -ENOENT if _STM doesn't exist, -errno on failure.
  */
-int ata_acpi_stm(const struct ata_port *ap, struct ata_acpi_gtm *stm)
+int ata_acpi_stm(struct ata_port *ap, const struct ata_acpi_gtm *stm)
 {
 	acpi_status status;
+	struct ata_acpi_gtm		stm_buf = *stm;
 	struct acpi_object_list         input;
 	union acpi_object               in_params[3];
 
 	in_params[0].type = ACPI_TYPE_BUFFER;
 	in_params[0].buffer.length = sizeof(struct ata_acpi_gtm);
-	in_params[0].buffer.pointer = (u8 *)stm;
+	in_params[0].buffer.pointer = (u8 *)&stm_buf;
 	/* Buffers for id may need byteswapping ? */
 	in_params[1].type = ACPI_TYPE_BUFFER;
 	in_params[1].buffer.length = 512;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ef52a07..1ca9b89 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -940,8 +940,8 @@ enum {
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
 extern int ata_acpi_cbl_80wire(struct ata_port *ap);
-int ata_acpi_stm(const struct ata_port *ap, struct ata_acpi_gtm *stm);
-int ata_acpi_gtm(const struct ata_port *ap, struct ata_acpi_gtm *stm);
+int ata_acpi_stm(struct ata_port *ap, const struct ata_acpi_gtm *stm);
+int ata_acpi_gtm(struct ata_port *ap, struct ata_acpi_gtm *stm);
 #else
 static inline int ata_acpi_cbl_80wire(struct ata_port *ap) { return 0; }
 #endif
-- 
1.5.2.4

