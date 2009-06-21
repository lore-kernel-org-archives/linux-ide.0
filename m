From: Evgeni Golov <sargentd@die-welt.net>
Subject: [PATCH] [libata] beautify module parameters
Date: Sun, 21 Jun 2009 22:43:20 +0200
Message-ID: <1245617000-23868-1-git-send-email-sargentd@die-welt.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vm1.die-welt.net ([84.246.122.34]:57774 "EHLO chi.die-welt.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750780AbZFUUua (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 Jun 2009 16:50:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Evgeni Golov <sargentd@die-welt.net>

1. add defaults to description where possible
2. add value definition (off=0, on=1) where missing

Signed-off-by: Evgeni Golov <sargentd@die-welt.net>
---
 drivers/ata/libata-core.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ca4d208..da27a3c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -125,11 +125,11 @@ MODULE_PARM_DESC(force, "Force ATA configurations including cable type, link spe
 
 static int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
-MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
+MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices; on by default (0=off, 1=on)");
 
 static int atapi_dmadir = 0;
 module_param(atapi_dmadir, int, 0444);
-MODULE_PARM_DESC(atapi_dmadir, "Enable ATAPI DMADIR bridge support (0=off, 1=on)");
+MODULE_PARM_DESC(atapi_dmadir, "Enable ATAPI DMADIR bridge support; off by default (0=off, 1=on)");
 
 int atapi_passthru16 = 1;
 module_param(atapi_passthru16, int, 0444);
@@ -137,7 +137,7 @@ MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices; on
 
 int libata_fua = 0;
 module_param_named(fua, libata_fua, int, 0444);
-MODULE_PARM_DESC(fua, "FUA support (0=off, 1=on)");
+MODULE_PARM_DESC(fua, "FUA support; off by default (0=off, 1=on)");
 
 static int ata_ignore_hpa;
 module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);
@@ -153,11 +153,11 @@ MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout (seconds)");
 
 int libata_noacpi = 0;
 module_param_named(noacpi, libata_noacpi, int, 0444);
-MODULE_PARM_DESC(noacpi, "Disables the use of ACPI in probe/suspend/resume when set");
+MODULE_PARM_DESC(noacpi, "Disable the use of ACPI in probe/suspend/resume; off by default (0=off, 1=on)");
 
 int libata_allow_tpm = 0;
 module_param_named(allow_tpm, libata_allow_tpm, int, 0444);
-MODULE_PARM_DESC(allow_tpm, "Permit the use of TPM commands");
+MODULE_PARM_DESC(allow_tpm, "Permit the use of TPM commands; off by default (0=off, 1=on)");
 
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
-- 
1.6.3.1

