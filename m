From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0058/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:37:38 +0800
Message-ID: <20160802103738.17628-1-baolex.ni@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:29980 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754137AbcHBLPm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Aug 2016 07:15:42 -0400
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
 drivers/ata/libata-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 97a14fe..ef8f3dd 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -21,7 +21,7 @@
 #include "libata.h"
 
 unsigned int ata_acpi_gtf_filter = ATA_ACPI_FILTER_DEFAULT;
-module_param_named(acpi_gtf_filter, ata_acpi_gtf_filter, int, 0644);
+module_param_named(acpi_gtf_filter, ata_acpi_gtf_filter, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(acpi_gtf_filter, "filter mask for ACPI _GTF commands, set to filter out (0x1=set xfermode, 0x2=lock/freeze lock, 0x4=DIPM, 0x8=FPDMA non-zero offset, 0x10=FPDMA DMA Setup FIS auto-activate)");
 
 #define NO_PORT_MULT		0xffff
-- 
2.9.2

