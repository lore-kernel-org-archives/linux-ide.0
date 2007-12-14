From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/9] libata: drop const from struct ata_port param on ata_acpi_gtm/stm()
Date: Fri, 14 Dec 2007 15:15:33 +0900
Message-ID: <11976129423207-git-send-email-htejun@gmail.com>
References: <11976129411285-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:60175 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbXLNGPt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2007 01:15:49 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1544730wah.23
        for <linux-ide@vger.kernel.org>; Thu, 13 Dec 2007 22:15:49 -0800 (PST)
In-Reply-To: <11976129411285-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

No other libata interface function takes const ata_port.  Drop them
from ata_acpi_gtm/stm().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |    4 ++--
 include/linux/libata.h    |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 545ea86..e55cb4b 100644
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
@@ -259,7 +259,7 @@ EXPORT_SYMBOL_GPL(ata_acpi_gtm);
  * RETURNS:
  * 0 on success, -ENOENT if _STM doesn't exist, -errno on failure.
  */
-int ata_acpi_stm(const struct ata_port *ap, struct ata_acpi_gtm *stm)
+int ata_acpi_stm(struct ata_port *ap, struct ata_acpi_gtm *stm)
 {
 	acpi_status status;
 	struct acpi_object_list         input;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ef52a07..6940344 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -940,8 +940,8 @@ enum {
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
 extern int ata_acpi_cbl_80wire(struct ata_port *ap);
-int ata_acpi_stm(const struct ata_port *ap, struct ata_acpi_gtm *stm);
-int ata_acpi_gtm(const struct ata_port *ap, struct ata_acpi_gtm *stm);
+int ata_acpi_stm(struct ata_port *ap, struct ata_acpi_gtm *stm);
+int ata_acpi_gtm(struct ata_port *ap, struct ata_acpi_gtm *stm);
 #else
 static inline int ata_acpi_cbl_80wire(struct ata_port *ap) { return 0; }
 #endif
-- 
1.5.2.4

