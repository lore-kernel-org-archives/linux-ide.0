From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0059/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:37:42 +0800
Message-ID: <20160802103742.17694-1-baolex.ni@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57622 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754549AbcHBLPr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Aug 2016 07:15:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, rjw@rjwysocki.net, lenb@kernel.org, x86@kernel.org, hpa@zytor.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, travis@sgi.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/ata/libata-core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6be7770..00b114f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -131,43 +131,43 @@ module_param_string(force, ata_force_param_buf, sizeof(ata_force_param_buf), 0);
 MODULE_PARM_DESC(force, "Force ATA configurations including cable type, link speed and transfer mode (see Documentation/kernel-parameters.txt for details)");
 
 static int atapi_enabled = 1;
-module_param(atapi_enabled, int, 0444);
+module_param(atapi_enabled, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on [default])");
 
 static int atapi_dmadir = 0;
-module_param(atapi_dmadir, int, 0444);
+module_param(atapi_dmadir, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(atapi_dmadir, "Enable ATAPI DMADIR bridge support (0=off [default], 1=on)");
 
 int atapi_passthru16 = 1;
-module_param(atapi_passthru16, int, 0444);
+module_param(atapi_passthru16, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices (0=off, 1=on [default])");
 
 int libata_fua = 0;
-module_param_named(fua, libata_fua, int, 0444);
+module_param_named(fua, libata_fua, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(fua, "FUA support (0=off [default], 1=on)");
 
 static int ata_ignore_hpa;
-module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);
+module_param_named(ignore_hpa, ata_ignore_hpa, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ignore_hpa, "Ignore HPA limit (0=keep BIOS limits, 1=ignore limits, using full disk)");
 
 static int libata_dma_mask = ATA_DMA_MASK_ATA|ATA_DMA_MASK_ATAPI|ATA_DMA_MASK_CFA;
-module_param_named(dma, libata_dma_mask, int, 0444);
+module_param_named(dma, libata_dma_mask, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma, "DMA enable/disable (0x1==ATA, 0x2==ATAPI, 0x4==CF)");
 
 static int ata_probe_timeout;
-module_param(ata_probe_timeout, int, 0444);
+module_param(ata_probe_timeout, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout (seconds)");
 
 int libata_noacpi = 0;
-module_param_named(noacpi, libata_noacpi, int, 0444);
+module_param_named(noacpi, libata_noacpi, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(noacpi, "Disable the use of ACPI in probe/suspend/resume (0=off [default], 1=on)");
 
 int libata_allow_tpm = 0;
-module_param_named(allow_tpm, libata_allow_tpm, int, 0444);
+module_param_named(allow_tpm, libata_allow_tpm, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(allow_tpm, "Permit the use of TPM commands (0=off [default], 1=on)");
 
 static int atapi_an;
-module_param(atapi_an, int, 0444);
+module_param(atapi_an, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(atapi_an, "Enable ATAPI AN media presence notification (0=0ff [default], 1=on)");
 
 MODULE_AUTHOR("Jeff Garzik");
-- 
2.9.2

