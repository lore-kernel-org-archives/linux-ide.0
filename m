From: Minwoo Im <dn3108@gmail.com>
Subject: [PATCH] libata: do not initialise statics to 0 ERROR fix.
Date: Sat, 17 Jun 2017 16:03:04 +0900
Message-ID: <1497682984-5554-1-git-send-email-dn3108@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33201 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbdFQHDP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 17 Jun 2017 03:03:15 -0400
Received: by mail-pf0-f193.google.com with SMTP id w12so9555001pfk.0
        for <linux-ide@vger.kernel.org>; Sat, 17 Jun 2017 00:03:14 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Minwoo Im <dn3108@gmail.com>

ERROR: do not initialise statics to 0 in four lines in libata-core.c.
Signed-off-by: Minwoo Im <dn3108@gmail.com>
---
 drivers/ata/libata-core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2191d23..8ed5bf3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -135,7 +135,7 @@ struct ata_force_ent {
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on [default])");
 
-static int atapi_dmadir = 0;
+static int atapi_dmadir;
 module_param(atapi_dmadir, int, 0444);
 MODULE_PARM_DESC(atapi_dmadir, "Enable ATAPI DMADIR bridge support (0=off [default], 1=on)");
 
@@ -143,7 +143,7 @@ struct ata_force_ent {
 module_param(atapi_passthru16, int, 0444);
 MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices (0=off, 1=on [default])");
 
-int libata_fua = 0;
+int libata_fua;
 module_param_named(fua, libata_fua, int, 0444);
 MODULE_PARM_DESC(fua, "FUA support (0=off [default], 1=on)");
 
@@ -159,11 +159,11 @@ struct ata_force_ent {
 module_param(ata_probe_timeout, int, 0444);
 MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout (seconds)");
 
-int libata_noacpi = 0;
+int libata_noacpi;
 module_param_named(noacpi, libata_noacpi, int, 0444);
 MODULE_PARM_DESC(noacpi, "Disable the use of ACPI in probe/suspend/resume (0=off [default], 1=on)");
 
-int libata_allow_tpm = 0;
+int libata_allow_tpm;
 module_param_named(allow_tpm, libata_allow_tpm, int, 0444);
 MODULE_PARM_DESC(allow_tpm, "Permit the use of TPM commands (0=off [default], 1=on)");
 
-- 
1.7.9.5

